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
	<title>立即注册</title>
	
	<link rel="stylesheet" href="<%=basePath%>static/bootstrap-3.3.7/css/bootstrap.css">
	<link rel="stylesheet" href="<%=basePath%>resources/layui/css/modules/layer/default/layer.css">
	<script src="<%=basePath%>resources/js/jquery-2.1.1.min.js" type="text/javascript"></script>
    <script src="<%=basePath%>resources/js/register.js" type="text/javascript"></script>
    <script src="<%=basePath%>static/jquery-3.1.1/jquery-3.1.1.js"></script>
    <script src="<%=basePath%>static/bootstrap-3.3.7/js/bootstrap.min.js"></script>
	
	<style type="text/css">
		body{
			width: 100%;
			height: 100%;
			background: url("static/img/login2.jpg");
			margin: 0;
			padding: 0;
		}
		.header{
		    border: 3px solid #9b8a7d;
		    width: 600px;
		    box-shadow: 0 0 20px 10px #96887d;
		    margin: 50px 0 0 400px;
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
   <fieldset><legend><span class="glyphicon glyphicon-user"></span>用户注册</legend>
  </fieldset>
  <div class="form-group">
    <label class="col-sm-2 control-label label-style">用户账号</label>
      <div class="col-sm-7">
        <input type="text" class="form-control" data-options="events:{blur: function(){judge_userid()}}" id="user_name" name="user_name" placeholder="请输入账号">
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
    <label class="col-sm-2 control-label label-style">邮箱</label>
    	<div class="col-sm-7">
    		<input type="text" class="form-control" id="user_mail" name="user_mail" placeholder="请输入邮箱">
    	</div>
  </div>
   <div class="form-group">
    <label class="col-sm-2 control-label label-style">注册时间</label>
    	<div class="col-sm-7">
    		<input type="text" class="form-control" id="user_time" name="user_time" placeholder="请输入注册日期">
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
    <label class="col-sm-2 control-label label-style">爱好</label>
    	<div class="col-sm-7">
				<input type="checkbox" name="ah" id="ah1" value="睡觉">睡觉&nbsp&nbsp
				<input type="checkbox" name="ah" id="ah2" value="学习">学习&nbsp&nbsp
				<input type="checkbox" name="ah" id="ah3" value="代码">代码&nbsp&nbsp
				<input type="checkbox" name="ah" id="ah4" value="唱歌">唱歌&nbsp&nbsp
				<input type="checkbox" name="ah" id="ah5" value="运动">运动&nbsp&nbsp
				<input type="checkbox" name="ah" id="ah6" value="逛街">逛街&nbsp&nbsp
    	</div>
  </div>
   <div class="form-group">
    <label class="col-sm-2 control-label label-style">特长</label>
    	<div class="col-sm-7">
    		  <textarea name="introduce" id="introduce" rows="10" cols="40" ></textarea>	
    	</div>
  </div>
  <div class="form-group">
    <div class="col-sm-offset-2 col-sm-3 col-sm-w">
      <button type="button" onclick="edit_userpwd()" class="btn btn-info" name="login-bt" id="login-bt" ><span class="glyphicon glyphicon-ok-sign"></span> 保存密码</button>
    </div>
    <div>
      <button type="button" onclick="return_loginview()" class="btn btn-warning"><span class="glyphicon glyphicon-home"></span> 返回登录</button>
    </div>
  </div>
</form>
</div>
<script src="<%=basePath%>resources/layui/layui.js"></script>
<script src="<%=basePath%>resources/layui/lay/modules/layer.js"></script>
<script>
layui.use('laydate', function(){
  var laydate = layui.laydate;
  laydate.render({
    elem: '#user_time' //layui时间控件使用
    	,theme: 'molv' 
  });
});
</script>
	<script type="text/javascript">
		function edit_userpwd(){
			var user_name=$("#user_name").val();
            var user_pwd=$("#user_pwd").val();
            var user_pwdok=$("#user_pwdok").val();
            var user_mail=$("#user_mail").val();
            var user_call=$("#user_call").val();
            var yzm=$("getback_pwdcode").val();
            var user_time=$("#user_time").val();
            var getback_pwdcode=$("#getback_pwdcode").val();
            var ah=document.getElementsByName('ah');
            var ah0=false;//判断是否有选中项，默认为无
            var introduce=$("#introduce").val();
            
            var ids = $('input[type=checkbox]');
            var data = '';
            ids.each(function () {
                //获取当前元素的勾选状态
                if ($(this).prop("checked")) {
                    data = data + $(this).val() + ",";
                }
            });
            //去最后的点
            data = data.substring(0, data.length - 1);
             /* //弹出结果
            alert(data); */

            for(var i=0;i<ah.length;i++)
            {
                  if(ah[i].checked==true)
                  {
                   
                	 ah0=true;
                     break;
                  }
            }
            
			if(user_name==""){
				layer.alert('请输入账号', {
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
			if(user_mail==""){
				layer.alert('请输入邮箱', {
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
			if(yzm==""){
				layer.alert('请输入验证码', {
					   skin: 'layui-layer-molv'
					   ,closeBtn: 2
					   ,anim: 1
					 });
				return;
			}
			if(user_time==""){
				layer.alert('请输入注册日期', {
					   skin: 'layui-layer-molv'
					   ,closeBtn: 2
					   ,anim: 1
					 });
				return;
				
			}
			if(user_call.length<11)
			{
				layer.alert('电话格式有误', {
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
			if(ah0==false){
				layer.alert('请至少勾选一个爱好', {
					   skin: 'layui-layer-molv'
					   ,closeBtn: 2
					   ,anim: 1
					 });
				return false;
				
			}
			if(introduce==""){
				layer.alert('请输入特长', {
					   skin: 'layui-layer-molv'
					   ,closeBtn: 2
					   ,anim: 1
					 });
				return;
			}
			
			var url="user/newbackuser";
			var data={
				user_name : user_name,
				user_pwd : user_pwd,
				user_mail :user_mail,
				user_call :user_call,
				yzm : yzm,
				user_time :user_time,
				getback_pwdcode : getback_pwdcode,
				data : data,
				introduce : introduce
				
			};
			
			$.post(url,data,function(data){
				var result=$.parseJSON(data);
				
				if(result.data=="1"){
					alert("注册成功！");
					return_loginview();
				}
				if(result.data=="-1"){
					alert("注册失败,该用户已存在！");
				}
				if(result.data=="0"){
					alert("验证码错误或为空");
				}
				if(result.data=="-3"){
					alert("验证码过期，请重试！");
				}
			});
			
		}
	
		var countdown=60;
	
		function gain_getbackpwdcode(val){
			
			if(countdown == 60){
				
				var user_call=$("#user_call").val();
				
				if(user_call==""){
					alert("请输入手机号码");
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
				} */
				//$.post("user/getback_pwd_code?user_call="+user_call,{},function(data){});
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
			window.location.href="login.jsp";
		}
	
		//正则表达式验证邮箱
		function mailcheck(temp){
		       //对电子邮件的验证
		       var myreg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
		       if(!myreg.test(temp)){
		            return false;
		       }else{
		    	   return true;
		       }
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