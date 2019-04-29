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
<body ontouchstart="" >
<header class="header" id="header" style="background-color:#e64340;position:relative;z-index:100">
<a href="javascript:history.go(-1)" target=_self class="back">返回</a>
<h1>党员验证</h1>
</header>
<div class="page home">
<div class="page__hd" style="padding-top:100px;padding-bottom:15px;">
<img src="static/images/liu3.png" width=370>


</div>
<div class="page__bd" >
<form action="" method="post" name="registerForm"
				id="registerForm">


<input type="hidden" name="openid"  value="${pd.openid }"  />  
<input type="hidden" name=phonenumber value="${pd.phonenumber}"   />  
<input type="hidden" name="pname" id="pname" value="${pd.pname}"  />   
<input type="hidden" name="pidcard" id="pidcard" value="${pd.pidcard}"  />  


<div class="weui-cells weui-cells_form">



     <div class="weui-cell">
        <div class="weui-cell__hd">
            <label class="weui-label">密码</label>
        </div>
        <div class="weui-cell__bd ">
            <input name="password" id="password" class="weui-input" type="password"  placeholder="输入您的密码">
        </div>
    </div>
    
    <div class="weui-cell">
        <div class="weui-cell__hd">
            <label class="weui-label">确认密码</label>
        </div>
        <div class="weui-cell__bd ">
            <input name="newpassword" id="newpassword" class="weui-input" type="password"  placeholder="确认您的密码">
        </div>
    </div>
    
    <div class="weui-cell weui-cell_vcode">
        <div class="weui-cell__hd">
            <div class="weui-label">验证码</div>
        </div>
        <div class="weui-cell__bd ">
        	<input type="text" name="code" id="code" class="weui-input" placeholder="请输入验证码" />
        </div>
        <div class="weui-cell__ft" style="width:100px">
        	<img id="codeImg" alt="点击更换" title="点击更换" src="" class="weui-vcode-img" />
        </div>
    </div>
    

  
</div>
<div class="weui-loadmore" style="position: absolute;top:40%;width:100%;height:100%;display:none" >
		<i class="weui-loading" ></i> <span class="weui-loadmore__tips">正在加载</span>
	</div>
<div class="weui-btn-area">
    <a class="weui-btn weui-btn_warn"  id="overall">确定</a>
    </div>
</form>
</div>




</div>
<!-- </div> -->
<script src="https://cdn.bootcss.com/jquery/1.11.0/jquery.min.js"></script>
	<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/jquery-weui.min.js"></script>
	<script type="text/javascript">
    $(function(){ 
  
    changeCode();
	$("#codeImg").bind("click", changeCode);
    $("#overall").click(function(e){
    
        var pairs = $("#registerForm").serialize().split(/&/gi);
        var data = {};
        pairs.forEach(function(pair) {
            pair = pair.split('=');
            data[pair[0]] = decodeURIComponent(pair[1] || '');
        });
        if(!data.password){
           $.toptip('请输入密码', 'success');
           $("#password").focus();
        }
        else if(!data.newpassword){
        	$.toptip('请输入重复密码', 'success');
            $("#newpassword").focus();
        }
        else  if(data.newpassword!=data.password){
       		 $.toptip('两次输入密码不一致', 'success');
             $("#newpassword").focus();
        }
        else if (checkStrong(data.password) < 2) {  
       		 $.toptip('密码太过简单', 'success');
             $("#password").focus();
        }
        else if(!data.code){
    	     $.toptip('验证码不能为空', 'success');
             $("#code").focus();
        }
        
       //通过传递参数判断用户是否是正确进入链接
        else if(!data.phonenumber){
            $.toptip('验证身份出错', 'success');
        }
       			
		else{
			  $(".weui-loadmore").css("display","block");
				//var password = $("#password").val();
				$.ajax({
					type: "POST",
					url: "<%=basePath%>partymember/binduser.do",
			    	data: $("#registerForm").serializeArray(),
					dataType:'json',
					cache: false,
					success: function(data){
						if("success" == data.result){
							window.location.href="<%=basePath%>partymember/yanzhengsuccess";
						}
						else if("nameerror"==data.result){
						$(".weui-loadmore").css("display","none");
							$.toptip('您的手机号码已被注册！', 'success');
						}
						else if("nocode"==data.result){
						$(".weui-loadmore").css("display","none");
							$.toptip('验证码不能为空', 'success');
							$("#code").focus();
						}
						else if("codeerror"==data.result){
						$(".weui-loadmore").css("display","none");
							$.toptip('验证码错误', 'success');
							$("#code").focus();
						}
					}
				});

			}
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
</body>

</html>