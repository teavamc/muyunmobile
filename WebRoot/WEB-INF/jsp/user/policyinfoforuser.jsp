<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html style="font-size:23.4375px;">
<head>
<meta charset="utf-8"/>
<title>${pd.SYSNAME}</title>
<base href="<%=basePath%>">
  <meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
		<meta name="description" content="">

  
   <link rel="stylesheet" type="text/css" href="static/new/css/base.css">
<script src="static/source/js/jquery.js"></script>
<script src="static/source/js/swiper.min.js"></script>
	 <link rel="stylesheet" href="//res.wx.qq.com/open/libs/weui/1.1.0/weui.min.css"/>
	   <style>
	 .tab_proList{padding:1% 3% 0 3%;overflow:hidden;background:white;margin:0;}
.tab_proList dt{padding:.1rem 0;height:35px;display:box;display:-webkit-box;display:-moz-box;border-bottom:1px #d2d2d2 solid;}
.tab_proList dt a{display:block;box-flex:1;-webkit-box-flex:1;-moz-box-flex:1;border-right:1px #d2d2d2 solid;text-align:center;}
.tab_proList dt a:last-child{border:none;}
.tab_proList dt .currStyle{color:#ff7d00;}
.tab_proList dd{margin:.23rem 0;}
.tab_proList dd li{overflow:hidden;border-bottom:1px #f1f1f1 dotted;padding:.15rem 0;}
.tab_proList dd li:last-child{margin:0;}
	 </style>
<script>
$(document).ready(function(){
	var mySwiper = new Swiper('#slide',{
		  autoplay:5000,
		  visibilityFullFit : true,
		  loop:true,
		  pagination : '.pagination',
	  });
	//product list:Tab
	$(".tab_proList dd").eq(0).show().siblings(".tab_proList dd").hide();
	$(".tab_proList dt a").eq(0).addClass("currStyle");
	$(".tab_proList dt a").click(function(){
	var liindex = $(".tab_proList dt a").index(this);
	$(this).addClass("currStyle").siblings().removeClass("currStyle");
	$(".tab_proList dd").eq(liindex).fadeIn(150).siblings(".tab_proList dd").hide();
	});

});
</script>
</head>
<body>
<input type="hidden" value="${pd.pagelength }" id="length">

		<header class="header" id="header" style="background-color:#e64340;position:relative;">
<a href="<%=basePath%>mainindex" target=_self class="back">返回</a>
<h1>公告与政策</h1>
</header>
		


<!--Tab:productList-->
<dl class="tab_proList">
 <dt style="font-size:20px;color:#06c1ae;">
  <a>公&nbsp;&nbsp;&nbsp;告</a>
  <a>政&nbsp;&nbsp;&nbsp;策</a>
 </dt>
 
 <dd>
 
 
<div class="weui-cells" style="background-color:#EAEAEA;">
    <c:choose>
    <c:when test="${not empty policyinfolist1}">
    <c:forEach items="${policyinfolist1}" var="policyinfo1" varStatus="vs1"> 
  <a class="weui-cell weui-cell_access" onclick="showpolicy('${policyinfo1.poinid}')">
  <input type="hidden" value="${vs1.index+1}">
  <input type="hidden" value="${policyinfo1.type}">
    <div class="weui-cell__bd">
      <p style="font-weight:bold;font-style:oblique;">${policyinfo1.title}</p>
    </div>
    <div class="weui-cell__ft">
    ${policyinfo1.reldate}
    </div>
  </a>
  </c:forEach>
  <div class="weui-form-preview">
<div class="weui-form-preview__ft">
<button type="submit" class="weui-form-preview__btn weui-form-preview__btn_primary" onclick="showall('公告')">
<span style="color:red;font-weight:bold;border-bottom:1px solid;">查看更多</span></button>
</div>
</div>
  </c:when>
  <c:otherwise>
	<div><h2 style="color:#008080;text-align:center;">暂无公告</h2></div>
	</c:otherwise>
  </c:choose>
</div>


 </dd>
 
 <dd>
 
 
   <div class="weui-cells" style="background-color:#EAEAEA;">
    <c:choose>
    <c:when test="${not empty policyinfolist2}">
    <c:forEach items="${policyinfolist2}" var="policyinfo2" varStatus="vs2"> 
  <a class="weui-cell weui-cell_access" onclick="showpolicy('${policyinfo2.poinid}')">
  <input type="hidden" value="${policyinfo2.type}">
    <div class="weui-cell__bd">
      <p style="font-weight:bold;">${vs2.index+1}：${policyinfo2.title}</p>
    </div>
    <div class="weui-cell__ft">
    ${policyinfo2.reldate}
    </div>
  </a>
  </c:forEach>
  
  <div class="weui-form-preview">
<div class="weui-form-preview__ft">
<button type="submit" class="weui-form-preview__btn weui-form-preview__btn_primary" onclick="showall('政策')">
<span style="color:red;font-weight:bold;border-bottom:1px solid;">查看更多</span></button>
</div>
</div>

  </c:when>
  <c:otherwise>
	<div><h2 style="color:#008080;text-align:center;">暂无政策</h2></div>
	</c:otherwise>
  </c:choose>
</div>


 </dd>
 
</dl>

  <script type="text/javascript">
  var length=$("#length").val();
  
	function showpolicy(poinid){
		window.location.href="<%=basePath%>policyinfo/policyinfocontent.do?poinid="+poinid;
	}
	
	function showall(type){
	window.location.href="<%=basePath%>policyinfo/policyinfolist.do?type="+type+"&begin="+0+"&length="+length+"&tip="+"firstpage";
	
	}
	
	</script>

</body>
</html>