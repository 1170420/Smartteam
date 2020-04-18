package com.shpr.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Timer;
import java.util.TimerTask;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.aliyuncs.dysmsapi.model.v20170525.SendSmsResponse;
import com.aliyuncs.exceptions.ClientException;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.shpr.pojo.Content;
import com.shpr.pojo.Feedback;
import com.shpr.pojo.Log;
import com.shpr.pojo.User;
import com.shpr.pojo.onecategory;
import com.shpr.pojo.towcategory;
import com.shpr.service.UserService;
import com.shpr.tools.AliyunCodeUtils;

@Controller
@RequestMapping("/user")
public class UserController {

	private static Logger logger = Logger.getLogger(UserController.class);
	
	@Autowired
	UserService userService;
	
	//阿里短信验证码接口调用--------发短信的调用
    @RequestMapping(value="/select_mailanduser_idExit")
    @ResponseBody
    public Map<String,Object> sendIdentifyingCode(HttpServletRequest request,HttpSession session,String user_call) throws ClientException {
    	
    	String user_call1 = request.getParameter("user_call");
		System.out.println(user_call1);
    	System.out.println("==发送手机号码=="+user_call);
    	Map<String, Object> resultMap =new HashMap<String, Object>();
        try {
            // 验证码生成发送
            int identifyingCode = AliyunCodeUtils.getIdentifyingCode();
            SendSmsResponse sendSmsResponse = AliyunCodeUtils.sendIdentifyingCode(user_call,identifyingCode);
            // ok代表的是接口发送成功的状态码
            if (sendSmsResponse.getCode()!= null && sendSmsResponse.getCode().equals("OK") && sendSmsResponse.getBizId()!=null) {
            	
                //定时从session中删除checkCode
            	request.getSession().setAttribute(user_call,identifyingCode);
                final Timer timer=new Timer();
                final String phoneNum=user_call;
                timer.schedule(new TimerTask() {
                  @Override
                  public void run() {
                	  request.removeAttribute(phoneNum);
                      System.out.println("验证码超时删除成功");
                      timer.cancel();
                  }
                },5*60*1000);
                
                //将验证码存入session
                session.setAttribute("aliyun_code",identifyingCode);
                System.out.print("===存入session==="+identifyingCode);
    			resultMap.put("state", "1");
    			resultMap.put("msg", "发送成功");
            } else {
    			resultMap.put("state", "0");
    			resultMap.put("msg", "触发小时级流控Permits:5或者触发天级流控Permits:10,请明日再发送");
    			System.out.println("==触发流控==");
            }
        } catch (ClientException e) {
            e.printStackTrace();
			resultMap.put("state", "2");
			resultMap.put("msg", "客户端异常,请确认阿里短信服务功能是否正常，请重新发送");
        }
        return resultMap;
    }
	//忘记密码
	@RequestMapping(value="/getback_userpwd")
	public void getback_userpwd(HttpServletRequest request,HttpServletResponse response,HttpSession session){
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		String user_name = request.getParameter("user_name");
	
		String user_pwd = request.getParameter("user_pwd");
		
		String user_call = request.getParameter("user_call");

		String user_yzm = request.getParameter("getback_pwdcode");
		
		int licode =(int) session.getAttribute("aliyun_code");
		logger.info("获得短信session中的验证码为:" +licode);
		String code = Integer.toString(licode);
		String codesession = code.toString();
		User user = new User();
		user.setUser_name(user_name);
		user.setUser_pwd(user_pwd);
		user.setUser_call(user_call);
		JSONObject json = new JSONObject();
		if(userService.selectUserExist(request.getParameter("user_name"))!=0){
			if(user_yzm.equals(codesession)&&userService.saveUserPass(user)==1)
			{
			json.put("data", "1");
			out.print(json);
			}else{
				json.put("data", "-2");
				out.print(json);
			}
		}else{
			json.put("data", "0");
			out.print(json);
		}
		
		
    }
	//修改密码
	@RequestMapping(value="/getpassword")
	public void getpassword(HttpServletRequest request,HttpServletResponse response,HttpSession session){
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		String user_name = request.getParameter("user_name");
		System.out.println(user_name);
		String newuser_pwd =request.getParameter("newuser_pwd");
		System.out.print(newuser_pwd);
		User user = new User();
		user.setUser_name(user_name);
		user.setUser_pwd(newuser_pwd);
		JSONObject json = new JSONObject();
		if(userService.saveUserPass(user)==1)
		{
			json.put("data", "1");
			out.print(json);
		}else{
				json.put("data", "-1");
				out.print(json);
		}
	}
	//反馈
	@RequestMapping(value="/feedbackuser")
	public void feedbackuser(HttpServletRequest request,HttpServletResponse response,HttpSession session){
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		String user_name = request.getParameter("user_name");
		System.out.println(user_name);
		String user_xb = request.getParameter("user_xb");
		System.out.println(user_xb);
		String user_age = request.getParameter("user_age");
		String user_address = request.getParameter("user_address");
		Date date = new Date();
        SimpleDateFormat sdf =   new SimpleDateFormat( " yyyy-MM-dd HH:mm:ss " );
        String nowTime = sdf.format(date);
        System.out.println(nowTime);
        String user_call = request.getParameter("user_call");
        String user_sf = request.getParameter("user_sf");
        System.out.println(user_sf);
        String introduce = request.getParameter("introduce");
        System.out.println(introduce);
        int licode =(int) session.getAttribute("aliyun_code");
		logger.info("获得短信session中的验证码为:" +licode);
		String code = Integer.toString(licode);
		String codesession = code.toString();
		Feedback feed=new Feedback();
        feed.setUser_name(user_name);
        feed.setUser_xb(user_xb);
        feed.setUser_age(user_age);
        feed.setUser_address(user_address);
        feed.setUser_time(nowTime);
        feed.setUser_call(user_call);
        feed.setUser_sf(user_sf);
        feed.setUser_advice(introduce);
        JSONObject json = new JSONObject();
        if(userService.saveUserFeedback(feed)==1)
        {
        	
        	json.put("data", "1");
			out.print(json);
        }else{
        	json.put("data", "-1");
			out.print(json);
        }
		
	}
	//注册
		@RequestMapping(value="/newbackuser")
		public void newbackuser(HttpServletRequest request,HttpServletResponse response,HttpSession session){
			PrintWriter out = null;
			try {
				out = response.getWriter();
			} catch (IOException e) {
				e.printStackTrace();
			}

			String user_name = request.getParameter("user_name");
			String user_pwd = request.getParameter("user_pwd");
			String user_mail = request.getParameter("user_mail");
			String user_call = request.getParameter("user_call");
			String user_code = request.getParameter("getback_pwdcode");
			int licode =(int) session.getAttribute("aliyun_code");
			logger.info("获得短信session中的验证码为:" +licode);
			String code = Integer.toString(licode);
			String codesession = code.toString();
			String user_time = request.getParameter("user_time");
			String data = request.getParameter("data");
			String user_specialty = request.getParameter("introduce");
	
			User user = new User();
			user.setUser_name(user_name);
			user.setUser_pwd(user_pwd);
			user.setUser_mail(user_mail);
			user.setUser_call(user_call);
			user.setUser_time(user_time);
			user.setUser_hobby(data);
			user.setUser_specialty(user_specialty);
			user.setUser_role("2");
			user.setUser_state(1);
			JSONObject json = new JSONObject();
			if(userService.selectUserExist(request.getParameter("user_name"))==0){
				if(userService.saveUserInfo(user)==1&&user_code.equals(codesession)){
				json.put("data", "1");
				out.print(json);
			}else if(!user_code.equals(codesession)||code==""){
				json.put("data", "0");
				out.print(json);
			}
			out.flush();
			out.close();
			}else{
				json.put("data", "-1");
				out.print(json);
			}
		}
	@RequestMapping(value="/login")
	public void userLogin(HttpServletRequest request,HttpServletResponse response,HttpSession session) throws ParseException{
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		//获取程序执行时长
        long startTime=System.currentTimeMillis();  //获取开始时间
      //获取本地ip地址ַ
		InetAddress ia=null;
		try {
			ia=InetAddress.getLocalHost();
		} catch (UnknownHostException e) {
			e.printStackTrace();
		}
		String localIp=ia.getHostAddress();//获取本地ip
		int localPort=request.getLocalPort();//获取本地的端口
		Map<String, String> map = System.getenv();
        String localUsername = map.get("USERNAME");//获取username
        String localHost = map.get("COMPUTERNAME");//获取计算机名
        
      //获取方法函数
        String localMethod = Thread.currentThread() .getStackTrace()[1].getMethodName();
        String localRoute =request.getRequestURI() ;
        String localFunction = localRoute +">"+localMethod;
        logger.info("==执行函数=="+localFunction);
        
		String user_name = request.getParameter("user_name");
		String user_pwd = request.getParameter("user_pwd");
		logger.info("账号"+user_name+"密码"+user_pwd);
		JSONObject json = new JSONObject();
		User user= new User();
	    user.setUser_name(user_name);
		user.setUser_pwd(user_pwd);
        user = userService.selecetUserByIdLogin(user_name,user_pwd);
		if(user != null && user.getUser_state() == 0){
			logger.info("该账号被锁定");
			json.put("data", "-1");
			out.print(json);
			out.flush();
			out.close();
			return;
		}
        if(user != null && user.getUser_state() == 1){
        	
        	long endTime=System.currentTimeMillis(); 
            String localData =endTime-startTime+"ms";
            logger.info("==执行时长=="+localData);
        	Date date = new Date();
            SimpleDateFormat sdf =   new SimpleDateFormat( " yyyy-MM-dd HH:mm:ss " );
            String nowTime = sdf.format(date);
            logger.info("==当前登录时间=="+nowTime);
            Log logs = new Log();
    		logs.setSystime(nowTime);
    		logs.setSysname(user_name);
    		logs.setSysip(localIp);
    		logs.setSysport(localPort);
    		logs.setSysusername(localUsername);
    		logs.setSyshost(localHost);
    		logs.setSysfunction(localFunction);
    		logs.setSysdata(localData);
    		
    		userService.saveLogInformation(logs);
    		
        	session.setAttribute("user", user);
        	logger.info("==用户进入=="+user);
			json.put("data", "1");
			out.print(json);
        }else{
        	logger.info("密码错误或已被锁定");
        	json.put("data", "2");
			out.print(json);
        }
		out.flush();
		out.close();
	}
	
