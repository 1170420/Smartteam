<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>    
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加管理员信息</title>
<link rel="stylesheet" href="<%=basePath%>static/bootstrap-3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=basePath%>resources/layui/css/layui.css">
<link rel="stylesheet" href="<%=basePath%>static/bootstrap-3.3.7/css/common.css">
<link rel="stylesheet" href="<%=basePath%>resources/layui/css/modules/layer/default/layer.css">

<script src="<%=basePath%>static/jquery-3.1.1/jquery-3.1.1.min.js"></script>
<script src="<%=basePath%>static/bootstrap-3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<div class="panel panel-info">
 <div class="panel-heading"><span class="glyphicon glyphicon-plus"></span> 新增管理员信息</div>
<div class="container1">
	<div class="emi-box1">
	
	  <div class="row">
		  <div class="col-md-6">带 <span style="color:red;font-weight:bold;font-size:15px;padding:0 5px;">*</span> 为必填项</div>
		  <div class="col-md-6 text-align-right">
		    <button type="button" onclick="saveUserInfo();" class="btn btn-info btn-sm"><span class="glyphicon glyphicon-th"></span> 保存管理员信息</button>
		  </div>
	  </div>
	  <!-- 基本信息表格 -->
	  <table class="table table-bordered margin-top-10 emi-table">
	    <tr>
	       <td class="emi-key"><span>*</span>登录账号：</td>
	       <td><input type="text" id="user_name" name="user_name" class="emi-input" placeholder="登录账号"/></td>
	       <td class="emi-key"><span>*</span>注册时间：</td>
	       <td colspan="3"><input type="text" id="user_time" name="user_time" class="emi-input" placeholder="请选择注册日期"/></td>
	       <td class="emi-photo" rowspan="5">
	          <img alt="yandongfa" src="<%=basePath%>static/img/ydf.jpg">
	       </td>
	    </tr>
	    
	    <tr>
	       <td class="emi-key"><span>*</span>登录密码：</td>
	       <td ><input type="password" id="user_pwd" name="user_pwd" class="emi-input" placeholder="登录密码"/></td>
	       <td class="emi-key"><span>*</span>手机号码：</td>
	       <td><input type="text" id="user_call" name="user_call" class="emi-input" placeholder="11位手机号码"/></td>
	    </tr>
	    
	    <tr>
	       <td class="emi-key"><span>*</span>身份权限：</td>
	       <td colspan="5">
	       <select class="emi-select" id="user_role" name="user_role">
	           <option value="">==请选择==</option>
	           <option value="1">管理员</option>
	           <option value="2">普通用户</option>
	       </select>
	       </td>
	    </tr>
	    
	    <tr>
	       <td class="emi-key"><span>*</span>账号激活：</td>
	       <td colspan="5">
	       <select class="emi-select" id="user_state" name="user_state">
	           <option value="">==请选择==</option>
	           <option value="1">启用</option>
	           <option value="0">禁用</option>
	       </select>
	       </td>
	    </tr>
	  </table>
	  <div class="emi-note">
	    1.此表作为公司人力资源记录，将被用于人力资源管理相关事宜，认真核对后填写<br>
	    2.此表由公司组织定期填写，期间有重要变更请及时通知人力资源部
	  </div>
	</div>
</div>
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
   function saveUserInfo(){
	   var user_name = $("#user_name").val();
	   var user_pwd =  $("#user_pwd").val();
	   var user_call = $("#user_call").val();
	   var user_time = $("#user_time").val();
	   var user_role = $("#user_role").val();
	   var user_state = $("#user_state").val();
	   if(user_name==""){
		   layer.tips('登录名不能为空', '#user_name', {
			  tips: [3, '#1AA094']
			});
		   $("#user_name").focus();
		   return;
	   }
	   if(user_pwd==""){
		   layer.tips('密码不能为空', '#user_pwd', {
			  tips: [3, '#1AA094']
			});
		   $("#user_pwd").focus();
		   return;
	   }
	   if(user_call==""){
		   layer.tips('手机号码不能为空', '#user_call', {
			  tips: [3, '#1AA094']
			});
		   $("#user_call").focus();
		   return;
	   }
	   if(!(/^1(3|4|5|7|8)\d{9}$/.test(user_call))){
   		   layer.tips('手机号码输入格式错误', '#user_call', {
			  tips: [3, '#1AA094']
			});
   		   $("#user_call").focus();
   		   return;
   	   }
	   if(user_time==""){
		   layer.tips('请选择注册时间', '#user_time', {
			  tips: [3, '#1AA094']
			});
		   return;
	   }
	   if(user_role==""){
		   layer.tips('请选择用户权限', '#user_role', {
			  tips: [3, '#1AA094']
			});
		   return;
	   }
	   if(user_state==""){
		   layer.tips('请选择用户激活状态', '#user_state', {
			  tips: [3, '#1AA094']
			});
		   return;
	   }
	   layer.load(1);     //加载层
	   var url="<%=basePath%>user/saveUserInfo";
	   var data={
		   user_name:user_name,
		   user_pwd:user_pwd,
		   user_call:user_call,
		   user_time:user_time,
		   user_role:user_role,
		   user_state:user_state
	   };
	   $.post(url,data,function(data){
		   var result = $.parseJSON(data);
		   if(result.data=="1"){
			   setTimeout(function(){
				   layer.closeAll('loading');
			   }, 500);
			   layer.alert('添加成功', {
				   skin: 'layui-layer-molv' //样式类名
				   ,closeBtn: 0
				   ,anim: 1
				 }, function(){
					window.location.href="<%=basePath%>user/To_Userinformation";
			   });
		   }
		   else if(result.data=="2"){
			   setTimeout(function(){
				   layer.closeAll('loading');
			   }, 500);
			   layer.alert('操作失败', {icon: 2}); 
		   }
		   else{
			   setTimeout(function(){
				   layer.closeAll('loading');
			   }, 500);
			   layer.alert('该账号已被占用', {icon: 2});
		   }
	   })
   }
</script>
</body>
</html>