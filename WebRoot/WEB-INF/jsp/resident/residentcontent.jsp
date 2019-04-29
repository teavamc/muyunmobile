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
       	<link rel="stylesheet"
	href="https://cdn.bootcss.com/weui/1.1.2/style/weui.min.css">
<link rel="stylesheet"
	href="https://cdn.bootcss.com/jquery-weui/1.2.0/css/jquery-weui.min.css">
     <link rel="stylesheet" type="text/css" href="static/new/css/base.css">

  </head>
  
  <body>
  
  
  

	
	<header class="header" id="header" style="background-color:#e64340;position: static;">
<a href="javascript:history.back(-1)" target=_self class="back">返回</a>
<h1>${resident.name }</h1>
</header>



<div class="weui-cells weui-cells_form" style="margin-top:0px;">
    <div class="weui-cell">
        <div class="weui-cell__hd">
            <label class="weui-label" style="color:#808080">居民姓名</label>
        </div>
        <div class="weui-cell__bd ">
            <input name="gname" id="gname" class="weui-input" type="text" readonly="readonly" value="${resident.name }">
        </div>
    </div>
    
     <div class="weui-cell">
        <div class="weui-cell__hd">
            <label class="weui-label" style="color:#808080">所在组</label>
        </div>
        <div class="weui-cell__bd ">
            <input name="uname" id="uname" class="weui-input" type="text" value="${resident.grouptype }" readonly="readonly">
        </div>
    </div>
    
     <div class="weui-cell">
        <div class="weui-cell__hd">
            <label class="weui-label" style="color:#808080">民族</label>
        </div>
        <div class="weui-cell__bd ">
            <input name="uname" id="uname" class="weui-input" type="text" value="${resident.nation }" readonly="readonly">
        </div>
    </div>
    
    <div class="weui-cell">
        <div class="weui-cell__hd">
            <label class="weui-label" style="color:#808080">性别</label>
        </div>
        <div class="weui-cell__bd ">
            <input name="uname" id="uname" class="weui-input" type="text" value="${resident.sex }" readonly="readonly">
        </div>
    </div>
    
      <div class="weui-cell">
        <div class="weui-cell__hd">
            <label class="weui-label" style="color:#808080">手机号码（一）</label>
        </div>
        <div class="weui-cell__bd ">
            <input name="number" id="number" class="weui-input" type="text" value="${resident.phone1 }" readonly="readonly">
        </div>
    </div>
    
    <div class="weui-cell">
        <div class="weui-cell__hd">
            <label class="weui-label" style="color:#808080">手机号码（二）</label>
        </div>
        <div class="weui-cell__bd ">
            <input name="number" id="number" class="weui-input" type="text" value="${resident.phone2 }" readonly="readonly">
        </div>
    </div>
    
    <div class="weui-cell">
        <div class="weui-cell__hd">
            <label class="weui-label" style="color:#808080">住址</label>
        </div>
        <div class="weui-cell__bd ">
            <input name="people" id="people" class="weui-input" type="text" value="${resident.address }" readonly="readonly">
        </div>
    </div>
    
    <div class="weui-cell">
        <div class="weui-cell__hd">
            <label class="weui-label" style="color:#808080">职业</label>
        </div>
        <div class="weui-cell__bd ">
            <input name="people" id="people" class="weui-input" type="text" value="${resident.jod }" readonly="readonly">
        </div>
    </div>
    
     <div class="weui-cell">
        <div class="weui-cell__hd">
            <label class="weui-label" style="color:#808080">工作地点</label>
        </div>
        <div class="weui-cell__bd ">
            <input name="people" id="people" class="weui-input" type="text" value="${resident.workplace }" readonly="readonly">
        </div>
    </div>
    
     <div class="weui-cell">
        <div class="weui-cell__hd">
            <label class="weui-label" style="color:#808080">收入</label>
        </div>
        <div class="weui-cell__bd ">
            <input name="people" id="people" class="weui-input" type="text" value="${resident.income }" readonly="readonly">
        </div>
    </div>
    
    
     <div class="weui-cell">
        <div class="weui-cell__hd">
            <label class="weui-label" style="color:#808080">其他</label>
        </div>
        <div class="weui-cell__bd ">
            <input name="people" id="people" class="weui-input" type="text" value="其他" readonly="readonly">
        </div>
    </div>
    
     <div class="weui-cell">
        <div class="weui-cell__hd">
            <label class="weui-label" style="color:#808080">其他</label>
        </div>
        <div class="weui-cell__bd ">
            <input name="people" id="people" class="weui-input" type="text" value="其他" readonly="readonly">
        </div>
    </div>
    </div>
    

   

	
	
	<script src="https://cdn.bootcss.com/jquery/1.11.0/jquery.min.js"></script>
	<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/jquery-weui.min.js"></script>


  </body>
</html>
