package it.cnr.igg.isotopedb.beans;

public class DatasetBean extends TheBean {
	private Long id;
	private String fileName, metadata;
	private boolean processed;
	
	public DatasetBean(Long id, String fileName, String metadata, boolean processed) {
		super();
		this.id = id;
		this.fileName = fileName;
		this.metadata = metadata;
		this.processed = processed;
	}

	public DatasetBean() {
		super();
		this.id = -1L;
		this.fileName = null;
		this.metadata = null;
		this.processed = false;
	}

	public Long getId() {
		return id;
	}

	public String getFileName() {
		return fileName;
	}

	public String getMetadata() {
		return metadata;
	}

	public boolean isProcessed() {
		return processed;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public void setMetadata(String metadata) {
		this.metadata = metadata;
	}

	public void setProcessed(boolean processed) {
		this.processed = processed;
	}
}
