<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html style="font-size:8px;">
<head>
<meta charset="utf-8"/>
<title>${pd.SYSNAME}</title>
<base href="<%=basePath%>">
  <meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
		<meta name="description" content="">


   <link rel="stylesheet" href="https://cdn.bootcss.com/weui/1.1.2/style/weui.min.css">

<script src="https://cdn.bootcss.com/jquery/1.11.0/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/jquery-weui.min.js"></script>
<link rel="stylesheet" href="https://cdn.bootcss.com/jquery-weui/1.2.0/css/jquery-weui.min.css">
<link rel="stylesheet" href="http://cdn.amazeui.org/amazeui/2.7.2/css/amazeui.css">
<script src="http://cdn.amazeui.org/amazeui/2.7.2/js/amazeui.js"></script>
<script src="http://cdn.amazeui.org/amazeui/2.7.2/js/amazeui.ie8polyfill.js"></script>
<script src="http://cdn.amazeui.org/amazeui/2.7.2/js/amazeui.widgets.helper.js"></script>


	  <script type="text/javascript" src="static/jqweui/yuqingjquery.qqFace.js"></script><!-- 表情js -->
	  

</head>
<body>

<header data-am-widget="header" class="am-header am-header-default">
      <div class="am-header-left am-header-nav">
          <a href="javascript:history.back(-1)" class="">
                <i class="am-header-icon am-icon-reply"></i>
          </a>
      </div>
<h1 class="am-header-title">
          <a  class="" style="margin-right:1.0rem;">评论内容</a>
      </h1>
  </header>


        <div class="weui-panel" style="margin-top:0px;">
        <div class="weui-panel__bd">
        <div class="weui-media-box weui-media-box_appmsg">
            <div class="weui-media-box__hd" style="height:40px;margin-right:0px;">
              <img class="weui-media-box__thumb" style="border-radius:200px;height:40px;width:40px"    src="${yqcon.headimg}">
              </div>
            <div class="weui-media-box__bd">
              <h4 class="weui-media-box__title" style="color:red;">${yqcon.uname}</h4>
              <p class="weui-media-box__desc">${yqcon.datetime}</p>
            </div>
           
</div>
        <div class="weui-media-box weui-media-box_appmsg">
        <div class="weui-media-box__bd">
            <p id="mycomemoji" style="font-size:15px;">${yqcon.yqccontent}</p>
          </div>
             </div> 
        </div>
      </div>

 


	<script src="https://cdn.bootcss.com/jquery/1.11.0/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/jquery-weui.min.js"></script>

<!-- 如果使用了某些拓展插件还需要额外的JS -->
<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/swiper.min.js"></script>
<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/city-picker.min.js"></script>
	<script type="text/javascript">
	$(document).ready(function(){
		$("#mycomemoji").html(replace_em($("#mycomemoji").text())); //解析表情
	});
	
	</script>
	<script type="text/javascript">
	function replace_em(str){
					str = str.replace(/\</g,'&lt;');
					str = str.replace(/\>/g,'&gt;');
					str = str.replace(/\n/g,'<br/>');
					str = str.replace(/\[em_([0-9]*)\]/g,'<img src="static/jqweui/emoji/$1.gif" style="height:25px;width:25px;display:inline;" border="0" />');
					return str;
					}
</script>
	



</body>
</html>