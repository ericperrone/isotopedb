package it.cnr.igg.isotopedb.beans;

public class SpiderBean extends TheBean {
	private String method;
	private String norm;
	
	public SpiderBean() {
		super();
		method = norm = null;
	}

	public SpiderBean(String method, String norm) {
		super();
		this.method = method;
		this.norm = norm;
	}

	public String getMethod() {
		return method;
	}

	public String getNorm() {
		return norm;
	}

	public void setMethod(String method) {
		this.method = method;
	}

	public void setNorm(String norm) {
		this.norm = norm;
	}
}
