package it.cnr.igg.isotopedb.queries;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import it.cnr.igg.isotopedb.beans.DatasetBean;
import it.cnr.igg.isotopedb.exceptions.DbException;
import it.cnr.igg.isotopedb.tools.QueryFilter;

public class DatasetQuery extends Query {

	public DatasetQuery() {
		super();
	}

	public void deleteDataset(Long id) throws Exception, DbException {
		PreparedStatement ps = null;
		Connection con = null;
		String delete = "delete from dataset where id = ?";
		try {
			con = cm.createConnection();
			ps = con.prepareStatement(delete);
			ps.setLong(1, id);
			ps.execute();
		} catch (Exception ex) {
			throw new DbException(ex);
		} finally {
			if (ps != null) {
				ps.close();
			}
			cm.closeConnection();
		}
	}

	public DatasetBean insertDataset(DatasetBean bean) throws Exception, DbException {
		PreparedStatement ps = null;
		ResultSet rs = null;
		Connection con = null;
		String insert = "insert into dataset (file_name, metadata, processed, link, authors, year) values (?,?,?,?,?,?)";
		String getId = "SELECT currval(pg_get_serial_sequence(\'dataset\',\'id\')) as id";
		try {
			con = cm.createConnection();
			con.setAutoCommit(false); // start transaction
			ps = con.prepareStatement(insert);
			ps.setString(1, bean.getFileName());
			ps.setString(2, bean.getMetadata());
			ps.setBoolean(3, false);
			ps.setString(4, bean.getLink());
			ps.setString(5, bean.getAuthors());
			ps.setInt(6, bean.getYear());
			ps.execute();
			ps.close();
			ps = null;

			ps = con.prepareStatement(getId);
			rs = ps.executeQuery();
			if (!rs.next())
				throw new DbException("Invalid sequence value");
			Long datasetId = rs.getLong("id");
			
			setAuthors(datasetId, bean.getAuthors(), con);
			
			con.commit();
			bean.setId(datasetId);
			return bean;
		} catch (Exception ex) {
			if (con != null)
				con.rollback();
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
	
	private void setAuthors(Long datasetId, String authors, Connection con) throws Exception {
		if (authors == null)
			return;
		String[] auths = authors.split(";");
		PreparedStatement ps = null;
		ResultSet rs = null;
		for (int i = 0; i < auths.length; i++) {
			String insert = "insert into dataset_authors (dataset_id, author_id) values (?, ?)";
			String query = "select id from authors where lower(surname) = ? and lower(name) = ?";
			String[] a = auths[i].split(",");
			String surname = a[0].toLowerCase().trim();
			String name = a[1].toLowerCase().trim();
			Long authorId = -1L;
			try {
				ps = con.prepareStatement(query);
				ps.setString(1, surname);
				ps.setString(2, name);
				rs = ps.executeQuery();
				if (rs.next()) {
					authorId = rs.getLong("id");
				}
				rs.close();
				ps.close();
				if (authorId == -1L)
					throw new DbException("Author not found: " + surname + " " + name);
				ps = con.prepareStatement(insert);
				ps.setLong(1, datasetId);
				ps.setLong(2,  authorId);
				ps.execute();
				ps.close();
			} catch (Exception x) {
				x.printStackTrace();
				throw x;
			} finally {
				if (rs != null)
					rs.close();
				if (ps != null) 
					rs.close();
			}
			
		}
	}
	
	public void updateProcessed(DatasetBean bean) throws Exception, DbException {
		PreparedStatement ps = null;
		Connection con = null;
		String update = "update dataset set processed=? where id=?";
		try {
			con = cm.createConnection();
			con.setAutoCommit(false); // start transaction
			ps = con.prepareStatement(update);

			ps.setBoolean(1, bean.isProcessed());
			ps.setLong(2, bean.getId());

			ps.execute();
		} catch (Exception ex) {
			if (con != null)
				con.rollback();
			throw new DbException(ex);
		} finally {
			if (ps != null) {
				ps.close();
			}
			con.setAutoCommit(true); // end transaction
			cm.closeConnection();
		}
	}

	public ArrayList<DatasetBean> queryDatasets(QueryFilter queryFilter, Connection con) throws Exception, DbException {
		ArrayList<DatasetBean> beans = new ArrayList<DatasetBean>();
		if (queryFilter.authors != null || queryFilter.keywords != null || queryFilter.ref != null
				|| queryFilter.year > 0) {
			PreparedStatement ps = null;
			ResultSet rs = null;
			String query = "select * from dataset where processed=true";

			if (queryFilter.authors != null) {
				query += " and id in (select dataset_id from dataset_authors where author_id in (select id from authors where (";
				for (String auth : queryFilter.authors) {
					String[] a = auth.split(",");
					String surname = a[0].toLowerCase().trim();
					String name = a[1].toLowerCase().trim();
					query += "(lower(surname) like '%" + surname + "%' and lower(name) like '%" + name + "%') or "; 
				}
				
				query = query.substring(0, query.length() - 4);
				query += ")))";
				
//				query += " and lower(authors) similar to '%(";
//				for (String auth : queryFilter.authors) {
//					query += "(" + auth.toLowerCase() + ")|";
//				}
//				query = query.substring(0, query.length() - 1);
//				query += ")%'";
			}

			if (queryFilter.keywords != null) {
				query += " and lower(metadata) similar to '%(";
				for (String key : queryFilter.keywords) {
					query += "(" + key.toLowerCase() + ")|";
				}
				query = query.substring(0, query.length() - 1);
				query += ")%'";
			}

			if (queryFilter.ref != null) {
				query += " and lower(link) like ?";
			}

			if (queryFilter.year > 0) {
				query += " and year = ?";
			}
			try {
				con = cm.createConnection();
				ps = con.prepareStatement(query);
				int position = 1;
				if (queryFilter.ref != null) {
					ps.setString(position, "%" + queryFilter.ref.toLowerCase() + "%");
					position++;
				}
				if (queryFilter.year > 0) {
					ps.setInt(position, queryFilter.year);
					position++;
				}

				rs = ps.executeQuery();

				while (rs.next()) {
					DatasetBean bean = new DatasetBean(rs.getLong("id"), rs.getString("file_name"),
							rs.getString("metadata"), rs.getString("authors"), rs.getString("link"), rs.getInt("year"),
							rs.getBoolean("processed"));
					beans.add(bean);
				}
			} catch (Exception ex) {
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
		return beans;

	}

	public ArrayList<DatasetBean> queryDatasets(QueryFilter queryFilter) throws Exception, DbException {
		Connection con = null;
		try {
			con = cm.createConnection();
			return queryDatasets(queryFilter, con);
		} catch (Exception ex) {
			throw new DbException(ex);
		} finally {
			cm.closeConnection();
		}
	}

	public ArrayList<DatasetBean> getDatasets(DatasetBean filter, boolean processedFilter)
			throws Exception, DbException {
		PreparedStatement ps = null;
		ResultSet rs = null;
		Connection con = null;
		String query = "select * from dataset where 1=1";
		if (filter.getId() > 0) {
			query += " and id = ?";
		}
		if (filter.getFileName() != null) {
			query += " and lower(file_name) like ?";
		}
		if (filter.getMetadata() != null) {
			query += " and metadata like ?";
		}
		if (filter.getLink() != null) {
			query += " and lower(link) like ?";
		}
		if (processedFilter == true) {
			query += " and processed = ?";
		}
		if (filter.getAuthors() != null) {
			String[] authors = filter.getAuthors().split(",");
			query += " and lower(authors) similar to '%(";
			for (int i = 0; i < authors.length - 2; i++) {
				query += "(" + authors[i].toLowerCase().trim() + ")|";
			}
			query += "(" + authors[authors.length - 1].toLowerCase().trim() + ")";
			query += ")%'";
		}
		if (filter.getMetadata() != null) {
			String[] keywords = filter.getMetadata().split(" ");
			query += " and lower(metadata) similar to '%(";
			for (int i = 0; i < keywords.length - 2; i++) {
				query += "(" + keywords[i].toLowerCase().trim() + ")|";
			}
			query += "(" + keywords[keywords.length - 1].toLowerCase().trim() + ")";
			query += ")%'";
		}

		ArrayList<DatasetBean> beans = new ArrayList<DatasetBean>();
		try {
			con = cm.createConnection();
			ps = con.prepareStatement(query);
			int position = 1;
			if (filter.getId() > 0) {
				ps.setLong(position, filter.getId());
				position++;
			}
			if (filter.getFileName() != null) {
				ps.setString(position, "%" + filter.getFileName().toLowerCase() + "%");
				position++;
			}
			if (filter.getMetadata() != null) {
				ps.setString(position, "%" + filter.getLink().toLowerCase() + "%");
				position++;
			}
			if (processedFilter == true) {
				ps.setBoolean(position, filter.isProcessed());
			}

			rs = ps.executeQuery();

			while (rs.next()) {
				DatasetBean bean = new DatasetBean(rs.getLong("id"), rs.getString("file_name"),
						rs.getString("metadata"), rs.getString("authors"), rs.getString("link"), rs.getInt("year"),
						rs.getBoolean("processed"));
				beans.add(bean);
			}

			return beans;
		} catch (Exception ex) {
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

}
