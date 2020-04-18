<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>     
 <%
 String path = request.getContextPath();
 String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
 %>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>平台首页</title>
<link rel="icon" href="<%=basePath%>static/img/title.png">
<link href="<%=basePath%>static/bootstrap-3.3.7/css/bootstrap.min.css" title="" rel="stylesheet" />
<link title="" href="<%=basePath%>static/css/index.css" rel="stylesheet" type="text/css"  />
<link title="blue" href="<%=basePath%>static/css/dermadefault.css" rel="stylesheet" type="text/css"/>
<link href="<%=basePath%>static/css/templatecss.css" rel="stylesheet" title="" type="text/css" />
<link rel="stylesheet" href="<%=basePath%>resources/layui/css/modules/layer/default/layer.css">
<link rel="stylesheet" href="<%=basePath%>static/bootstrap-3.3.7/css/common.css">

<script src="<%=basePath%>static/jquery-3.1.1/jquery-3.1.1.min.js" type="text/javascript"></script>
<script src="<%=basePath%>static/jquery-3.1.1/jquery.cookie.js" type="text/javascript"></script>
<script src="<%=basePath%>static/bootstrap-3.3.7/js/bootstrap.min.js" type="text/javascript"></script>
<script src="<%=basePath%>resources/layui/lay/modules/layer.js"></script>

</head>
<body>

 <nav class="nav navbar-default navbar-mystyle navbar-fixed-top">
   <div class="navbar-header">
   <button class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse"> 
     <span class="icon-bar"></span> 
     <span class="icon-bar"></span> 
     <span class="icon-bar"></span> 
   </button>
   <a class="navbar-brand mystyle-brand"><span class="glyphicon glyphicon-map-marker"></span></a> 
   </div>
   
     <div class="collapse navbar-collapse">
    <ul class="nav navbar-nav">
      <li class="li-border"><a class="mystyle-color" class="font-style">&nbsp;在线组队平台</a></li>
    </ul>
    
    <ul class="nav navbar-nav pull-right">
      <li class="dropdown li-border"><a class="font-style"   class="dropdown-toggle mystyle-color" data-toggle="dropdown">
        <span class="glyphicon glyphicon-user"></span> ${user.user_name}<span class="caret"></span></a>
        <ul class="dropdown-menu">
          <li><a href="javascript:checkUser();"><span class="glyphicon glyphicon-envelope"></span> 个人信息</a></li>
          <li class="divider"></li>
          <li><a href="javascript:updateUser();"><span class="glyphicon glyphicon-lock"></span> 修改密码</a></li>
          <li class="divider"></li>
          <li><a href="javascript:help();"><span class="glyphicon glyphicon-question-sign"></span> 帮助文档</a></li>
        </ul>
      </li>
      <li class="dropdown"><a href="javascript:exit();"><span class="glyphicon glyphicon-off"></span> 注销</a>
     </li>
    </ul>
    
     </div>
 </nav>
 
