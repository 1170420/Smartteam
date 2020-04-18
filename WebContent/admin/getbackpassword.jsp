<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>   
<!DOCTYPE html>
<html>
<head>
    <base href="<%=basePath%>">
	<meta charset="UTF-8">
	<title>忘记密码</title>
	
	<link rel="stylesheet" href="<%=basePath%>static/bootstrap-3.3.7/css/bootstrap.css">
	<link rel="stylesheet" href="<%=basePath%>resources/layui/css/modules/layer/default/layer.css">
	
    <script src="<%=basePath%>static/jquery-3.1.1/jquery-3.1.1.js"></script>
    <script src="<%=basePath%>static/bootstrap-3.3.7/js/bootstrap.min.js"></script>
	
	<style type="text/css">
		body{
			width: 100%;
			height: 100%;
			background: url("static/img/logo1.jpg");
			margin: 0;
			padding: 0;
		}
		.header{
		    border: 2px solid #9b8a7d;
		    width: 650px;
		    box-shadow: 0 0 20px 10px #96887d;
		    margin: 100px 0 0 400px;
		    background: #fff;
		  
		}
		.from-control-input{
		   width: 400px !important;
		}
		
		.help-block1 {
		    display: block;
		    margin-top: 2px;
		    color: #737373;
		}
		.from-padding{
		    margin: 15px 0 0 20px;
		}
		.btn-w355{width: 356px;}
		legend {
		    display: block;
		    width: 100%;
		    padding: 0;
		    margin-bottom: 20px;
		    font-size: 15px;
		    line-height: inherit;
		    color: #5bc0de;
		    border: 0;
		    border-bottom: 1px solid #e5e5e5;
		}
		.label-style{
		   font-size: 12px;
		   color: #696664;
		   font-family: '微软雅黑';
		}
		.col-sm-w{width: 20%;}
	</style>
</head>
<body>
<div class="header">
 <form class="form-horizontal from-padding">
   <fieldset><legend><span class="glyphicon glyphicon-user"></span> 用户找回密码</legend>
  </fieldset>
  <div class="form-group">
    <label class="col-sm-2 control-label label-style">用户账号</label>
      <div class="col-sm-7">
        <input type="text" class="form-control" data-options="events:{blur: function(){judge_userid()}}" id="user_name" name="user_name" placeholder="请输入原有账号">
      </div>
      <div style="display: inline;">
         <label class="help-block" id="msg" style="font-size: 12px;"></label>
      </div>
  </div>
  <div class="form-group">
     <label class="col-sm-2 control-label label-style">新密码</label>
      <div class="col-sm-7">
         <input type="password" class="form-control" id="user_pwd" name="user_pwd" placeholder="请输入新密码">
      </div>
  </div>
  <div class="form-group">
    <label class="col-sm-2 control-label label-style">确认密码</label>
      	<div class="col-sm-7">
           <input type="password" class="form-control" id="user_pwdok" name="user_pwdok" placeholder="请输入确认密码">
    	</div>
  </div>
  <div class="form-group">
    <label class="col-sm-2 control-label label-style">手机号</label>
    	<div class="col-sm-7">
    		<input type="text" class="form-control" id="user_call" name="user_call" placeholder="请输入手机号">
    	</div>
  </div>
  <div class="form-group">
    <label class="col-sm-2 control-label label-style">验证码</label>
    	<div class="col-sm-4">
    		<input type="text" class="form-control"  style="width:240px;" id="getback_pwdcode" placeholder="请输入验证码">
    	</div>
    <div style="display: inline;">
      <label class="help-block1">
        <input type="button" class="btn btn-default btn-sm" onclick="gain_getbackpwdcode(this)" value="获取验证码" style="width: 105px;margin-left: 47px;"/>
      </label>
    </div>
  </div>
  <div class="form-group">
    <div class="col-sm-offset-2 col-sm-3 col-sm-w">
      <button type="button" onclick="edit_userpwd()" class="btn btn-info"><span class="glyphicon glyphicon-ok-sign"></span> 保存密码</button>
    </div>
    <div>
      <button type="button" onclick="return_loginview()" class="btn btn-warning"><span class="glyphicon glyphicon-home"></span> 返回登录</button>
    </div>
  </div>
