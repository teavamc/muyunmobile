<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html style="font-size:23.4375px;">
<head>
<title>${pd.SYSNAME}</title>
<base href="<%=basePath%>">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
<meta name="description" content="">


<!-- css && js -->
<link rel="stylesheet" href="https://cdn.bootcss.com/weui/1.1.2/style/weui.min.css"><%-- weui-css --%>
<link rel="stylesheet" href="https://cdn.bootcss.com/jquery-weui/1.2.0/css/jquery-weui.min.css"><%-- weui-js-css --%>

<script src="https://cdn.bootcss.com/jquery/1.11.0/jquery.min.js"></script><%-- jquery--%>
<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/jquery-weui.min.js"></script>
<!-- css && js end -->

<link rel="stylesheet" type="text/css" href="static/login/css/slick.css" />
<link rel="stylesheet" type="text/css" href="static/login/css/base.css" />
<link rel="stylesheet" type="text/css" href="static/new/css/base.css">
<link rel="stylesheet" type="text/css" href="static/login/css/style.css" />



</head>

<body>


<header class="header" id="header" style="background-color:#008B00;position:relative;z-index:100">
<a href="javascript:history.back(-1)" target=_self class="back">返回</a>
<h1>个人信息</h1>
</header>
  
  	<style>
        .justify{
            justify-content: center;
        }
        .align{
            align-items: center;
        }
        .wid{
            height: 5em;
        }
        
    </style>
    
    <style type="text/css">
    *{margin:0;padding:0}
    html,body{font: 12px/21px Verdana, Geneva, Arial, Helvetica, sans-serif;background: #fff}
	</style>

	<form action="" name="userForm" id="userForm" method="post" >
		<input type="hidden" name="uid" id="uid" value="${user.uid }" />
		<input type="hidden" name="loginid" id="loginid" value="${user.loginid }" />
		<input type="hidden" name="usersex" id="usexinput" value="${user.usex }" />
		

		<%-- <div class="page__bd page__bd_spacing  " style="margin-top:20px;">
		
	<div class="weui-flex">
		  <div class="weui-flex__item weui-flex justify align" >
				<span>
					<img src="${user.headimg}" style="border-radius:5px;height:60px;width:60px;">
				</span>
			</div>
		</div>
		
		<div class="weui-flex">
		  <div class="weui-flex__item weui-flex justify align" >
					<p>微信头像</p>
			</div>
		</div>	
	</div> --%>
	
    <div class="weui-cells weui-cells_form">
    
      <div class="weui-cell">
        <div class="weui-cell__hd"><label class="weui-label"><span style="color:red;">*</span>姓名</label></div>
        <div class="weui-cell__bd">
          <input type="text" id="uname" name="uname" placeholder="填写用户名" value="${user.uname }" />
        </div>
        
      </div>
      
    
      
       <div class="weui-cell">
        <div class="weui-cell__hd"><label class="weui-label"><span style="color:red;">*</span>身份证</label></div>
        <div class="weui-cell__bd">
         <input type="text" name="idcard" id="idcard" placeholder="请填写您的身份证号" value="${user.idcard }" />
        </div>
      </div>
      
       <div class="weui-cell">
        <div class="weui-cell__hd"><label class="weui-label"><span style="color:red;">*</span>是否党员</label></div>
        <div class="weui-cell__bd">
         <input type="text" name="isparty" id="isparty" value="${user.isparty }" readonly="readonly" />
        </div>
      </div>
      
        <div class="weui-cell">
        <div class="weui-cell__hd"><label class="weui-label">手机号码</label></div>
        <div class="weui-cell__bd">
         <input type="text" name="uphone" id="uphone" placeholder="请填写您的手机号码" value="${user.phone }" />
        </div>
      </div>
      
      <div class="weui-cell">
        <div class="weui-cell__hd"><label class="weui-label">性别</label></div>
        <div class="weui-cell__bd">
				
				 <select class="weui-select" name="usex">
            <option selected="">请选择</option>
            <option id="man">男</option>
            <option id="woman">女</option>
          </select>
        </div>
      </div>
      
     
      
      <div class="weui-cell">
        
        <div class="weui-cell__hd"><label for="" class="weui-label">出生日期</label></div>
        <div class="weui-cell__bd">
          <input class="weui-input" type="date" value="">
        </div>
      </div>
      
      <div class="weui-cell">
        <div class="weui-cell__hd"><label class="weui-label">电子邮箱</label></div>
        <div class="weui-cell__bd">
         <input type="text" name="uemail" id="uemail" placeholder="请填写您的邮箱地址" value="${user.uemail }" />
        </div>
      </div>
      
     <div class="weui-cells__title">家庭住址</div>
    <div class="weui-cells">
      <div class="weui-cell">
        <div class="weui-cell__bd">
          <input class="weui-input" type="text" name="address" id="address" placeholder="请填写您的家庭住址" value="${user.address }">
        </div>
      </div>
    </div>
    
    <div class="weui-cells__title">银行卡一</div>
    <div class="weui-cells">

      <div class="weui-cell weui-cell_select weui-cell_select-before">
        <div class="weui-cell__hd">
          <select class="weui-select" name="selectbank1">
            <option value="1">工商银行</option>
            <option value="2">建设银行</option>
            <option value="3">招商银行</option>
            <option value="4">农业银行</option>
          </select>
        </div>
        <div class="weui-cell__bd">
          <input class="weui-input" type="number" pattern="[0-19]*" placeholder="请输入银行卡号">
        </div>
      </div>
    </div>
    
    <div class="weui-cells__title">银行卡二（没有则不填）</div>
    <div class="weui-cells">

      <div class="weui-cell weui-cell_select weui-cell_select-before">
        <div class="weui-cell__hd">
          <select class="weui-select" name="selectbank1">
            <option value="1">工商银行</option>
            <option value="2">建设银行</option>
            <option value="3">招商银行</option>
            <option value="4">农业银行</option>
          </select>
        </div>
        <div class="weui-cell__bd">
          <input class="weui-input" type="number" pattern="[0-19]*" placeholder="请输入银行卡号">
        </div>
      </div>
    </div>
    
     <div class="weui-cells__title">银行卡三（没有则不填）</div>
    <div class="weui-cells">

      <div class="weui-cell weui-cell_select weui-cell_select-before">
        <div class="weui-cell__hd">
          <select class="weui-select" name="selectbank1">
            <option value="1">工商银行</option>
            <option value="2">建设银行</option>
            <option value="3">招商银行</option>
            <option value="4">农业银行</option>
          </select>
        </div>
        <div class="weui-cell__bd">
          <input class="weui-input" type="number" pattern="[0-19]*" placeholder="请输入银行卡号">
        </div>
      </div>
    </div>
      
  
   <div class="weui-cells__title">个人说明</div>  
      <div class="weui-cells weui-cells_form">
      <div class="weui-cell">
        <div class="weui-cell__bd">
          <textarea class="weui-textarea" placeholder="请输入文本" name="note" id="note" placeholder="请填写您的个人说明" value="${user.note }" rows="3"></textarea>
          <div class="weui-textarea-counter"><span>0</span>/200</div>
        </div>
      </div>
   
    </div>


			<div class="weui-btn-area">
	   			  <a class="weui-btn weui-btn_primary"  onclick="save()">保存</a>
			</div>
	</form>


	<script type="text/javascript">
    //是否党员
    $(function(){
    if($("#isparty").val()=="1"){
    $("#isparty").val("党员");
    $("#isparty").css("color","red");
    $("#idcard").attr("readonly","readonly");//身份证不可更改
    $("#idcard").css("color","#C0C0C0");
     $("#uname").attr("readonly","readonly");//姓名不可更改
     $("#uname").css("color","red");
    }
    else{
    $("#isparty").val("您还没有验证党员身份");
    $("#isparty").css("color","#C0C0C0");
    $("#yanzheng").css("display","block");
    
    }
    });
    //性别，默认为男
    $(function(){
    if($("#usexinput").val()=="女"){
    $("#woman").attr("class","sex-check");
    }
    else{
    $("#man").attr("class","sex-check");
    }
    });
   


    
    
//保存
	
	function save() {
	var sex=$(".sex-check").text();
	$("#usexinput").val(sex);
		if ($("#uname").val() == "") {
			showtopTips('请输入您的姓名');
			$("#uname").focus();
		}
		else if ($("#uphone").val() == "") {
			showtopTips('请输入您的手机号码');
			$("#uphone").focus();

		} 
		else if($("#idcard").val() == "" ){
				showtopTips('请输入身份证号码');
				$("#idcard").focus();

		}
		else if ( !checkMobile($("#uphone").val())) {
			showtopTips('手机号码格式不正确');
			$("#uphone").focus();

		}
		else if (!checkCard($("#idcard").val())) {
				showtopTips('身份证号码格式不正确');
				$("#idcard").focus();

			}
		else if($("#uemail").val()!=""&&$("#uemail").val()!=null &&!ismail($("#uemail").val())){
				showtopTips('邮箱格式不正确');
				$("#uemail").focus();


		}	
	
	else{
			$.ajax({
					type: "POST",
					url: "<%=basePath%>users/editU.do",
					data : $("#userForm").serializeArray(),
					dataType : 'json',
					cache : false,
					success : function(data) {
						if ("success" == data.result) {
							showtopTips('保存成功');
							window.history.go(0); //刷新页面
						} else {
							showtopTips('提交失败');
						}
					}
				});
			}
		}

		/** 
		 * 检查字符串是否为合法手机号码 
		 * @param {String} 字符串 
		 * @return {bool} 是否为合法手机号码 
		 */
		function checkMobile(aPhone) {
			var bValidate = RegExp(
					/^(0|86|17951)?(13[0-9]|15[012356789]|18[0-9]|14[57])[0-9]{8}$/)
					.test(aPhone);
			if (bValidate) {
				return true;
			} else
				return false;
		}


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

		function ismail(mail) {
			return (new RegExp(
					/^(?:[a-zA-Z0-9]+[_\-\+\.]?)*[a-zA-Z0-9]+@(?:([a-zA-Z0-9]+[_\-]?)*[a-zA-Z0-9]+\.)+([a-zA-Z]{2,})+$/)
					.test(mail));
		}

		//toptips
		var $tooltips = $("#toptip");
		function showtopTips(content) {
			if ($tooltips.css("display") != "none")
				return;
			// toptips的fixed, 如果有`animation`, `position: fixed`不生效
			$(".page.cell").removeClass("slideIn");
			$tooltips.css("display", "block");
			$tooltips.html(content);
			setTimeout(function() {
				$tooltips.css("display", "none");
			}, 2000);
		}
	</script>
	<script type="text/javascript" src="static/js/jquery.min.js"></script>
	<script src="static/js/mainjs/jquery-1.10.2.min.js"></script>
	

</body>
</html>