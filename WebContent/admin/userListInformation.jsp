<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>    
<!-- index账号管理 -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户列表</title>

<link type="text/css" rel="stylesheet" href="<%=basePath%>static/bootstrap-3.3.7/css/bootstrap.min.css" />
<link type="text/css" rel="stylesheet" href="<%=basePath%>static/bootstrap-3.3.7/css/bootstrap-table.css" />
<link rel="stylesheet" href="<%=basePath%>resources/layui/css/modules/layer/default/layer.css">
<link rel="stylesheet" href="<%=basePath%>resources/layui/css/layui.css">
<link type="text/css" rel="stylesheet" href="<%=basePath%>static/bootstrap-3.3.7/css/mytable.css" />

<script type="text/javascript" src="<%=basePath%>static/jquery-3.1.1/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="<%=basePath%>static/bootstrap-3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=basePath%>static/bootstrap-3.3.7/js/bootstrap-table.js"></script>
<script type="text/javascript" src="<%=basePath%>resources/plugins/bootstrap-table-1.11.0/locale/bootstrap-table-zh-CN.js"></script>
<script src="<%=basePath%>resources/layui/lay/modules/layer.js"></script>
</head>
<body>
<!-- 获取到的数据表 -->
<div><table id="UserInfoTable" class="table table-condensed"></table></div>

<!-- 工具栏 toolbar-->
<div id="toolbar" >
    <button onclick="addUserInfo();" type="button" class="btn btn-info">
        <span class="glyphicon glyphicon-plus"></span> 新增管理员信息
    </button>&nbsp;
    <button id="btn_delete" type="button" class="btn btn-warning">
        <span class="glyphicon glyphicon-trash"></span> 删除管理员信息
    </button>
</div>

<!-- 新增用户信息 -->
<div class="modal fade" id="addUserModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document" style="width:550px;">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h5 class="modal-title" id="myModalLabel"><span class="glyphicon glyphicon-folder-open"></span> 新增用户信息</h5>
      </div> 
      <div class="modal-body">
		 <form class="form-horizontal">
		  <div class="form-group">
		    <input type="hidden" id="user_id" name="user_id" class="form-control" >
		    <label for="inputEmail3" class="col-sm-2 control-label">登录账号</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control form-control-input" id="adduser_name" name="adduser_name" class="form-control" placeholder="请输入信息">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="inputPassword3" class="col-sm-2 control-label">注册时间</label>
		    <div class="col-sm-10">
		      <input type="text" id="adduser_time" name="adduser_time" class="form-control" placeholder="请输入信息">
		    </div>
		  </div>
		  <div class="form-group">
		    <input type="hidden" id="user_id" name="user_id" class="form-control" >
		    <label for="inputEmail3" class="col-sm-2 control-label">登录密码</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control form-control-input" id="adduser_pwd" name="adduser_pwd" class="form-control" placeholder="请输入信息">
		    </div>
		  </div>	  
		  <div class="form-group">
		    <label for="inputPassword3" class="col-sm-2 control-label">联系电话</label>
		    <div class="col-sm-10">
		      <input type="text" id="adduser_call" name="adduser_call" class="form-control" placeholder="请输入信息">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="inputPassword3" class="col-sm-2 control-label">角色权限</label>
		    <div class="col-sm-10">
		      <select class="form-control" id="adduser_role" name="adduser_role" >
		          <option value="">==请选择==</option>
				  <option value="1">管理员</option>
				  <option value="2">普通用户</option>
			  </select>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="inputPassword3" class="col-sm-2 control-label">账号状态</label>
		    <div class="col-sm-10">
		      <select class="form-control" id="adduser_state" name="adduser_state" >
				  <option value="">==请选择==</option>
				  <option value="1">启用</option>
				  <option value="0">禁用</option>
			  </select>
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
<div class="modal fade" id="checkModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document" style="width:550px;">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h5 class="modal-title" id="myModalLabel"><span class="glyphicon glyphicon-folder-open"></span> 更新信息</h5>
      </div> 
      <div class="modal-body">
		 <form class="form-horizontal">
		  <div class="form-group">
		    <input type="hidden" id="user_id" name="user_id" class="form-control" >
		    <label for="inputEmail3" class="col-sm-2 control-label">登录账号</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control form-control-input" id="user_name" name="user_name" class="form-control" disabled>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="inputPassword3" class="col-sm-2 control-label">注册时间</label>
		    <div class="col-sm-10">
		      <input type="text" id="user_time" name="user_time" class="form-control form-control-input" disabled>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="inputPassword3" class="col-sm-2 control-label">联系电话</label>
		    <div class="col-sm-10">
		      <input type="text" id="user_call" name="findtcall" class="form-control" >
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="inputPassword3" class="col-sm-2 control-label">角色权限</label>
		    <div class="col-sm-10">
		      <select class="form-control" id="user_role" name="user_role" >
				  <option value="1">管理员</option>
				  <option value="2">普通用户</option>
			  </select>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="inputPassword3" class="col-sm-2 control-label">账号状态</label>
		    <div class="col-sm-10">
		      <select class="form-control" id="user_state" name="user_state" >
				  <option value="1">启用</option>
				  <option value="0">禁用</option>
			  </select>
		    </div>
		  </div>
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default btn-sm" data-dismiss="modal"><span class="glyphicon glyphicon-ban-circle"></span> 关闭信息</button>
        <button type="button" onclick="updateUserInfo();" class="btn btn-info btn-sm"><span class="glyphicon glyphicon-ok-sign"></span> 保存修改</button>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript">

