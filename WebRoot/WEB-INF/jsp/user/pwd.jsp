<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html style="font-size:23.4375px;">

<head>
<title>${pd.SYSNAME}</title>
<base href="<%=basePath%>">
<meta charset="UTF-8" />
<meta name="renderer" content="webkit">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
       	<link rel="stylesheet" href="https://cdn.bootcss.com/weui/1.1.2/style/weui.min.css">
<link rel="stylesheet" href="https://cdn.bootcss.com/jquery-weui/1.2.0/css/jquery-weui.min.css">
        	   <link rel="stylesheet" type="text/css" href="static/new/css/base.css">

<!-- <script src="static/js/weui.js"></script> -->
<style type="text/css">
body{
  background: #efeff4;
}
.container{
   padding: 15px;
}
</style>
 <style type="text/css">
  </style>
</head>
<body>

	<header class="header" id="header"
		style="background-color:#e64340;position:relative;z-index:100">
		<a href="javascript:history.back(-1)" target=_self class="back">返回</a>
		<h1>账号换绑</h1>
	</header>
	<div class="page home">

		<div class="page__bd">
			<form action="" method="post" name="registerForm" id="registerForm">
				<input type="hidden" value="${user.uid}" />
				<div class="weui-cells weui-cells_form">
					<div class="weui-cell">
						<div class="weui-cell__hd">
							<label class="weui-label">手机号码</label>
						</div>
						<div class="weui-cell__bd ">
							<input name="phonenumber" id="phonenumber" class="weui-input"
								type="tel" placeholder="请输入手机号码" />
						</div>
					</div>
					<div class="weui-cell weui-cell_vcode">
						<div class="weui-cell__hd">
							<label class="weui-label">短信验证码</label>
						</div>
						<div class="weui-cell__bd ">
							<input type="text" name="phoneyanzheng" id="phoneyanzheng"
								class="weui-input" placeholder="输入验证码" />
						</div>
						<div class="weui-cell__ft">
							<input type="button" id="phoneyanzhengsend"
								class="weui-vcode-img" value="发送短信"
								style="color:#ffffff;background:#e64340;width:90px;font-size:15px"
								onclick="sendmessage()" />
						</div>
					</div>

					<div class="weui-cell">
						<div class="weui-cell__hd">
							<div class="weui-label">密码</div>
						</div>
						<div class="weui-cell__bd ">
							<input type="password" name="password" class="weui-input"
								id="password" value="" placeholder="请输入密码" />
						</div>
					</div>
					<div class="weui-cell">
						<div class="weui-cell__hd">
							<div class="weui-label">确认密码</div>
						</div>
						<div class="weui-cell__bd ">
							<input type="password" name="newpassword" class="weui-input"
								id="newpassword" value="" placeholder="请确认密码" />
						</div>
					</div>

				</div>
				<span id="phone" style="text-align:center;display:none;">已发短信到<span
					style="color:green;" id="phoneshow"></span></span>


				<div class="weui-btn-area">
					<a class="weui-btn weui-btn_warn" id="save">提交</a>
				</div>

			</form>
			<div class="page__ft">
				<div class="weui-footer">
					<p class="weui-footer_text" style="text-align:center;">Copyright
						&copy; 暮云新村 思信科技</p>
				</div>
			</div>
		</div>

	</div>
	<!-- </div> -->
