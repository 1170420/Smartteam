package com.shpr.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import com.google.gson.Gson;
import com.shpr.pojo.LTContent;
import com.shpr.pojo.Message;

@ServerEndpoint("/chatSocket")
public class chatSocket {

	//用户名
	private String username;
	//session集合
	private static List<Session> sessions= new ArrayList<Session>();
	
	//用户列表集合
	private static List<String> names = new ArrayList<String>();
	
	//用户名与session的Map
		private static Map<String,Session> map = new HashMap<String,Session>();
	
	/***
	 * 进入聊天室
	 * @param session
	 */
	@OnOpen
	public void open(Session session) throws UnsupportedEncodingException{
		
	//当前websocket的session对象，不是servlet的session，这里的一个session代表一个通信会话！
      String queryString =session.getQueryString();
      
      System.out.println(queryString);
      
      //获取当前登录的用户名
      username = queryString.split("=")[1];
      
      //将用户名放入用户列表集合
      this.names.add(username);
      //将当前session放入session集合
      this.sessions.add(session);
      //将用户名和对应session放入map中
	  this.map.put(this.username, session);
      
      //进入聊天室欢迎语
      String msg="欢迎"+this.username+"进入聊天室！！<br/>";
      System.out.println("msg----------"+msg);
      //创建message对象
      Message message= new Message();
      message.setWelcome(msg);
      message.setUsername(this.names);
     
      //广播
      this.broadcast(this.sessions,message.toJson());
      
	}
	
	/***
	 * 退出聊天室
	 * @param msg
	 */
	@OnClose
	public void close(Session session){
		
		//session集合清除当前用户
		sessions.remove(session);
		
		//用户列表集合清除当前用户
		names.remove(username);
		
		//退出聊天室提示语
		String msg = username+"退出聊天室！！<br/>";
		
		//创建message对象
	      Message message= new Message();
	      message.setWelcome(msg);
	      message.setUsername(this.names);
	     
	      //广播
	      this.broadcast(this.sessions,message.toJson());
		
		
	}
	
	//创建Gson对象
	private static Gson gson = new Gson();
	
	/***
	 * 进行聊天
	 * @param msg
	 */
	@OnMessage
	public void message(Session session,String json){
		System.out.println("sss");
		   
		  LTContent vo= gson.fromJson(json, LTContent.class);
		  
		  if(vo.getType()==1){
			//广播
			Message message= new Message();
				 
			//message.setUsername(this.names);
			  message.setContent(this.username,vo.getMsg());
		      broadcast(this.sessions,message.toJson());   
		  }else{
			 //单聊
			 
		    String	to=vo.getChatToWho(); 
			Session to_session = this.map.get(to);
			
			Message message= new Message();
			message.setContent(this.username,"<font color=red>私聊:"+vo.getMsg()+"</font>");
			try{
				
				
				to_session.getBasicRemote().sendText(message.toJson());
				
			}catch(IOException e){
				
				e.printStackTrace();
			}
			 
			  
		  }
		  
		  
		
			
	
		
	}
	
	private void broadcast(List<Session> ss, String msg) {
		        //遍历session集合
		System.out.println(msg);
				for (Session session : ss) {
					try {
						//服务端向客户端发送消息
						session.getBasicRemote().sendText(msg);
					} catch (IOException e) {
						e.printStackTrace();
					}
				}	
	}
		
	
}
