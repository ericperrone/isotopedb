package it.cnr.igg.isotopedb.queries;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import it.cnr.igg.isotopedb.beans.MeasureUnitBean;
import it.cnr.igg.isotopedb.exceptions.DbException;
import it.cnr.igg.isotopedb.tools.CommonTools;

public class MeasureUnitQuery extends Query {

	public MeasureUnitQuery() {
		super();
	}

	public ArrayList<MeasureUnitBean> getAll() throws DbException {
		Connection con = null;
		try {
			con = cm.createConnection();
			return getAll(con);
		} catch (Exception ex) {
			ex.printStackTrace();
			throw new DbException(ex);
		} finally {
			if (con != null) {
				cm.closeConnection();
			}
		}
	}

	public ArrayList<MeasureUnitBean> getAll(Connection conn) throws Exception {
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement("select * from measure_unit");
			rs = ps.executeQuery();
			
			ArrayList<MeasureUnitBean> beans = new ArrayList<MeasureUnitBean>();
			
			while (rs.next()) {
				beans.add(new MeasureUnitBean(rs.getString(1), rs.getDouble(2)));
			}
			
			return beans;
			
		} catch (Exception ex) {
			ex.printStackTrace();
			throw new DbException(ex.getMessage());
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (ps != null) {
				ps.close();
			}
		}
	}

}
