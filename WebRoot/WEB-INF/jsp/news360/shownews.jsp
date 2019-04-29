<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html style="font-size:8px;">
<!DOCTYPE HTML>
<head>
	<title>${pd.SYSNAME}</title>
	<base href="<%=basePath%>">
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
	<meta name="description" content="">
	<link rel="stylesheet" href="https://cdn.bootcss.com/weui/1.1.2/style/weui.min.css">
	<link rel="stylesheet" href="https://cdn.bootcss.com/jquery-weui/1.2.0/css/jquery-weui.min.css">
	<script src="https://cdn.bootcss.com/jquery/1.11.0/jquery.min.js"></script>
	<link rel="stylesheet" href="http://cdn.amazeui.org/amazeui/2.7.2/css/amazeui.css">
	<script src="http://cdn.amazeui.org/amazeui/2.7.2/js/amazeui.js"></script>
	<script src="http://cdn.amazeui.org/amazeui/2.7.2/js/amazeui.ie8polyfill.js"></script>
	<script src="http://cdn.amazeui.org/amazeui/2.7.2/js/amazeui.widgets.helper.js"></script>
	<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/jquery-weui.min.js"></script>
	<script src="static/source/js/swiper.min.js"></script>
	<link rel="stylesheet" type="text/css" href="static/login/css/headmain.css"/><!-- 分页-->
</head>

<!-- 开始内容 -->
<body>

<!-- 页头 -->
	<header data-am-widget="header" class="am-header am-header-default">
      <div class="am-header-left am-header-nav">
          <a href="<%=basePath%>mainindex" class="">
                <i class="am-header-icon am-icon-reply"></i>
          </a>
      </div>
      
       <span class="am-header-title">测试</span>
  	</header>
  	
<!-- 页面内容 -->
<div class="weui-cells" >

<!-- JSTL库 -->
  <c:choose>
  
  <c:when test="${not empty Api360News}">
    <c:forEach items="${Api360News}" var="newsall" varStatus="vs"> 
    
      <p>${newsall.title}</p>
      <p>${newsall.publishDate}</p>
      <p>${newsall.commentCount}</p>

    </c:forEach>


  </c:when>

    <c:otherwise>
      <div><h2 style="color:#008080;text-align:center;">暂无</h2></div>
    </c:otherwise>
  </c:choose>
</div>

<script src="https://cdn.bootcss.com/jquery/1.11.0/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/jquery-weui.min.js"></script>


<script type="text/javascript">

 
</script>			

 </body>
</html>

