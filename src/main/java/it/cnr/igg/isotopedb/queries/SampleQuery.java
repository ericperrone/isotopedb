package it.cnr.igg.isotopedb.queries;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Set;
import java.util.Iterator;

import com.google.gson.internal.LinkedTreeMap;

import java.util.ArrayList;
import java.util.HashMap;
import it.cnr.igg.isotopedb.exceptions.DbException;
import it.cnr.igg.isotopedb.tools.QueryFilter;
import it.cnr.igg.isotopedb.beans.SampleBean;
import it.cnr.igg.isotopedb.beans.SampleFieldBean;
import it.cnr.igg.isotopedb.beans.ComponentBean;

public class SampleQuery extends Query {
	/*
	 * query per i campi select distinct si.sample_id, se.field, se.value from
	 * sample_index si left join sample_element se on(se.sample_id = si.sample_id)
	 * order by si.sample_id ;
	 * 
	 * query per elementi chimici select distinct si.sample_id, cc."element",
	 * cc.value from sample_index si left join chem_component cc on(cc.sample_id =
	 * si.sample_id) order by si.sample_id ;
	 */
	private String queryAll = "select distinct si.sample_id, se.field, se.value, cc.\"element\", cc.value as cvalue "
			+ "from sample_index si " + "left join sample_element se on(se.sample_id = si.sample_id) "
			+ "left join chem_component cc on(cc.sample_id = si.sample_id) " + "order by si.sample_id";

	private String queryElements = "select distinct si.sample_id, cc.\"element\", cc.value from sample_index si "
			+ "left join chem_component cc on(cc.sample_id = si.sample_id) order by si.sample_id";

	private String queryFields = "select distinct si.sample_id, se.field, se.value from sample_index si left "
			+ "join sample_element se on(se.sample_id = si.sample_id) order by si.sample_id";

	public SampleQuery() {
		super();
	}

