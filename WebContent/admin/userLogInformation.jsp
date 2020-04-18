<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>日志信息</title>
   
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
<body>
<!-- 获取到的数据表 -->
<div><table id="LogInforTable" class="table table-condensed"></table></div>

<!-- 工具栏 toolbar-->
<div id="toolbar" >
    <button id="userlog_delete" type="button" class="btn btn-info" style="width: 900px;">
        <span class="glyphicon glyphicon-folder-open"></span>&nbsp;&nbsp;删除系统日志信息
    </button>
</div>

<script type="text/javascript">
$(function(){
	$('#LogInforTable').bootstrapTable({
		url : '<%=basePath%>user/getLogList',		
		method : 'get',            // 请求方式
		toolbar : '#toolbar',      // 工具按钮用哪个容器
		striped : false,           // 是否显示行间隔色
		cache : false,             // 是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性
	    sortable : true,           //用 是否启排序
		sidePagination : "client", // 分页方式：client客户端分页，server服务端分页（*）
		pagination : true,         // 是否显示分页
		pageNumber: 1,             //如果设置了分页，首页页码
		pageSize: 10,              //每页的记录行数
	    //pageList: [15,20,30],      //可供选择的每页的行数
		showRefresh : false,        // 是否显示刷新按钮
		clickToSelect : true,      // 是否启用点击选中行
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
			field : 'sysname',
			title : '账号',
			align: 'center',
            valign: 'middle',
            sortable : true
		},{
			field : 'sysip',
			title : 'IP',
			align: 'center',
            valign: 'middle',
            sortable : true
		},{
			field : 'sysport',
			title : '端口号',
			align: 'center',
            valign: 'middle',
            sortable : true
		},{
			field : 'sysusername',
			title : '用户名',
			align: 'center',
            valign: 'middle',
            sortable : true
		},{
			field : 'syshost',
			title : '主机名',
			align: 'center',
            valign: 'middle',
            sortable : true
		},{
			field : 'sysfunction',
			title : '执行函数',
			align: 'center',
            valign: 'middle',
            sortable : true
		},{
			field : 'sysdata',
			title : '时长',
			align: 'center',
            valign: 'middle',
            sortable : true
		},{
			field : 'systime',
			title : '登录时间',
			align: 'center',
            valign: 'middle',
            sortable : true
		}],
	 });
  })
  
 //批量删除
$("#userlog_delete").click(function(){
	var rows = $("#LogInforTable").bootstrapTable('getSelections');
    if (rows.length == 0) {
    	layer.alert('请选择删除的记录数据', {
      		 icon: 6,
      		 title: "提示"
      	 });
        return;
    } 
    else {
    	var ids = [];              // 声明一个数组
        $(rows).each(function () { // 通过获得别选中的来进行遍历
        	ids.push(this.id);     //id为获得到的整条数据中的一列
        });
        if (ids.length > 0){
        console.log(ids);	
       	$.ajax({
			url:"<%=basePath%>user/deleteLogs?ids=" + ids,
			type:"POST",
			success:function(data){
			if(data==1){
				layer.msg('删除成功', {icon: 1,});
    			$('#LogInforTable').bootstrapTable('refresh');
			}else{
				layer.msg('删除失败', {icon: 2,});
    			$('#LogInforTable').bootstrapTable('refresh');
			}
			}
		});
       }
    }
});
  
</script>
</body>

</html>

