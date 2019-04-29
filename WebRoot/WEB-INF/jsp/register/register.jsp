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
<body>
 <div class="weui-toptips weui-toptips_warn" id="toptip">错误提示</div>
<!-- <div class="container" id="container"> -->
<div class="page home">
<div class="page__hd" style="padding-top:20px;padding-left:40px;">
<h2 class="page__title" style="text-align:center;">暮云党建平台账号注册</h2>
</div>
<div class="page__bd" >
<form action="" method="post" name="registerForm"
				id="registerForm">
				<input type="hidden" name="openid"  value="${webchatUser.openid }"  />
				<input type="hidden" name="nickname"  value="${webchatUser.nickname }"  />
				<input type="hidden" name="sex"  value="${webchatUser.sex }"  />
<div class="weui-cells weui-cells_form">
    <div class="weui-cell">
        <div class="weui-cell__hd">
            <label class="weui-label">登录名</label>
        </div>
        <div class="weui-cell__bd ">
            <input name="registername" id="registername" class="weui-input" type="text"  placeholder="请输入登录名">
        </div>
    </div>
    <div class="weui-cell">
        <div class="weui-cell__hd">
            <div class="weui-label">登录密码</div>
        </div>
        <div class="weui-cell__bd ">
           <input type="password" name="password" class="weui-input" id="password" placeholder="请输入密码" value=""/>
        </div>
    </div>
    <div class="weui-cell">
        <div class="weui-cell__hd">
            <div class="weui-label">确认密码</div>
        </div>
        <div class="weui-cell__bd ">
            <input type="password" name="repassword"  class="weui-input" id="repassword" placeholder="请输入确认密码" value=""/>
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
        	<img id="codeImg" alt="点击更换" title="点击更换" src="" class="weui-vcode-img" />
        </div>
    </div>
</div>

<div class="weui-btn-area">
    <a class="weui-btn weui-btn_primary"  id="save">注册</a>
    <a class="weui-btn weui-btn_default" href="<%=basePath%>login_toLogin" >已有账号，去登陆</a>
</div>
</form>
</div>
<div class="page__ft">
<div class="weui-footer">
	<p class="weui-footer_text">Copyright &copy;  暮云新村 思信科技</p>
</div>
</div>
<!-- loading toast -->
    <div id="loadingToast" style="display:none;">
        <div class="weui-mask_transparent"></div>
        <div class="weui-toast">
            <i class="weui-loading weui-icon_toast"></i>
            <p class="weui-toast__content">数据加载中</p>
        </div>
    </div>
</div>
<!-- </div> -->

	<script type="text/javascript">
	var checkresult = false;
	
    $(function(){ 
		changeCode();
		$("#codeImg").bind("click", changeCode);
    $("#save").click(function(e){
    //??????代码不解！
        var pairs = $("#registerForm").serialize().split(/&/gi);
        var data = {};
        pairs.forEach(function(pair) {
            pair = pair.split('=');
            data[pair[0]] = decodeURIComponent(pair[1] || '');
        });
        if(!data.registername){
            showtopTips('请输入登录名');
            return;
        }
        if(!data.password){
            showtopTips('请输入登录密码');
            return;
        }else if (checkStrong(data.password) < 2) {  
                    showtopTips("密码太过简单");  
                    return;  
        }
        
        if(data.password!=data.repassword){
            showtopTips('两次输入的密码不一致');
            return;
        }
        if(!data.code){
            showtopTips('请输入验证码');
            return;
        }
        //微信用到
   //     if(!data.openid){
    //        showtopTips('请关注微信公众号后进入该链接');
     //       return;
     // }
      
      showloading('数据加载中...');
        //校验用户名是否存在
        $.post("<%=basePath%>register/checkUsername.do",{registername:$("#registername").val()},function(data){
							if(data.result=="success"){
							//用户名校验成功，可以使用，进行注册
								$.ajax({
					type: "POST",
					url: "<%=basePath%>register/register.do",
			    	data: $("#registerForm").serializeArray(),
					dataType:'json',
					cache: false,
					success: function(data1){
						if("success" == data1.result){
 					//		$.weui.toast('注册成功');
							window.location.href="<%=basePath%>register/success.do";
						}else if("codeerror" == data1.result){
							showtopTips('验证码输入有误');
						}else if("adderror" == data1.result){
							showtopTips('注册出错');
						}else{
							showtopTips('缺少参数');
						}
					}
				});
							}else if(data.result=="nameerror"){
								showtopTips('用户名已存在');
								//alert(data.result);
								checkresult=false;
							}else{
								showtopTips('用户名不得为空');
								checkresult=false;
							}
						});
						
		
    });
    // loading
        var $loadingToast = $('#loadingToast');
        function showloading(){
            if ($loadingToast.css('display') != 'none') return;

            $loadingToast.fadeIn(100);
            setTimeout(function () {
                $loadingToast.fadeOut(100);
            }, 2000);
        };
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
    });
		
		$(document).keyup(function(event) {
			if (event.keyCode == 13) {
				$("#to-recover").trigger("click");
			}
		});

		function genTimestamp() {
			var time = new Date();
			return time.getTime();
		}

		function changeCode() {
	
			$("#codeImg").attr("src", "code.do?t=" + genTimestamp());
		}

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
	</script>
	<script>
	</script>
	<script src="static/js/jquery-1.7.2.js"></script>
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript" src="static/js/jquery.cookie.js"></script>
</body>

</html>