	//主页
	@RequestMapping(value="/index")
	public ModelAndView index(){
		
		ModelAndView model = new ModelAndView("admin/index");
		return model;
	}
	
	@RequestMapping(value="right")
public ModelAndView right(){
		
		ModelAndView model = new ModelAndView("admin/right");
		return model;
	}
	@RequestMapping(value="Login1")
	public ModelAndView Login1(){
			
			ModelAndView model = new ModelAndView("login");
			return model;
		}
	//忘记密码
	@RequestMapping(value="/forgetpwd")
	public ModelAndView forgetpwd(){
	    ModelAndView model = new ModelAndView("admin/getbackpassword");
	    return model;
		
	}
	//用户信息
	@RequestMapping(value="/Userinformation")
	public ModelAndView Userinformation(){
	    ModelAndView model = new ModelAndView("admin/information");
	    return model;
		
	}
	//获取用户爱好
	@RequestMapping(value="/getinformation")
	@ResponseBody
	public List<User> getinformation(){
		System.out.println(userService.getinformation());
		return userService.getinformation();
	}
	
	 //聊天界面
    @RequestMapping(value="/LiaoTian")
    public ModelAndView LiaoTxy(){
    	ModelAndView model = new ModelAndView("admin/chat");
    	return model;
    }
	@RequestMapping(value="/Look")
	public ModelAndView Look(ModelMap model,String uname,String roomid){
	
			model.put("uname",uname);
			model.put("roomid", roomid);
	    ModelAndView xxmodel = new ModelAndView("admin/room");
	    return xxmodel;
		
	}
	//����ע��
	@RequestMapping(value="/loginUser")
	public ModelAndView loginUser(){
		ModelAndView model = new ModelAndView("admin/registerUser");
		return model;
	}
	//�˳���ҳ
	@RequestMapping(value="/loginExit")
	public ModelAndView loginExit(HttpSession session){
		session.removeAttribute("user");
		ModelAndView model = new ModelAndView("/login");
		return model;
	}
	//管理员登入
	@RequestMapping(value="/login1")
	public ModelAndView login1(HttpSession session){
		
		ModelAndView model =new ModelAndView("admin/login1");
		return model;
	}
	@RequestMapping(value="/To_Userinformation")
	public ModelAndView getAlluser(@RequestParam(value="pn",defaultValue="1")Integer pn,HttpServletRequest request){
	  ModelAndView model = new ModelAndView("admin/userManagement");
	  PageHelper.startPage(pn,10);  
	  List<User> users = userService.getUserList();
	  PageInfo<User> page = new PageInfo<User>(users,10);
	  model.addObject("PageInfo",page);
	  logger.info("==��ѯ����Ա����=="+page);
	  return model;
	}

/*	@RequestMapping(value="/To_Teachinformation")
	public ModelAndView getAllteach(@RequestParam(value="pn",defaultValue="1")Integer pn,HttpServletRequest request){
	   ModelAndView model = new ModelAndView("admin/teachListInformation");
	   PageHelper.startPage(pn,10);  
	   List<Teach> teachs = userService.getUserList1();
	   PageInfo<Teach> page = new PageInfo<Teach>(teachs,10);
	   model.addObject("PageInfo",page);
	   logger.info("==��ѯָ����ʦ����=="+page);
	   return model;
	}*/
	
