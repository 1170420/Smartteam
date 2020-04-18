<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>智能推荐</title>

<link type="text/css" rel="stylesheet" href="<%=basePath%>static/bootstrap-3.3.7/css/bootstrap.min.css" />
<link type="text/css" rel="stylesheet" href="<%=basePath%>static/bootstrap-3.3.7/css/bootstrap-table.css" />
<link type="text/css" rel="stylesheet" href="<%=basePath%>static/bootstrap-3.3.7/css/mytable.css" />
<link rel="stylesheet" href="<%=basePath%>resources/layui/css/modules/layer/default/layer.css">
<link rel="stylesheet" href="<%=basePath%>resources/layui/css/layui.css">

<script type="text/javascript" src="<%=basePath%>static/jquery-3.1.1/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="<%=basePath%>static/bootstrap-3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=basePath%>static/bootstrap-3.3.7/js/bootstrap-table.js"></script>
<script type="text/javascript" src="<%=basePath%>resources/plugins/bootstrap-table-1.11.0/locale/bootstrap-table-zh-CN.js"></script>
<script src="<%=basePath%>resources/layui/lay/modules/layer.js"></script>

</head>


<script type="text/javascript">
//计算相似度
$.ajax({
	url:"<%=basePath%>count/calculateSimilarity",
	success:function(data){
	//console.log(data);
	}
});

</script>
<body>
<!-- 获取到的数据表 -->
<div><table id="ContentInforTable" class="table table-hover"></table></div>

<script type="text/javascript">
 $(function(){

	      var user_id =  "${user.id}";
	      console.log(user_id);
	 $('#ContentInforTable').bootstrapTable({
		 //进入智能推荐
		url:'<%=basePath%>count/getindex?user_id='+user_id,   
		dataType : 'json',
		method : 'get',            // 请求方式
		toolbar : '#toolbar',      // 工具按钮用哪个容器
		striped : false,           // 是否显示行间隔色
		cache : false,             // 是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性
	    sortable : true,           //用 是否启排序
		sidePagination : "client", // 分页方式：client客户端分页，server服务端分页（*）
		pagination : true,         // 是否显示分页
		pageNumber: 1,             //如果设置了分页，首页页码
		pageSize: 5,               //每页的记录行数
	    pageList: [10,20,30],      //可供选择的每页的行数
		showRefresh : false,       // 是否显示刷新按钮
		clickToSelect : true,      // 是否启用点击选中行
		singleSelect : true,       // 单选checkbox 
	    uniqueId : "id",           // 每一行的唯一标识，一般为主键列
		search:true,               //是否启用搜索框
		silent : true,             // 刷新事件必须设置
		columns : [{               //页面需要展示的列，后端交互对象的属性          
		     checkbox: true
	    },{                                                                           
			field : 'id', 
			title : '编号', 
			align : 'center', 
			valign : 'middle',
			sortable : true
		},{
			field : 'author',
			title : '作者',
			align: 'center',
            valign: 'middle',
            sortable : true
		},{
			field : 'title',
			title : '标题',
			align: 'center',
            valign: 'middle',
            sortable : true
		},{
			field : 'time',
			title : '时间',
			align: 'center',
	        valign: 'middle',
	        sortable : true
		},{
			field : 'click',
			title : '状态',
			align: 'center',
	        valign: 'middle',
	        sortable : true
		},{
			field : 'content',
			title : '内容',
			align: 'center',
            valign: 'middle',
		}],
	
	 });
  }) 
 
</script>


<%-- <script type="text/javascript">
var user_id = "${user.id}";
console.log(user_id);
$.ajax({
	url:"<%=basePath%>count/getindex",
	data:{'user_id':user_id},
	success:function(data){
	//console.log(data);
	}
});
</script> --%>
</body>
</html>