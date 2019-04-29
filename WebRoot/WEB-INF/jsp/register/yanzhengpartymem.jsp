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
<div class="page__hd" style="padding-top:100px;padding-bottom:15px">
<img src="static/images/liu1.png" width=370>

</div>
<div class="page__bd" >
<form action="" method="post" name="registerForm"
				id="registerForm">
				
<div class="weui-cells weui-cells_form">
	<div class="weui-cell weui-cell_vcode">
        <div class="weui-cell__bd ">
        	<input type="text" name="idcard" id="partyidcard"  class="weui-input" placeholder="请输入您的身份证号码" />
        </div>
        <div class="weui-cell__ft">
        	<input type="button" id="yanzheng" class="weui-vcode-img" value="点击验证" style="color:#ffffff;background:#e64340;width:90px;font-size:15px;"/>
        </div>
    </div>
    
    
    <div class="weui-cell" >
        <div class="weui-cell__bd ">
            <input type="text" class="weui-input" id="pname" readonly="readonly" placeholder="这里将显示您的姓名，请认真核对！" value=""/>
        </div>
    </div>
 
  
</div>

<div class="weui-btn-area">
    <a class="weui-btn weui-btn_warn"  id="next">下一步</a>
    </div>
    <div>
    <span id="Nopartytip" style="display:none;color:red;font-size:15px">
    党员确认失败，可能是您的信息未采集，请您及时汇报给您所在支部，再由支部报告给基层委员，由基层委员的信息采集员在全国党员管理信息系统中修改您的个人信息
    </span>
    </div>
</form>
</div>


</div>
<!-- </div> -->
<script src="https://cdn.bootcss.com/jquery/1.11.0/jquery.min.js"></script>
	<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/jquery-weui.min.js"></script>
	<script type="text/javascript">
	//var checkresult = false;

	var checkresult = false;
    $(function(){ 
    $("#yanzheng").click(function(e){
    var pidcard=$.trim($("#partyidcard").val());
    if(pidcard.length==0) {
    $.toptip('身份证号不能为空', 'success');
    $("#partyidcard").focus();
    checkresult=false;
    }
    if (!checkCard($("#partyidcard").val())) {
				$.toptip('身份证号码格式不正确', 'success');
				$("#partyidcard").focus();
				checkresult=false;
			}
    else{
        //校验党员身份证号信息
        $.post("<%=basePath%>partymember/checkpatrymember.do",{pidcard:pidcard},function(data){
							if(data.result=="nullerror"){
							$("#pname").val("");
							$("#Nopartytip").css("display", "none");
							checkresult=false;
							}else if(data.result=="partymembererror"){
							$("#pname").val("");
								$("#Nopartytip").css("display", "block");
								checkresult=false;
							}else if(data.result=="uidisuse"){
								$.toptip('党员已被验证', 'success');
							}else{
								$("#pname").val(data.result);
								$("#Nopartytip").css("display", "none");
								checkresult=true;
							}
						});
						}

    });
  
    $("#next").click(function(e){
    if(checkresult){
    window.location.href="<%=basePath%>partymember/yanzhengpartymem2.do";
			}
			else{
			$.toptip('请核实信息', 'success');
			}
			});
	});	 
		/**
		 * 检查输入的身份证号是否正确
		 * 输入:str  字符串
		 *  返回:true 或 flase; true表示格式正确
		 */
		function checkCard(str) {
			//15位数身份证正则表达式
			var arg1 = /^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$/;
			//18位数身份证正则表达式
			var arg2 = /^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])((\d{4})|\d{3}[A-Z])$/;
			if (str.match(arg1) == null && str.match(arg2) == null) {
				return false;
			} else {
				return true;
			}
		}
    

    
		
	
	

	</script>


</body>

</html>