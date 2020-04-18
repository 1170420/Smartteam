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
<title>用户类目二</title>

<link type="text/css" rel="stylesheet" href="<%=basePath%>static/bootstrap-3.3.7/css/bootstrap.min.css" />
<link type="text/css" rel="stylesheet" href="<%=basePath%>static/bootstrap-3.3.7/css/bootstrap-table.css" />
<link rel="stylesheet" href="<%=basePath%>resources/layui/css/modules/layer/default/layer.css">
<link rel="stylesheet" href="<%=basePath%>resources/layui/css/layui.css">
<link type="text/css" rel="stylesheet" href="<%=basePath%>static/bootstrap-3.3.7/css/mytable.css" />

<script type="text/javascript" src="<%=basePath%>static/jquery-3.1.1/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="<%=basePath%>static/bootstrap-3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=basePath%>static/bootstrap-3.3.7/js/bootstrap-table.js"></script>

<script type="text/javascript" src="<%=basePath%>resources/plugins/select2/css/select2.css"></script>
<script type="text/javascript" src="<%=basePath%>resources/plugins/select2/js/select2.js"></script>

<script type="text/javascript" src="<%=basePath%>resources/plugins/bootstrap-table-1.11.0/locale/bootstrap-table-zh-CN.js"></script>
<script src="<%=basePath%>resources/layui/lay/modules/layer.js"></script>
</head>
<body>
<!-- 获取到的数据表 -->
<div><table id="UserInfoTable" class="table table-hover"></table></div>

<!-- 工具栏 toolbar-->
<div id="toolbar" >
    <button onclick="addUserInfo();" type="button" class="btn btn-warning">
        <span class="glyphicon glyphicon-plus"></span> 新增二级类目信息
    </button>&nbsp;
   <!--  <button id="btn_delete" type="button" class="btn btn-warning">
        <span class="glyphicon glyphicon-trash"></span> 删除二级类目信息
    </button> -->
</div>

<!-- 新增用户信息 -->
<div class="modal fade" id="addUserModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document" style="width:550px;">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h5 class="modal-title" id="myModalLabel"><span class="glyphicon glyphicon-folder-open"></span> 新增二级类目信息</h5>
      </div> 
      <div class="modal-body">
		 <form class="form-horizontal">
		 <div class="form-group">
		  <label for="inputEmail3" class="col-sm-2 control-label">一级名称</label>
			 <div class="col-sm-10">
			 <select class="selectpicker form-control" data-live-search="true" name="addid" id="addid">
			 </select>
			 </div>
		</div>

		  <div class="form-group">
		    <input type="hidden" id="one_id" name="one_id" class="form-control" >
		    <label for="inputEmail3" class="col-sm-2 control-label">二类名称</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control form-control-input" id="addcategory2_name" name="addcategory2_name" class="form-control" placeholder="请输入信息">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="inputPassword3" class="col-sm-2 control-label">添加时间</label>
		    <div class="col-sm-10">
		      <input type="text" id="addcategory2_time" name="addcategory2_time" class="form-control" placeholder="请输入信息">
		    </div>
		  </div>
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default btn-sm" data-dismiss="modal"><span class="glyphicon glyphicon-ban-circle"></span> 关闭信息</button>
        <button type="button" onclick="saveUserInfo();" class="btn btn-info btn-sm"><span class="glyphicon glyphicon-ok-sign"></span> 保存信息</button>
      </div>
    </div>
  </div>
</div>

<!-- 更新用户信息 -->
<div class="modal fade" id="checkModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document" style="width:550px;">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h5 class="modal-title" id="myModalLabel"><span class="glyphicon glyphicon-folder-open"></span> 更新信息</h5>
      </div> 
      <div class="modal-body">
		 <form class="form-horizontal">
		  <div class="form-group">
		    <input type="hidden" id="tow_id" name="tow_id" class="form-control" >
		    <label for="inputEmail3" class="col-sm-2 control-label">类目名称</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control form-control-input" id="category2_name" name="category2_name" class="form-control">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="inputPassword3" class="col-sm-2 control-label">添加时间</label>
		    <div class="col-sm-10">
		      <input type="text" id="category2_time" name="category2_time" class="form-control form-control-input" >
		    </div>
		  </div>
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default btn-sm" data-dismiss="modal"><span class="glyphicon glyphicon-ban-circle"></span> 关闭信息</button>
      <!--   <button type="button" onclick="updateUserInfo();" class="btn btn-info btn-sm"><span class="glyphicon glyphicon-ok-sign"></span> 保存修改</button> -->
      </div>
    </div>
  </div>
</div>

<script type="text/javascript">