<script src="https://cdn.bootcss.com/jquery/1.11.0/jquery.min.js"></script>
	<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/jquery-weui.min.js"></script>
	<script type="text/javascript">
		function sendmessage(){
		var phone=$("#phonenumber").val();
		if(phone!=""){
			if (!checkMobile(phone)) {
			$.toptip('手机号码格式不正确', 'success');
			$("#phonenumber").focus();
			}
			else{
				$.ajax({
					type: "POST",
					url: "<%=basePath%>sendmessage.do",
			    	data: "phonenumber="+phone,
					dataType:'json',
					cache: false,
					success: function(data1){
						if(data1.result=="error"){
							$.toptip('短信验证码发送失败', 'success');
						}
						else{
							$("#phoneshow").html(phone);
							$("#phone").css("display","block");
						}
					}
				});
			}
		}else{
		$.toptip('请输入手机号码', 'success');
		$("#phonenumber").focus();
		}	
	}
	
    $(function(){ 
    $("#save").click(function(e){
        var pairs = $("#registerForm").serialize().split(/&/gi);
        var data = {};
        pairs.forEach(function(pair) {
            pair = pair.split('=');
            data[pair[0]] = decodeURIComponent(pair[1] || '');
        });
        if(!data.phoneyanzheng){
            $.toptip('请输入验证码', 'success');
            $("#phoneyanzheng").focus();
        }
        else if(!data.password){
      		$.toptip('请输入密码', 'success');
            $("#password").focus();
        }
        else if(!data.newpassword){
       		$.toptip('请确认密码', 'success');
            $("#newpassword").focus();
        }
        else if (checkStrong(data.password) < 2) { 
      		$.toptip('密码太过简单', 'success'); 
			$("#password").focus();
        }
        
        else if(data.password!=data.newpassword){
        	$.toptip('两次输入的密码不一致', 'success'); 
			$("#newpassword").focus();
        }
        else{
		 var phone=$("#phonenumber").val();
		 var password=$("#password").val();
		 var phoneyanzheng=$("#phoneyanzheng").val();
		 	//先判断输入短信验证码是否正确
		 	$.post("<%=basePath%>judgecode",{phoneyanzheng:phoneyanzheng},function(data1){
		 		if(data1.result=="success"){ //正确
		 		$.ajax({
					type: "POST",
					url: "<%=basePath%>users/changphone.do",
			    	data: "loginid="+phone+"&password="+password,
					dataType:'json',
					cache: false,
					success: function(data){
						if("success" == data.result){
						//验证成功操作
        				$.toast("换绑成功");
        				window.history.go(-1); //上级页面
						}else if("error" == data.result){
						$.toptip('非党员无法进行换绑操作', 'success'); 
						}
						else{
						$.toast("换绑失败", "cancel");
						}
					}
				});
		 		}
		 		else{
		 		$.toptip('验证码错误', 'success');
           		$("#phoneyanzheng").focus();
		 		}
		 	});		
						
		}	
		
				
		
		
    });
    });


		/* 
            判断字符类型 
        */  
        function CharMode(iN) {  
            if (iN >= 48 && iN <= 57) //数字    
                return 1;  
            if (iN >= 65 && iN <= 90) //大写字母    
                return 2;  
            if (iN >= 97 && iN <= 122) //小写    
                return 4;  
            else  
                return 8; //特殊字符    
        }  
        /* 
            统计字符类型 
        */  
        function bitTotal(num) {  
            modes = 0;  
            for (i = 0; i < 4; i++) {  
                if (num & 1) modes++;  
                num >>>= 1;  
            }  
            return modes;  
        }  
        /* 
            返回密码的强度级别 
        */  
        function checkStrong(sPW) {  
            if (sPW.length <= 4)  
                return 0; //密码太短    
            Modes = 0;  
            for (i = 0; i < sPW.length; i++) {  
                //测试每一个字符的类别并统计一共有多少种模式.    
                Modes |= CharMode(sPW.charCodeAt(i));  
            }  
            return bitTotal(Modes);  
        }
        
        /** 
        * 检查字符串是否为合法手机号码 
        * @param {String} 字符串 
        * @return {bool} 是否为合法手机号码 
        */  
function checkMobile(aPhone){
   var bValidate = RegExp(/^(0|86|17951)?(13[0-9]|15[012356789]|18[0-9]|14[57])[0-9]{8}$/).test(aPhone);  
   if (bValidate) {  
        return true;  
   }  
   else  
     return false;  
}
	</script>

</body>

</html>