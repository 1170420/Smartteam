$(function(){ 
	//短信验证码倒计时
	var countdownHandler = function(){
		var $button = $(".sendVerifyCode");
		var number = 60;
		var countdown = function(){
			if (number == 0) {
				$button.attr("disabled",false);
				$button.html("发送验证码");
	            number = 60;
	            return;
	        } else {
	        	$button.attr("disabled",true);
	        	$button.html(number + "秒 重新发送");
	        	number--;
	        }
			setTimeout(countdown,1000);
		}
		setTimeout(countdown,1000);
	}
	//发送短信验证码
	$(".sendVerifyCode").on("click", function(){
		var $mobile = $("input[name=mobile]");
		var data = {};
		data.mobile = $.trim($mobile.val());
		if(data.mobile == ''){
			alert('请输入手机号码');
			return;
		}
		var reg = /^1\d{10}$/;
		if(!reg.test(data.mobile)){
			alert('请输入合法的手机号码');
			return ;
		}
		$.ajax({
	        url: getBasePath()+"/sendSms",
	        async : true,
	        type: "post",
	        dataType: "text",
	        data: data,
	        success: function (data) {
	        	if(data == 'success'){
	        		countdownHandler();
	        		return ;
	        	}
	        	alert(data);
	        }
    	});
	})
	//提交
	$(".sub-btn").on("click", function(){
		var data = {};
		data.userId = $.trim($("input[name=userId]").val());
		data.password = $.trim($("input[name=password]").val());
		data.mobile = $.trim($("input[name=mobile]").val());
		data.verifyCode = $.trim($("input[name=verifyCode]").val());
		if(data.userId == ''){
			alert("请输入账号");
			return ;
		}
		if(data.password == ''){
			alert("请输入密码");
			return ;
		}
		if(data.mobile == ''){
			alert("请输入手机号");
			return ;
		}
		if(data.verifyCode == ''){
			alert("请输入验证码");
			return ;
		}
		$.ajax({
	        url: getBasePath()+"/register",
	        async : true,
	        type: "post",
	        dataType: "text",
	        data: data,
	        success: function (data) {
	        	if(data == 'success'){
	        		alert("注册成功");
	        		return ;
	        	}
	        	alert(data);
	        }
    	});
	})
});
