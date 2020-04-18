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
	<title>用户反馈</title>
	
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
			background: url("static/img/logo1.jpg");
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
   <fieldset><legend><span class="glyphicon glyphicon-user"></span>用户反馈</legend>
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
    <label class="col-sm-2 control-label label-style">性别</label>
    	<div class="col-sm-7">
				<input type="radio" name="xb" id="xb1" value="男" checked>男&nbsp&nbsp
				<input type="radio" name="xb" id="xb2" value="女">女&nbsp&nbsp
    	</div> 
  </div>
  <div class="form-group">
    <label class="col-sm-2 control-label label-style">年龄</label>
    	<div class="col-sm-7">
    		<input type="text" class="form-control" id="user_age" name="user_age" placeholder="请输入年龄">
    	</div>
  </div>
  <div class="form-group">
    <label class="col-sm-2 control-label label-style">联系地址</label>
    	<div class="col-sm-7">
    		<input type="text" class="form-control" id="user_address" name="user_address" placeholder="请输入联系地址">
    	</div>
  </div>
    <div class="form-group">
    <label class="col-sm-2 control-label label-style">手机号</label>
    	<div class="col-sm-7">
    		<input type="text" class="form-control" id="user_call" name="user_call" placeholder="请输入手机号">
    	</div>
  </div>
  <!-- <div class="form-group">
    <label class="col-sm-2 control-label label-style">验证码</label>
    	<div class="col-sm-4">
    		<input type="text" class="form-control"  style="width:240px;" id="getback_pwdcode" placeholder="请输入验证码">
    	</div>
    <div style="display: inline;">
      <label class="help-block1">
        <input type="button" class="btn btn-default btn-sm" onclick="gain_getbackpwdcode(this)" value="获取验证码" style="width: 105px;margin-left: 47px;"/>
      </label>
    </div>
  </div> -->
   <div class="form-group">
    <label class="col-sm-2 control-label label-style">身份</label>
    	<div class="col-sm-7">
				<select name="user_sf" id="user_sf">
				<option value="初中生">初中生</option>
				<option value="高中生">高中生</option>
				<option value="大学生">大学生</option>
				<option value="其他">其他</option>
				</select>
    	</div>
  </div>
   <div class="form-group">
    <label class="col-sm-2 control-label label-style">您对本网站的建议</label>
    	<div class="col-sm-7">
    		  <textarea name="introduce" id="introduce" rows="10" cols="40" ></textarea>	
    	</div>
  </div>
  <div class="form-group">
    <div class="col-sm-offset-2 col-sm-3 col-sm-w">
      <button type="button" onclick="edit_userpwd()" class="btn btn-info" name="login-bt" id="login-bt" ><span class="glyphicon glyphicon-ok-sign"></span> 保存提交</button>
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
            var user_xb=$("input[type='radio']:checked").val();
            var user_age=$("#user_age").val();
            var user_address=$("#user_address").val();
            var user_call=$("#user_call").val();
            var yzm=$("getback_pwdcode").val();
            var options = $("#user_sf option:selected");　　
            var user_sf = options.val();　　　　　　　　　　　　　
            var introduce=$("#introduce").val();  
            
 
			if(user_name==""){
				layer.alert('请输入账号', {
					   skin: 'layui-layer-molv'
					   ,closeBtn: 2
					   ,anim: 1
					 });
				return;
			}
			if(user_xb==""){
				layer.alert('请输入性别', {
					   skin: 'layui-layer-molv'
					   ,closeBtn: 2
					   ,anim: 1
					 });
				return;
			}
			if(user_age==""){
				layer.alert('请输入年龄', {
					   skin: 'layui-layer-molv'
					   ,closeBtn: 2
					   ,anim: 1
					 });
				return;
			}
			if(user_address==""){ 
				layer.alert('请输入年龄', {
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
			if(user_call.length<11)
			{
				layer.alert('电话格式有误', {
					   skin: 'layui-layer-molv'
					   ,closeBtn: 2
					   ,anim: 1
					 });
				return;
				
			}
			/* if(yzm==""){
				layer.alert('请输入验证码', {
					   skin: 'layui-layer-molv'
					   ,closeBtn: 2
					   ,anim: 1
					 });
				return;
			} */
			if(introduce==""){
				layer.alert('请输入网站建议', {
					   skin: 'layui-layer-molv'
					   ,closeBtn: 2
					   ,anim: 1
					 });
				return;
			}
			
			//var url="user/newbackuser";
			var url="user/feedbackuser"
			var data={
				user_name : user_name,
				user_xb : user_xb,
				user_age :user_age,
				user_address : user_address,
				user_call :user_call,
				yzm : yzm,
				user_sf : user_sf,
				data : data,
				introduce : introduce
				
			};
			
			$.post(url,data,function(data){
				var result=$.parseJSON(data);
				if(result.data=="1"){
					alert("提交成功！");
					return_loginview();
				}
				if(result.data=="-1"){
					alert("提交失败！");
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
			window.location.href="index.jsp";
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