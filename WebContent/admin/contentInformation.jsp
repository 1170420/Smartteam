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
<title>系统需求</title>

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
<script type="text/javascript" charset="utf-8" src="<%=basePath%>static/ueditor/ueditor.config.js"></script> <!--ueditor的配置文件-->
<script type="text/javascript" charset="utf-8" src="<%=basePath%>static/ueditor/ueditor.all.min.js"></script> <!--ueditor核心文件-->
<script type="text/javascript" charset="utf-8" src="<%=basePath%>static/ueditor/lang/zh-cn/zh-cn.js"></script> <!--ueditor语言文件-->
</head>
<body>
<!-- 获取到的数据表 -->
<div><table id="ContentInforTable" class="table table-hover"></table></div>

<!-- 工具栏 toolbar-->
<div id="toolbar" >
   
    <button id="content_update" type="button" class="btn btn-success" style="width: 200px;">
        <span class="glyphicon glyphicon-pencil"></span>&nbsp;&nbsp;修改需求信息
    </button>
     <button id="content_delete" type="button" class="btn btn-danger" style="width: 200px;">
        <span class="glyphicon glyphicon-trash"></span>&nbsp;&nbsp;删除需求信息
    </button>
</div>
<div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" id="myModal">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">修改需求信息</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                
				  <div class="form-group">
				    <label class="col-sm-2 control-label">作者</label>
				    <div class="col-sm-9">
				      <input type="text" class="form-control from-input" id="modal_author"   disabled="disabled">
				    </div>
				  </div>
				    <div class="form-group">
				    <label class="col-sm-2 control-label">标题</label>
				    <div class="col-sm-9">
				      <input type="text" class="form-control from-input" id="modal_title"   disabled="disabled">
				    </div>
				  </div>
				   <div class="form-group">
				    <label class="col-sm-2 control-label">时间</label>
				    <div class="col-sm-9">
				      <input type="text" class="form-control from-input" id="modal_time">
				    </div>
				  </div>
				  
				   <div class="form-group">
				    <label class="col-sm-2 control-label">状态</label>
				    <div class="col-sm-9">
				        <select class="form-control from-input" id="modal_click" name="modal_click">
					           <option value="">请选择需求状态</option>
					           <option value="激活">激活</option>
					           <option value="禁用">禁用</option>
					    </select>
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <label class="col-sm-2 control-label">内容</label>
				    <div class="col-sm-9" >
				      <script  type="text/plain"  id="modal_content" name ="modal_content" style="width:650px;height:300px;"></script>
				    </div>
				  </div>
				  
				  </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="sava-edit-btn">保存</button>
            </div>
        </div>
    </div>
</div>

<script src="<%=basePath%>resources/layui/layui.js"></script>
<script src="<%=basePath%>resources/layui/lay/modules/layer.js"></script>
<script type="text/javascript">
layui.use('laydate', function(){
  var laydate = layui.laydate;
  laydate.render({
    elem: '#modal_time' //layui时间控件使用
    	,theme: 'molv' 
    	,type:'datetime'
  });
});
</script>
<script type="text/javascript">
    window.UEDITOR_HOME_URL = "${pageContext.request.contextPath}/static/ueditor/";
</script> 
<script type="text/javascript">
 $(function(){
	      var author =  "${user.user_name}";
	 $('#ContentInforTable').bootstrapTable({
		url:'<%=basePath%>count/secleteAuthor?author='+author,
		method : 'get',            // 请求方式
		toolbar : '#toolbar',      // 工具按钮用哪个容器
		striped : false,           // 是否显示行间隔色
		cache : false,             // 是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性
	    sortable : true,           //用 是否启排序
		sidePagination : "client", // 分页方式：client客户端分页，server服务端分页（*）
		pagination : true,         // 是否显示分页
		pageNumber: 1,             //如果设置了分页，首页页码
		pageSize: 5,              //每页的记录行数
	    pageList: [10,20,30],      //可供选择的每页的行数
		showRefresh : false,        // 是否显示刷新按钮
		clickToSelect : true,      // 是否启用点击选中行
		singleSelect : false,        // 单选checkbox 
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
  //修改
  $("#content_update").click(function(){
	  
	  var info = $("#ContentInforTable").bootstrapTable('getSelections');
      if(info.length==0){
    	  layer.alert('请选择修改的记录数据', {
       		 icon: 5,
       		 title: "提示"
       	 });
         return;
          
      }else{
    	/*  alert(info[0].id);  */
          $("#modal_id").val(info[0].id)
          $("#modal_author").val(info[0].author)
          $("#modal_title").val(info[0].title)
          $("#modal_time").val(info[0].time)
          $("#modal_click").val(info[0].click)
          $("#modal_content").val(info[0].content)
          
          $("#myModal").modal();
      }


 var ue = UE.getEditor('modal_content'); //初始化对象
 $(document).ready(function(){
	 
 	var ue = UE.getEditor('modal_content');
 	var proinfo=  $("#modal_content").val(info[0].content);
 	console.log(proinfo);
 	ue.ready(function() {//编辑器初始化完成再赋值
 		ue.setContent(proinfo);  //赋值给UEditor
 	});
 		
 });
 
});
 
  //关闭模态框数据保存到table
 $("#sava-edit-btn").click(function () {
     $('#myModal').modal('hide');
     var info = $("#ContentInforTable").bootstrapTable('getSelections');
     var id = info[0].id;
     var modal_author = $("#modal_author").val();
     var modal_title = $("#modal_title").val();
     var modal_time = $("#modal_time").val();
     var modal_click = $("#modal_click").val();
    // var modal_content = $("#modal_content").val();
     ue = UE.getEditor('modal_content');
     var modal_content = UE.getEditor('modal_content').getContentTxt();
     console.log(modal_content);
   
	    var url = "<%=basePath%>count/updataContents";
	 	var data = {
	 			id:id,
	 			title:modal_title,
	 			content:modal_content,
	 			author:modal_author,
	 			count_time:modal_time,
	 			click:modal_click
	 	};
	 	$.post(url,data,function(data){
	 		if(data=="1"){
	 			layer.msg('修改成功', {icon: 1,});
	 			$('#ContentInforTable').bootstrapTable('refresh');
	 		}else{
	 			layer.msg('修改失败', {icon: 2,});
    			$('#ContentInforTable').bootstrapTable('refresh');
	 		}
	 	})
    	 
 }) 
 
 //批量删除
 $("#content_delete").click(function(){
	var rows = $("#ContentInforTable").bootstrapTable('getSelections');
    if (rows.length == 0) {
    	layer.alert('请选择删除的记录数据', {
      		 icon: 5,
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
			url:"<%=basePath%>count/deleteContents?ids=" + ids,
			type:"POST",
			success:function(data){
			if(data==1){
				layer.msg('删除成功', {icon: 1,});
    			$('#ContentInforTable').bootstrapTable('refresh');
			}else{
				layer.msg('删除失败', {icon: 2,});
    			$('#ContentInforTable').bootstrapTable('refresh');
			}
			}
		});
       }
    }
});
</script>
</body>
</html>