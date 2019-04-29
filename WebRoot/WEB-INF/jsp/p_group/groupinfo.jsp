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

<script src="https://cdn.bootcss.com/jquery/1.11.0/jquery.min.js"></script>


</head>
  
<body ontouchstart>
  
  <header class="header" id="header" style="background-color:#e64340;position: static;">
<a href="javascript:history.back(-1)" target=_self class="back">返回</a>
</header>

    
    <div class="weui-cells">
          
          <div class="weui-cell">
            <div class="weui-cell__bd">
              <h4 style="font-size:20px">${groupcontent.uname}</h4>
            </div>
          </div>
          
          <div class="weui-cell">
            <div class="weui-cell__bd">
              <p>党员小组</p>
            </div>
            <div class="weui-cell__ft">${groupcontent.grouptype}</div>
          </div>
          
          <div class="weui-cell">
            <div class="weui-cell__bd">
              <p>性别</p>
            </div>
            <div class="weui-cell__ft">${groupcontent.sex}</div>
          </div>
          
          <div class="weui-cell">
            <div class="weui-cell__bd">
              <p>民族</p>
            </div>
            <div class="weui-cell__ft">${groupcontent.nations}</div>
          </div>
          
          <div class="weui-cell">
            <div class="weui-cell__bd">
              <p>身份证</p>
            </div>
            <div class="weui-cell__ft">${groupcontent.idcard}</div>
          </div>
          
          <div class="weui-cell">
            <div class="weui-cell__bd">
              <p>手机卡号</p>
            </div>
            <div class="weui-cell__ft">${groupcontent.phone}</div>
          </div>
          
          <div class="weui-cell">
            <div class="weui-cell__bd">
              <p>家庭住址</p>
            </div>
            <div class="weui-cell__ft">${groupcontent.address}</div>
          </div>
          
          <div class="weui-cell">
            <div class="weui-cell__bd">
              <p>学历</p>
            </div>
            <div class="weui-cell__ft">${groupcontent.edulevel}</div>
          </div>
          
          <div class="weui-cell">
            <div class="weui-cell__bd">
              <p>出生日期</p>
            </div>
            <div class="weui-cell__ft">${groupcontent.birthday}</div>
          </div>
          
          <div class="weui-cell">
            <div class="weui-cell__bd">
              <p>入党日期</p>
            </div>
            <div class="weui-cell__ft">${groupcontent.partyjoindate}</div>
          </div>
          
          
    </div>
    
  </body>
</html>
