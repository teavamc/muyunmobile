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
	      <img alt="" src="${zhiban.zbpic}" >
	      
	        <div class="weui-form-preview__item">
	          <h1>党员姓名：${zhiban.pname}</h1>
	        </div>
	        
	      </div>
	      
	      <div class="weui-form-preview__bd">
	      
	      <div class="weui-form-preview__item">
	          <label class="weui-form-preview__label">个人简介</label>
	          <span class="weui-form-preview__value">${zhiban.zbsum}</span>
	        </div>
	        
	        <div class="weui-form-preview__item">
	          <label class="weui-form-preview__label">党员职务</label>
	          <span class="weui-form-preview__value">${zhiban.position}</span>
	        </div>
	        
	        <div class="weui-form-preview__item">
	          <label class="weui-form-preview__label">值班日期</label>
	          <span class="weui-form-preview__value">${zhiban.zbdate}</span>
	        </div>
	       
	       <div class="weui-form-preview__item">
	          <label class="weui-form-preview__label">值班口号</label>
	          <span class="weui-form-preview__value">${zhiban.zbwords}</span>
	        </div>
	        
	        <div class="weui-form-preview__item">
	          <label class="weui-form-preview__label">值班次数</label>
	          <span class="weui-form-preview__value"> 32 </span>
	        </div>
	        
	      </div>
	      
	    </div>


	<script src="https://cdn.bootcss.com/jquery/1.11.0/jquery.min.js"></script>
	<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/jquery-weui.min.js"></script>
	<script src="static/jqweui/swiper.js" charset='utf-8'></script>
  </body>
</html>
