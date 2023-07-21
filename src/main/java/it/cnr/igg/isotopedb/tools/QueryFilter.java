package it.cnr.igg.isotopedb.tools;

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
	public DataType type;
	public String queryItem;
	public FilterOperator operator;
	public Object val;
	public FilterRelations relation;
	
	public QueryFilter() {
	}

}