</form>
</div>
<script src="<%=basePath%>resources/layui/lay/modules/layer.js"></script>
	<script type="text/javascript">
		function edit_userpwd(){
			var user_name=$("#user_name").val();
            var user_pwd=$("#user_pwd").val();
            var user_pwdok=$("#user_pwdok").val();
            var user_call=$("#user_call").val();
            var getback_pwdcode=$("#getback_pwdcode").val();
          
			if(user_name==""){
				layer.alert('请输入原账号', {
					   skin: 'layui-layer-molv'
					   ,closeBtn: 2
					   ,anim: 1
					 });
				return;
			}
			if(user_pwd==""){
				layer.alert('请输入新密码', {
					   skin: 'layui-layer-molv'
					   ,closeBtn: 2
					   ,anim: 1
					 });
				return;
			}
			if(user_pwdok==""){
				layer.alert('请输入确认密码', {
					   skin: 'layui-layer-molv'
					   ,closeBtn: 2
					   ,anim: 1
					 });
				return;
			}
			if(user_pwd.length<6||user_pwdok.length<6){
				layer.alert('密码不能少于6位', {
					   skin: 'layui-layer-molv'
					   ,closeBtn: 2
					   ,anim: 1
					 });
				return;
			}
			if(user_pwd!=user_pwdok){
				layer.alert('两次密码不一致', {
					   skin: 'layui-layer-molv'
					   ,closeBtn: 2
					   ,anim: 1
					 });
				return;
			}
			if(user_call==""){
				layer.alert('请输入手机号', {
					   skin: 'layui-layer-molv'
					   ,closeBtn: 2
					   ,anim: 1
					 });
				return;
			}
			if(user_call.length!=11){
				layer.alert('请输入合理的手机号', {
					   skin: 'layui-layer-molv'
					   ,closeBtn: 2
					   ,anim: 1
					 });
				return;
			}
			if(getback_pwdcode==""){
				layer.alert('请输入验证码', {
					   skin: 'layui-layer-molv'
					   ,closeBtn: 2
					   ,anim: 1
					 });
				return;
			}
			
			var url="user/getback_userpwd";
			var data={
				user_name : user_name,
				user_pwd : user_pwd,
				user_pwdok : user_pwdok,
				user_call :user_call,
				getback_pwdcode : getback_pwdcode
			};
			$.post(url,data,function(data){
				var s=$.parseJSON(data);
				if(s.data=="1"){
					alert("修改成功！");
					return_loginview();
				}
				if(s.data=="0"){
					alert("该用户，不存在！");
				}
				if(s.data=="-2"){
					alert("验证码错误！");
				}
			});
			
		}
	
		var countdown=60;
	
		function gain_getbackpwdcode(val){
			
			if(countdown == 60){
				var flag=true;
				var user_call=$("#user_call").val();
				if(user_call==""){
					alert("请输入手机号");
					return;
				}
				
				var reg = /^1\d{10}$/;
				if(!reg.test(user_call)){
					alert('请输入合法的手机号码');
					return ;
				}
				var data={
					user_call:user_call
				};
				
				$.ajax({
	   				type:"post",
	   				url:"<%=basePath%>user/select_mailanduser_idExit",
	   				data:data,
	   				cache: false,
	   				async: false,  
	                success:function(data){
	                	var result = $.parseJSON(data);
						if(result.data == '1'){
							alert("注册成功！");
			        		return ;
						}
						if(result.data = '0'){
							alert("验证码错误或验证为空！");
			        		return ;
						}
						if(result.data = '-1'){
							alert("注册失败！");
			        		return ;
						}	
	                }
				});
	
				/* if(flag==false){
					return;
				}
				$.post("user/getback_pwd_code?user_mail="+user_mail,{},function(data){}); */
			}
			if (countdown == 0) {
	            val.removeAttribute("disabled");
	            val.value="获取验证码";
	            countdown = 60;
	           
	        }else {
	        	
	            val.setAttribute("disabled", true);
	            val.value="重新发送(" + countdown + ")";
	            countdown--;
	            setTimeout(function() {
	            	gain_getbackpwdcode(val)
	            },1000)
	        }
		}
		
	   //异步查询发送ajax请求校验登陆名称是否可用
       $("#user_name").change(function(){
       	var user_name = this.value;
       	$.ajax({
       		url:"user/user_availablename",
       		data:{
               user_name:$("#user_name").val()
            },
       		type:"POST",
       		success:function(data){
       		    var msg=document.getElementById("msg");
       			if(data=="1"){
       			    msg.innerHTML="<font color='red'>*账号名不存在,不可修改</font>";
       			}
       			if(data=="2"){
       				msg.innerHTML="<font color='#157514'>*账号名存在,可修改</font>";
       			}
       		}
       	});
	   });
		 
		//返回登录界面
		function return_loginview(){
			window.location.href="user/Login1";
		}
	
		/* //正则表达式验证邮箱
		function mailcheck(temp){
		       //对电子邮件的验证
		       var myreg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
		       if(!myreg.test(temp)){
		            return false;
		       }else{
		    	   return true;
		       }
		} */
	</script>

</body>
</html>