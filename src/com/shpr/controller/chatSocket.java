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

	//�û���
	private String username;
	//session����
	private static List<Session> sessions= new ArrayList<Session>();
	
	//�û��б���
	private static List<String> names = new ArrayList<String>();
	
	//�û�����session��Map
		private static Map<String,Session> map = new HashMap<String,Session>();
	
	/***
	 * ����������
	 * @param session
	 */
	@OnOpen
	public void open(Session session) throws UnsupportedEncodingException{
		
	//��ǰwebsocket��session���󣬲���servlet��session�������һ��session����һ��ͨ�ŻỰ��
      String queryString =session.getQueryString();
      
      System.out.println(queryString);
      
      //��ȡ��ǰ��¼���û���
      username = queryString.split("=")[1];
      
      //���û��������û��б���
      this.names.add(username);
      //����ǰsession����session����
      this.sessions.add(session);
      //���û����Ͷ�Ӧsession����map��
	  this.map.put(this.username, session);
      
      //���������һ�ӭ��
      String msg="��ӭ"+this.username+"���������ң���<br/>";
      System.out.println("msg----------"+msg);
      //����message����
      Message message= new Message();
      message.setWelcome(msg);
      message.setUsername(this.names);
     
      //�㲥
      this.broadcast(this.sessions,message.toJson());
      
	}
	
	/***
	 * �˳�������
	 * @param msg
	 */
	@OnClose
	public void close(Session session){
		
		//session���������ǰ�û�
		sessions.remove(session);
		
		//�û��б��������ǰ�û�
		names.remove(username);
		
		//�˳���������ʾ��
		String msg = username+"�˳������ң���<br/>";
		
		//����message����
	      Message message= new Message();
	      message.setWelcome(msg);
	      message.setUsername(this.names);
	     
	      //�㲥
	      this.broadcast(this.sessions,message.toJson());
		
		
	}
	
	//����Gson����
	private static Gson gson = new Gson();
	
	/***
	 * ��������
	 * @param msg
	 */
	@OnMessage
	public void message(Session session,String json){
		System.out.println("sss");
		   
		  LTContent vo= gson.fromJson(json, LTContent.class);
		  
		  if(vo.getType()==1){
			//�㲥
			Message message= new Message();
				 
			//message.setUsername(this.names);
			  message.setContent(this.username,vo.getMsg());
		      broadcast(this.sessions,message.toJson());   
		  }else{
			 //����
			 
		    String	to=vo.getChatToWho(); 
			Session to_session = this.map.get(to);
			
			Message message= new Message();
			message.setContent(this.username,"<font color=red>˽��:"+vo.getMsg()+"</font>");
			try{
				
				
				to_session.getBasicRemote().sendText(message.toJson());
				
			}catch(IOException e){
				
				e.printStackTrace();
			}
			 
			  
		  }
		  
		  
		
			
	
		
	}
	
	private void broadcast(List<Session> ss, String msg) {
		        //����session����
		System.out.println(msg);
				for (Session session : ss) {
					try {
						//�������ͻ��˷�����Ϣ
						session.getBasicRemote().sendText(msg);
					} catch (IOException e) {
						e.printStackTrace();
					}
				}	
	}
		
	
}