	//删除用户
	@RequestMapping("/deleteUser")
	public void deleteUser(HttpServletRequest request,HttpServletResponse response){
		PrintWriter out =null;
		try{
			out = response.getWriter();
		}catch(IOException e){
			e.printStackTrace();
		}
		int user_id = Integer.parseInt(request.getParameter("id"));
		User user = new User();
		user.setId(user_id);
		logger.info("==用户id=="+user_id);
		JSONObject json =new JSONObject();
		if(userService.deleteUserInfo(user)==1){
			json.put("data", "1");
			out.print(json);
		}else{
			json.put("data", "2");
			out.print(json);
		}
		out.flush();
		out.close();
	}
	
	//�����û�ID
	@RequestMapping(value="/stopUser")
	public void stopUser(HttpServletRequest request,HttpServletResponse response){
		PrintWriter out =null;
		try{
			out = response.getWriter();
		}catch(IOException e){
			e.printStackTrace();
		}
		int user_id = Integer.parseInt(request.getParameter("id"));
		User user = new User();
		user.setId(user_id);
		logger.info("==�����û�ID=="+user_id);
		if(userService.stopUser(user)==1){
			out.print("1");
		}else{
			out.print("0");
		}
		out.flush();
		out.close();
	}
	//�����û�ID
	@RequestMapping(value="/starUser")
	public void starUser(HttpServletRequest request,HttpServletResponse response){
		PrintWriter out =null;
		try{
			out = response.getWriter();
		}catch(IOException e){
			e.printStackTrace();
		}
		int user_id = Integer.parseInt(request.getParameter("id"));
		User user = new User();
		user.setId(user_id);
		logger.info("==�����û�ID=="+user_id);
		if(userService.starUser(user)==1){
			out.print("1");
		}else{
			out.print("0");
		}
		out.flush();
		out.close();
	}
	//��Ϣ�б��б༭
	@RequestMapping(value="/selectUserById")
	public ModelAndView selectUserById(HttpServletRequest request,HttpServletResponse response){
		ModelAndView model = new ModelAndView("admin/userInformation");
		int id = Integer.parseInt(request.getParameter("id"));
		User user = new User();
		user = userService.selectUserById(id);
		logger.info("==��ȡ������Ϣ=="+user.getUser_name());
		if(user!=null){
			model.addObject("user",user);
		}
		return model;
	}
	//�˺Ź���
	@RequestMapping(value="/userlist")
	public ModelAndView ydf(){
	ModelAndView model = new ModelAndView("admin/userListInformation");
		return model;
	}
	@RequestMapping(value="/userlist1")
	public ModelAndView qwe(){
		
		ModelAndView model = new ModelAndView("admin/teachListInformation");
		return model;
	}
	
