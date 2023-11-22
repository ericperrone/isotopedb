package it.cnr.igg.isotopedb.tools;

import java.util.List;

import it.cnr.igg.isotopedb.beans.DatasetBean;
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
	public enum DataType {
		FIELD,
		CHEMICAL,
		ISOTOPE
	}

	public enum FilterOperator {
		LT, LTE, GT, GTE, BETWEEN, EQ, NEQ
	}

	public enum FilterRelations {
		AND, OR, NONE
	}

	public String[] authors;
	public String[] keywords;
	public String ref;
	public int year;
	public List<DatasetBean> datasets;
	public GeoCoord geoCoord;
	
	public QueryFilter() {
	}

}
