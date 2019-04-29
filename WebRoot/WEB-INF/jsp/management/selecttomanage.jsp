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

<head >
<title>${pd.SYSNAME}</title>
<base href="<%=basePath%>">
<meta charset="UTF-8" />
<meta name="renderer" content="webkit">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" type="text/css" href="static/new/css/base.css">
	    	<link rel="stylesheet" href="https://cdn.bootcss.com/weui/1.1.2/style/weui.min.css">
<link rel="stylesheet" href="https://cdn.bootcss.com/jquery-weui/1.2.0/css/jquery-weui.min.css">
<style type="text/css">
body{
  background: #efeff4;
}
.container{
   padding: 15px;
}
</style>

</head>
<body>
<input type="hidden" value="${shouquan}" id="shouquan">

<header class="header" id="header" style="background-color:#e64340;position:relative;z-index:100">
<a href="javascript:history.go(-1)" target=_self class="back">返回</a>
<h1>村事管理</h1>
</header>

<div class="weui-btn-area" >
  <a onclick="xiaocun()" class="weui-btn weui-btn_default">管理小村家事</a>
  
  <a onclick="yuqing()" class="weui-btn weui-btn_default">管理舆情上报</a>
  
  <a href="<%=basePath%>feedback/editallfeed?ftype=咨询" class="weui-btn weui-btn_default">管理投诉咨询</a>
  
  <a onclick="muyuncircle()" class="weui-btn weui-btn_default">管理暮云圈</a>

</div>

<script src="https://cdn.bootcss.com/jquery/1.11.0/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/jquery-weui.min.js"></script>

	<script type="text/javascript">
		function yuqing(){

		$.modal({
  		title: "舆情管理",
  		text: "请选择转向:",
 		buttons: [
    { text: "去审核", onClick: function(){$.toast("尚未开发", "cancel");}},
    { text: "编辑舆情", onClick: function(){ window.location.href="<%=basePath%>yuqing/showallyuqing?edit=toedit";} },
    { text: "取消", className: "default", onClick: function(){ } },
  			]
		});
		}
		
		function xiaocun(){
		window.location.href="<%=basePath%>xiaocun/showallxiaocun?edit=toedit";
		}
		
		function muyuncircle(){

		$.modal({
  		title: "暮云圈管理",
  		text: "请选择转向:",
 		buttons: [
    { text: "编辑", onClick: function(){window.location.href="<%=basePath%>pcircle/showpcircle?edit=edit";}},
    { text: "暮云热点", onClick: function(){ window.location.href="<%=basePath%>pcircle/showpcircle?edit=hotedit";} },
    { text: "取消", className: "default", onClick: function(){ } },
  			]
		});
		}
	</script>
	
	

</body>

</html>