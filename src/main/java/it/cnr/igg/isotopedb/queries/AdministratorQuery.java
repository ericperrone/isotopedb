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

	public AdministratorBean putAdministrator(AdministratorBean bean) throws DbException, Exception {
		Connection con = null;
		try {
			con = cm.createConnection();
			return putAdministrator(bean, con);
		} catch (Exception ex) {
			ex.printStackTrace();
			throw new DbException(ex);
		} finally {
			if (con != null) {
				cm.closeConnection();
			}
		}
	}

	public AdministratorBean putAdministrator(AdministratorBean bean, Connection con) throws DbException, Exception {
		String insert = "insert into administrators (account, password, email) values(?, ?, ?)";
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = con.prepareStatement(insert);
			ps.setString(1, bean.getAccount());
			ps.setString(2, generatePassword(bean.getPassword()));
			ps.setString(3, bean.getEmail());

			ps.execute();
			bean = getAdministrator(bean.getAccount());
			bean.setPassword("");
			return bean;
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

	public boolean changePassword(String account, String password) throws DbException, Exception {
		Connection con = null;
		try {
			con = cm.createConnection();
			return changePassword(account, password, con);
		} catch (Exception ex) {
			ex.printStackTrace();
			throw new DbException(ex);
		} finally {
			if (con != null) {
				cm.closeConnection();
			}
		}
	}

	public boolean changePassword(String account, String password, Connection con) throws DbException, Exception {
		String update = "update administrators set password = ? where account = ?";
		PreparedStatement ps = null;
		try {
			ps = con.prepareStatement(update);
			ps.setString(1, generatePassword(password));
			ps.setString(2, account);
			return ps.execute();
		} catch (Exception ex) {
			ex.printStackTrace();
			throw new DbException(ex.getMessage());
		} finally {
			if (ps != null) {
				ps.close();
			}
		}
	}

	public String login(AdministratorBean bean) throws DbException, Exception {
		Connection con = null;
		PreparedStatement ps = null;
		try {
			con = cm.createConnection();
			String registered = getPassword(bean.getAccount(), con);
			String password = generatePassword(bean.getPassword());
			if (!password.equals(registered))
				throw new DbException("Invalid password");
			String key = generateToken(bean.getAccount());
			ps = con.prepareStatement("update administrators set key=? where account=?");
			ps.setString(1, key);
			ps.setString(2, bean.getAccount());
			ps.execute();
			return key;
		} catch (Exception ex) {
			ex.printStackTrace();
			throw new DbException(ex);
		} finally {
			if (ps != null) {
				ps.close();
			}
			if (con != null) {
				cm.closeConnection();
			}
		}
	}
	
	public AdministratorBean checkKey(String key) throws DbException, Exception {
		Connection con = null;
		try {
			con = cm.createConnection();
			return checkKey(key, con);
		} catch (Exception ex) {
			ex.printStackTrace();
			throw new DbException(ex);
		} finally {
			if (con != null) {
				cm.closeConnection();
			}
		}		
	}
	
	public AdministratorBean checkKey(String key, Connection con) throws DbException, Exception  {
		PreparedStatement ps = null;
		ResultSet rs = null;
		String query = "select * from administrators where key = ?";
		try {
			ps = con.prepareStatement(query);
			ps.setString(1, key);
			rs = ps.executeQuery();
			if (rs.next()) {
				return new AdministratorBean(rs.getLong("id"), 
						rs.getString("account"), 
						rs.getString("email"), 
						rs.getTimestamp("expiration") == null);
			}
			throw new DbException("User not authorized or not logged in");
		} catch (Exception ex) {
			ex.printStackTrace();
			throw new DbException(ex);
		} finally {
			if (ps != null) {
				ps.close();
			}
			if (con != null) {
				cm.closeConnection();
			}
		}
	}
	
	public String getPassword(String account) throws DbException, Exception {
		Connection con = null;
		try {
			con = cm.createConnection();
			return getPassword(account, con);
		} catch (Exception ex) {
			ex.printStackTrace();
			throw new DbException(ex);
		} finally {
			if (con != null) {
				cm.closeConnection();
			}
		}		
	}
	
	public String getPassword(String account, Connection con) throws DbException, Exception {
		String select = "select password from administrators where lower(account) = ?";
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = con.prepareStatement(select);
			ps.setString(1, account.toLowerCase());
			rs = ps.executeQuery();
			if (rs.next()) {			
				return rs.getString("password");
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

	public AdministratorBean getAdministrator(String account) throws DbException, Exception {
		Connection con = null;
		try {
			con = cm.createConnection();
			return getAdministrator(account, con);
		} catch (Exception ex) {
			ex.printStackTrace();
			throw new DbException(ex);
		} finally {
			if (con != null) {
				cm.closeConnection();
			}
		}
	}

	public AdministratorBean getAdministrator(String account, Connection con) throws DbException, Exception {
		String select = "select id, account, email, expiration from administrators where lower(account) = ?";
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = con.prepareStatement(select);
			ps.setString(1, account.toLowerCase());
			rs = ps.executeQuery();
			if (rs.next()) {
				boolean active = rs.getTimestamp(4) == null;
				return new AdministratorBean(Long.valueOf(rs.getLong("id")), rs.getString("account"),
						rs.getString("email"), active);
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

	public String generateToken(String account) throws Exception {
		String token = account + ":" + System.currentTimeMillis();
		return CommonTools.Sha256(token);
	}

	public static void main(String[] args) {
		AdministratorQuery query = new AdministratorQuery();
		try {
			String p = query.generatePassword("cippalippa00");
			System.out.println(p);
			p = query.generatePassword("cippalippa02");
			System.out.println(p);
			p = query.generateToken("ericperrone");
			System.out.println(p);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
