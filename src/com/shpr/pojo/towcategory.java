package com.shpr.pojo;

public class towcategory {
	
	private int category2_id;
	
	private String category2_name;
	
	private int category1_id;

	private String category2_time;

	public String getCategory2_time() {
		return category2_time;
	}



	public void setCategory2_time(String category2_time) {
		this.category2_time = category2_time;
	}



	public int getCategory2_id() {
		return category2_id;
	}



	public void setCategory2_id(int category2_id) {
		this.category2_id = category2_id;
	}



	public String getCategory2_name() {
		return category2_name;
	}



	public void setCategory2_name(String category2_name) {
		this.category2_name = category2_name;
	}



	public int getCategory1_id() {
		return category1_id;
	}



	public void setCategory1_id(int category1_id) {
		this.category1_id = category1_id;
	}



	@Override
	public String toString() {
		return "towcategory [category2_id=" + category2_id + ", category2_name=" + category2_name + ", category1_id="
				+ category1_id + "]";
	}

	
	
	
	

}
