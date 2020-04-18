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
<div><table id="ContentInforTable" class="table table-hover"></table></div>

<div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" id="updateUser">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">查看需求信息</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                
                
				  <div class="form-group">
				    <label class="col-sm-2 control-label">作者</label>
				    <div class="col-sm-9">
				      <input type="text" class="form-control from-input" id=modal_author   disabled="disabled">
				    </div>
				  </div>
				  
				   <div class="form-group">
				    <label class="col-sm-2 control-label">爱好</label>
				    <div class="col-sm-9">
				      <input type="text" class="form-control from-input" id="user_hobby" disabled="disabled">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <label class="col-sm-2 control-label">特长</label>
				    <div class="col-sm-9">
				      <input type="text" class="form-control from-input" id="user_specialty" disabled="disabled">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <label class="col-sm-2 control-label">标题</label>
				    <div class="col-sm-9">
				      <input type="text" class="form-control from-input" id="modal_title" disabled="disabled">
				    </div>
				  </div>
				  
				   <div class="form-group">
				    <label class="col-sm-2 control-label">时间</label>
				    <div class="col-sm-9">
				      <input type="text" class="form-control from-input" id="modal_time" disabled="disabled">
				    </div>
				  </div>
				  
				   <div class="form-group">
				    <label class="col-sm-2 control-label">状态</label>
				    <div class="col-sm-9">
				         <input type="text" class="form-control from-input" id="modal_click" disabled="disabled">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <label class="col-sm-2 control-label">内容</label>
				    <div class="col-sm-9" >
				      <textarea id="modal_content" name ="modal_content" style="width:650px;height:300px;"></textarea>
				    </div>
				  </div>
				  
				  </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
   buttonName = "收藏";
 $(function(){
	 $('#ContentInforTable').bootstrapTable({
		url:'<%=basePath%>count/getContentList',
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
		singleSelect : true,       //单选checkbox
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

		},{
			field : 'title',
			title : '标题',
			align: 'center',
            valign: 'middle',
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
		},{
			field : 'content',
			title : '内容',
			align: 'center',
            valign: 'middle',
		},
		{
			title: '操作',
			align: 'center',
			width:200,
			formatter : function(value, row, index) {
				var id = value;
	            var result = "";
	            result += "<a href='javascript:;' class='btn btn-info btn-xs' onclick=\"findUser('" + row.id + "')\" title='查看'>查看 <span class='glyphicon glyphicon-pencil'></span></a>";
	            result +="<a href='javascript:;' class='btn btn-warning btn-xs btn-margin1' onclick=\"shoucuangUser('" + row.id + "')\" title='收藏'>收藏 <span class='glyphicon glyphicon-th-list'></span></a>";
	            return result;
			},
         }],
		
    	onCheck:function(row,$element){
			var id = row.id; //id每一行的唯一标识，一般为主键列
			var user_id = "${user.id}";
	    	$.ajax({
				url:"<%=basePath%>count/getContentDetail",
				data:{'id':id,'user_id':user_id},
				success:function(data){
				//console.log(data);
				}
			});
    	},
    	
	 });
  })
  
 function findUser(id){
	 
	//点击量
	 <%-- onCheck:function(row,$element){
				var id = row.id; //id每一行的唯一标识，一般为主键列
		    	$.ajax({
					url:"<%=basePath%>count/insertClick?id=" + id,
					type:"POST",
					success:function(data){
					//console.log(data);
					}
				});
	    	}, --%>
	    	
	 
	 //这段代码就是点击就选中的 getRowByUniqueId 这是固定写法
	 var rowData = $("#ContentInforTable").bootstrapTable('getRowByUniqueId', id);
	 console.log("名字=="+rowData.author);
	 var author = rowData.author;
	 $('#updateUser').modal("show");
	 $.ajax({
			url:"<%=basePath%>count/findUserhobby",
			type:"POST",
			data:{"author":author},
			success:function(data){
				//console.log("返回结果"+data);
			  //console.log("第一个=="+data.hobby+"第二个=="+data.specialty);
			  //下面这个要选中那个  才能取到ID 意思是按钮 没在数据列表当中 在他去工具模块当中 也就是 最上面 比如批量删除那种  
				 $("#modal_author").val(rowData.author)
			     $("#modal_title").val(rowData.title)
			     $("#modal_time").val(rowData.time)
			     $("#user_hobby").val(data.hobby)
			     $("#user_specialty").val(data.specialty)
			     $("#modal_click").val(rowData.click)
			     $("#modal_content").val(rowData.content)
			}
		});
	 
	
 }
 function shoucuangUser(id){
	 var author =  "${user.user_name}";
	 var rowData = $("#ContentInforTable").bootstrapTable('getRowByUniqueId', id);
	 var author = author;
	 var id = rowData.id;
	 $.ajax({
			url:"<%=basePath%>count/shoucuanguser",
			type:"POST",
			async : false,
			data:{"id":id,"author":author},
			success:function(data){
			var result=$.parseJSON(data);
				if(result.data=="1")
				{
					
				layer.alert('收藏成功');
			//	document.getElementById("butId").style.backgroundColor = "gray";
				}else{
				layer.alert('取消收藏');
			//	document.getElementById("butId").style.backgroundColor = "bule";
			}
			}
		});
 }
 
 
/* function operateFormatter1(value,row,index) {//赋予的参数 
	 
	 var result = "" ;
	    result +="<button id='butId' class='btn btn-info btn-xs btn-ss' onclick=\"shoucuangUser('" + row.id + "')\" title='收藏'><span class='glyphicon glyphicon-pencil'></span> "+buttonName+"</button>";
	    return result;
 } */
 
 
 
</script>


</body>
</html>