	public ArrayList<SampleBean> getSamples(List<QueryFilter> filter) throws Exception, DbException {
		ArrayList<SampleBean> beans = new ArrayList<SampleBean>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			Connection con = cm.createConnection();
			ps = manageFilter(filter, con);
			rs = ps.executeQuery();
			HashMap<Long, SampleBean> sampleIndex = new HashMap<Long, SampleBean>();
			while (rs.next()) {
				Long id = rs.getLong("sample_id");
				if (sampleIndex.get(id) == null) {
					sampleIndex.put(id, new SampleBean());
					sampleIndex.get(id).setFields(new ArrayList<SampleFieldBean>());
					sampleIndex.get(id).setComponents(new ArrayList<ComponentBean>());
				}
				boolean already = false;
				List<SampleFieldBean> flist = sampleIndex.get(id).getFields();
				SampleFieldBean sfb = rsToSampleFieldBean(rs);
				for (SampleFieldBean item : flist) {
					if (item.compareTo(sfb) == true) {
						already = true;
						break;
					}
				}
				if (already == false)
					sampleIndex.get(id).getFields().add(sfb);
				
				ComponentBean cb = rsTocomponentBean(rs);
				List<ComponentBean> list = sampleIndex.get(id).getComponents();
				already = false;
				for (ComponentBean item : list) {
					if (item.compareTo(cb) == true) {
						already = true;
						break;
					}
				}
				if (already == false)
					sampleIndex.get(id).getComponents().add(cb);
			}
			Set<Long> set = sampleIndex.keySet();
			Iterator<Long> it = set.iterator();
			while (it.hasNext())
				beans.add(sampleIndex.get(it.next()));
			return beans;
		} catch (Exception ex) {
			ex.printStackTrace();
			throw new DbException(ex);
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (ps != null) {
				ps.close();
			}
			cm.closeConnection();
		}
	}

	private PreparedStatement manageFilter(List<QueryFilter> filter, Connection con) throws SQLException {
		PreparedStatement ps = con.prepareStatement(queryAll);
		if (filter != null && filter.size() >= 0) {
			// to do ...
		}
		return ps;
	}

	private SampleFieldBean rsToSampleFieldBean(ResultSet rs) throws SQLException {
		SampleFieldBean sfb = new SampleFieldBean();
		String field = rs.getString("field");
		String value = rs.getString("value");
		sfb.setFieldName(field);
		sfb.setFieldValue(value);
		return sfb;
	}
	
	private ComponentBean rsTocomponentBean(ResultSet rs) throws SQLException {
		ComponentBean cb = new ComponentBean();
		String component = rs.getString("element");
		Double value = rs.getDouble("cvalue");
		cb.setComponent(component);
		cb.setValue(value);
		return cb;
	}

	public void insert(ArrayList<SampleBean> samples) throws Exception, DbException {
		PreparedStatement ps = null;
		ResultSet rs = null;
		Connection con = null;
		String insertSample = "insert into sample_index (ts) values(now());";
		String getSampleId = "SELECT currval(pg_get_serial_sequence(\'sample_index\',\'sample_id\')) as sample_id";
		String insertField = "insert into sample_element (sample_id, field, value) values (?, ?, ?)";
		String insertChem = "insert into chem_component (sample_id, element, value, isotope) values (?, ?, ?, ?)";
		try {
			con = cm.createConnection();
			con.setAutoCommit(false); // start transaction
			for (SampleBean sb : samples) {
				// step 1: insert master record
				ps = con.prepareStatement(insertSample);
				ps.execute();
				ps.close();
				ps = null;

				// step 2: get master record id
				ps = con.prepareStatement(getSampleId);
				rs = ps.executeQuery();
				if (!rs.next())
					throw new DbException("Invalid sequence value");
				Long sampleId = rs.getLong("sample_id");
				rs.close();
				rs = null;
				ps.close();
				ps = null;

				// step 3: insert sample fields
				List<SampleFieldBean> fields = sb.getFields();
				for (SampleFieldBean sfb : fields) {
					ps = con.prepareStatement(insertField);
					ps.setLong(1, sampleId);
					ps.setString(2, sfb.getFieldName());
					ps.setString(3, sfb.getFieldValue());
					ps.execute();
					ps.close();
					ps = null;
				}

				// step 4: insert chemical components
				List<ComponentBean> components = sb.getComponents();
				for (ComponentBean cb : components) {
					ps = con.prepareStatement(insertChem);
					ps.setLong(1, sampleId);
					ps.setString(2, cb.getComponent());
					ps.setString(3, "" + cb.getValue());
					ps.setBoolean(4, cb.getIsIsotope());
					ps.execute();
					ps.close();
					ps = null;
				}
			}
			con.commit();
		} catch (Exception ex) {
			if (con != null)
				con.rollback();
			ex.printStackTrace();
			throw new DbException(ex);
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (ps != null) {
				ps.close();
			}
			con.setAutoCommit(true); // end transaction
			cm.closeConnection();
		}
	}

