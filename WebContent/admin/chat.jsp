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
<title>Insert title here</title>
<script src="<%=basePath%>resources/js/jquery-2.1.1.min.js"></script>
<script src="<%=basePath%>resources/js/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath%>resources/css/qq.css">
   <script type="text/javascript">
       var username='${user.user_name}'; 
   
       var ws; //一个ws对象就是一个管道！！！
       var target="ws://localhost:8080/Smartteam/chatSocket?username="+username;
       
       window.onload = function(){
        	//进入聊天页面，就打开soket通道
        	
           
            	  if ('WebSocket' in window) {
                      ws = new WebSocket(target);
                  } else if ('MozWebSocket' in window) {
                      ws = new MozWebSocket(target);
                  } else {
                      alert('WebSocket is not supported by this browser.');
                      return;
                  }
            	  
            	  ws.onmessage= function(event){
            		 
            		  eval("var msg="+event.data+";");
            		  
            		  console.log(msg);
            		  if(undefined!=msg.welcome)
            			$("#content").append(msg.welcome+"<br/>");
            		  
            		  
            		  if(undefined!=msg.username){
            			  
            			  //清空
            			  $("#userList").html("");
            			  $(msg.username).each(function(){
            				 
            				  $("#userList").append("<input type='checkbox' value='"+this+"'>"+this+"<br/>")
            			  });
            		  }
            		  
            		//服务端 发送到客户端的内容
        	    	  if(undefined!=msg.content){
        	    		  $("#content").append(msg.content)
        	    	  }
            		  
            		  
            	  }

        }
       //发送方法
       function subSend(){
    	   
    	   var ss = $("#userList :checked");
    	   //拿到选中的用户
    	   console.info(ss.val());
    	   console.info(ss.size());
    	   
    	   var msg = $("#msg").val();
    	   var obj = null;
       	   if(ss.size()==0){
       		    obj={
       				msg:msg,
       				type:1 //1 广播 2 单聊
       		        }
       	      }else{
       		var chatToWho = $("#userList :checked").val();
       		obj={
       				chatToWho:chatToWho,
       				msg:msg,
       				type:2  //1 广播 2 单聊
       		}
       	} 
        
       	//将js对象转成json串
       	var str = JSON.stringify(obj);
       	    
       	  console.log(str);
         
       	    ws.send(str);
       	    
         	$("#msg").val(""); 
         	
         	
         	
       } 
      
        
       //退出 
       function exit(){
    	   location.href="<%=request.getContextPath()%>/admin/right.jsp";
       }
       
       $('.ExP').on('mouseenter',function(){
   		$('.emjon').show();
   	})
   	$('.emjon').on('mouseleave',function(){
   		$('.emjon').hide();
   	})
   	$('.emjon li').on('click',function(){
   		var imgSrc=$(this).children('img').attr('src');
   		var str="";
   		str+='<li>'+
   				'<div class="nesHead"><img src="img/6.jpg"/></div>'+
   				'<div class="news"><img class="jiao" src="<%=basePath%>resources/img/20170926103645_03_02.jpg"><img class="Expr" src="'+imgSrc+'"></div>'+
   			'</li>';
   		$('.newsList').append(str);
   		$('.emjon').hide();
   		$('.RightCont').scrollTop($('.RightCont')[0].scrollHeight );
   	})
   	
   	
        
   </script>
   

</head>
 <!-- <body>
   <div   id="container"  style="border:1px solid black; width:400px; height:400px; Float:left">
       <div id="content" style="height:350px; ">
       
       </div>
       <div style="border-top:1px solid black; width:400px; height:100px;">
           <input id="msg"/><button type="button" onclick="subSend()">发送</button>
           <button  type="button" onclick="exit()">退出</button>
       </div>
   </div>
   <div id="userList" style="border:1px solid black; width:100px; height:400px;Float:left ">

   </div>
</body> -->

 <body style="background-image:url(../resources/img/009.jpg);">

