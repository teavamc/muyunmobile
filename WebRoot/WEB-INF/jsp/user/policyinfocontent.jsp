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
<link rel="stylesheet" href="https://cdn.bootcss.com/weui/1.1.2/style/weui.min.css">
<link rel="stylesheet" href="https://cdn.bootcss.com/jquery-weui/1.2.0/css/jquery-weui.min.css">
	 <link rel="stylesheet" type="text/css" href="static/new/css/base.css">
  </head>
  
  <body >


  <header class="header" id="header" style="background-color:#e64340;position:relative;z-index:100">
<a href="javascript:history.back(-1)" target=_self class="back">返回</a>
<h1>${poinfo.type}</h1>
</header>

  <div style="text-align:left;"><h2 style="font-weight:bold;font-size:22px;margin-top:4px;">${poinfo.title}</h2></div>
     <div><h4 style="margin-left:52px;font-weight:lighter;margin-top:3px;color:#808080;font-size:17px;">${poinfo.reldate}</h4></div>
     <div style="white-space:normal;margin-top:6px;font-size:18px;margin-left:5px;">${poinfo.content}</div>
    
    <script type="text/javascript">

	</script>	

  </body>
</html>
