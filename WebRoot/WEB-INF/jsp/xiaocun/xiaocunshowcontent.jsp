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
       	
	<link rel="stylesheet" href="https://cdn.bootcss.com/jquery-weui/1.2.0/css/jquery-weui.min.css">
    <link rel="stylesheet" type="text/css" href="static/new/css/base.css">
    <link rel="stylesheet" type="text/css" href="static/simditor-2.3.13/assets/styles/font-awesome.css" >  
    <link rel="stylesheet" type="text/css" href="static/simditor-2.3.13/assets/styles/simditor.css" >  
      <link rel="stylesheet" type="text/css" href="static/new/css/base.css">
      
	<script type="text/javascript" src="static/simditor-2.3.13/assets/scripts/jquery.min.js"></script>      
	<script type="text/javascript" src="static/simditor-2.3.13/assets/scripts/module.js"></script>  
	<script type="text/javascript" src="static/simditor-2.3.13/assets/scripts/hotkeys.js"></script>  
	<script type="text/javascript" src="static/simditor-2.3.13/assets/scripts/uploader.js"></script>  
	<script type="text/javascript" src="static/simditor-2.3.13/assets/scripts/simditor.js"></script>  

  </head>
  
  <body>
  

	
	<header class="header" id="header" style="background-color:#e64340;position: static;">
<a href="javascript:history.back(-1)" target=_self class="back">返回</a>
</header>
<div style="padding:10px;background-color:#ffffff">
  
  <div style="text-align:left;"><h2 style="font-weight:bold;font-size:22px;margin-top:4px;">${xiaocun.title}</h2></div>
  
     <div>
     <img src="${xiaocun.headimg}" style="width:28px;height:28px;float:left;border-radius:200px">
     <h4 style="margin-left:38px;font-weight:lighter;margin-top:15px;color:#808080;font-size:17px;">
     ${xiaocun.adduname}&nbsp;&nbsp;&nbsp;${xiaocun.adddate }
     </h4>
     </div>
     
     
     <div id="simditor" style="margin-top:10px;">
     ${xiaocun.content}
     </div>
	 
</div>

	<script src="https://cdn.bootcss.com/jquery/1.11.0/jquery.min.js"></script>
	<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/jquery-weui.min.js"></script>


  </body>
</html>