<div class="down-main">
    <c:if test="${user.user_role==2}">
  <div class="left-main left-full">
    <div class="sidebar-fold"><span class="glyphicon glyphicon-menu-hamburger"></span></div>
    <div class="subNavBox">
     <div class="sBox">
        <div class="subNav sublist-up"><span class="title-icon glyphicon glyphicon-chevron-up"></span><span class="sublist-title">我的</span></div>
        <ul class="navContent" style="display:none">
             <li>
            <div class="showtitle" style="width:100px;"><img src="<%=basePath%>static/img/leftimg.png" />智能推荐</div>
            <a href="<%=basePath%>user/Recommend" class="font-style" target="mainFrame"><span class="sublist-icon glyphicon glyphicon-cloud"></span><span class="sub-title">智能推荐</span></a></li>
             <li>
            <div class="showtitle" style="width:100px;"><img src="<%=basePath%>static/img/leftimg.png" />聊天</div>
            <a href="<%=basePath%>user/LiaoTian" class="font-style" target="mainFrame"><span class="sublist-icon glyphicon glyphicon-comment"></span><span class="sub-title">聊天</span></a></li>
             
               <li>
            <div class="showtitle" style="width:100px;"><img src="<%=basePath%>static/img/leftimg.png" />收藏</div>
            <a href="<%=basePath%>count/shoucuang" class="font-style" target="mainFrame"><span class="sublist-icon glyphicon glyphicon-folder-open"></span><span class="sub-title">收藏</span></a></li>
             
             <li>
            <div class="showtitle" style="width:100px;"><img src="<%=basePath%>static/img/leftimg.png" />用户反馈</div>
            <a href="<%=basePath%>user/feedback" class="font-style" target="mainFrame"><span class="sublist-icon glyphicon glyphicon-edit"></span><span class="sub-title">用户反馈</span></a></li>
        </ul>
      </div>
      <div class="sBox">
        <div class="subNav sublist-up"><span class="title-icon glyphicon glyphicon-chevron-up"></span><span class="sublist-title">系统需求发布</span></div>
        <ul class="navContent" style="display:none">
           <li>
            <div class="showtitle" style="width:100px;"><img src="<%=basePath%>static/img/leftimg.png" />添加一级目录</div>
            <a href="<%=basePath%>count/To_AddcategoryOne" class="font-style" target="mainFrame"><span class="sublist-icon glyphicon glyphicon-plus"></span><span class="sub-title">添加一级目录</span></a></li>
             <li>
            <div class="showtitle" style="width:100px;"><img src="<%=basePath%>static/img/leftimg.png" />添加二级目录</div>
            <a href="<%=basePath%>count/To_AddcategoryTow" class="font-style" target="mainFrame"><span class="sublist-icon glyphicon glyphicon-plus"></span><span class="sub-title">添加二级目录</span></a></li>
               <li>
              <div class="showtitle" style="width:100px;"><img src="<%=basePath%>static/img/leftimg.png" />添加需求</div>
              <a href="<%=basePath%>count/To_AddCountinformation" class="font-style" target="mainFrame"><span class="sublist-icon glyphicon glyphicon-plus"></span><span class="sub-title">添加需求</span></a></li>
        </ul>
      </div>
      <div class="sBox">
        <div class="subNav sublist-up"><span class="title-icon glyphicon glyphicon-chevron-up"></span><span class="sublist-title">智能推荐组队</span></div>
        <ul class="navContent" style="display:none">
          <li>
            <div class="showtitle" style="width:100px;"><img src="<%=basePath%>static/img/leftimg.png" />智能推荐</div>
            <a href="<%=basePath%>count/contentList" class="font-style" target="mainFrame"><span class="sublist-icon glyphicon glyphicon-wrench"></span><span class="sub-title">推荐管理</span></a></li>
        </ul>
      </div>
      <div class="sBox">
       <div class="subNav sublist-down"><span class="title-icon glyphicon glyphicon-chevron-down"></span><span class="sublist-title">位置</span></div>
        <ul class="navContent" style="display:block">
          <li>
            <div class="showtitle" style="width:100px;"><img src="<%=basePath%>static/img/leftimg.png" />定位功能</div>
            <a href="<%=basePath%>user/dingwei" class="font-style" target="mainFrame"><span class="sublist-icon glyphicon glyphicon-map-marker"></span><span class="sub-title">定位功能</span></a> </li>
        </ul>
      </div>
    </div>
  </div>
  <div class="right-product view-product right-full">
     <div class="container-fluid">
				
				<div class="message-manage info-center">
					<div class="page-header">
					  <ol class="breadcrumb">
						  <li><a href="<%=basePath%>user/right"  target="mainFrame" style="color:#0099cc;" ><span class="glyphicon glyphicon-home"></span> 首页</a></li>
						  <li><a style="color:#0099cc;">Library</a></li>
						  <li class="active">Data</li>
						  </ol>
                    </div>
				</div>
				<div class="clearfix"></div>
				<div class="show-page padding-big-right hidden">
					<div class="page"></div>
				</div>
   <!-- 文本中心 -->
		 
			 <div  style="height:650px;">
			   <iframe src="../admin/right.jsp" id="mainFrame" name="mainFrame" frameborder="0" width="100%"  height="100%" frameBorder="0"></iframe>
             </div>  
             <c:if test="${empty user}">	
			  <script type="text/javascript">
			   layer.alert('账号过期,请重新登录', {
				   skin: 'layui-layer-molv' //样式类名
				   ,closeBtn: 0
				   ,anim: 4
				 }, function(){
					 window.location.href="<%=basePath%>user/loginExit";
			   });
			  </script>
			</c:if>
		</div>
  </div>
  </c:if>
   <c:if test="${user.user_role==1}">  
    <div class="left-main left-full">
    <div class="sidebar-fold"><span class="glyphicon glyphicon-menu-hamburger"></span></div>
    <div class="subNavBox">
      <div class="sBox">
       <div class="subNav sublist-down"><span class="title-icon glyphicon glyphicon-chevron-down"></span><span class="sublist-title">用户信息中心</span></div>
        <ul class="navContent" style="display:block">
          <li>
            <div class="showtitle" style="width:100px;"><img src="<%=basePath%>static/img/leftimg.png" />信息列表</div>
            <a href="<%=basePath%>user/To_Userinformation" class="font-style" target="mainFrame"><span class="sublist-icon glyphicon glyphicon-th-list"></span><span class="sub-title">信息列表</span></a> </li>
            <li>
            <div class="showtitle" style="width:100px;"><img src="<%=basePath%>static/img/leftimg.png" />账号管理</div>
            <a href="<%=basePath%>user/userlist" class="font-style" target="mainFrame"><span class="sublist-icon glyphicon glyphicon-user"></span><span class="sub-title">账号管理</span></a> </li>
          <li>
            <div class="showtitle" style="width:100px;"><img src="<%=basePath%>static/img/leftimg.png" />添加账号</div>
            <a href="<%=basePath%>user/To_AddUserinformation" class="font-style" target="mainFrame"><span class="sublist-icon glyphicon glyphicon-plus"></span><span class="sub-title">添加账号</span></a> </li>
          <%--   <li>
            <div class="showtitle" style="width:100px;"><img src="<%=basePath%>static/img/leftimg.png" />用户反馈表</div>
            <a href="<%=basePath%>user/Userfeedlist" class="font-style" target="mainFrame"><span class="sublist-icon glyphicon glyphicon-edit"></span><span class="sub-title">用户反馈表</span></a> </li> --%>
        </ul>
      </div>
      <div class="sBox">
        <div class="subNav sublist-up"><span class="title-icon glyphicon glyphicon-chevron-up"></span><span class="sublist-title">系统需求管理</span></div>
        <ul class="navContent" style="display:none">
        <li>
            <div class="showtitle" style="width:100px;"><img src="<%=basePath%>static/img/leftimg.png" />一级目录管理</div>
            <a href="<%=basePath%>count/To_AddCountinOne" class="font-style" target="mainFrame"><span class="sublist-icon glyphicon glyphicon-th-list"></span><span class="sub-title">一级目录管理</span></a></li>
             <li>
            <div class="showtitle" style="width:100px;"><img src="<%=basePath%>static/img/leftimg.png" />二级目录管理</div>
            <a href="<%=basePath%>count/To_AddCountinTow" class="font-style" target="mainFrame"><span class="sublist-icon glyphicon glyphicon-th-list"></span><span class="sub-title">二级目录管理</span></a></li>
          <li>
            <div class="showtitle" style="width:100px;"><img src="<%=basePath%>static/img/leftimg.png" />添加需求</div>
            <a href="<%=basePath%>count/To_AddCountinformation" class="font-style" target="mainFrame"><span class="sublist-icon glyphicon glyphicon-plus"></span><span class="sub-title">添加需求</span></a></li>
        </ul>
      </div>
      <div class="sBox">
        <div class="subNav sublist-up"><span class="title-icon glyphicon glyphicon-chevron-up"></span><span class="sublist-title">智能推荐管理</span></div>
        <ul class="navContent" style="display:none">
          <li>
            <div class="showtitle" style="width:100px;"><img src="<%=basePath%>static/img/leftimg.png" />推荐管理</div>
            <a href="<%=basePath%>count/AdminContentList" class="font-style" target="mainFrame"><span class="sublist-icon glyphicon glyphicon-envelope"></span><span class="sub-title">推荐管理</span></a></li>
        </ul>
      </div>
      <div class="sBox">
        <div class="subNav sublist-up"><span class="title-icon glyphicon glyphicon-chevron-up"></span><span class="sublist-title">日志信息报告</span></div>
        <ul class="navContent" style="display:none">
          <li>
            <div class="showtitle" style="width:100px;"><img src="<%=basePath%>static/img/leftimg.png" />查看日志</div>
            <a href="<%=basePath%>user/loglist" class="font-style" target="mainFrame"><span class="sublist-icon glyphicon glyphicon-globe"></span><span class="sub-title">查看日志</span></a></li>
        </ul>
      </div>
    </div>
  </div>
