package com.shpr.pojo;

public class LTContent {
  
	    //����ʱ ��Ϣ���͵�Ŀ��
		private String chatToWho;
		
		//��������
		private String msg;
		
		//�������ͣ�Ⱥ�Ļ��ߵ��ģ�
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
