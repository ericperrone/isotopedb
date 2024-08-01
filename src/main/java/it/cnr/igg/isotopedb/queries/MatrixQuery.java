package it.cnr.igg.isotopedb.queries;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import it.cnr.igg.isotopedb.beans.MatrixAlias;
import it.cnr.igg.isotopedb.beans.MatrixBean;
import it.cnr.igg.isotopedb.exceptions.DbException;

public class MatrixQuery extends Query {

	private String baseQuery = "select m.id, m.matrix, m.parent_id, m.level from matrix m where 1=1 ";
	private String baseOrderBy = "order by m.level, m.matrix";
	
	public MatrixQuery() {
		super();
	}
	
	public ArrayList<MatrixBean> getAll() throws DbException {
		Connection con = null;
		try {
			con = cm.createConnection();
			return getAll(con);
		} catch (Exception ex) {
			ex.printStackTrace();
			throw new DbException(ex.getMessage());
		} finally {
			cm.closeConnection();
		}
	}
	
	public ArrayList<MatrixBean> getAll(Connection con) throws Exception, DbException {
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ArrayList<MatrixBean> m = new ArrayList<MatrixBean>();
			ps = con.prepareStatement(baseQuery + baseOrderBy);
			rs = ps.executeQuery();
			while (rs.next()) {
				m.add(new MatrixBean(rs.getLong("id"), rs.getLong("parent_id"), rs.getInt("level"), rs.getString("matrix")));
			}
			return m;
		} catch (Exception ex) {
			throw ex;
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (ps != null) {
				ps.close();
			}
		}
	}
	
	public ArrayList<MatrixBean> getByAlias(String alias) throws DbException {
		Connection con = null;
		try {
			con = cm.createConnection();
			return getByAlias(con, alias);
		} catch (Exception ex) {
			ex.printStackTrace();
			throw new DbException(ex.getMessage());
		} finally {
			cm.closeConnection();
		}		
	}
	
	public ArrayList<MatrixBean> getByAlias(Connection con, String alias) throws Exception, DbException {
		String query = "select m.id, m.matrix, m.level, m.parent_id from matrix m where m.id = (select ma.matrix_id from matrix_aliases ma where ma.alias = ?)";
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ArrayList<MatrixBean> m = new ArrayList<MatrixBean>();
			ps = con.prepareStatement(query);
			ps.setString(1, alias);
			rs = ps.executeQuery();
			while (rs.next()) {
				m.add(new MatrixBean(rs.getLong("id"), rs.getLong("parent_id"), rs.getInt("level"), rs.getString("matrix")));
			}
			return m;
		} catch (Exception ex) {
			throw ex;
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