<div class="right-product view-product right-full">
     <div class="container-fluid">
				
				<div class="message-manage info-center">
					<div class="page-header">
					  <ol class="breadcrumb">
						  <li><a href="<%=basePath%>user/right"  target="mainFrame" style="color:#0099cc;" ><span class="glyphicon glyphicon-home"></span> 首页</a></li>
						  <li><a style="color:#0099cc;">Library</a></li>
						  <li class="active">Data</li>
						  </ol>
                    </div>
				</div>
				<div class="clearfix"></div>
				<div class="show-page padding-big-right hidden">
					<div class="page"></div>
				</div>
   <!-- 文本中心 -->
		 
			 <div  style="height:650px;">
			   <iframe src="../admin/right.jsp" id="mainFrame" name="mainFrame" frameborder="0" width="100%"  height="100%" frameBorder="0"></iframe>
             </div>  
             <c:if test="${empty user}">	
			  <script type="text/javascript">
			   layer.alert('账号过期,请重新登录', {
				   skin: 'layui-layer-molv' //样式类名
				   ,closeBtn: 0
				   ,anim: 4
				 }, function(){
					 window.location.href="<%=basePath%>user/loginExit";
			   });
			  </script>
			</c:if>
		</div>
  </div>
    </c:if>
</div>




<!-- 个人信息模态框 -->
<div class="modal fade" id="checkUserModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document" style="padding-top:100px;">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h5 class="modal-title" id="myModalLabel"><span class="glyphicon glyphicon-folder-open"></span> 个人信息</h5>
      </div> 
      <div class="modal-body">
		 <form class="form-horizontal">
		  <div class="form-group">
		    <input type="hidden" id="user_id" name="user_id" class="form-control" >
		    <label for="inputEmail3" class="col-sm-2 control-label">登录账号</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control form-control-input" value="${user.user_name}" disabled>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="inputPassword3" class="col-sm-2 control-label">注册时间</label>
		    <div class="col-sm-10">
		      <input type="text" value="${user.user_time}" readonly="readonly" class="form-control" disabled>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="inputPassword3" class="col-sm-2 control-label">联系电话</label>
		    <div class="col-sm-10">
		      <input type="text" value="${user.user_call}" class="form-control" disabled>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="inputPassword3" class="col-sm-2 control-label">角色权限</label>
		    <div class="col-sm-10">
		    <c:if test="${user.user_role eq 1}">
		      <select class="form-control" disabled>
				  <option value="1">管理员</option>
			  </select>
			 </c:if>
			 <c:if test="${user.user_role eq 2}">
		      <select class="form-control" disabled>
				  <option value="2">普通用户</option>
			  </select>
			 </c:if>  
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="inputPassword3" class="col-sm-2 control-label">账号状态</label>
		    <div class="col-sm-10">
		      <c:if test="${user.user_state eq 1}">
		      <select class="form-control" disabled>
				  <option value="1">启用</option>
			  </select>
			 </c:if>
			 <c:if test="${user.user_state eq 0}">
		      <select class="form-control" disabled>
				  <option value="0">禁用</option>
			  </select>
			  </c:if>
		    </div>
		  </div>
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default btn-sm" data-dismiss="modal"><span class="glyphicon glyphicon-ban-circle"></span> 关闭信息</button>
      </div>
    </div>
  </div>