$(function(){
	$('#UserInfoTable').bootstrapTable({
		url : '<%=basePath%>user/gettowcategoryList',		
		method : 'get',            // 请求方式
		toolbar : '#toolbar',      // 工具按钮用哪个容器
		striped : false,           // 是否显示行间隔色
		cache : false,             // 是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性
	    sortable : true,           //用 是否启排序
		sidePagination : "client", // 分页方式：client客户端分页，server服务端分页（*）
		pagination : true,         // 是否显示分页
		pageNumber: 1,             //如果设置了分页，首页页码
		pageSize: 10,              //每页的记录行数
	    pageList: [10,20,30],      //可供选择的每页的行数
		showRefresh : false,        // 是否显示刷新按钮
		clickToSelect : true,      // 是否启用点击选中行
	    uniqueId : "id",           // 每一行的唯一标识，一般为主键列
		search:true,               //是否启用搜索框
		silent : true,             // 刷新事件必须设置
		theadClasses: "thead-dark",//这里设置表头样式
		columns : [{               //页面需要展示的列，后端交互对象的属性          
		     checkbox: true
	    },{                                                                           
			field : 'category2_id',          // 返回json数据中的name
			title : '编号',           // 表格表头显示文字
			align : 'center',      // 左右居中
			valign : 'middle',     // 上下居中
			sortable : true
		},{
			field : 'category2_name',
			title : '二级类目名称',
			align: 'center',
            valign: 'middle',
		},{
			field : 'category1_id',
			title : '一级类目id',
			align: 'center',
            valign: 'middle',
		},{
			field : 'category2_time',
			title : '添加时间',
			align: 'center',
            valign: 'middle',
			
		},{
			title : '操作',
			align : 'center',
			formatter : function(value, row, index) {
				var id = value;
				console.log(row.category2_id);
	            var result = "";
	            result += "<a href='javascript:;' class='btn btn-warning btn-xs' onclick=\"ViewById('" + row.id + "')\" title='查看'>查看 <span class='glyphicon glyphicon-pencil'></span></a>";
	          /*   result +="<a href='javascript:;' class='btn btn-warning btn-xs btn-margin1' onclick=\"DeleteById('" + row.category2_id + "')\" title='删除'>删除 <span class='glyphicon glyphicon-remove'></span></a>"; */
	            return result;
			},
		}],
		
		 //点击findProductListByCategory2Id  用户访问二级类目，添加用户历史访问记录
		 onCheck:function(row,$element){
			  var user_id = "${user.id}";
			  var category2_id = row.category2_id;
			  console.log(user_id);
			  console.log(category2_id);
				 $.ajax({
					 url:"<%=basePath%>count/findProductListByCategory2Id",
					 data:{'category2_id':category2_id,'user_id':user_id},
					 success : function(data){
				     console.log(data);  
				     }   
				}); 
	    	}, 
		  	
	 });
  })

 
        
  
	//更新信息
	function ViewById(){
		var row=$.map($("#UserInfoTable").bootstrapTable('getSelections'),function(row){
			console.log(row);
            return row;
        });
		if(row.length==0){
			layer.alert('请选择一条记录数据', {
       		 icon: 6,
       		 title: "提示"
       	 });
		}
		if(row.length>1){
			layer.msg('抱歉！只能选择一条记录数据', function(){
         		//关闭后的操作
         	});
		}
	    if(row.length==1){
	    	  for (var i = 0; i < row.length; i++) {
	              $('#checkModal2').modal();
	              $('#tow_id').val(row[i].category2_id);
	              $('#category2_name').val(row[i].category2_name);
	              $('#category2_time').val(row[i].category2_time);
	          }
	   }
	}
    
