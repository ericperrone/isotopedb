package it.cnr.igg.isotopedb.queries;

import java.math.BigDecimal;
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
import it.cnr.igg.isotopedb.beans.ElementBean;

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
			String queryData = "select distinct si.sample_id, si.dataset_id, sa.type, sa.name, sa.svalue, sa.nvalue, c.latitude, c.longitude "
					+ "from sample_index si, sample_attribute sa "
					+ "left join coord c on c.sample_id = sa.sample_id "
					+ "where type in ('F', 'I', 'C') "
					+ "and sa.sample_id = si.sample_id ";
			if (filter.datasets.size() > 0) {
				queryData += " and si.dataset_id in (";
				for (DatasetBean db : filter.datasets) {
					queryData += db.getId() + ",";
				}
				queryData = queryData.substring(0, queryData.length() - 1);
				queryData += ")";
			}
			if (filter.geoCoord != null) {
				queryData += " and latitude >= " + filter.geoCoord.minLat + " and latitude <= " + filter.geoCoord.maxLat;
				queryData += " and longitude >= " + filter.geoCoord.minLong + " and longitude <= " + filter.geoCoord.maxLong;
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

			index.forEach((id, bean) -> beans.add(bean));

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
		String insertCoord = "insert into coordinates (sample_id, latitude, longitude) values (?, ?, ?)";
		try {
			ElementQuery eq = new ElementQuery();
			HashMap<String, ElementBean> hm = new HashMap<String, ElementBean>();

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

				Double[] coord = { null, null };

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

						String name = sfb.getFieldName().toLowerCase();
						if (name.contains("latitude")) {
							value = value.replaceAll(",", ".");
							coord[0] = Double.valueOf(value);
						}
						if (name.contains("longitude")) {
							value = value.replaceAll(",", ".");
							coord[1] = Double.valueOf(value);
						}
						if (coord[0] != null && coord[1] != null) {
							ps = con.prepareStatement(insertCoord);
							ps.setLong(1, sampleId);
							ps.setDouble(2, coord[0]);
							ps.setDouble(3, coord[1]);
							ps.execute();
							ps.close();
							ps = null;
						}
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
						if (!hm.containsKey(cb.getComponent().toLowerCase())) {
							hm.put(cb.getComponent().toLowerCase(), toElementBean(cb));
						}
					}
				}
			}
			ArrayList<ElementBean> ls = new ArrayList<ElementBean>();
			for (ElementBean em : hm.values()) {
				ls.add(em);
			}
			eq.testElements(ls, con);
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

	private ElementBean toElementBean(ComponentBean bean) {
		ElementBean cBean = new ElementBean();
		cBean.setIsotope(bean.getIsIsotope());
		cBean.setElement(bean.getComponent());
		return cBean;
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
}