	//添加管理员
	@RequestMapping(value="/To_AddUserinformation")
	public ModelAndView To_AddUserinformation(){
		
		ModelAndView model = new ModelAndView("admin/addUserInformation");
		return model;
	}

	@RequestMapping(value="getUserList")
	@ResponseBody
	public List<User> getUserList(){
		return userService.getUserList();
	}
	
	
	//展示一级类目
	@RequestMapping(value="getonecategoryList")
	@ResponseBody
	public List<onecategory>getonecategoryList(){
		return userService.getonecategoryList();
	}
	
	//添加一级类目saveOnecategoryInfo
	@RequestMapping(value="/saveOnecategoryInfo")
	public void saveOnecategoryInfo(HttpServletRequest request,HttpServletResponse response){
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		String category1_name = request.getParameter("category1_name");
		String category1_time = request.getParameter("category1_time");
		onecategory onecate = new onecategory();
		onecate.setCategory1_name(category1_name);
		onecate.setCategory1_time(category1_time);
		JSONObject json = new JSONObject();
			if(userService.saveonecateInfo(onecate)==1){
	       
			   json.put("data", "1");
			   out.print(json);
			}else{
				json.put("data", "2");
				out.print(json);
			}
		out.flush();
		out.close();
	}
	//修改一级类目updateOnecategoryInfo
	@RequestMapping(value="/updateOnecategoryInfo")
	public void updateOnecategoryInfo(HttpServletRequest request,HttpServletResponse response){
		
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		int category_id = Integer.parseInt(request.getParameter("category_id"));
		String category1_name = request.getParameter("category1_name");
		System.out.println(category1_name);
		String category1_time = request.getParameter("category1_time");
		onecategory onecate = new onecategory();
		
		onecate.setCategory1_name(category1_name);
		onecate.setCategory1_time(category1_time);
		onecate.setCategory_id(category_id);
		
		JSONObject json = new JSONObject();
			if(userService.updateonecateInfo(onecate)==1){
	       
			    json.put("data", "1");
			    out.print(json);
			}else{
				json.put("data", "2");
				out.print(json);
			}
		out.flush();
		out.close();
	}
	
