package it.cnr.igg.isotopedb.tools;

enum DataType {
	FIELD,
	CHEMICAL,
	ISOTOPE
}

enum FilterOperator {
	LT, LTE, GT, GTE, BETWEEN, EQ, NEQ
}

enum FilterRelations {
	AND, OR, NONE
}

public class QueryFilter {
	DataType type;
	String queryItem;
	FilterOperator operator;
	Object[] values;
	FilterRelations relation;
	
	public QueryFilter() {
	}

}
