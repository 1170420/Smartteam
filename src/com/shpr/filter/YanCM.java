package com.shpr.filter;

import java.io.IOException;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.alibaba.fastjson.JSONObject;
import com.zhenzi.sms.ZhenziSmsClient;

/**
 * ��ȡ��֤��
 */
public class YanCM extends HttpServlet {
	private static final long serialVersionUID = 1L;
	//����ƽ̨��ز���
	private String apiUrl = "https://sms_developer.zhenzikj.com";
	private String appId = "102322";
	private String appSecret = "06a854d4-ba10-44f1-a6e3-e5c3009a424e";
       
    public YanCM() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * ����ƽ̨ʹ�õ�������ƶ���(smsow.zhenzikj.com)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			
			String mobile = request.getParameter("user_call");
			System.out.println(mobile);
			JSONObject json = null;
			//����6λ��֤��
			String verifyCode = String.valueOf(new Random().nextInt(899999) + 100000);
			System.out.println(verifyCode);
			//���Ͷ���
			ZhenziSmsClient client = new ZhenziSmsClient(apiUrl, appId, appSecret);
			String result = client.send(mobile, "������֤��Ϊ:" + verifyCode + "���������ﰡ!");
			json = JSONObject.parseObject(result);
			if(json.getIntValue("code") != 0){//���Ͷ���ʧ��
				renderData(response, "fail");
				return; 
			}
			//����֤��浽session��,ͬʱ���봴��ʱ��
			//��json��ţ�����ʹ�õ��ǰ����fastjson
			HttpSession session = request.getSession();
			json = new JSONObject();
			json.put("mobile", mobile);
			json.put("verifyCode", verifyCode);
			json.put("createTime", System.currentTimeMillis());
			// ����֤�����SESSION
			request.getSession().setAttribute("verifyCode", json);
			renderData(response, "success");
			return ;
		} catch (Exception e) {
			e.printStackTrace();
		}
		renderData(response, "fail");
	}
	
	protected void renderData(HttpServletResponse response, String data){
		try {
			response.setContentType("text/plain;charset=UTF-8");
			response.getWriter().write(data);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}