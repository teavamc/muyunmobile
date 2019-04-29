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
<html lang="en">

<head>
<title>${pd.SYSNAME}</title>
<base href="<%=basePath%>">
<meta charset="UTF-8" />
<meta name="renderer" content="webkit">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="https://cdn.bootcss.com/weui/1.1.2/style/weui.min.css">
<link rel="stylesheet" href="https://cdn.bootcss.com/jquery-weui/1.2.0/css/jquery-weui.min.css">
<link rel="stylesheet" type="text/css" href="static/new/css/base.css">
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
<body ontouchstart="">
<header class="header" id="header" style="background-color:#e64340;position:relative;z-index:100">
<a href="javascript:history.go(-1)" target=_self class="back">返回</a>
<h1>党员验证</h1>
</header>
<!-- <div class="container" id="container"> -->
<div class="page home">
<div class="page__hd" style="padding-top:100px;padding-bottom:15px;">
<img src="static/images/liu2.png" width=370>


</div>
<div class="page__bd" >
<form action="" method="post" name="registerForm"
				id="registerForm">
		
<div class="weui-cells weui-cells_form">

	<div class="weui-cell">
        <div class="weui-cell__hd">
            <label class="weui-label">您的姓名</label>
        </div>
        <div class="weui-cell__bd ">
            <input name="pname" id="pname" class="weui-input" type="text" readonly="readonly" value="${pd.pname}">
        </div>
    </div>

     <div class="weui-cell">
        <div class="weui-cell__hd">
            <label class="weui-label">手机号码</label>
        </div>
        <div class="weui-cell__bd ">
            <input name="phonenumber" id="phonenumber" class="weui-input" type="tel"  placeholder="输入您的手机号码">
        </div>
    </div>
    
    <div class="weui-cell weui-cell_vcode">
    <div class="weui-cell__hd">
            <label class="weui-label">短信验证码</label>
        </div>
        <div class="weui-cell__bd ">
        	<input type="text" name="phoneyanzheng" id="phoneyanzheng"  class="weui-input" placeholder="输入验证码" />
        </div>
        <div class="weui-cell__ft">
        	<input type="button" id="phoneyanzhengsend" class="weui-vcode-img" value="发送短信" 
        	style="color:#ffffff;background:#ff9900;width:90px;font-size:15px;" onclick="sendmessage()"/>
        </div>
    </div>
  
</div>
<span id="phone" style="text-align:center;display:none;">已发短信到<span style="color:green;" id="phoneshow"></span></span>

<div class="weui-btn-area">
    <a class="weui-btn weui-btn_warn"  onclick="overall()">下一步</a>
    </div>
</form>
</div>




</div>
<!-- </div> -->
<script src="https://cdn.bootcss.com/jquery/1.11.0/jquery.min.js"></script>
	<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/jquery-weui.min.js"></script>
	<script type="text/javascript">
	
	function sendmessage(){
	var phonenumber=$("#phonenumber").val();
		if(phonenumber!=""){
			if (!checkMobile($("#phonenumber").val())) {
			$.toptip('手机号码格式不正确', 'success');
			$("#phonenumber").focus();
			}
			else{
				$.ajax({
					type: "POST",
					url: "<%=basePath%>sendmessage.do",
			    	data: "phonenumber="+phonenumber,
					dataType:'json',
					cache: false,
					success: function(data1){
						if(data1.result=="error"){
							$.toptip('短信验证码发送失败', 'success');
						}
						else{
							$("#phoneshow").html(phonenumber);
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
	

    
    function overall(){
    var phonenumber=$("#phonenumber").val();
    var pname=$("#pname").val();
    var phoneyanzheng=$("#phoneyanzheng").val();
      if(phonenumber==""){
      	 $.toptip('手机号码不能为空', 'success');
      	 $("#phonenumber").focus();
        }
      if(phoneyanzheng==""){
      	 $.toptip('验证码不能为空', 'success');
      	 $("#phoneyanzheng").focus();
        }
       //通过传递参数判断用户是否是正确进入链接
      if(pname==""){
         $.toptip('验证身份出错', 'success');
        }
      			
		else{
			//判断输入短信验证码是否正确
		 	$.post("<%=basePath%>judgecode",{phoneyanzheng:$("#phoneyanzheng").val()},function(data1){
		 		if(data1.result=="success"){ //正确
		 		window.location.href="<%=basePath%>partymember/yanzhengpartymem3?phone="+phonenumber;
		 		}
		 		else{
		 		$.toptip('验证码错误', 'success');
		 		$("#phoneyanzheng").focus();
		 		}
		 	});
			}
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