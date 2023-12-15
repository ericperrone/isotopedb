package it.cnr.igg.isotopedb.beans;

public class DatasetBean extends TheBean {
	private Long id;
	private String fileName, metadata;
	private String authors, link;
	private int year;
	private boolean processed;
	
	public DatasetBean(String fileName, String metadata,
			String authors, String link,
			int year,
			boolean processed) {
		super();
		this.fileName = fileName;
		this.metadata = metadata;
		this.processed = processed;
		this.authors = authors;
		this.link = link;
		this.year = year;
	}
	
	public DatasetBean(Long id, String fileName, String metadata,
			String authors, String link,
			int year,
			boolean processed) {
		super();
		this.id = id;
		this.fileName = fileName;
		this.metadata = metadata;
		this.processed = processed;
		this.authors = authors;
		this.link = link;
		this.year = year;
	}

	public DatasetBean() {
		super();
		this.id = -1L;
		this.fileName = null;
		this.metadata = null;
		this.authors = null;
		this.link = null;
		this.year = -1;
		this.processed = false;
	}

	public String getAuthors() {
		return authors;
	}

	public String getLink() {
		return link;
	}

	public int getYear() {
		return year;
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

	public void setAuthors(String authors) {
		this.authors = authors;
	}

	public void setLink(String link) {
		this.link = link;
	}

	public void setYear(int year) {
		this.year = year;
	}
}
