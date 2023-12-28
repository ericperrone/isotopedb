package it.cnr.igg.isotopedb.queries;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.security.MessageDigest;

import it.cnr.igg.isotopedb.beans.AdministratorBean;
import it.cnr.igg.isotopedb.exceptions.DbException;
import it.cnr.igg.isotopedb.tools.CommonTools;

public class AdministratorQuery extends Query {

	public AdministratorQuery() {
		super();
	}

	public AdministratorBean getAdministrator(String account) throws DbException, Exception {
		Connection con = null;
		try {
			con = cm.createConnection();
			con.setAutoCommit(false); // start transaction
			return getAdministrator(account, con);
		} catch (Exception ex) {
			ex.printStackTrace();
			throw new DbException(ex);
		} finally {
			if (con != null) {
				con.setAutoCommit(true);
				cm.closeConnection();
			}
		}
	}

	public AdministratorBean getAdministrator(String account, Connection con) throws DbException, Exception {
		String select = "select * from administrators where lower(account) = ?";
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = con.prepareStatement(select);
			ps.setString(1, account.toLowerCase());
			rs = ps.executeQuery();
			if (rs.next()) {
				return new AdministratorBean(Long.valueOf(rs.getLong("id")), rs.getString("account"),
						rs.getString(rs.getString("email")));
			} else {
				throw new DbException("User " + account + " not found.");
			}
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

	public String generatePassword(String password) throws Exception {
		return CommonTools.Sha256(password);
	}

	public static void main(String[] args) {
		AdministratorQuery query = new AdministratorQuery();
		try {
			String p = query.generatePassword("cippalippa00");
			System.out.println(p);
			p = query.generatePassword("cippalippa02");
			System.out.println(p);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
