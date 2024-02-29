package it.cnr.igg.isotopedb.beans;

import java.util.List;

public class SampleBean extends TheBean {
	private Long id;
	private List<ComponentBean> components;
	private List<SampleFieldBean> fields;
	private Long datasetId;
	
	public SampleBean() {
		super();
		id = -1L;
		datasetId = -1L;
		components = null;
		fields = null;
	}
	
	public void setId(Long id) {
		this.id = id;
	}

	public void setDatasetId(Long datasetId) {
		this.datasetId = datasetId;
	}

	public Long getDatasetId() {
		return datasetId;
	}
	
	public Long getId() {
		return id;
	}

	public List<SampleFieldBean> getFields() {
		return fields;
	}

	public List<ComponentBean> getComponents() {
		return components;
	}
	
	public void setComponents(List<ComponentBean> components) {
		this.components = components;
	}

	public void setFields(List<SampleFieldBean> fields) {
		this.fields = fields;
	}
}
