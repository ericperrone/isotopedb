package it.cnr.igg.isotopedb.beans;

public class ComponentBean extends TheBean {
	private Long componentId;
	private String component;
	private Double value;
	private String um;
	private boolean isIsotope;
	
	public ComponentBean(Long id, String component, Double value, String um) {
		this.componentId = id;
		this.component = component;
		this.value = value;
		this.um = um;
	}
	
	public ComponentBean(String component, Double value, String um) {
		this.component = component;
		this.value = value;
		this.um = um;
	}
	
	public ComponentBean(String component, Double value, boolean isIsotope) {
		this.component = component;
		this.value = value;
		this.isIsotope = isIsotope;
	}
	
	public ComponentBean() {
		
	}

	public Long getId() {
		return componentId;
	}

	public String getComponent() {
		return component;
	}

	public Double getValue() {
		return value;
	}

	public String getUm() {
		return um;
	}
	
	public boolean getIsIsotope() {
		return isIsotope;
	}

	public void setId(Long id) {
		this.componentId = id;
	}

	public void setComponent(String component) {
		this.component = component;
	}

	public void setValue(Double value) {
		this.value = value;
	}

	public void setUm(String um) {
		this.um = um;
	}
	
	public void setIsIsotope(boolean isIsotope) {
		this.isIsotope = isIsotope;
	}
	
	public boolean compareTo(ComponentBean cb) {
		return (cb.getComponent().equalsIgnoreCase(component));
	}
	
}
