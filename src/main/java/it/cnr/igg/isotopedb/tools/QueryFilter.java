package it.cnr.igg.isotopedb.tools;

import java.util.ArrayList;

import it.cnr.igg.isotopedb.beans.AuthorBean;
import it.cnr.igg.isotopedb.beans.DatasetBean;
import it.cnr.igg.isotopedb.exceptions.DbException;
import it.cnr.igg.isotopedb.tools.GeoCoord;

//enum DataType {
//	FIELD,
//	CHEMICAL,
//	ISOTOPE
//}
//
//enum FilterOperator {
//	LT, LTE, GT, GTE, BETWEEN, EQ, NEQ
//}
//
//enum FilterRelations {
//	AND, OR, NONE
//}

public class QueryFilter {
	public String operator;
	public ArrayList<String> authors;
	public ArrayList<String> keywords;
	public String reference;
	public GeoCoord coordinates;
	public ArrayList<DatasetBean> datasets;
	public Integer year;
	public static final String AND = "AND";
	public static final String OR = "OR";
	
	public QueryFilter() {
		authors = null;
		keywords = null;
		reference = null;
		coordinates = null;
	}
	
	private void setOperator(String operator) throws DbException {
		if (operator.toUpperCase().equals(QueryFilter.AND) || 
			operator.toUpperCase().equals(QueryFilter.OR)) {
			this.operator = operator;
		} else {
			throw new DbException("Invalid logical operator: " + operator);
		}
	}
	
	public void setYear(String operator, String year) throws DbException {
		setOperator(operator);
		this.year = Integer.valueOf(year);
		keywords = null;
		reference = null;
		coordinates = null;	
		authors = null;
	}
	
	public void setAuthors(String operator, ArrayList<String> authors) throws DbException {
		setOperator(operator);
		this.authors = authors;
		keywords = null;
		reference = null;
		coordinates = null;		
		year = null;
	}
	
	public void setKeywords(String operator, ArrayList<String> keywords) throws DbException {
		setOperator(operator);
		authors = null;
		this.keywords = keywords;
		reference = null;
		coordinates = null;	
		year = null;
	}
	
	public void setReference(String operator, String reference) throws DbException {
		setOperator(operator);
		authors = null;
		keywords = null;
		this.reference = reference;
		coordinates = null;		
		year = null;
	}
	
	public void setCoordinates(String operator, GeoCoord coordinates) throws DbException {
		setOperator(operator);
		authors = null;
		keywords = null;
		reference = null;
		this.coordinates = coordinates;	
		year = null;
	}
}