</div>

<!-- 帮助文档模态框 -->
 <div class="modal fade" id="helpModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document" style="padding-top:100px;">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h5 class="modal-title" id="myModalLabel"><span class="glyphicon glyphicon-folder-open"></span> 帮助文档</h5>
      </div> 
      <div class="modal-body">
		<h5>One、好好学习，天天向上 </h5><br/>
		<h5>Tow、此系统有在线聊天功能、推荐功能、需求发布、定位功能等....... </h5><br/>
		<h5>Three、需求发布时，可根据类目一、二来发布</h5>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default btn-sm" data-dismiss="modal"><span class="glyphicon glyphicon-ban-circle"></span> 关闭信息</button>
      </div>
    </div>
  </div>
</div>

<!-- 修改密码模态框 -->
<div class="modal fade" id="updateUserModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document" style="padding-top:100px;">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h5 class="modal-title" id="myModalLabel"><span class="glyphicon glyphicon-folder-open"></span> 修改密码</h5>
      </div> 
      <div class="modal-body">
		 <form class="form-horizontal">
		 <div class="form-group">
		    <input type="hidden" id="user_id4" name="user_id4" class="form-control" >
		    <label for="inputEmail3" class="col-sm-2 control-label">登录账号</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control form-control-input" name="user_name"  id="user_name" value="${user.user_name}" disabled>
		    </div>
		  </div>
		  <div class="form-group">
		    <input type="hidden" id="user_id5" name="user_id5" class="form-control" >
		    <label for="inputEmail3" class="col-sm-2 control-label">新密码</label>
		    <div class="col-sm-10">
		      <input type="password" class="form-control form-control-input" id="newuser_pwd5" name="newuser_pwd5" placeholder="新密码">
		    </div>
		  </div>
		  <div class="form-group">
		    <input type="hidden" id="user_id6" name="user_id6" class="form-control" >
		    <label for="inputEmail3" class="col-sm-2 control-label">确认密码</label>
		    <div class="col-sm-10">
		      <input type="password" class="form-control form-control-input" id="okuser_pwd6" name="okuser_pwd6" placeholder="确认密码">
		    </div>
		  </div>
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default btn-sm" data-dismiss="modal"><span class="glyphicon glyphicon-ban-circle"></span> 关闭信息</button>
        <button type="button" onclick="updateUserPassword();" class="btn btn-info btn-sm"><span class="glyphicon glyphicon-ok-sign"></span> 保存修改</button>
      </div>
    </div>
  </div>
