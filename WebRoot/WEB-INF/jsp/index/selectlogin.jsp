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
<html lang="en">

<head>
<title>${pd.SYSNAME}</title>
<base href="<%=basePath%>">
<meta charset="UTF-8" />
<meta name="renderer" content="webkit">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<!-- 引入 WeUI -->
        <link rel="stylesheet" href="//res.wx.qq.com/open/libs/weui/1.1.0/weui.min.css"/>
<!--         <link rel="stylesheet" href="static/register/weui.min.css"/> -->
<script type="text/javascript" src="static/js/jquery.min.js"></script>
<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
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

<body ontouchstart="">
<input type="hidden" value="${shouquan}" id="shouquan">
 <div class="weui-toptips weui-toptips_warn" id="toptip">错误提示</div>


<div class="page home">
<div class="page__hd" style="padding-top:20px;padding-left:40px;">
<h2 class="page__title" ></h2>
</div>
<div class="page__bd" >
<form action="" method="post" name="registerForm"
				id="registerForm">
		<input type="hidden" name="openid"  value="${webchatUser.userid} "  />
				<input type="hidden" name="nickname"  value="${webchatUser.name}"  />
				<input type="hidden" name="sex"  value="${webchatUser.gender}"  />
				<input type="hidden" name="avatar"  value="${webchatUser.avatar}"  />
				<input type="hidden" id="isparty"  value="${isparty}"  />
<div class="weui-cells weui-cells_form">

</div>

<div class="weui-btn-area" id="main" style="display:block;">
  
    <a class="weui-btn weui-btn_primary" href="<%=basePath%>partymember/yanzhengpartymem" style="margin-top:90px;height:100px;line-height:3.8;font-size:25px;background-color:#FF3300;">绑定党员账号</a>
<a class="weui-btn weui-btn_primary" href="<%=basePath%>login_toLogin" style="margin-top:70px;height:100px;line-height:3.8;font-size:25px;background-color:#FF3300;">已有党员账号，直接登陆</a>
</div>
</form>




</div>


</div>



	<script type="text/javascript">
		$(document).ready(function(){  
	var shouquan=$("#shouquan").val();
	
	if(shouquan=="shouquan"){//授权跳转而来         自动注册
			$.ajax({
					type: "POST",
					url: "<%=basePath%>mainindexfunction.do",
			    	data: $("#registerForm").serializeArray(),
					dataType:'json',
					cache: false,
					success: function(data1){
						if("sessionno" == data1.sessionno){
							window.location.href="<%=basePath%>login_toLogin";
						}
						else if(1==data1.isparty){ //若其为党员则跳转到党员专区
						window.location.href="<%=basePath%>partymember/partyzhuanqu";
						}
					}
				});  		
}else{
	var isparty=${isparty}
	$("#isparty").val(isparty);
	}

	});
        
        //toptips
        var $tooltips = $("#toptip");
        function showtopTips(content){
            if ($tooltips.css("display") != "none") return;

            // toptips的fixed, 如果有`animation`, `position: fixed`不生效
            $(".page.cell").removeClass("slideIn");

            $tooltips.css("display", "block");
            $tooltips.html(content );
            setTimeout(function () {
                $tooltips.css("display", "none");
            }, 2000);
        }
 

	</script>
	<script>
	</script>
	<script src="static/js/jquery-1.7.2.js"></script>
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript" src="static/js/jquery.cookie.js"></script>
</body>

</html>