<div class="qqBox" style="background:; no-repeat">
	<div class="BoxHead">
		<div class="headImg">
			<img src="<%=basePath%>resources/img/bo.jpg">
		</div>
		<div class="internetName">在线聊天室</div>
	</div>
	<div class="context" >
		<div  class="conLeft" id="userList" >
			
		</div>
		<div class="conRight">
			<div class="Righthead">
				<div class="headName"></div>
				<div class="headConfig">
					<ul>
						<li><img src="<%=basePath%>resources/img/20170926103645_06.jpg"></li>
						<li><img src="<%=basePath%>resources/img/20170926103645_08.jpg"></li>
						<li><img src="<%=basePath%>resources/img/20170926103645_10.jpg"></li>
						<li><img src="<%=basePath%>resources/img/20170926103645_12.jpg"></li>
					</ul>
				</div>
			</div>
			<div class="RightCont" id="content" style="background-image:url(../resources/img/003.jpg);">
				<ul class="newsList">
				
				</ul>
			</div>
			<div class="RightFoot">
				<div class="emjon">
					<ul>
						<li><img src="<%=basePath%>resources/img/em_02.jpg"></li>
						<li><img src="<%=basePath%>resources/img/em_05.jpg"></li>
						<li><img src="<%=basePath%>resources/img/em_07.jpg"></li>
						<li><img src="<%=basePath%>resources/img/em_12.jpg"></li>
						<li><img src="<%=basePath%>resources/img/em_14.jpg"></li>
						<li><img src="<%=basePath%>resources/img/em_16.jpg"></li>
						<li><img src="<%=basePath%>resources/img/em_20.jpg"></li>
						<li><img src="<%=basePath%>resources/img/em_23.jpg"></li>
						<li><img src="<%=basePath%>resources/img/em_25.jpg"></li>
						<li><img src="<%=basePath%>resources/img/em_30.jpg"></li>
						<li><img src="<%=basePath%>resources/img/em_31.jpg"></li>
						<li><img src="<%=basePath%>resources/img/em_33.jpg"></li>
						<li><img src="<%=basePath%>resources/img/em_37.jpg"></li>
						<li><img src="<%=basePath%>resources/img/em_38.jpg"></li>
						<li><img src="<%=basePath%>resources/img/em_40.jpg"></li>
						<li><img src="<%=basePath%>resources/img/em_45.jpg"></li>
						<li><img src="<%=basePath%>resources/img/em_47.jpg"></li>
						<li><img src="<%=basePath%>resources/img/em_48.jpg"></li>
						<li><img src="<%=basePath%>resources/img/em_52.jpg"></li>
						<li><img src="<%=basePath%>resources/img/em_54.jpg"></li>
						<li><img src="<%=basePath%>resources/img/em_55.jpg"></li>
					</ul>
				</div>
				<div class="footTop">
					<ul>
						<li><img src="<%=basePath%>resources/img/20170926103645_31.jpg"></li>
						<li class="ExP"><img src="<%=basePath%>resources/img/20170926103645_33.jpg"></li>
						<li><img src="<%=basePath%>resources/img/20170926103645_35.jpg"></li>
						<li><img src="<%=basePath%>resources/img/20170926103645_37.jpg"></li>
						<li><img src="<%=basePath%>resources/img/20170926103645_39.jpg"></li>
						<li><img src="<%=basePath%>resources/img/20170926103645_41.jpg" alt=""></li>
						<li><img src="<%=basePath%>resources/img/20170926103645_43.jpg"></li>
						<li><img src="<%=basePath%>resources/img/20170926103645_45.jpg"></li>
					</ul>
				</div>
				<div class="inputBox">
					 <textarea id="msg" style="width: 99%;height: 75px; border: none;outline: none; background-image:url(../resources/img/001.jpeg); "></textarea>
					<button class="sendBtn" onclick="subSend()">发送</button> 
					<!-- <input id="msg"/><button type="button" onclick="subSend()">发送</button>
                    <button  type="button" onclick="exit()">退出</button> -->
					<button class="sendBtn1" type="button" onclick="exit()">退出</button>
				</div>
			</div>
		</div>
	</div>
</div>



</body>
</html>