	//删除一级类目
	@RequestMapping("/deleteOnecate")
	public void deleteOnecate(HttpServletRequest request,HttpServletResponse response){
		PrintWriter out =null;
		try{
			out = response.getWriter();
		}catch(IOException e){
			e.printStackTrace();
		}
		int category_id = Integer.parseInt(request.getParameter("id"));
		onecategory onecate = new onecategory();
		onecate.setCategory_id(category_id);
		JSONObject json =new JSONObject();
		if(userService.deleteOnecate(onecate)==1){
			json.put("data", "1");
			out.print(json);
		}else{
			json.put("data", "2");
			out.print(json);
		}
		out.flush();
		out.close();
	}
	
	
	//展示二级目录
	@RequestMapping("/gettowcategoryList")
	@ResponseBody
	public List<towcategory>gettowcategoryList(){
		return userService.gettowcategoryList();
	}
	
	//添加二级目录
	@RequestMapping("/saveTowcategoryInfo")
	@ResponseBody
	public void saveTowcategoryInfo(HttpServletRequest request,HttpServletResponse response){
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		int category1_id = Integer.parseInt(request.getParameter("category1_id"));
		System.out.println(category1_id);
		String category2_name = request.getParameter("category2_name");
		System.out.println(category2_name);
		String category2_time = request.getParameter("category2_time");
		towcategory towcate = new towcategory();
		towcate.setCategory1_id(category1_id);
		towcate.setCategory2_name(category2_name);
		towcate.setCategory2_time(category2_time);
		
		JSONObject json = new JSONObject();
			if(userService.savetowcateInfo(towcate)==1){
			    json.put("data", "1");
			    out.print(json);
			}else{
				json.put("data", "2");
				out.print(json);
			}
		out.flush();
		out.close();
		
		
		
		
	}
	//二级目录修改updateTowcategoryInfo
	@RequestMapping("/updateTowcategoryInfo")
	public void updateTowcategoryInfo(HttpServletRequest request,HttpServletResponse response){
		
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		int category2_id = Integer.parseInt(request.getParameter("category2_id"));
		String category2_name = request.getParameter("category2_name");
		System.out.println(category2_name);
		String category2_time = request.getParameter("category2_time");
		towcategory towcate = new towcategory();
		
		towcate.setCategory2_name(category2_name);
		towcate.setCategory2_time(category2_time);
		towcate.setCategory2_id(category2_id);
		
		JSONObject json = new JSONObject();
			if(userService.updateTowcateInfo(towcate)==1){
	       
			    json.put("data", "1");
			    out.print(json);
			}else{
				json.put("data", "2");
				out.print(json);
			}
		out.flush();
		out.close();
	}
	
