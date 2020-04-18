<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>     
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>百度编译器使用</title>
<link rel="stylesheet" href="<%=basePath%>static/bootstrap-3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=basePath%>static/css/count.css">

<script src="<%=basePath%>static/jquery-3.1.1/jquery-3.1.1.min.js"></script>
<script src="<%=basePath%>static/bootstrap-3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript" charset="utf-8" src="<%=basePath%>static/ueditor/ueditor.config.js"></script> <!--ueditor的配置文件-->
<script type="text/javascript" charset="utf-8" src="<%=basePath%>static/ueditor/ueditor.all.min.js"></script> <!--ueditor核心文件-->
<script type="text/javascript" charset="utf-8" src="<%=basePath%>static/ueditor/lang/zh-cn/zh-cn.js"></script> <!--ueditor语言文件-->

<script src="<%=basePath%>resources/layui/layui.js"></script>
<script src="<%=basePath%>resources/layui/lay/modules/layer.js"></script>
</head>
<body>
<div class="panel panel-info">
 <div class="panel-heading"><span class="glyphicon glyphicon-plus"></span> 新增需求信息</div>
  <div style="padding-top:10px;"></div>
  <form class="form-horizontal">
   <div class="form-group">
	<label class="col-sm-2 control-label">二级名称</label>
		<div class="col-sm-8">
		  <select class="selectpicker form-control" data-live-search="true" name="addid2" id="addid2">
			</select>
		</div>
	</div>
  <div class="form-group">
    <label class="col-sm-2 control-label">作者</label>
    <div class="col-sm-9">
      <input type="text" class="form-control from-input" id="author" name="author" value="${user.user_name}" disabled="disabled">
    </div>
  </div>
  <div class="form-group">
    <label class="col-sm-2 control-label">标题</label>
    <div class="col-sm-9">
      <input type="text" class="form-control from-input" id="title" name="title" placeholder="请输入标题信息">
    </div>
  </div>
   <div class="form-group">
    <label class="col-sm-2 control-label">时间</label>
    <div class="col-sm-9">
      <input type="text" class="form-control from-input" id="count_time" name="count_time" placeholder="请录入发布时间">
    </div>
  </div>
   <div class="form-group">
    <label class="col-sm-2 control-label">状态</label>
    <div class="col-sm-9">
        <select class="form-control from-input" id="need_select" name="need_select">
	           <option value="">请选择需求状态</option>
	           <option value="激活">激活</option>
	           <option value="禁用">禁用</option>
	    </select>
    </div>
  </div>
  <div class="form-group">
    <label class="col-sm-2 control-label">内容</label>
    <div class="col-sm-6">
      <script id="editor" type="text/plain" style="width:860px;height:200px;"></script>
    </div>
  </div>
  <div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
      <button type="button" onclick="saveCount();" class="btn btn-info"><span class="glyphicon glyphicon-th"></span> 保存系统信息</button>
    </div>
  </div>
  </form>
</div> 

<script type="text/javascript">
layui.use('laydate', function(){
	  var laydate = layui.laydate;
	  laydate.render({
	    elem: '#count_time' //layui时间控件使用
	    	,theme: 'molv' 
	  });
	});
	
    $.ajax({ 
	   type:"POST",
	   url: "<%=basePath%>user/gettowcategoryList",
	   success : function(data) { 
	   var opts = "";
	   for( var i = 0 ; i < data.length; i++ ){
	   var depart = data[i];
//	   console.log(depart);
	   opts += "<option value='"+depart.category2_id+"'>"+depart.category2_name+"</option>";
	 }
	 // 查询界面
	 $("#addid2").append(opts); 
	 //$("#addid").selectpicker("refresh");
	  } 
	 }); 
</script>
<script type="text/javascript">
    window.UEDITOR_HOME_URL = "${pageContext.request.contextPath}/static/ueditor/";
</script> 
  <script type="text/javascript">
      var ue = UE.getEditor('editor');
  </script>
  <script type="text/javascript">
    function saveCount(){
    	var obj = document.getElementById('addid2');
 	   console.log(obj);
 	   var category2_id = obj.value;
    	var title = $("#title").val();
    	var author = $("#author").val();
    	var count_time = $("#count_time").val();
    	var need_select = $("#need_select").val();
    	ue = UE.getEditor('editor');
        var content = UE.getEditor('editor').getContentTxt();
    	if(title==""){
    		alert('标题不能为空');
    		$("#title").focus();
    		return;
    	}
    	if(content==""){
    		alert("内容不能为空");
    		return;
    	}
    	if(count_time==""){
    		alert("时间不能为空");
    		return ;
    	}
        if(author==""){
        	alert("作者不能为空");
    	}
        if(need_select==""){
        	alert("状态不能为空");
    		return ;
        }
    	var url = "<%=basePath%>count/saveCountInfo";
    	var data = {
    			category2_id:category2_id,
    			title:title,
    			content:content,
    			author:author,
    			count_time:count_time,
    			need_select:need_select
    	};
    	$.post(url,data,function(data){
    		if(data=="1"){
    			alert("添加成功");
    			window.location.href="<%=basePath%>count/contentList";
    		}else{
    			alert("添加失败");
    		}
    	})
    }
  </script>
</body>
</html>