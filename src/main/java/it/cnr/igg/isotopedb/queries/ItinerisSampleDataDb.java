package it.cnr.igg.isotopedb.queries;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import it.cnr.igg.isotopedb.beans.SampleDataBean;
import it.cnr.igg.isotopedb.exceptions.DbException;
import it.cnr.igg.isotopedb.exceptions.NotAuthorizedException;

public class ItinerisSampleDataDb extends ItinerisCommon {

	public ItinerisSampleDataDb(String key) {
		super(key);
	}
	
	public ArrayList<SampleDataBean> getSampleData(Integer sampleId) throws DbException, NotAuthorizedException {
		Connection con = null;
		PreparedStatement ps = null;
		String query = "select sa.type, sa.name, sa.svalue, sa.nvalue, um from sample_attribute sa "
				+ "where sa.sample_id = ?";
		ArrayList<SampleDataBean> list = new ArrayList<SampleDataBean>();
		try {
			con = checkItinerisKey();
			ps = con.prepareStatement(query);
			ps.setInt(1, sampleId);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				SampleDataBean sdb = new SampleDataBean(rs.getString("type"),
						rs.getString("name"),
						rs.getString("svalue"),
						rs.getFloat("nvalue"),
						rs.getString("um"));
				list.add(sdb);
			}
			return list;
		} catch (Exception ex) {
			ex.printStackTrace();
			throw new DbException(ex);
		} finally {
			if (con != null) {
				cm.closeConnection();
			}
		}	
	}
}
