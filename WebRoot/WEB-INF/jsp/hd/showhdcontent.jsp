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
<link rel="stylesheet" type="text/css" href="static/new/css/video-js.css">

<script src="static/new/videojs/video.min.js"></script>

</head>
  
<body ontouchstart>
  
<header class="header" id="header" style="background-color:#e64340;position: static;">
<a href="javascript:history.back(-1)" target=_self class="back">返回</a>
</header>


		<div class="weui-form-preview">
	      <div class="weui-form-preview__hd">
	      <img alt="" src="${hd.hdpic}" >
	      
	        <div class="weui-form-preview__item">
	          <h1>${hd.hdtitle}</h1>
	        </div>
	        
	      </div>
	      <div class="weui-form-preview__bd">
	      
	      <div class="weui-form-preview__item">
	          <label class="weui-form-preview__label">活动简介</label>
	          <span class="weui-form-preview__value">${hd.hdsum}</span>
	        </div>
	        <br>
	        <div class="weui-form-preview__item">
	          <label class="weui-form-preview__label">活动类型</label>
	          <span class="weui-form-preview__value">${hd.hdtype}</span>
	        </div>
	        <br>
	        <div class="weui-form-preview__item">
	          <label class="weui-form-preview__label">活动地点</label>
	          <span class="weui-form-preview__value">${hd.hdloc}</span>
	        </div>
	        <br>
	        <div class="weui-form-preview__item">
	          <label class="weui-form-preview__label">活动人数</label>
	          <span class="weui-form-preview__value">${hd.hdnum}</span>
	        </div>
	        <br>
	        <div class="weui-form-preview__item">
	          <label class="weui-form-preview__label">活动开始时间</label>
	          <span class="weui-form-preview__value">${hd.hdbtime}</span>
	        </div>
	        <br>
	        <div class="weui-form-preview__item">
	          <label class="weui-form-preview__label">活动结束时间</label>
	          <span class="weui-form-preview__value">${hd.hdbtime}</span>
	        </div>
	        <br>
	        <div class="weui-form-preview__item">
	          <label class="weui-form-preview__label">活动发起时间</label>
	          <span class="weui-form-preview__value">${hd.hdbtime}</span>
	        </div>
	        <br>
	        <div class="weui-form-preview__item">
	          <label class="weui-form-preview__label">活动发起人</label>
	          <span class="weui-form-preview__value">${hd.uid}</span>
	        </div>
	        
	      </div>
	      
	    </div>


	<script src="https://cdn.bootcss.com/jquery/1.11.0/jquery.min.js"></script>
	<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/jquery-weui.min.js"></script>
	<script src="static/jqweui/swiper.js" charset='utf-8'></script>
  </body>
</html>
