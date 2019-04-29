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
              <p>${filecontent.filename}</p>
            </div>
          </div>
          
          <div class="weui-cell">
            <div class="weui-cell__bd">
              <p>下载量</p>
            </div>
            <div class="weui-cell__ft">${filecontent.downloadnum}次</div>
          </div>
          <div class="weui-cell">
            <div class="weui-cell__bd">
              <p>点赞数</p>
            </div>
            <div class="weui-cell__ft">${filecontent.zan}次</div>
          </div>
          <div class="weui-cell">
            <div class="weui-cell__bd">
              <p>上传时间</p>
            </div>
            <div class="weui-cell__ft">${filecontent.uploaddate}</div>
          </div>
          <div class="weui-cell">
            <div class="weui-cell__bd">
              <p>上传人</p>
            </div>
            <div class="weui-cell__ft">${filecontent.uname}</div>
          </div>
          <div class="weui-cell">
            <div class="weui-cell__bd">
              <p>上传大小</p>
            </div>
            <div class="weui-cell__ft">${filecontent.filesize}M</div>
          </div>
          
    </div>
    
       <a href="FileManager/filedownload?filename=${filecontent.filename}" class="weui-btn weui-btn_primary" style="margin:20px">下载该文件</a>
  </body>
</html>
