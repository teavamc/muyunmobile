<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html lang="zh-CN" style="font-size: 23.4375px;">
<head>
<title>${pd.SYSNAME}</title>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
<meta content="yes" name="apple-mobile-web-app-capable" />
<meta content="black" name="apple-mobile-web-app-status-bar-style" />
<meta content="telephone=no" name="format-detection" />
<link rel="stylesheet"
	href="https://cdn.bootcss.com/weui/1.1.2/style/weui.min.css">
<link rel="stylesheet"
	href="https://cdn.bootcss.com/jquery-weui/1.2.0/css/jquery-weui.min.css">

<link rel="stylesheet" type="text/css" href="static/new/css/base.css">

<style>
	.groupbutton {
	  background: #d0451b;
	  background-image: -webkit-linear-gradient(top, #d0451b, #bc3315);
	  background-image: -moz-linear-gradient(top, #d0451b, #bc3315);
	  background-image: -ms-linear-gradient(top, #d0451b, #bc3315);
	  background-image: -o-linear-gradient(top, #d0451b, #bc3315);
	  background-image: linear-gradient(to bottom, #d0451b, #bc3315);
	  -webkit-border-radius: 3;
	  -moz-border-radius: 3;
	  border-radius: 3px;
	  text-shadow: 0px 1px 0px #854629;
	  -webkit-box-shadow: inset 0px 1px 0px 0px #cf866c;
	  -moz-box-shadow: inset 0px 1px 0px 0px #cf866c;
	  box-shadow: inset 0px 1px 0px 0px #cf866c;
	  font-family: Arial;
	  color: #ffffff;
	  font-size: 16px;
	  padding: 12px 30px 12px 30px;
	  border: solid #942911 1px;
	  text-decoration: none;
	}
	.groupbutton:hover {
	  color: #ffffff;
	  background: #bc3315;
	  text-decoration: none;
	}
</style>

</head>

<body>

	<header class="header" id="header"
		style="background-color:#e64340;position:relative;">
		<a href="<%=basePath%>partymember/partyzhuanqu.do" target=_self class="back">返回</a>
		<h1>党员小组</h1>
	</header>
	
		 <article class="weui-article">
			 <div class="weui-panel weui-panel_access" >
					<div class="weui-panel__bd">
						<a class="weui-media-box weui-media-box_appmsg">
					      <div class="weui-media-box__bd">
					        <h4 style="font-size:20px">党员总数:${pd.pmnumber}&nbsp&nbsp男:${pd.mannum}人&nbsp女:${pd.womennum}人</h4>
					      </div>
					    </a> 
				 	</div>
				</div>
		</article>
		
	 <article class="weui-article" style="margin:0px">

	 <a onclick="grouptype(1)" class="weui-btn weui-btn_default">新港</a>
	 
	 <a onclick="grouptype(2)" class="weui-btn weui-btn_default">白庙咀</a>
      
	 <a onclick="grouptype(3)" class="weui-btn weui-btn_default">排兴垅</a>
      
     <a onclick="grouptype(4)" class="weui-btn weui-btn_default">曹家塘</a>
      
     <a onclick="grouptype(5)" class="weui-btn weui-btn_default">长塘</a>
     
     <a onclick="grouptype(6)" class="weui-btn weui-btn_default">上珠塘</a>
		
     <a onclick="grouptype(7)" class="weui-btn weui-btn_default">暮云铺</a>
      
     <a onclick="grouptype(8)" class="weui-btn weui-btn_default">禁山子</a>
   </article>
	
	

<script src="https://cdn.bootcss.com/jquery/1.11.0/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/jquery-weui.min.js"></script>

<!-- 如果使用了某些拓展插件还需要额外的JS -->
<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/swiper.min.js"></script>
<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/city-picker.min.js"></script>



	<script type="text/javascript">
		var type = ['新港','白庙咀','排兴垅','曹家塘','长塘','上珠塘','暮云铺','禁山子']; 
		var searchInput=$.trim($("#searchInput").val());
		
		function grouptype(i){
			window.location.href="<%=basePath%>partygroup/typecontent?begin=0&length=10&type="+type[i-1];		
		};
	
	</script>									
 </body>
</html>

