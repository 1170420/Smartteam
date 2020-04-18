package com.shpr.pojo;

import java.util.Date;
import java.util.List;

import com.google.gson.Gson;
public class Message {
	
	//第一句欢迎语
	private String welcome;
	
	//进入聊天室的用户列表
	private List<String> username;
	
	//聊天内容（发送者，发送时间，内容）
	private String content;
	

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
	public void setContent(String name,String msg) {
		this.content = name +" "+new Date().toLocaleString()+"<br/>"+msg+"<br/>";
	}

	public String getWelcome() {
		return welcome;
	}

	public void setWelcome(String welcome) {
		this.welcome = welcome;
	}

	public List<String> getUsername() {
		return username;
	}

	public void setUsername(List<String> username) {
		this.username = username;
	}
	
	public Message(){
		super();
	}
	
	private static Gson gson = new Gson();
	
	public String toJson(){
		
		return gson.toJson(this);
	}
	
	
	
	

}
