<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <base href="<%=basePath%>">
 <title>智能推荐的在线组队平台</title>
    <meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
    <link rel="icon" href="<%=basePath%>static/img/title1.png">
    <link rel="stylesheet" href="<%=basePath%>static/bootstrap-3.3.7/css/bootstrap.css">
	<link rel="stylesheet" href="<%=basePath%>static/css/login.css">
	<link rel="stylesheet" href="<%=basePath%>resources/layui/css/modules/layer/default/layer.css">
	<link rel="stylesheet" href="<%=basePath%>resources/layui/css/modules/layui.css">
	<link rel="stylesheet" href="<%=basePath%>resources/layui/css/modules/layui.mobile.css">
    <script src="<%=basePath%>static/jquery-3.1.1/jquery-3.1.1.js"></script>
    <script src="<%=basePath%>static/jquery-3.1.1/jquery-3.1.1.min.js"></script>
    <script src="<%=basePath%>static/bootstrap-3.3.7/js/bootstrap.min.js"></script>
  <script type="text/javascript">
    $(function(){
       $('#myModel').modal({
    	     backdrop:false,//点击空白处不关闭对话框
             show:true, //弹出对话框
             keyboard:false //键盘关闭对话框
       });
       
    });
    </script>
</head>
<body>
<div class="header">
 <div class="header-title">
   <h4><span class="glyphicon glyphicon-apple"></span>确认过眼神，你就是我要找的人</h4>
 </div>
</div>
 <div class="bodyy">
  <p style="color:#fff;padding-top: 150px;margin-left: 200px;font-size: 30px;">在线组队平台  组队需求发布</p>
   <p style="color:#fff;padding-top: 5px;margin-left: 200px;font-size: 15px;">智能推荐信息，参队请求信息</p>
   <p style="color:#fff;padding-top: 5px;margin-left: 200px;font-size: 15px;">请求并组建团队，与成员在线聊天</p>
   <p style="color:#fff;padding-top: 5px;margin-left: 200px;font-size: 15px;">参队候选人，发布自己的技能描述 </p>
   <p style="color:#fff;padding-top: 5px;margin-left: 200px;font-size: 15px;">能够跨专业跨校，快速找到自己需求的队友</p>
   <div class="modal fade login-fade"  id="myModel" role="dialog">
	  <div class="modal-dialog" role="document" style="width:450px;">
	  
	    <div class="modal-content login-modal-content">
	      <div class="modal-header">
	        <h4 class="modal-title"><span class="glyphicon glyphicon-user"></span> Welcome登陆</h4>
	      </div>
	      <div class="modal-body modal-bodyy">
	         <form>
	         <table class="login-table">
	            <tr class="login-tr">
	               <td class="login-key">账号：</td>
	               <td><input type="text" id="user_name" name="user_name" class="form-control" placeholder="请输入邮箱 / 账户"/></td>
	            </tr>
	            <tr></tr>
	            <tr class="login-tr">
	               <td class="login-key">密码：</td>
	               <td><input type="password" id="user_pwd" name="user_pwd" class="form-control" placeholder="请输入登录密码"/></td>
	            </tr>
	            <tr class="login-tr1">
	               <td class="login-key1" colspan="2">
	                    <a href="user/forgetpwd">忘记密码</a>
	                   <a href="user/loginUser"style="margin-left: 5px;">立即注册</a>
	               </td>
	            </tr>             
	         </table>
	      <div class="modal-footer" >
	        <button type="button" class="btn btn-info" name="login-bt" id="login-bt" onclick="login();">登录</button>
	        <button type="reset" class="btn btn-default"  onclick="javascript:loginForm.reset();return false;" >重置</button>
	      </div>
	       </form>
	      </div>
	    </div>
	  </div>
	</div>
  </div>
 
 <div class="foot foot-style"><p style="color:#999;">Copyright @ 2020 贵州师范学院     &nbsp;&nbsp;邮编：550028  &nbsp;&nbsp;技术支持：summer-少年</p></div>
<script src="<%=basePath%>resources/layui/lay/modules/layer.js"></script>
<script type="text/javascript">
  
   function login(){
	   
	   var user_name=$("#user_name").val();
	   var user_pwd=$("#user_pwd").val();
	   if(user_name==""){
		   layer.alert('账号不能为空!');
		   return false;
	   }
	   if(user_pwd==""){
		   layer.alert('密码不能为空!');
		   return false;
	   }
	   //进入后台
	   var url ="<%=basePath%>user/login";
	   var data={user_name:user_name,user_pwd:user_pwd};
	   $.post(url,data,function(data){
		   var result = $.parseJSON(data);
		   if(result.data=="1"){

			   window.location.href="<%=basePath%>user/index";
		   }
		   if(result.data=="-1"){
			   layer.alert("账号被锁!");
			   return;
		   }
		   if(result.data=="2")
		   {
			   layer.alert("密码错误或账号!");
			   return;
		   }
	   })
	   
   }
// 网页内按下回车触发
	var ShowEnterKey = function(e) 
	{
		var currKey = 0, e = e || event;
		currKey = e.keyCode || e.which || e.charCode;
		if (currKey == 13) {
			$("#login-bt").click();
			return false;
		}
	};
	document.onkeydown = ShowEnterKey;
</script>
</body>
</html>
