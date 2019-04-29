<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en" style="font-size: 10px;">

<head>
<title>${pd.SYSNAME}</title>
<base href="<%=basePath%>">
<meta charset="UTF-8" />
<meta name="renderer" content="webkit">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<link rel="stylesheet" href="https://cdn.bootcss.com/weui/1.1.2/style/weui.min.css"><!-- weui-css -->
<link rel="stylesheet" href="https://cdn.bootcss.com/jquery-weui/1.2.0/css/jquery-weui.min.css"><!-- weui-js-css -->
<link rel="stylesheet" href="http://cdn.amazeui.org/amazeui/2.7.2/css/amazeui.css"><!-- zmazeui-->
<link rel="stylesheet" type="text/css" href="static/login/css/headmain.css"/><!-- 分页-->
<script src="https://cdn.bootcss.com/jquery/1.11.0/jquery.min.js"></script><!-- jquery-->
<script src="http://cdn.amazeui.org/amazeui/2.7.2/js/amazeui.js"></script><!-- zmazeui-->
<script src="http://cdn.amazeui.org/amazeui/2.7.2/js/amazeui.ie8polyfill.js"></script><!-- zmazeui-->
<script src="http://cdn.amazeui.org/amazeui/2.7.2/js/amazeui.widgets.helper.js"></script><!-- zmazeui-->
<script src="static/source/js/swiper.min.js"></script><!-- 通栏-->
<script type="text/javascript" src="static/jqweui/jquery.qqFace.js"></script><!-- 留言表情-->


</style>
 <style type="text/css">
  </style>
</head>
<body ontouchstart="">

 <div class="weui-toptips weui-toptips_warn" id="toptip">错误提示</div>

<header data-am-widget="header" class="am-header am-header-default">
      <div class="am-header-left am-header-nav">
          <a href="<%=basePath%>mainindex" class="">
                <i class="am-header-icon am-icon-reply"></i>
          </a>
      </div>
        <h1 class="am-header-title">
          <a class="">投诉或咨询</a>
      </h1>
  </header>

	
	
<div class="page home">
<div class="page__hd" style="padding-top:10px;padding-left:40px;">
<h2 class="page__title" ></h2>
</div>
<div class="page__bd" >

<div class="weui-btn-area" id="main" style="display:block;margin-top:0px;" >
  
  <a onclick="showallfeed('1')"><img src="static/new/images/new/ts1.png" style="background-size:contain|cover;width:100%;height: auto;"  alt=""/></a>
 
  <a onclick="showallfeed('0')" style="margin-top:10px;"><img src="static/new/images/new/ts2.png" style="background-size:contain|cover;width:100%;height: auto;"  alt=""/></a>
  
  <a onclick="zixun()" style="margin-top:10px;" ><img src="static/new/images/new/ts3.png" style="background-size:contain|cover;width:100%;height: auto;"  alt=""/></a>
  
  <a onclick="tousu()"style="margin-top:10px;" ><img src="static/new/images/new/ts4.png"  style="background-size:contain|cover;width:100%;height: auto;" alt=""/></a>
  
  </div>

</div>


</div>

<!-- </div> -->

	<script type="text/javascript">
	function showallfeed(read){
window.location.href="<%=basePath%>feedback/showallfeed?isread="+read;
}

function tousu(){
window.location.href="<%=basePath%>feedback/feedinsert?ftype="+"投诉";
}
function zixun(){
window.location.href="<%=basePath%>feedback/feedinsert?ftype="+"咨询";
}
        
        //toptips
        var $tooltips = $("#toptip");
        function showtopTips(content){
            if ($tooltips.css("display") != "none") return;

            // toptips的fixed, 如果有`animation`, `position: fixed`不生效
            $(".page.cell").removeClass("slideIn");

            $tooltips.css("display", "block");
            $tooltips.html(content );
            setTimeout(function () {
                $tooltips.css("display", "none");
            }, 2000);
        }
 

	</script>
	<script>
	</script>
	<script src="static/js/jquery-1.7.2.js"></script>
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript" src="static/js/jquery.cookie.js"></script>
</body>

</html>