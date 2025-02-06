package it.cnr.igg.isotopedb.queries;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import it.cnr.igg.isotopedb.beans.DatasetBean;
import it.cnr.igg.isotopedb.exceptions.DbException;
import it.cnr.igg.isotopedb.exceptions.NoDatasetFoundException;
import it.cnr.igg.isotopedb.tools.QueryFilter;
import it.cnr.igg.isotopedb.tools.QueryFilterItem;

public class DatasetQuery extends Query {

	public DatasetQuery() {
		super();
	}

	public String deleteDataset(Long id) throws Exception, DbException {
		PreparedStatement ps = null;
		ResultSet rs = null;
		Connection con = null;
		String query = "select file_name from dataset where id = ?";
		String deleteRef = "delete from dataset_authors where dataset_id = ?";
		String delete = "delete from dataset where id = ?";
		try {
			con = cm.createConnection();
			ps = con.prepareStatement(query);
			ps.setLong(1, id);
			rs = ps.executeQuery();
			String fileName = "";
			if (rs.next()) {
				fileName = rs.getString(1);
			}
			rs.close();
			rs = null;
			ps.close();
			ps = con.prepareStatement(deleteRef);
			ps.setLong(1, id);
			ps.execute();
			ps.close();
			ps = con.prepareStatement(delete);
			ps.setLong(1, id);
			ps.execute();
			return fileName;
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

	public ArrayList<Integer> getYears(Connection con) throws Exception, DbException {
		PreparedStatement ps = null;
		ResultSet rs = null;
		String query = "select distinct year from dataset order by year";
		try {
			ArrayList<Integer> list = new ArrayList<Integer>();
			ps = con.prepareStatement(query);
			rs = ps.executeQuery();
			while (rs.next()) {
				list.add(rs.getInt(1));
			}
			return list;
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

	public ArrayList<Integer> getYears() throws Exception, DbException {
		Connection con = null;
		try {
			con = cm.createConnection();
			return getYears(con);
		} catch (Exception ex) {
			throw new DbException(ex);
		} finally {
			cm.closeConnection();
		}
	}

	public ArrayList<String> getLinks() throws Exception, DbException {
		Connection con = null;
		try {
			con = cm.createConnection();
			return getLinks(con);
		} catch (Exception ex) {
			throw new DbException(ex);
		} finally {
			cm.closeConnection();
		}
	}

	public ArrayList<String> getLinks(Connection con) throws Exception, DbException {
		PreparedStatement ps = null;
		ResultSet rs = null;
		String query = "select distinct link from dataset order by link";
		try {
			ArrayList<String> list = new ArrayList<String>();
			ps = con.prepareStatement(query);
			rs = ps.executeQuery();
			while (rs.next()) {
				list.add(rs.getString(1));
			}
			return list;
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

	public DatasetBean insertDataset(DatasetBean bean) throws Exception, DbException {
		Connection con = null;
		try {
			con = cm.createConnection();
			con.setAutoCommit(false); // start transaction
			bean = insertDataset(bean, false, con);
			con.commit();
			return bean;
		} catch (Exception ex) {
			if (con != null)
				con.rollback();
			throw new DbException(ex);
		} finally {
			con.setAutoCommit(true); // end transaction
			cm.closeConnection();
		}
	}

	public DatasetBean insertDataset(DatasetBean bean, boolean processed, Connection con)
			throws Exception, DbException {
		PreparedStatement ps = null;
		ResultSet rs = null;
		String insert = "insert into dataset (file_name, keywords, processed, link, authors, year, metadata) values (?,?,?,?,?,?,?)";
		String getId = "SELECT currval(pg_get_serial_sequence(\'dataset\',\'id\')) as id";
		try {
			ps = con.prepareStatement(insert);
			ps.setString(1, bean.getFileName());
			ps.setString(2, bean.getKeywords());
			ps.setBoolean(3, processed);
			ps.setString(4, bean.getLink());
			ps.setString(5, bean.getAuthors());
			ps.setInt(6, bean.getYear());
			ps.setString(7, bean.getMetadata() == null ? "" : bean.getMetadata());
			ps.execute();
			ps.close();
			ps = null;

			ps = con.prepareStatement(getId);
			rs = ps.executeQuery();
			if (!rs.next())
				throw new DbException("Invalid sequence value");
			Long datasetId = rs.getLong("id");

			setAuthors(datasetId, bean.getAuthors(), con);

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
		}
	}

	private void setAuthors(Long datasetId, String authors, Connection con) throws Exception {
		if (authors == null || authors.length() < 1)
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
				ps.setLong(2, authorId);
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

	public String updateProcessed(DatasetBean bean) throws Exception, DbException {
		PreparedStatement ps = null;
		ResultSet rs = null;
		Connection con = null;
		String query = "select file_name from dataset where id = ?";
		String update = "update dataset set processed=? where id=?";
		try {
			con = cm.createConnection();
			con.setAutoCommit(false); // start transaction

			String fileName = "";
			ps = con.prepareStatement(query);
			ps.setLong(1, bean.getId());
			rs = ps.executeQuery();
			if (rs.next()) {
				fileName = rs.getString("file_name");
			}
			rs.close();
			rs = null;
			ps.close();
			ps = null;

			ps = con.prepareStatement(update);

			ps.setBoolean(1, bean.isProcessed());
			ps.setLong(2, bean.getId());

			ps.execute();

			return fileName;
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

	public DatasetBean findByLink(String link, Connection con) throws Exception, DbException {
		PreparedStatement ps = null;
		ResultSet rs = null;
		String query = "select * from dataset where link=?";
		try {
			con = cm.createConnection();
			ps = con.prepareStatement(query);
			ps.setString(1, link);
			int position = 1;
			rs = ps.executeQuery();

			if (rs.next()) {
				DatasetBean bean = new DatasetBean(rs.getLong("id"), rs.getString("file_name"),
						rs.getString("keywords"), rs.getString("authors"), rs.getString("link"),
						rs.getString("metadata"), rs.getInt("year"), rs.getBoolean("processed"));
				return bean;
			}
			return null;
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

	public ArrayList<QueryFilterItem> findDatasetByAuthorList(ArrayList<QueryFilter> filters, Connection con)
			throws Exception, NoDatasetFoundException, DbException {
		if (filters.size() == 0)
			throw new NoDatasetFoundException("No author filter.");
		ArrayList<QueryFilterItem> list = new ArrayList<QueryFilterItem>();
		String query = "select * from dataset where ";
		String subQuery = "";
		for (QueryFilter f : filters) {
			if (f.authors != null) {
				subQuery += manageAuthors(f) + " ";
			}
			if (subQuery.length() > 0) {
				if (subQuery.toUpperCase().startsWith("AND")) {
					subQuery = subQuery.substring(3);
				} else if (subQuery.toUpperCase().startsWith("OR")) {
					subQuery = subQuery.substring(2);
				}
				query += subQuery;
				ArrayList<DatasetBean> beans = executeDatasetQuery(query, con);
				String operator = f.operator;
//				if (beans.size() > 1) {
//					operator = "OR";
//				}
				for (DatasetBean b : beans) {
					list.add(new QueryFilterItem(QueryFilterItem.TYPE_AUTHOR, operator, b));
				}
				return list;
			}
		}
		throw new NoDatasetFoundException("No author filter");
	}
	
	public ArrayList<QueryFilterItem> findDatasetByYear(ArrayList<QueryFilter> filters, Connection con)
			throws Exception, NoDatasetFoundException, DbException {
		if (filters.size() == 0)
			throw new NoDatasetFoundException("No year filter.");
		ArrayList<QueryFilterItem> list = new ArrayList<QueryFilterItem>();
		String query = "select * from dataset where ";
		String subQuery = "";
		for (QueryFilter f : filters) {
			if (f.year != null) {
				subQuery += manageYear(f) + " ";
			}
			if (subQuery.length() > 0) {
				if (subQuery.toUpperCase().startsWith("AND")) {
					subQuery = subQuery.substring(3);
				} else if (subQuery.toUpperCase().startsWith("OR")) {
					subQuery = subQuery.substring(2);
				}
				query += subQuery;
				ArrayList<DatasetBean> beans = executeDatasetQuery(query, con);
				for (DatasetBean b : beans) {
					list.add(new QueryFilterItem(QueryFilterItem.TYPE_YEAR, f.operator, b));
				}
				return list;
			}
		}
		throw new NoDatasetFoundException("No year filter");
	}
	
	public ArrayList<QueryFilterItem> findDatasetByReference(ArrayList<QueryFilter> filters, Connection con)
			throws Exception, NoDatasetFoundException, DbException {
		if (filters.size() == 0)
			throw new NoDatasetFoundException("No reference filter.");
		ArrayList<QueryFilterItem> list = new ArrayList<QueryFilterItem>();
		String query = "select * from dataset where ";
		String subQuery = "";
		for (QueryFilter f : filters) {
			if (f.reference != null) {
				subQuery += manageReference(f) + " ";
			}
			if (subQuery.length() > 0) {
				if (subQuery.toUpperCase().startsWith("AND")) {
					subQuery = subQuery.substring(3);
				} else if (subQuery.toUpperCase().startsWith("OR")) {
					subQuery = subQuery.substring(2);
				}
				query += subQuery;
				ArrayList<DatasetBean> beans = executeDatasetQuery(query, con);
				for (DatasetBean b : beans) {
					list.add(new QueryFilterItem(QueryFilterItem.TYPE_REFERENCE, f.operator, b));
				}
				return list;
			}
		}
		throw new NoDatasetFoundException("No reference filter");
	}	
	
	public ArrayList<QueryFilterItem> findDatasetByKeywords(ArrayList<QueryFilter> filters, Connection con)
			throws Exception, NoDatasetFoundException, DbException {
		if (filters.size() == 0)
			throw new NoDatasetFoundException("No keywords filter.");
		ArrayList<QueryFilterItem> list = new ArrayList<QueryFilterItem>();
		String query = "select * from dataset where ";
		String subQuery = "";
		for (QueryFilter f : filters) {
			if (f.keywords != null) {
				subQuery += manageKeywords(f) + " ";
			}
			if (subQuery.length() > 0) {
				if (subQuery.toUpperCase().startsWith("AND")) {
					subQuery = subQuery.substring(3);
				} else if (subQuery.toUpperCase().startsWith("OR")) {
					subQuery = subQuery.substring(2);
				}
				query += subQuery;
				ArrayList<DatasetBean> beans = executeDatasetQuery(query, con);
				String operator = f.operator;
//				if (beans.size() > 1)
//					operator = "OR";
				for (DatasetBean b : beans) {
					list.add(new QueryFilterItem(QueryFilterItem.TYPE_KEYWORD, f.operator, b));
				}
				return list;
			}
		}
		throw new NoDatasetFoundException("No keywords filter");
	}	
	
	private ArrayList<DatasetBean> executeDatasetQuery(String query, Connection con) throws NoDatasetFoundException, Exception {
		System.out.println(query);
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ArrayList<DatasetBean> list = new ArrayList<DatasetBean>();
			ps = con.prepareStatement(query);
			rs = ps.executeQuery();

			while (rs.next()) {
				DatasetBean bean = new DatasetBean(rs.getLong("id"), rs.getString("file_name"),
						rs.getString("keywords"), rs.getString("authors"), rs.getString("link"),
						rs.getString("metadata"), rs.getInt("year"), rs.getBoolean("processed"));
				
				list.add(bean);
			} 
			
			if (list.size() > 0) {
				return list;
			}
			else {
				throw new NoDatasetFoundException("No dataset for query:\n" + query);
			}
		} catch (NoDatasetFoundException ex) {
			throw ex;
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
	
	

	public ArrayList<DatasetBean> findDatasets(ArrayList<QueryFilter> filters, Connection con)
			throws Exception, NoDatasetFoundException, DbException {
		ArrayList<DatasetBean> beans = new ArrayList<DatasetBean>();
		if (filters.size() == 0)
			return beans;
		String query = "select * from dataset where ";
		String subQuery = "";
		for (QueryFilter f : filters) {
			if (f.authors != null) {
				subQuery += manageAuthors(f) + " ";
			}
			if (f.keywords != null) {
				subQuery += manageKeywords(f) + " ";
			}
			if (f.reference != null) {
				subQuery += manageReference(f) + " ";
			}
			if (f.year != null) {
				subQuery += manageYear(f) + " ";
			}
		}
		if (subQuery.length() > 0) {
			if (subQuery.toUpperCase().startsWith("AND")) {
				subQuery = subQuery.substring(3);
			} else if (subQuery.toUpperCase().startsWith("OR")) {
				subQuery = subQuery.substring(2);
			}
			query += subQuery;
			System.out.println(query);
			PreparedStatement ps = null;
			ResultSet rs = null;
			try {
				ps = con.prepareStatement(query);
				rs = ps.executeQuery();

				while (rs.next()) {
					DatasetBean bean = new DatasetBean(rs.getLong("id"), rs.getString("file_name"),
							rs.getString("keywords"), rs.getString("authors"), rs.getString("link"),
							rs.getString("metadata"), rs.getInt("year"), rs.getBoolean("processed"));
					beans.add(bean);
				}
				if (beans.size() < 1) {
					throw new NoDatasetFoundException("No dataset for query:\n" + query);
				}
			} catch (NoDatasetFoundException ex) {
				throw ex;
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

	private String manageAuthors(QueryFilter f) {
		String query = f.operator
				+ " id in (select dataset_id from dataset_authors where author_id in (select id from authors where (";
		for (String auth : f.authors) {
			String[] a = auth.split(",");
			String surname = a[0].toLowerCase().trim();
			String name = a[1].toLowerCase().trim();
			query += "(lower(surname) like '%" + surname + "%' and lower(name) like '%" + name + "%') or ";
		}
		query = query.substring(0, query.length() - 4);
		query += ")))";
		return query;
	}

	private String manageKeywords(QueryFilter f) {
		String query = "";
		if (f.keywords.size() == 1) {
			query = f.operator + " lower(keywords) similar to '%" + f.keywords.get(0).toLowerCase() + "%'";
		} else {
			query = f.operator + " lower(keywords) similar to '%(";
			for (String key : f.keywords) {
				query += "(" + key.toLowerCase() + ")|";
			}
			query = query.substring(0, query.length() - 1);
			query += ")%'";
		}
		return query;
	}

	private String manageReference(QueryFilter f) {
		String query = f.operator + " lower(link) like '%" + f.reference.toLowerCase() + "%' ";
		return query;
	}

	private String manageYear(QueryFilter f) {
		String query = f.operator + " year = " + f.year.toString();
		return query;
	}

	public ArrayList<QueryFilterItem> queryDatasets(QueryFilter queryFilter, Connection con) throws Exception, DbException {
		ArrayList<QueryFilterItem> beans = new ArrayList<QueryFilterItem>();
		if (queryFilter.authors != null || queryFilter.keywords != null || queryFilter.reference != null
				|| queryFilter.year > 0) {
			PreparedStatement ps = null;
			ResultSet rs = null;
			String query = "select * from dataset where 1=1 "; // processed=true";

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
				query += ")%'";
			}

			if (queryFilter.keywords != null) {
				query += " and lower(keywords) similar to '%(";
				for (String key : queryFilter.keywords) {
					query += "(" + key.toLowerCase() + ")|";
				}
				query = query.substring(0, query.length() - 1);
				query += ")%'";
			}

			if (queryFilter.reference != null) {
				query += " and lower(link) like ?";
			}

			if (queryFilter.year > 0) {
				query += " and year = ?";
			}
			try {
				con = cm.createConnection();
				ps = con.prepareStatement(query);
				int position = 1;
				if (queryFilter.reference != null) {
					ps.setString(position, "%" + queryFilter.reference.toLowerCase() + "%");
					position++;
				}
				if (queryFilter.year > 0) {
					ps.setInt(position, queryFilter.year);
					position++;
				}

				rs = ps.executeQuery();

				while (rs.next()) {
					DatasetBean bean = new DatasetBean(rs.getLong("id"), rs.getString("file_name"),
							rs.getString("keywords"), rs.getString("authors"), rs.getString("link"),
							rs.getString("metadata"), rs.getInt("year"), rs.getBoolean("processed"));
					beans.add(new QueryFilterItem("", "", bean));
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

	public ArrayList<QueryFilterItem> queryDatasets(QueryFilter queryFilter) throws Exception, DbException {
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
		if (filter.getKeywords() != null) {
			query += " and keywords like ?";
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
		if (filter.getKeywords() != null) {
			String[] keywords = filter.getKeywords().split(" ");
			query += " and lower(keywords) similar to '%(";
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
			if (filter.getKeywords() != null) {
				ps.setString(position, "%" + filter.getLink().toLowerCase() + "%");
				position++;
			}
			if (processedFilter == true) {
				ps.setBoolean(position, filter.isProcessed());
			}

			rs = ps.executeQuery();

			while (rs.next()) {
				DatasetBean bean = new DatasetBean(rs.getLong("id"), rs.getString("file_name"),
						rs.getString("keywords"), rs.getString("authors"), rs.getString("link"),
						rs.getString("metadata"), rs.getInt("year"), rs.getBoolean("processed"));
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
