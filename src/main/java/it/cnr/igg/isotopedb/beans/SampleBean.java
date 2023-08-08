package it.cnr.igg.isotopedb.beans;

import java.util.List;
import com.google.gson.Gson;

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
//	public String getName() {
//		return name;
//	}
//	public String getLocation() {
//		return location;
//	}
//	public String getRockType() {
//		return rockType;
//	}
//	public String getAge() {
//		return age;
//	}
//	public float getLongMin() {
//		return longMin;
//	}
//	public float getLongMax() {
//		return longMax;
//	}
//	public float getLatMin() {
//		return latMin;
//	}
//	public float getLatMax() {
//		return latMax;
//	}
//	public String getReference() {
//		return reference;
//	}
	public List<ComponentBean> getComponents() {
		return components;
	}
//	public String getMeta() {
//		return meta;
//	}
//	
//	public void setId(Long id) {
//		this.id = id;
//	}
//	public void setName(String name) {
//		this.name = name;
//	}
//	public void setLocation(String location) {
//		this.location = location;
//	}
//	public void setRockType(String rockType) {
//		this.rockType = rockType;
//	}
//	public void setAge(String age) {
//		this.age = age;
//	}
//	public void setLongMin(float longMin) {
//		this.longMin = longMin;
//	}
//	public void setLongMax(float longMax) {
//		this.longMax = longMax;
//	}
//	public void setLatMin(float latMin) {
//		this.latMin = latMin;
//	}
//	public void setLatMax(float latMax) {
//		this.latMax = latMax;
//	}
//	public void setReference(String reference) {
//		this.reference = reference;
//	}
	public void setComponents(List<ComponentBean> components) {
		this.components = components;
	}
//	public void setMeta(String meta) {
//		this.meta = meta;
//	}
	public void setFields(List<SampleFieldBean> fields) {
		this.fields = fields;
	}
	
}