<%-- 	function updateUserInfo(){
	
		
		var category2_id = $("#tow_id").val();
		console.log(category2_id);
		var category2_name = $("#category2_name").val();
		console.log(category2_name);
		var category2_time =$("#category2_time").val();
		console.log(category2_time);
		
		if(category2_name==""){
			layer.alert('名称不能为空')
			   return;
		   }
		  
		   if(category2_time==""){
			   layer.alert('时间不能为空')
			   return;
		   } 
		   layer.load(1);     //加载层
		   var url="<%=basePath%>user/updateTowcategoryInfo";
		   var data={
				   category2_id:category2_id,
				  category2_name:category2_name,
				  category2_time:category2_time
		   };
		   $.post(url,data,function(data){
		   var result = $.parseJSON(data);
		   if(result.data=="1"){
			   setTimeout(function(){
				   layer.closeAll('loading');
			   }, 500);
			   layer.alert('修改成功', {
				   skin: 'layui-layer-molv' //样式类名
				   ,closeBtn: 1
				   ,icon:1
				   ,anim: 1
				 }, function(){
					 window.location.href="<%=basePath%>count/To_AddcategoryTow";
			   });
		   }
		   else if(result.data=="2"){
			   setTimeout(function(){
				   layer.closeAll('loading');
			   }, 500);
			   layer.alert('操作失败', {icon: 2}); 
		   }
		})
	}
	 --%>
	function addUserInfo(){
		 $('#addUserModal').modal();
		
		 $.ajax({ 
			   type:"POST",
			   url: "<%=basePath%>user/getonecategoryList",
			   success : function(data) { 
			
			/*  console.log(data.length);
			 console.log(data[0].category1_name);
			 console.log(data[1].category_id) */
			 var opts = "";
			 for( var i = 0 ; i < data.length; i++ ){
			 var depart = data[i];
			 opts += "<option value='"+depart.category_id+"'>"+depart.category1_name+"</option>";
			 }
			 // 查询界面
			 $("#addid").append(opts); 
			 //$("#addid").selectpicker("refresh");
			  } 
			 }); 
		
	}
	
	//删除
	<%-- $("#btn_delete").click(function(){
		 var row=$.map($("#UserInfoTable").bootstrapTable('getSelections'),function(row){
             return row ;
         });
         var ids=[];              //获取自定义table 的中的checkbox值
         for (var i = 0; i < row.length; i++) {
             var id=row[i].id;   //这个是你要在列表中取的单个id
             ids.push(id);        //然后把单个id循环放到ids的数组中
         }
         if (ids.length==0) {
        	 layer.alert('请选择一条要删除的记录数据', {
        		 icon: 6,
        		 title: "提示"
        	 });
         }
         if (row.length>1) {
         	layer.msg('抱歉！只能选择一条记录数据', function(){
         		//关闭后的操作
         	});
         } 
         if (ids.length==1) {
			var ids = id;
			var url="<%=basePath%>user/deleteUser";
    		var data={id : id};
    		$.post(url,data,function(data){
   			var result=$.parseJSON(data);
   			if(result.data=="1"){
   				layer.msg('删除成功', {icon: 1,});
				$('#UserInfoTable').bootstrapTable('refresh');
   			}else{
   				layer.msg('删除失败', {icon: 2,});
				$('#UserInfoTable').bootstrapTable('refresh');
   			}
    	  });
	    }
	});
   
	//删除信息
	function DeleteById(id){
        if (window.confirm("数据删除不可恢复,确认删除吗？")) {
           $.ajax({
			url:"<%=basePath%>user/deleteTowcate",
			data:{id:id},
			type:"POST",
			success:function(data){
			var result=$.parseJSON(data);
			if(result.data==1){
				layer.msg('删除成功', {icon: 1,});
				$('#UserInfoTable').bootstrapTable('refresh');
			}
			else{
				layer.msg('删除失败', {icon: 2,});
				$('#UserInfoTable').bootstrapTable('refresh');
			}
			}
		});
      }
   } --%>
</script>

<script src="<%=basePath%>resources/layui/layui.js"></script>
<script>
layui.use('laydate', function(){
  var laydate = layui.laydate;
  laydate.render({
    elem: '#addcategory2_time' //layui时间控件使用
    	,theme: 'molv' 
  });
});

layui.use('laydate', function(){
	  var laydate = layui.laydate;
	  laydate.render({
	    elem: '#category2_time' //layui时间控件使用
	    	,theme: 'molv' 
	  });
	});

</script> 

<script type="text/javascript">
   function saveUserInfo(){
	   var obj = document.getElementById('addid');
	   console.log(obj.value);
	   var category1_id = obj.value;
	   var category2_name = $("#addcategory2_name").val();
	   var category2_time = $("#addcategory2_time").val();
	   if(category2_name==""){
		   layer.tips('名称不能为空', '#addcategory2_name', {
				tips: [3, '#f0ad4e']
				});
			   $("#addcategory2_name").focus();
		   return false;
	   }
	 
	   if(category2_time==""){
		   layer.tips('时间不能为空', '#addcategory2_time', {
				tips: [3, '#f0ad4e']
				});
		   return false;
	   }
	   layer.load(1);     //加载层
	   var url="<%=basePath%>user/saveTowcategoryInfo";
	   var data={
		   category1_id : category1_id,
		   category2_name:category2_name,
		   category2_time:category2_time
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
					window.location.href="<%=basePath%>count/To_AddcategoryTow";
			   });
		   }
		   else if(result.data=="2"){
			   setTimeout(function(){
				   layer.closeAll('loading');
			   }, 500);
			   layer.alert('操作失败', {icon: 2}); 
		   }
	   })
   }
</script>
</body>
</html>