	//删除类目二数据deleteTowcate
	@RequestMapping("/deleteTowcate")
	public void deleteTowcate(HttpServletRequest request,HttpServletResponse response){
		PrintWriter out =null;
		try{
			out = response.getWriter();
		}catch(IOException e){
			e.printStackTrace();
		}
		int category2_id = Integer.parseInt(request.getParameter("id"));
		System.out.println(category2_id);
		towcategory towcate = new towcategory();
		towcate.setCategory2_id(category2_id);
		logger.info("==删除二级类目id=="+category2_id);
		JSONObject json =new JSONObject();
		if(userService.deleteTowcate(towcate)==1){
			json.put("data", "1");
			out.print(json);
		}else{
			json.put("data", "2");
			out.print(json);
		}
		out.flush();
		out.close();
	}
	
    //定位
	@RequestMapping("/dingwei")
	public ModelAndView dw(){
		
		ModelAndView model = new ModelAndView("admin/UserDingWei");
		return model;
	}
	//用户反馈
	@RequestMapping("/feedback")
	public ModelAndView fd(){
		
		ModelAndView model = new ModelAndView("my/UserfeedAdd");
		return model;
	}
	//管理员用户反馈表
	@RequestMapping("/Userfeedlist")
	public ModelAndView Uf(){
		ModelAndView model = new ModelAndView("admin/Userfeedlist");
		
		return model;
	}
	//展示用户反馈表
	@RequestMapping(value="/getUserfeedList")
	public List<Feedback>getUserfeedList(){
		
		return userService.getUserfeedList();
	}
	
	@RequestMapping(value="/user_availablename")
	public void user_availablename(HttpServletRequest request,HttpServletResponse response){
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		String user_name = request.getParameter("user_name");
		
	}
	
	

	@RequestMapping(value="/getback_pwd_code")
	public void getback_pwd_code(HttpServletRequest request,HttpServletResponse response){
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		String user_mail = request.getParameter("user_mail");
		
		
	}
	
	
	
	
	@RequestMapping(value="/updateUserInfo")
	public void updateUserInfo(HttpServletRequest request,HttpServletResponse response){
		
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
        long startTime=System.currentTimeMillis();
		InetAddress ia=null;
		try {
			ia=InetAddress.getLocalHost();
		} catch (UnknownHostException e) {
			e.printStackTrace();
		}
		String localIp=ia.getHostAddress();
		int localPort=request.getLocalPort();
		Map<String, String> map = System.getenv();
        String localUsername = map.get("USERNAME");
        String localHost = map.get("COMPUTERNAME");

        String localMethod = Thread.currentThread() .getStackTrace()[1].getMethodName();
        String localRoute =request.getRequestURI() ;
        String localFunction = localRoute +">"+localMethod;
        logger.info("==ִ�к���=="+localFunction);
        
		int id = Integer.parseInt(request.getParameter("user_id"));
		String user_name = request.getParameter("user_name");
		String user_call = request.getParameter("user_call");
		String user_time = request.getParameter("user_time");
		String user_role = request.getParameter("user_role");
		int user_state = Integer.parseInt(request.getParameter("user_state"));
		User user = new User();
		user.setId(id);
		user.setUser_call(user_call);
		user.setUser_time(user_time);
		user.setUser_role(user_role);
		user.setUser_state(user_state);
		JSONObject json = new JSONObject();
		if(userService.updateUserInfo(user)==1){
			long endTime=System.currentTimeMillis(); //��ȡ����ʱ��
	        String localData =endTime-startTime+"ms";
	        logger.info("==ִ��ʱ��=="+localData);
	        Date date = new Date();
            SimpleDateFormat sdf =   new SimpleDateFormat( " yyyy-MM-dd HH:mm:ss " );
            String nowTime = sdf.format(date);
            logger.info("==��ǰ��¼ʱ��=="+nowTime);
            Log logs = new Log();
    		logs.setSystime(nowTime);
    		logs.setSysname(user_name);
    		logs.setSysip(localIp);
    		logs.setSysport(localPort);
    		logs.setSysusername(localUsername);
    		logs.setSyshost(localHost);
    		logs.setSysfunction(localFunction);
    		logs.setSysdata(localData);
    		userService.saveLogInformation(logs);
    		
			json.put("data", "1");
			out.print(json);
		}else{
			json.put("data", "2");
			out.print(json);
		}
		out.flush();
		out.close();
	}
	
