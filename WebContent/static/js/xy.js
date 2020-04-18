	function checkradioandcheckbox(bdname)
       		{
			flag = false;
			var lists = document.getElementsByName(bdname);

			for (var i = 0; i < lists.length; i++) {
				if (lists[i].checked) {
				flag = true;
				break;
				}
			}
			return flag;
       		}

			function isEmail(str){ 
				var reg = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/; 
				return reg.test(str); 
			//正则表达式的使用
			} 

			function isage(str){ 
				var reg = /^[1-9]\d*$/;

				return reg.test(str); 
			//正则表达式的使用，满足某些规则的字符的通配符
			} 
      function ispho(str){
      	var reg = /^[1-9]\d*$/;

				return reg.test(str); 
			} 
			function clear()
			{
				document.getElementById("tips").innerHTML="";
			}
       		function chk()
       		{

       			if(regform.xm.value==""){
       				document.getElementById("tips").innerHTML="姓名不能为空";
       				alert("姓名不能为空");
       				regform.xm.focus();
       				//表单元素的引用方法1:
       				//表单名.具体元素名.属性名=属性取值；
       				//表单名.具体元素名.方法名()；
       				return false;
       			}
       			if(!checkradioandcheckbox("xb"))
       			{
       				document.getElementById("tips").innerHTML="请选择性别";
       				alert("请选择性别");
       				return false;
       			}

        		if(document.getElementById("age").value==""){
        			document.getElementById("tips").innerHTML="年龄不能为空";
       				alert("年龄不能为空");
       				document.getElementById("age").focus();
       				return false;
       			}
       			if(!isage(document.getElementById("age").value)){
       				document.getElementById("tips").innerHTML="年龄不正确";
       				alert("年龄不正确");
       				document.getElementById("age").focus();
       				return false;
       			}
            if(document.getElementById("pho").value=="")
            {
            	document.getElementById("tips").innerHTML="电话不能为空";
            	alert("电话不能为空");
            	document.getElementById("pho").focus();
            	return false;
            }
            if(!ispho(document.getElementById("pho").value)){
            	document.getElementById("pho").innerHTML="电话不正确";
            	alert("电话不正确");
            	document.getElementById("pho").focus();
            	return false;
            }
       			if(document.getElementById("email").value==""){
       				document.getElementById("tips").innerHTML="邮箱不能为空";
       				alert("邮箱不能为空");
       				document.getElementById("email").focus();
       				return false;
       			}
       			if(document.getElementById("dizhi").value==""){
       				document.getElementById("tips").innerHTML="联系地址不能为空";
       				alert("联系地址不能为空");
       				document.getElementById("dizhi").focus();
       				return false;
       			}

       			if(!isEmail(document.getElementById("email").value)){
       				document.getElementById("tips").innerHTML="邮箱格式不正确";
       				alert("邮箱格式不正确");
       				document.getElementById("email").focus();
       				return false;
       			}


       			if(document.getElementById("introduce").value==""){
       				document.getElementById("tips").innerHTML="网站建议不能为空";
       				alert("网站建议不能为空");
       				document.getElementById("introduce").focus();
       				return false;
       			}
       		}