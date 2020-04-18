package com.shpr.pojo;

public class Feedback {
	
	private int id;   //ID
	private String user_name; //用户名
	private String user_xb; //性别
	private String user_age; //年龄
	private String user_address; //联系地址
	private String user_time; //反馈时间
	private String user_call; //手机号
	private String user_sf; //身份
    private String user_advice; //网站建议	
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getUser_xb() {
		return user_xb;
	}

	public void setUser_xb(String user_xb) {
		this.user_xb = user_xb;
	}

	public String getUser_age() {
		return user_age;
	}

	public void setUser_age(String user_age) {
		this.user_age = user_age;
	}

	public String getUser_address() {
		return user_address;
	}

	public void setUser_address(String user_address) {
		this.user_address = user_address;
	}

	public String getUser_time() {
		return user_time;
	}

	public void setUser_time(String user_time) {
		this.user_time = user_time;
	}

	public String getUser_call() {
		return user_call;
	}

	public void setUser_call(String user_call) {
		this.user_call = user_call;
	}

	public String getUser_sf() {
		return user_sf;
	}

	public void setUser_sf(String user_sf) {
		this.user_sf = user_sf;
	}

	public String getUser_advice() {
		return user_advice;
	}

	public void setUser_advice(String user_advice) {
		this.user_advice = user_advice;
	}

	@Override
	public String toString() {
		return "Feedback [id=" + id + ", user_name=" + user_name + ", user_xb=" + user_xb + ", user_age=" + user_age
				+ ", user_address=" + user_address + ", user_time=" + user_time + ", user_call=" + user_call
				+ ", user_sf=" + user_sf + ", user_advice=" + user_advice + "]";
	}
    
    
	

}
