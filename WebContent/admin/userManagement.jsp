<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
    <link href="<%=basePath%>resources/plugins/bootstrap-3.3.0/css/bootstrap.min.css" rel="stylesheet"/>
	<link href="<%=basePath%>resources/plugins/bootstrap-table-1.11.0/bootstrap-table.min.css" rel="stylesheet"/>
	<link rel="stylesheet" href="<%=basePath%>static/bootstrap-3.3.7/css/common.css">
	
	<script src="<%=basePath%>resources/plugins/jquery.1.12.4.min.js"></script>
    <script src="<%=basePath%>resources/plugins/bootstrap-3.3.0/js/bootstrap.min.js"></script>
    <script src="<%=basePath%>resources/plugins/bootstrap-table-1.11.0/bootstrap-table.min.js"></script>
    <script src="<%=basePath%>resources/plugins/bootstrap-table-1.11.0/locale/bootstrap-table-zh-CN.js"></script>
    
</head>
<body style="padding-top:10px;">
   
 <div class="panel panel-success">
  <!-- Default panel contents -->
  <div class="panel-heading"><span class="glyphicon glyphicon-th-list"></span> 管理员列表  </div>
	<!-- 显示表格数据 -->   
    <table class="table table-hover table-stripe table-bordered table-condensed">
         <tr class="info">
            <th style="text-align: center;">#</th>
            <th style="text-align: center;">账号</th>
            <th style="text-align: center;">创建时间</th>
            <th style="text-align: center;">电话</th>
            <th style="text-align: center;">身份权限</th>
            <th style="text-align: center;">状态</th>
            <th style="text-align: center;">操作</th>
         </tr>
         
      <c:forEach items="${PageInfo.list}" var="us">
         <tr>
            <th class="tbody-th">${us.id }</th>
            <th class="tbody-th">${us.user_name }</th>
            <th class="tbody-th">${us.user_time }</th>
            <th class="tbody-th">${us.user_call }</th>
            <c:if test="${us.user_role eq 1 }">
                <th class="tbody-th">管理员</th>
            </c:if>
            <c:if test="${us.user_role eq 2 }">
                <th class="tbody-th">普通用户</th>
            </c:if>
            <c:if test="${us.user_state eq 1 }">
                <th class="tbody-th">
                  <a onclick="javascript:   (${us.id});">启用</a>                              
                </th>
            </c:if>
            <c:if test="${us.user_state eq 0 }">
                <th class="tbody-th">
                   <a style="color:red;" onclick="javascript:stopuser(${us.id});">禁用</a>                       
                </th>
            </c:if>
            <th class="tbody-th">
               <a class="btn btn-info btn-xs" href="<%=basePath%>user/selectUserById?id=${us.id}">编辑
               <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
               </a>
               <a class="btn btn-warning btn-xs" onclick="javascript:deleteuser(${us.id});">删除
               <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
               </a>
            </th>
         </tr>
       </c:forEach>
     </table>
    </div> 
   <!-- 分页 -->	   
   <div style="text-align: right;">
    <nav aria-label="Page navigation">
	  <ul class="pagination pagination-sm">
	    <li><a href="${pageContext.request.contextPath }/user/To_Userinformation?pn=1">首页</a></li>
	    
	    <c:if test="${PageInfo.hasPreviousPage }">
	       <li>
	         <a href="${pageContext.request.contextPath }/user/To_Userinformation?pn=${PageInfo.pageNum-1}" aria-label="Previous">
	         <span aria-hidden="true">&laquo;</span>
	         </a>
	       </li>
	    </c:if>
	    
	    <c:forEach items="${PageInfo.navigatepageNums }" var="page_Num">
	       <c:if test="${page_Num==PageInfo.pageNum}">
	          <li class="active"><a href="#">${page_Num }</a></li>
	       </c:if>
	       <c:if  test="${page_Num!=PageInfo.pageNum}">
	          <li><a href="${pageContext.request.contextPath }/user/To_Userinformation?pn=${page_Num }">${page_Num }</a></li>
	       </c:if>
	    </c:forEach>
	    
	    <c:if test="${PageInfo.hasNextPage }">
	      <li>
	        <a href="${pageContext.request.contextPath }/user/To_Userinformation?pn=${PageInfo.pageNum+1 }" aria-label="Next">
	          <span aria-hidden="true">&raquo;</span>
	        </a>
	       </li>
	    </c:if>
	    
	     <li><a href="${pageContext.request.contextPath }/user/To_Userinformation?pn=${PageInfo.pages }">末页</a></li>
	  </ul>
	</nav>
   </div>
 
<script type="text/javascript">
    function deleteuser(id){
    	if(window.confirm("数据删除不可恢复，你确定要删除吗")){
    		var url="<%=basePath%>user/deleteUser";
    		var data={id : id};
    		$.post(url,data,function(data){
    			var result=$.parseJSON(data);
    			if(result.data=="1"){
    				alert("删除成功！");
    				location.reload();
    			}else{
    				alert("操作失败！");
    			}
    		})
    	}
    }
    //禁用用户
    function startuser(id){
    	if(window.confirm("您确定禁用此用户吗？")){
      		var   url="<%=basePath%>user/stopUser";
            var   data={id : id,};
            $.post(url,data,function(data){
             if(data=="0"){
             	alert("操作异常，请稍后再试！");
             }
             else if(data=="1"){
             	alert("操作成功！");
             	location.reload();
             }
           });
      	 }
      }
    //启动用户
    function stopuser(id){
    	if(window.confirm("您确定启用此用户吗？")){
   		 var   url="<%=basePath%>user/startUser";
         var   data={id : id,};
         $.post(url,data,function(data){
          if(data=="0"){
          	alert("操作异常，请稍后再试！");
          }
          else if(data=="1"){
          	alert("操作成功！");
          	location.reload();
          }
         });
   	   }
    }
</script>
</body>
</html>