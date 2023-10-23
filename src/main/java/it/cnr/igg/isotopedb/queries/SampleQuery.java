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
import it.cnr.igg.isotopedb.beans.DatasetBean;

public class SampleQuery extends Query {
	public final String TYPE_FIELD = "F";
	public final String TYPE_ISOTOPE = "I";
	public final String TYPE_CHEM = "C";

	public SampleQuery() {
		super();
	}

	public ArrayList<SampleBean> querySamples(QueryFilter filter, Connection con) throws Exception, DbException {
		ArrayList<SampleBean> beans = new ArrayList<SampleBean>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			String queryData = "select distinct si.sample_id, si.dataset_id, sa.type, sa.name, sa.svalue, sa.nvalue "
					+ "from sample_index si, sample_attribute sa "
					+ "where type in ('F', 'I', 'C') "
					+ "and sa.sample_id = si.sample_id ";
			if (filter.datasets.size() > 0) {
				queryData += " and si.dataset_id in (";
				for (DatasetBean db : filter.datasets) {
					queryData += db.getId() + ",";
				}
				queryData = queryData.substring(0, queryData.length() - 1);
				queryData +=")";
			}
			queryData += " order by si.sample_id";

			System.out.println(queryData);
			HashMap<Long, SampleBean> index = new HashMap<Long, SampleBean>();

			ps = con.prepareStatement(queryData);
			rs = ps.executeQuery();
			while (rs.next()) {
				Long id = rs.getLong("sample_id");
				if (index.get(id) == null) {
					SampleBean bean = new SampleBean();
					Long datasetId = rs.getLong("dataset_id");
					if (datasetId > 0)
						bean.setDatasetId(datasetId);
					bean.setFields(new ArrayList<SampleFieldBean>());
					bean.setComponents(new ArrayList<ComponentBean>());
					index.put(id, bean);
				}
				String type = rs.getString("type");
				switch (type) {
				case TYPE_FIELD:
					index.get(id).getFields().add(setField(rs));
					break;
				case TYPE_ISOTOPE:
					index.get(id).getComponents().add(setIsotope(rs));
					break;
				case TYPE_CHEM:
					index.get(id).getComponents().add(setChem(rs));
					break;
				}
			}
			
			index.forEach( (id, bean) ->  beans.add(bean) );

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
		}
	}
	
	public ArrayList<SampleBean> querySamples(QueryFilter filter) throws Exception, DbException {
		try {
			Connection con = cm.createConnection();		
			return querySamples(filter, con);
		} catch (Exception ex) {
			ex.printStackTrace();
			throw new DbException(ex);
		} finally {
			cm.closeConnection();
		}
	}
	
	public void insertSamples(ArrayList<SampleBean> samples) throws Exception, DbException {
		PreparedStatement ps = null;
		ResultSet rs = null;
		Connection con = null;
		String insertSample = "insert into sample_index (ts, dataset_id) values(now(), ?);";
		String getSampleId = "SELECT currval(pg_get_serial_sequence(\'sample_index\',\'sample_id\')) as sample_id";
		String insertField = "insert into sample_attribute (sample_id, type, name, svalue) values (?, ?, ?, ?)";
		String insertChem = "insert into sample_attribute (sample_id, type, name, nvalue) values (?, ?, ?, ?)";
		try {
			con = cm.createConnection();
			con.setAutoCommit(false); // start transaction
			for (SampleBean sb : samples) {
				// step 1: insert master record
				ps = con.prepareStatement(insertSample);
				ps.setLong(1, sb.getDatasetId() >= 0 ? sb.getDatasetId() : null);
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

				// step 3: insert attributes
				List<SampleFieldBean> fields = sb.getFields();
				for (SampleFieldBean sfb : fields) {
					String value = sfb.getFieldValue();
					if (value != null && value.length() > 0) {
						ps = con.prepareStatement(insertField);
						ps.setLong(1, sampleId);
						ps.setString(2, TYPE_FIELD);
						ps.setString(3, sfb.getFieldName());
						ps.setString(4, value);
						ps.execute();
						ps.close();
						ps = null;
					}
				}

				// step 4: insert chemical components
				List<ComponentBean> components = sb.getComponents();
				for (ComponentBean cb : components) {
					Double value = cb.getValue();
					if (value != null && value != 0L) {
						ps = con.prepareStatement(insertChem);
						ps.setLong(1, sampleId);
						ps.setString(2, cb.getIsIsotope() == true ? TYPE_ISOTOPE : TYPE_CHEM);
						ps.setString(3, cb.getComponent());
						ps.setDouble(4, value);
						ps.execute();
						ps.close();
						ps = null;
					}
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

	
	private SampleFieldBean setField(ResultSet rs) throws Exception {
		SampleFieldBean sfb = new SampleFieldBean();
		sfb.setFieldName(rs.getString("name"));
		sfb.setFieldValue(rs.getString("svalue"));
		return sfb;
	}
	
	private ComponentBean setIsotope(ResultSet rs) throws Exception {
		ComponentBean sfb = new ComponentBean();
		sfb.setComponent(rs.getString("name"));
		sfb.setValue(rs.getDouble("nvalue"));
		sfb.setIsIsotope(true);
		return sfb;
	}

	private ComponentBean setChem(ResultSet rs) throws Exception {
		ComponentBean sfb = new ComponentBean();
		sfb.setComponent(rs.getString("name"));
		sfb.setValue(rs.getDouble("nvalue"));
		sfb.setIsIsotope(false);
		return sfb;
	}


//	private ArrayList<Long> createIndex(Connection con, List<QueryFilter> filters) throws Exception {
//		String queryBase = "select sample_id from (";
//		String queryField = "select distinct sample_id from sample_element where 1=1 ";
//		String queryChem = "select distinct sample_id from sample_element where 1=1 ";
//		ArrayList<Object> values = new ArrayList<Object>();
//		if (filters != null) {
//			for (QueryFilter qf : filters) {
//				if (qf.type == QueryFilter.DataType.FIELD) {
//					queryField += " and lower(field) like ?";
//					values.add(("%" + qf.queryItem + "%").toLowerCase());
//					switch (qf.operator) {
//					case EQ:
//					default:
//						queryField += " and lower(value) like ?";
//						values.add(("%" + qf.val + "%").toLowerCase());
//						break;
//					// inserire tutti gli altri casi
//					}
//				} else if (qf.type == QueryFilter.DataType.ISOTOPE) {
//					queryChem += "and isotope=true and lower(field) like ?";
//					values.add(("%" + qf.queryItem + "%").toLowerCase());
//					switch (qf.operator) {
//					case EQ:
//					default:
//						queryChem += " and value = ";
//						values.add((Double) qf.val);
//						break;
//					// inserire tutti gli altri casi
//					}
//
//				} else {
//					queryChem += " and lower(field) like ?";
//					values.add(("%" + qf.queryItem + "%").toLowerCase());
//					switch (qf.operator) {
//					case EQ:
//					default:
//						queryChem += " and value = ";
//						values.add((Double) qf.val);
//						break;
//					// inserire tutti gli altri casi
//					}
//				}
//			}
//		}
//		queryBase += queryField + " and sample_id in (";
//		queryBase += queryChem + ")) as index ";
//		queryBase += "order by sample_id";
//
//		PreparedStatement ps = null;
//		ResultSet rs = null;
//		try {
//			ps = con.prepareStatement(queryBase);
//			for (int i = 0; i < values.size(); i++) {
//				Object v = values.get(i);
//				if (v instanceof Double)
//					ps.setDouble(i + 1, (Double) v);
//				else
//					ps.setString(i + 1, "" + v);
//			}
//			rs = ps.executeQuery();
//			ArrayList<Long> index = new ArrayList<Long>();
//			while (rs.next()) {
//				index.add(rs.getLong(1));
//			}
//			return index;
//		} catch (SQLException e) {
//			e.printStackTrace();
//			throw e;
//		} finally {
//			if (rs != null)
//				rs.close();
//			if (ps != null)
//				ps.close();
//		}
//	}

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
		Boolean isotope = rs.getBoolean("isotope");
		cb.setComponent(component);
		cb.setValue(value);
		cb.setIsIsotope(isotope);
		return cb;
	}

//	public void insert(ArrayList<SampleBean> samples) throws Exception, DbException {
//		PreparedStatement ps = null;
//		ResultSet rs = null;
//		Connection con = null;
//		String insertSample = "insert into sample_index (ts) values(now());";
//		String getSampleId = "SELECT currval(pg_get_serial_sequence(\'sample_index\',\'sample_id\')) as sample_id";
//		String insertField = "insert into sample_element (sample_id, field, value) values (?, ?, ?)";
//		String insertChem = "insert into chem_component (sample_id, element, value, isotope) values (?, ?, ?, ?)";
//		try {
//			con = cm.createConnection();
//			con.setAutoCommit(false); // start transaction
//			for (SampleBean sb : samples) {
//				// step 1: insert master record
//				ps = con.prepareStatement(insertSample);
//				ps.execute();
//				ps.close();
//				ps = null;
//
//				// step 2: get master record id
//				ps = con.prepareStatement(getSampleId);
//				rs = ps.executeQuery();
//				if (!rs.next())
//					throw new DbException("Invalid sequence value");
//				Long sampleId = rs.getLong("sample_id");
//				rs.close();
//				rs = null;
//				ps.close();
//				ps = null;
//
//				// step 3: insert sample fields
//				List<SampleFieldBean> fields = sb.getFields();
//				for (SampleFieldBean sfb : fields) {
//					String value = sfb.getFieldValue();
//					if (value != null && value.length() > 0) {
//						ps = con.prepareStatement(insertField);
//						ps.setLong(1, sampleId);
//						ps.setString(2, sfb.getFieldName());
//						ps.setString(3, value);
//						ps.execute();
//						ps.close();
//						ps = null;
//					}
//				}
//
//				// step 4: insert chemical components
//				List<ComponentBean> components = sb.getComponents();
//				for (ComponentBean cb : components) {
//					Double value = cb.getValue();
//					if (value != null && value != 0L) {
//						ps = con.prepareStatement(insertChem);
//						ps.setLong(1, sampleId);
//						ps.setString(2, cb.getComponent());
//						ps.setDouble(3, value);
//						ps.setBoolean(4, cb.getIsIsotope());
//						ps.execute();
//						ps.close();
//						ps = null;
//					}
//				}
//			}
//			con.commit();
//		} catch (Exception ex) {
//			if (con != null)
//				con.rollback();
//			ex.printStackTrace();
//			throw new DbException(ex);
//		} finally {
//			if (rs != null) {
//				rs.close();
//			}
//			if (ps != null) {
//				ps.close();
//			}
//			con.setAutoCommit(true); // end transaction
//			cm.closeConnection();
//		}
//	}

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
