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
 * @comment 登录过滤
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
		//向前台发送数据解决中文乱码
		request.setCharacterEncoding("UTF-8");  
	    response.setContentType("text/html;charset=UTF-8"); 
	    //获取session
	    HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user"); 
		// 获得用户请求的URI
		String path = request.getRequestURI();
		/*logger.info("==当前请求页面为=="+path);*/
		// 登陆页面/注册页/找回密码页/无需过滤
		 if(path.indexOf("/login.jsp") > -1) {
			 filterChain.doFilter(servletRequest, servletResponse);
			 return;
		}
		if(user==null){
		    	PrintWriter out = response.getWriter();  
		    	//未登陆重定向登陆界面
				logger.warn("未登录");
				out.println("<script type='text/javascript'> alert('您未登陆，点击确定后转至登录页面');</script>"); 
				//setHeader实现定时跳页功能
				response.setHeader("refresh","0;/Smartteam/login.jsp"); 
		}else{
			//已登录则放行
			filterChain.doFilter(request, response);
		}
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		logger.info("项目启动,过滤器开始工作......");
	}

}
