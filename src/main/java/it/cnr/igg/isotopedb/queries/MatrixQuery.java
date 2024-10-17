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

	private String baseQuery = "select m.matrix, m.nodeid, m.parent_nodeid from matrix m where 1=1 ";
	private String baseOrderBy = "order by m.nodeid, m.matrix";

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
				m.add(new MatrixBean(rs.getLong("nodeid"), rs.getLong("parent_nodeid"), rs.getString("matrix")));
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

	public ArrayList<MatrixBean> getByName(String name) throws DbException {
		Connection con = null;
		try {
			con = cm.createConnection();
			return getByName(con, name);
		} catch (Exception ex) {
			ex.printStackTrace();
			throw new DbException(ex.getMessage());
		} finally {
			cm.closeConnection();
		}
	}

	public ArrayList<MatrixBean> getByName(Connection con, String name) throws Exception, DbException {
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			String query = baseQuery + " and lower(matrix) = ? " + baseOrderBy;
			ArrayList<MatrixBean> m = new ArrayList<MatrixBean>();
			ps = con.prepareStatement(query);
			ps.setString(1, name.toLowerCase());
			rs = ps.executeQuery();
			while (rs.next()) {
				m.add(new MatrixBean(rs.getLong("nodeid"), rs.getLong("parent_nodeid"), rs.getString("matrix")));
			}
			if (m.size() == 0)
				m = getByAlias(con, name);
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
		String query = "select m.nodeid , m.matrix, m.parent_nodeid from matrix m where m.nodeid = (select ma.matrix_id from matrix_aliases ma where ma.alias = ?)";
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			ArrayList<MatrixBean> m = new ArrayList<MatrixBean>();
			ps = con.prepareStatement(query);
			ps.setString(1, alias);
			rs = ps.executeQuery();
			while (rs.next()) {
				m.add(new MatrixBean(rs.getLong("nodeid"), rs.getLong("parent_nodeid"), rs.getString("matrix")));
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

	public void insertSampleMatrix(Long sampleId, ArrayList<MatrixBean> beans) throws Exception, DbException {
		Connection con = null;
		try {
			con = cm.createConnection();
			insertSampleMatrix(con, sampleId, beans);
		} catch (Exception ex) {
			ex.printStackTrace();
			throw new DbException(ex.getMessage());
		} finally {
			cm.closeConnection();
		}
	}

	public void insertSampleMatrix(Connection con, Long sampleId, ArrayList<MatrixBean> beans)
			throws Exception, DbException {
		String insert = "insert into sample_matrix (sample_id, matrix_id) values (?, ?)";
		PreparedStatement ps = null;
		try {
			for (MatrixBean mb : beans) {
				ps = con.prepareStatement(insert);
				ps.setLong(1, sampleId);
				ps.setLong(2, mb.getNodeId());
				ps.execute();
				ps.close();
				ps = null;
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			throw new DbException(ex.getMessage());
		} finally {
			if (ps != null) {
				ps.close();
			}
		}
	}

}
