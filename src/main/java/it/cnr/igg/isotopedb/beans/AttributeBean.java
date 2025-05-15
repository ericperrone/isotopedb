package it.cnr.igg.isotopedb.beans;

public class AttributeBean extends TheBean {
	private Long sampleId;
	private String type, name, svalue, um, technique, uncertainty, uncertaintyType, jvalue;
	private Float nvalue;
	
	public AttributeBean(Long sampleId, String type, String name, String svalue, String um, String technique,
			String uncertainty, String uncertaintyType, String jvalue, Float nvalue) {
		super();
		this.sampleId = sampleId;
		this.type = type;
		this.name = name;
		this.svalue = svalue;
		this.um = um;
		this.technique = technique;
		this.uncertainty = uncertainty;
		this.uncertaintyType = uncertaintyType;
		this.jvalue = jvalue;
		this.nvalue = nvalue;
	}

	public Long getSampleId() {
		return sampleId;
	}

	public String getType() {
		return type;
	}

	public String getName() {
		return name;
	}

	public String getSvalue() {
		return svalue;
	}

	public String getUm() {
		return um;
	}

	public String getTechnique() {
		return technique;
	}

	public String getUncertainty() {
		return uncertainty;
	}

	public String getUncertaintyType() {
		return uncertaintyType;
	}

	public String getJvalue() {
		return jvalue;
	}

	public Float getNvalue() {
		return nvalue;
	}
}