$(function(){
	$('#UserInfoTable').bootstrapTable({
		url : '<%=basePath%>user/getUserList',		
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
		columns : [{               //页面需要展示的列，后端交互对象的属性          
		     checkbox: true
	    },{                                                                           
			field : 'id',          // 返回json数据中的name
			title : '编号',           // 表格表头显示文字
			align : 'center',      // 左右居中
			valign : 'middle',     // 上下居中
			sortable : true
		},{
			field : 'user_name',
			title : '账号',
			align: 'center',
            valign: 'middle',
		},{
			field : 'user_call',
			title : '电话',
			align: 'center',
            valign: 'middle',
		},{
			field : 'user_time',
			title : '注册时间',
			align: 'center',
            valign: 'middle',
		},{
			field : 'user_role',
			title : '用户权限',
			align: 'center',
            valign: 'middle',
            formatter : roleFormatter,
		},{
			field : 'user_state',
			title : '状态',
			align: 'center',
            valign: 'middle',
            formatter : stateFormatter,
		},{
			title : '操作',
			align : 'center',
			formatter : function(value, row, index) {
				var id = value;
	            var result = "";
	            result += "<a href='javascript:;' class='btn btn-info btn-xs' onclick=\"ViewById('" + row.id + "')\" title='修改'>修改 <span class='glyphicon glyphicon-pencil'></span></a>";
	            result +="<a href='javascript:;' class='btn btn-warning btn-xs btn-margin1' onclick=\"DeleteById('" + row.id + "')\" title='删除'>删除 <span class='glyphicon glyphicon-remove'></span></a>";
	            return result;
			},
		}],
		
	 });
  })

    //角色字段格式化
	function roleFormatter(value) {
	    if (value == "1") { 
	    	value = "管理员"; 
	    }
	    else if (value == "2") { 
	    	value = "普通用户";
	    }
	    return '<div>' + value + '</div>';
	}
    //状态字段格式化
	function stateFormatter(value) {
	    if (value == "1") { 
	    	value = "激活";
	    	color = '#31B0D5'; 
	    }
	    else if (value == "0") { 
	    	value = "禁用";
	    	color = '#EC971F';
	    }
	    return '<div  style="color: ' + color + '">' + value + '</div>';
	}
   
	//更新信息
	function ViewById(){
		var row=$.map($("#UserInfoTable").bootstrapTable('getSelections'),function(row){
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
            $('#checkModal').modal();
            $('#user_id').val(row[i].id);
            $('#user_name').val(row[i].user_name);
            $('#user_call').val(row[i].user_call);
            $('#user_time').val(row[i].user_time);
            $('#user_role').val(row[i].user_role);
            $('#user_state').val(row[i].user_state);
        }
	   }
	}
    
	function updateUserInfo(){
		var user_name = $("#user_name").val();
		var user_id = $("#user_id").val();
		var user_call =$("#user_call").val();
		var user_time =$("#user_time").val();
		var user_role =$("#user_role").val();
		var user_state =$("#user_state").val();
		
		if(user_call==""){
			layer.alert('不能为空')
			   return;
		   }
		   if(!(/^1(3|4|5|7|8)\d{9}$/.test(user_call))){
			   layer.alert('手机格式错误');
	   		   return;
	   	   }
		   if(user_time==""){
			   layer.alert('不能为空')
			   return;
		   }
		   if(user_role==""){
			   layer.alert('不能为空')
			   return;
		   }
		   if(user_state==""){
			   layer.alert('不能为空')
			   return;
		   }
		   layer.load(1);     //加载层
		   var url="<%=basePath%>user/updateUserInfo";
		   var data={
			   user_id:user_id,
			   user_name:user_name,
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
			   layer.alert('修改成功', {
				   skin: 'layui-layer-molv' //样式类名
				   ,closeBtn: 1
				   ,icon:1
				   ,anim: 1
				 }, function(){
					window.location.href="<%=basePath%>user/userlist";
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
	
	function addUserInfo(){
		$('#addUserModal').modal();
	}
	
	//删除
	$("#btn_delete").click(function(){
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
			url:"<%=basePath%>user/deleteUser",
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
   }
</script>

<script src="<%=basePath%>resources/layui/layui.js"></script>
<script>
layui.use('laydate', function(){
  var laydate = layui.laydate;
  laydate.render({
    elem: '#adduser_time' //layui时间控件使用
    	,theme: 'molv' 
  });
});
</script> 

<script type="text/javascript">
   function saveUserInfo(){
	   var user_name = $("#adduser_name").val();
	   var user_pwd =  $("#adduser_pwd").val();
	   var user_call = $("#adduser_call").val();
	   var user_time = $("#adduser_time").val();
	   var user_role = $("#adduser_role").val();
	   var user_state = $("#adduser_state").val();
	   if(user_name==""){
		   layer.tips('账号不能为空', '#adduser_name', {
				tips: [3, '#f0ad4e']
				});
			   $("#adduser_name").focus();
		   return false;
	   }
	   if(user_pwd==""){
		   layer.tips('不能为空', '#adduser_pwd', {
				tips: [3, '#f0ad4e']
				});
			   $("#adduser_pwd").focus();
		   return false;
	   }
	   if(user_call==""){
		   layer.tips('不能为空', '#adduser_call', {
				tips: [3, '#f0ad4e']
				});
			   $("#adduser_call").focus();
		   return false;
	   }
	   if(!(/^1(3|4|5|7|8)\d{9}$/.test(user_call))){
		   layer.tips('格式错误', '#adduser_call', {
				tips: [3, '#f0ad4e']
				});
			   $("#adduser_call").focus();
		   return false;
   	   }
	   if(user_time==""){
		   layer.tips('不能为空', '#adduser_time', {
				tips: [3, '#f0ad4e']
				});
		   return false;
	   }
	   if(user_role==""){
		   layer.tips('不能为空', '#adduser_role', {
				tips: [3, '#f0ad4e']
				});
		   return false;
	   }
	   if(user_state==""){
		   layer.tips('不能为空', '#adduser_state', {
				tips: [3, '#f0ad4e']
				});
		   return false;
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
					window.location.href="<%=basePath%>user/userlist";
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