package com.shpr.filter;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.shpr.controller.UserController;
import com.shpr.pojo.User;


/***
 * @comment ��¼����
 * @author yandongfa
 * @data 2019/1/24
 *
 */
public class LoginFilter implements Filter{

	Logger logger = Logger.getLogger(LoginFilter.class);
	
	@Override
	public void destroy() {
		
	}
	
	@Override
	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse,
			FilterChain filterChain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) servletRequest;
		HttpServletResponse response = (HttpServletResponse) servletResponse;
		//��ǰ̨�������ݽ����������
		request.setCharacterEncoding("UTF-8");  
	    response.setContentType("text/html;charset=UTF-8"); 
	    //��ȡsession
	    HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user"); 
		// ����û������URI
		String path = request.getRequestURI();
		/*logger.info("==��ǰ����ҳ��Ϊ=="+path);*/
		// ��½ҳ��/ע��ҳ/�һ�����ҳ/�������
		 if(path.indexOf("/login.jsp") > -1) {
			 filterChain.doFilter(servletRequest, servletResponse);
			 return;
		}
		if(user==null){
		    	PrintWriter out = response.getWriter();  
		    	//δ��½�ض����½����
				logger.warn("δ��¼");
				out.println("<script type='text/javascript'> alert('��δ��½�����ȷ����ת����¼ҳ��');</script>"); 
				//setHeaderʵ�ֶ�ʱ��ҳ����
				response.setHeader("refresh","0;/Smartteam/login.jsp"); 
		}else{
			//�ѵ�¼�����
			filterChain.doFilter(request, response);
		}
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		logger.info("��Ŀ����,��������ʼ����......");
	}

}