	//������Ϣ
	@RequestMapping(value="/saveUserInfo")
	public void saveUserInfoormation(HttpServletRequest request,HttpServletResponse response){
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		//��ȡ����ִ��ʱ��
        long startTime=System.currentTimeMillis();
		InetAddress ia=null;
		try {
			ia=InetAddress.getLocalHost();
		} catch (UnknownHostException e) {
			e.printStackTrace();
		}
		String localIp=ia.getHostAddress();
		int localPort=request.getLocalPort();
		Map<String, String> map = System.getenv();
        String localUsername = map.get("USERNAME");
        String localHost = map.get("COMPUTERNAME");
		//��ȡ��������
        String localMethod = Thread.currentThread() .getStackTrace()[1].getMethodName();
        String localRoute =request.getRequestURI() ;
        String localFunction = localRoute +">"+localMethod;
        logger.info("==ִ�к���=="+localFunction);
		
		String user_name = request.getParameter("user_name");
		String user_pwd = request.getParameter("user_pwd");
		String user_call = request.getParameter("user_call");
		String user_time = request.getParameter("user_time");
		String user_role = request.getParameter("user_role");
		int user_state = Integer.parseInt(request.getParameter("user_state"));
		User user = new User();
		user.setUser_name(user_name);
		user.setUser_pwd(user_pwd);
		user.setUser_call(user_call);
		user.setUser_time(user_time);
		user.setUser_role(user_role);
		user.setUser_state(user_state);
		JSONObject json = new JSONObject();
		
		if(userService.selectUserExist(request.getParameter("user_name"))==0){
			if(userService.saveUserInfo(user)==1){
			long endTime=System.currentTimeMillis(); 
	        String localData =endTime-startTime+"ms";
	        logger.info("==ִ��ʱ��=="+localData);
	        Date date = new Date();
            SimpleDateFormat sdf =   new SimpleDateFormat( " yyyy-MM-dd HH:mm:ss " );
            String nowTime = sdf.format(date);
            logger.info("==��ǰ��¼ʱ��=="+nowTime);
            Log logs = new Log();
    		logs.setSystime(nowTime);
    		logs.setSysname(user_name);
    		logs.setSysip(localIp);
    		logs.setSysport(localPort);
    		logs.setSysusername(localUsername);
    		logs.setSyshost(localHost);
    		logs.setSysfunction(localFunction);
    		logs.setSysdata(localData);
    		userService.saveLogInformation(logs);
			json.put("data", "1");
			out.print(json);
			}else{
				json.put("data", "2");
				out.print(json);
			}
		}else{
			json.put("data", "0");
			out.print(json);
		}
		out.flush();
		out.close();
	}
	
	@RequestMapping(value="/loglist")
    public ModelAndView loglist(){
    	ModelAndView model = new ModelAndView("admin/userLogInformation");
    	return model;
    }
    @RequestMapping(value="/getLogList")
    @ResponseBody
    public List<Log>getLogList(){
    	return userService.getLogList();
    }
    
    @RequestMapping(value="/deleteLogs")
    public void deleteLog(int[] ids,HttpServletResponse response){
    	PrintWriter out =null;
    	try{
    		out = response.getWriter();
    	}catch(IOException e){
    		e.printStackTrace();
    	}
    	userService.deleteLogs(ids);   
    	if(ids!=null){
    		out.print("1");
    	}else{
    		out.print("2");
    	}
    	out.flush();
    	out.close();
    }
    //推荐Recommend
    @RequestMapping("Recommend")
    public ModelAndView Recommend(){
    	ModelAndView model = new ModelAndView("admin/IntelligenceRecommend");
    	return model;
    }
    
   
    
	
	
}