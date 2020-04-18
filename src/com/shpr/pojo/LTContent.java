package com.shpr.pojo;

public class LTContent {
  
	    //单聊时 信息发送的目标
		private String chatToWho;
		
		//聊天内容
		private String msg;
		
		//聊天类型（群聊或者单聊）
		private Integer type;
		
		public String getChatToWho() {
			return chatToWho;
		}
		public void setChatToWho(String chatToWho) {
			this.chatToWho = chatToWho;
		}
		public String getMsg() {
			return msg;
		}
		public void setMsg(String msg) {
			this.msg = msg;
		}
		public Integer getType() {
			return type;
		}
		public void setType(Integer type) {
			this.type = type;
}
		public LTContent(){
			super();
		}
}
