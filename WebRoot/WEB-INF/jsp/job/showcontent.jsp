<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
String jid=request.getParameter("jid");  //获得id方便图片展示
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

</head>

<body>
	<header class="header" id="header"
		style="background-color:#e64340;position:relative;z-index:100">
		<a href="javascript:history.go(-1)" target=_self class="back">返回</a>
		<h1>招聘信息</h1>
	</header>
<%-- <img src="<%=basePath%>jobs/showimage?jid=<%=jid%>"  style="height:170px;width:375px;"> --%>


				<div class="weui-form-preview" >
					<div class="weui-form-preview__hd">
						<label class="weui-form-preview__label" style="font-size:18px;">职位类型</label> <em
							class="weui-form-preview__value" style="font-size:19px;">${tbjob.jtype}</em>
					</div>
					<div class="weui-form-preview__hd">
						<label class="weui-form-preview__label" style="font-size:18px;">职位</label> <em
							class="weui-form-preview__value" style="font-size:19px;">${tbjob.position}</em>
					</div>
					<div class="weui-form-preview__bd">
						<div class="weui-form-preview__item" style="font-size:18px;">
							<label class="weui-form-preview__label" >招聘公司</label> <span
								class="weui-form-preview__value" style="font-size:18px;">${tbjob.company }</span>
						</div>
						<div class="weui-form-preview__item">
							<label class="weui-form-preview__label" style="font-size:18px;">招聘人数</label> <span
								class="weui-form-preview__value" style="font-size:18px;">${tbjob.num }</span>
						</div>
						
						<div class="weui-form-preview__item">
							<label class="weui-form-preview__label" style="font-size:18px;">联系方式</label> <span
								class="weui-form-preview__value" style="font-size:18px;">${tbjob.phone }</span>
						</div>
						<div class="weui-form-preview__item">
							<label class="weui-form-preview__label" style="font-size:18px;">电子邮箱</label> <span
								class="weui-form-preview__value" style="font-size:18px;">${tbjob.email }</span>
						</div>
						<div class="weui-form-preview__item">
							<label class="weui-form-preview__label" style="font-size:18px;">公司网址</label> <span
								class="weui-form-preview__value" style="font-size:18px;"><a href="${tbjob.url}">${tbjob.url }</a></span>
						</div>
						<div class="weui-form-preview__item">
							<label class="weui-form-preview__label" style="font-size:18px;">招聘开始</label> <span
								class="weui-form-preview__value" style="font-size:15px;">${tbjob.bedate }</span>
						</div>
						<div class="weui-form-preview__item">
							<label class="weui-form-preview__label" style="font-size:18px;">招聘结束</label> <span
								class="weui-form-preview__value" style="font-size:15px;">${tbjob.endate }</span>
						</div>
						<div class="weui-form-preview__item">
							<label class="weui-form-preview__label" style="font-size:18px;">职位介绍</label> <span
								class="weui-form-preview__value" style="font-size:15px;">${tbjob.introduction }</span>
						</div>
						<div class="weui-form-preview__item">
							<label class="weui-form-preview__label" style="font-size:18px;">招聘内容</label> <span
								class="weui-form-preview__value" style="font-size:15px;">222222222222222222222222222222222222222222222222222222222222222222222222</span>
						</div>
					</div>
				</div>





	<script src="https://cdn.bootcss.com/jquery/1.11.0/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/jquery-weui.min.js"></script>


							
 </body>
</html>

