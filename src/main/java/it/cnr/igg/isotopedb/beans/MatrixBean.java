package it.cnr.igg.isotopedb.beans;

import java.util.ArrayList;

public class MatrixBean extends TheBean {
	private Long matrixId;
	private Long parentId;
	private String matrix;
	private ArrayList<String> aliases;
	
	public MatrixBean(Long matrixId, Long parentId, String matrix) {
		super();
		this.matrixId = matrixId;
		this.parentId = parentId;
		this.matrix = matrix;
	}

	public Long getMatrixId() {
		return matrixId;
	}

	public Long getParentId() {
		return parentId;
	}

	public String getMatrix() {
		return matrix;
	}

	public ArrayList<String> getAliases() {
		return aliases;
	}

	public void setAliases(ArrayList<String> aliases) {
		this.aliases = aliases;
	}
}
