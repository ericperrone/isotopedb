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
import it.cnr.igg.isotopedb.tools.QueryFilter;
import it.cnr.igg.isotopedb.beans.DatasetBean;
import it.cnr.igg.isotopedb.queries.DatasetQuery;

public class MainQuery extends Query {

	public MainQuery() {
		super();
	}
	
	public ArrayList<SampleBean> query(QueryFilter queryFilter) throws Exception, DbException  {
		ArrayList<SampleBean> beans = new ArrayList<SampleBean>();
		Connection con = null;
		try {
			con = cm.createConnection();
			queryFilter.datasets = (new DatasetQuery()).queryDatasets(queryFilter, con);	
			beans = (new SampleQuery()).querySamples(queryFilter, con);
			return beans;
		} catch (Exception e) {
			e.printStackTrace();
			throw new DbException(e);
		} finally {
			cm.closeConnection();
		}
	}

}
