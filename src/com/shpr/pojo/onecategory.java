package com.shpr.pojo;

public class onecategory {
	
	private int category_id;
	
	private String category1_name;
	
	private String category1_time;

	public int getCategory_id() {
		return category_id;
	}

	public void setCategory_id(int category_id) {
		this.category_id = category_id;
	}

	public String getCategory1_name() {
		return category1_name;
	}

	public void setCategory1_name(String category1_name) {
		this.category1_name = category1_name;
	}

	public String getCategory1_time() {
		return category1_time;
	}

	public void setCategory1_time(String category1_time) {
		this.category1_time = category1_time;
	}

	@Override
	public String toString() {
		return "onecategory [category_id=" + category_id + ", category1_name=" + category1_name + ", category1_time="
				+ category1_time + "]";
	}

	

	
	
	

}
