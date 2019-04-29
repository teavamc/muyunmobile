<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html lang="zh-CN" style="font-size: 8px;">
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

   <link rel="stylesheet" href="https://cdn.bootcss.com/weui/1.1.2/style/weui.min.css">

<script src="https://cdn.bootcss.com/jquery/1.11.0/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/jquery-weui.min.js"></script>
<link rel="stylesheet" href="https://cdn.bootcss.com/jquery-weui/1.2.0/css/jquery-weui.min.css">
<link rel="stylesheet" href="http://cdn.amazeui.org/amazeui/2.7.2/css/amazeui.css">
<script src="http://cdn.amazeui.org/amazeui/2.7.2/js/amazeui.js"></script>
<script src="http://cdn.amazeui.org/amazeui/2.7.2/js/amazeui.ie8polyfill.js"></script>
<script src="http://cdn.amazeui.org/amazeui/2.7.2/js/amazeui.widgets.helper.js"></script>

<script src="static/source/js/swiper.min.js"></script>

</head>

<!-- 开始内容 -->
<body>
<input type="hidden" value="${pd.pagelength }" id="length">

<!-- 页头 -->

<header data-am-widget="header" class="am-header am-header-default">
      <div class="am-header-left am-header-nav">
          <a href="<%=basePath%>mainindex" class="">
                <i class="am-header-icon am-icon-reply"></i>
          </a>
      </div>
<h1 class="am-header-title">
          <a  class="" style="margin-right:1.0rem;">服务指南</a>
      </h1>
  </header>



<div class="weui-cells" style="margin-top:0px;" >
	<a  style="margin-top:0px;" ><img src="static/new/images/new/fw1.png" style="background-size:contain|cover;width:100%;height: auto;"  alt=""/></a>
    
    <c:choose>
    <c:when test="${not empty showguide}">
    <c:forEach items="${showguide}" var="sg" varStatus="vs"> 
    
	  <a class="weui-cell weui-cell_access" onclick="showguide('${sg.guid}')" style="margin-top:0px;">
	  <input type="hidden" value="${vs.index+1}">
	  <input type="hidden" value="${sg.remark}">
	    <div class="weui-panel__bd">
	          <div class="weui-media-box weui-media-box_text">
	            <h4 class="weui-media-box__title">${sg.guname}</h4>
	            <p class="weui-media-box__desc">${sg.gutype}</p>
	            <ul class="weui-media-box__info">
	              <li class="weui-media-box__info__meta">发布日期：${sg.pushdate} </li>
	            </ul>
	          </div>
	        </div>
	  </a>
  
  </c:forEach>
  <div class="weui-form-preview">
<div class="weui-form-preview__ft">
<button type="submit" class="weui-form-preview__btn weui-form-preview__btn_primary" onclick="showallguide(1)">
<span style="color:red;font-weight:bold;border-bottom:1px solid;">查看更多</span></button>
</div>
</div>
  </c:when>
  <c:otherwise>
	<div><h2 style="color:#008080;text-align:center;">暂无指南</h2></div>
	</c:otherwise>
  </c:choose>
</div>



  <script type="text/javascript">
  var length=$("#length").val();
  
	function showguide(guid){
		window.location.href="<%=basePath%>guide/showallguide.do?guid="+guid;
	}
	
	function showallguide(remark){
	window.location.href="<%=basePath%>guide/guidelist.do?remark="+remark+"&begin="+0+"&length="+length+"&tip="+"firstpage";
	
	}
	
	</script>

</body>
</html>