//	public SampleBean insert(String jsonIn) throws Exception, DbException {
//		PreparedStatement ps = null;
//		String values = ") values (?";
//		String helper = "";
//		SampleBean sample = new SampleBean();
//
//		LinkedTreeMap map = sample.fromJson(jsonIn);
//		Set<String> jsonKeys = sample.getKeys(map);
//		for (String jsonKey : jsonKeys) {
//			String key = jsonKey.toLowerCase();
//			if (key.contains("location") || key.contains("locality")) {
//				helper = sample.getLocation() != null ? sample.getLocation() + " " : "";
//				sample.setLocation(helper + map.get(jsonKey));
//			}
//			if (key.contains("rock")) {
//				helper = sample.getRockType() != null ? sample.getRockType() + " " : "";
//				sample.setRockType(helper + map.get(jsonKey));
//			}
//			if (key.contains("age")) {
//				helper = sample.getAge() != null ? sample.getAge() + " " : "";
//				sample.setAge(helper + map.get(jsonKey));
//			}
//			if (key.contains("name") || key.contains("sample id")) {
//				helper = sample.getName() != null ? sample.getName() + " " : "";
//				sample.setName(helper + map.get(jsonKey));
//			}
//			if (key.contains("reference") || key.contains("citation")) {
//				helper = sample.getReference() != null ? sample.getReference() + " " : "";
//				sample.setReference(helper + map.get(jsonKey));
//			}
//			if (key.contains("longitud")) {
//				if (key.contains("max")) {
//					sample.setLongMax(Float.valueOf("" + map.get(jsonKey)));
//				} else {
//					sample.setLongMin(Float.valueOf("" + map.get(jsonKey)));
//				}
//			}
//			if (key.contains("latitud")) {
//				if (key.contains("max")) {
//					sample.setLatMax(Float.valueOf("" + map.get(jsonKey)));
//				} else {
//					sample.setLatMin(Float.valueOf("" + map.get(jsonKey)));
//				}
//			}
//		}
//
//		if (sample.getLocation() != null) {
//			insertBase += ", location";
//			values += ", ?";
//		}
//		if (sample.getAge() != null) {
//			insertBase += ", age";
//			values += ", ?";
//		}
//		if (sample.getRockType() != null) {
//			insertBase += ", rock_type";
//			values += ", ?";
//		}
//		if (sample.getReference() != null) {
//			insertBase += ", reference";
//			values += ", ?";
//		}
//
//		insertBase += values + ")";
//
//		try {
//			int position = 1;
//			Connection con = cm.createConnection();
//			ps = con.prepareStatement(insertBase);
//
//			if (sample.getMeta() != null) {
//				ps.setString(position, sample.getMeta());
//				position++;
//			}
//
//			if (sample.getLocation() != null) {
//				ps.setString(position, sample.getLocation());
//				position++;
//			}
//
//			if (sample.getAge() != null) {
//				ps.setString(position, sample.getAge());
//				position++;
//			}
//
//			if (sample.getRockType() != null) {
//				ps.setString(position, sample.getRockType());
//				position++;
//			}
//
//			if (sample.getReference() != null) {
//				ps.setString(position, sample.getReference());
//				position++;
//			}
//
//			ps.execute();
//			return sample;
//
//		} catch (Exception ex) {
//			ex.printStackTrace();
//			throw new DbException(ex);
//		} finally {
//			if (ps != null) {
//				ps.close();
//			}
//			cm.closeConnection();
//		}
//	}
//
//	private List<SampleBean> rsToSample(ResultSet rs) throws Exception {
//		ArrayList<SampleBean> samples = new ArrayList<SampleBean>();
//		HashMap<Long, SampleBean> index = new HashMap<Long, SampleBean>();
//
//		while (rs.next()) {
//			long sampleId = rs.getLong("id");
//			SampleBean sample = index.get(sampleId);
//			if (sample == null) {
//				sample = new SampleBean();
//				sample.setId(sampleId);
//				sample.setAge(rs.getString("age"));
//				sample.setComponents(new ArrayList<ComponentBean>());
//				sample.setLatMax(rs.getFloat("lat_max"));
//				sample.setLatMin(rs.getFloat("lat_min"));
//				sample.setLongMax(rs.getFloat("long_max"));
//				sample.setLongMin(rs.getFloat("long_min"));
//				sample.setMeta(rs.getString("meta"));
//				sample.setName(rs.getString("name"));
//				sample.setReference(rs.getString("reference"));
//				sample.setRockType(rs.getString("rock_type"));
//				index.put(sampleId, sample);
//			}
//
//			ComponentBean component = new ComponentBean(rs.getLong("component_id"), rs.getString("component"),
//					rs.getDouble("value"), rs.getString("um"));
//			sample.getComponents().add(component);
//		}
//
//		return samples;
//
//	}
}