</div>

<script src="<%=basePath%>static/js/nav.js" type="text/javascript"></script>

<script type="text/javascript">
   
   function exit(){
	   layer.confirm('您确定要退出系统吗？',{
		 btn:['确定','取消']  
	   }, function(){
		   window.location.href="<%=basePath%>user/loginExit";
	   }, function(){
	      return;   
	      } );
   }
   function checkUser(){
	   $('#checkUserModal').modal("show");
   }
   function help(){
	   $('#helpModal').modal("show");
   }
   function updateUser(){
	   $('#updateUserModal').modal("show");
   }
   function updateUserPassword(){
	   var user_name = $("#user_name").val();
	   var newuser_pwd = $("#newuser_pwd5").val();
	   var okuser_pwd = $("#okuser_pwd6").val();
	   
	   if(newuser_pwd == ""){
		  layer.alert('新密码不能为空', {
			   skin: 'layui-layer-molv'
			   ,closeBtn: 2
			   ,anim: 1
			 });
		return;
	   }
	   if(newuser_pwd.length <6 || okuser_pwd.length < 6){
		   layer.alert('密码不少于6位', {
			   skin: 'layui-layer-molv'
			   ,closeBtn: 2
			   ,anim: 1
			 });
		return;
	   }
	   if(okuser_pwd ==""){
		   layer.alert('确定密码不能为空', {
			   skin: 'layui-layer-molv'
			   ,closeBtn: 2
			   ,anim: 1
			 });
		return;
		  
	   }
	   
	   if(okuser_pwd != newuser_pwd){
		   layer.alert('两次密码输入不一致', {
			   skin: 'layui-layer-molv'
			   ,closeBtn: 2
			   ,anim: 1
			 });
		return;
	   }
	   var data={
		   user_name : user_name,
		   newuser_pwd : newuser_pwd
	   }
	   $.ajax({
		   type:"post",
		   url:"<%=basePath%>user/getpassword",
		   data:data,
		   cache: false,
		   async: false,
		   success:function(data){
			   var result = $.parseJSON(data);
			   if(result.data == '1'){
				   alert("修改成功！");
				   return ;
			   }
			   if(result.data =='-1'){
				   alert("修改失败！");
				   return ;
			   }
		   }
	   });
	   
   }

</script>
</body>
</html>