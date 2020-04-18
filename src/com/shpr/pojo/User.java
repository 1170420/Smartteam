package com.shpr.pojo;

public class User {

	private int id;           //ID
	private String user_name; //账号
	private String user_pwd;  //密码
	private String user_call; //电话
	private String user_time; //时间
	private String user_mail; //邮箱
	private String user_hobby; //爱好
	public String getUser_mail() {
		return user_mail;
	}
	public void setUser_mail(String user_mail) {
		this.user_mail = user_mail;
	}
	public String getUser_hobby() {
		return user_hobby;
	}
	public void setUser_hobby(String user_hobby) {
		this.user_hobby = user_hobby;
	}
	public String getUser_specialty() {
		return user_specialty;
	}
	public void setUser_specialty(String user_specialty) {
		this.user_specialty = user_specialty;
	}
	private String user_specialty; //T特长
	private String user_role; //用户权限1：管理员.2：普通用户
	private int user_state;//用户状态0：禁用.1：启动
	
	public int getId(){
		return id;
	}
	public void setId(int id){
		this.id = id;
	}
	public String getUser_name(){
		return user_name;
	}
	public void setUser_name(String user_name){
		this.user_name =user_name;
	}
	
	public String getUser_pwd(){
		return user_pwd;
	}
	public void setUser_pwd(String user_pwd){
		this.user_pwd =user_pwd;
	}
	public String getUser_call(){
		return user_call;
	}
	public void setUser_call(String user_call){
		this.user_call =user_call;
	}
	public String getUser_time(){
		return user_time;
	}
	public void setUser_time(String user_time){
		this.user_time =user_time;
	}
	public String getUser_role(){
		return user_role;
	}
	public void setUser_role(String user_role){
		this.user_role =user_role;
	}
	public int getUser_state() {
		return user_state;
	}
	public void setUser_state(int user_state) {
		this.user_state = user_state;
	}
	@Override
	public String toString() {
		return "User [id=" + id + ", user_name=" + user_name + ", user_pwd=" + user_pwd + ", user_call=" + user_call
				+ ", user_time=" + user_time + ", user_mail=" + user_mail + ", user_hobby=" + user_hobby
				+ ", user_specialty=" + user_specialty + ", user_role=" + user_role + ", user_state=" + user_state
				+ "]";
	}
	
	
}
