package it.cnr.igg.isotopedb.tools;

import it.cnr.igg.isotopedb.beans.DatasetBean;

public class QueryFilterItem {
	public String operator;
	public DatasetBean bean;
	
	public QueryFilterItem(String operator, DatasetBean bean) {
		this.operator = operator;
		this.bean = bean;
	}
}
