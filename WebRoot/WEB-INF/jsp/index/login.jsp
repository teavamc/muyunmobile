<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">

<head>
<title>${pd.SYSNAME}</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

  <link rel="stylesheet" href="//res.wx.qq.com/open/libs/weui/1.1.0/weui.min.css"/>
          <link rel="stylesheet" href="https://cdn.bootcss.com/jquery-weui/1.2.0/css/jquery-weui.min.css">

		<script type="text/javascript" src="static/js/jquery.min.js"></script>
		<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
   
 
</head>
<body>

	<a style="margin-top:0px;"><img style="background-size:contain|cover;width:100%;height: auto;" src="static/new/images/new/loginpic.png" alt=""/></a>
		
		<div class="page home">
<div class="page__hd" style="text-align:center;">
<h2 class="page__title" >村务管理系统</h2>
</div>
<div class="page__bd" >
<form action="" method="post" name="loginForm" id="loginForm">

				
<div class="weui-cells weui-cells_form">
    <div class="weui-cell">
        <div class="weui-cell__hd">
            <label class="weui-label">党员账号</label>
        </div>
        <div class="weui-cell__bd ">
            <input name="loginname" id="loginname" class="weui-input" type="text"  placeholder="请输入账号">
        </div>
    </div>
    <div class="weui-cell">
        <div class="weui-cell__hd">
            <div class="weui-label">党员密码</div>
        </div>
        <div class="weui-cell__bd ">
           <input type="password" name="password" class="weui-input" id="password" placeholder="请输入密码" value=""/>
        </div>
    </div>
    
    <div class="weui-cell weui-cell_vcode">
        <div class="weui-cell__hd">
            <div class="weui-label">验证码</div>
        </div>
        <div class="weui-cell__bd ">
        	<input type="text" name="code" id="code" class="weui-input" placeholder="请输入验证码" />
        </div>
        <div class="weui-cell__ft">
        	<img id="changecode" alt="点击更换" title="点击更换"  onclick="change()" src="${pd.time}" class="weui-vcode-img" />
        </div>
    </div>
</div>

<div class="weui-btn-area">
    <a class="weui-btn weui-btn_primary" onclick="severCheck();" id="to-recover" >登陆</a>
</div>
</form>
</div>
<div class="page__ft">
<div class="weui-footer">
	<p class="weui-footer_text" style="padding-top:20px;" >Copyright &copy; 思信网络科技有限公司 </p>
</div>
</div>

	<script type="text/javascript">
		//服务器校验
		function severCheck(){
			if(check()){
				
				var loginname = $("#loginname").val();
				var password = $("#password").val();
				var code = "infopublic"+loginname+",info,"+password+"infopublic"+",info,"+$("#code").val();
				$.ajax({
					type: "POST",
					url: 'login_login',
			    	data: {KEYDATA:code,tm:new Date().getTime()},
					dataType:'json',
					cache: false,
					success: function(data){
						if("success" == data.result){
							window.location.href="mainindex";
						}else if("usererror" == data.result){
							$("#loginname").tips({
								side : 1,
								msg : "用户名或密码有误",
								bg : '#FF5080',
								time : 15
							});
							showfh();
							$("#loginname").focus();
						}else if("loginderror"==data.result){
							alert("此党员账号已在其他设备登陆");
						}else if("codeerror" == data.result){
							$("#code").tips({
								side : 1,
								msg : "验证码输入有误",
								bg : '#FF5080',
								time : 15
							});
							showfh();
							$("#code").focus();
						}else{
							$("#loginname").tips({
								side : 1,
								msg : "缺少参数",
								bg : '#FF5080',
								time : 15
							});
							showfh();
							$("#loginname").focus();
						}
					}
				});
			}
		}


		



		function genTimestamp() {
			var time = new Date();
			return time.getTime();
		}

		function change(){
		$("#changecode").attr("src", "code.do?t=" + genTimestamp());
		}

		//客户端校验
		function check() {

			if ($("#loginname").val() == "") {

				$("#loginname").tips({
					side : 2,
					msg : '用户名不得为空',
					bg : '#AE81FF',
					time : 3
				});
				showfh();
				$("#loginname").focus();
				return false;
			} else {
				$("#loginname").val(jQuery.trim($('#loginname').val()));
			}

			if ($("#password").val() == "") {

				$("#password").tips({
					side : 2,
					msg : '密码不得为空',
					bg : '#AE81FF',
					time : 3
				});
				showfh();
				$("#password").focus();
				return false;
			}
			if ($("#code").val() == "") {

				$("#code").tips({
					side : 1,
					msg : '验证码不得为空',
					bg : '#AE81FF',
					time : 3
				});
				showfh();
				$("#code").focus();
				return false;
			}

			$("#loginbox").tips({
				side : 1,
				msg : '正在登录 , 请稍后 ...',
				bg : '#68B500',
				time : 10
			});

			return true;
		}


		function quxiao() {
			$("#loginname").val('');
			$("#password").val('');
		}

	
	</script>

	<c:if test="${'1' == pd.msg}">
		<script type="text/javascript">
		$(tsMsg());
		function tsMsg(){
			alert('此党员账号已在其它终端上登录,您被强制下线');
		}
		</script>
	</c:if>
	<c:if test="${'2' == pd.msg}">
		<script type="text/javascript">
			$(tsMsg());
			function tsMsg(){
				alert('您被系统管理员强制下线');
			}
		</script>
	</c:if>

	<script src="static/login/js/bootstrap.min.js"></script>
	<script src="static/js/jquery-1.7.2.js"></script>
	<script src="static/login/js/jquery.easing.1.3.js"></script>
	<script src="static/login/js/jquery.mobile.customized.min.js"></script>
	<script src="static/login/js/camera.min.js"></script>
	<script src="static/login/js/templatemo_script.js"></script>
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript" src="static/js/jquery.cookie.js"></script>
</body>

</html>