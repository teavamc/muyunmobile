<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
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

<input type="hidden" value="${pd.searchtip }" id="searchtip">
	
	<header class="header" id="header"
		style="background-color:#e64340;position:relative;">
		<a href="javascript:history.back(-1)" target=_self class="back">返回</a>
		<h1>村民信息</h1>
	</header>
	
	

<div class="weui-search-bar" id="searchBar">
      
      <form class="weui-search-bar__form" id="sub">
        <div class="weui-search-bar__box">
          <i class="weui-icon-search"></i>
          
          <input type="search" class="weui-search-bar__input" id="searchInput" placeholder="姓名/组别/性别/身份证" required="" onkeydown="if(event.keyCode==13){sousuo();}">
          <input type="text" style="display:none">
          
          <a href="javascript:" class="weui-icon-clear" id="searchClear"></a>  
        </div>
        
        <label class="weui-search-bar__label" id="searchText" style="transform-origin: 0px 0px 0px; opacity: 1; transform: scale(1, 1);">
          <i class="weui-icon-search"></i>
          <span>搜索</span>
        </label>
        
      </form>
      
      <a href="javascript:" class="weui-search-bar__cancel-btn" id="searchCancel">取消</a>
    </div>
    
    
	<div class="weui-panel weui-panel_access">
		<div class="weui-panel">
		        <div class="weui-panel__bd">
			          <div class="weui-media-box weui-media-box_text">
			            <h4 class="weui-media-box__title" align="center"><strong>数据统计栏</strong></h4>
			             <p class="weui-media-box__desc" align="center">总居民数：${pd.allnumber}人&nbsp&nbsp&nbsp&nbsp男性居民数：${pd.mannumber}人</p>
			            <p class="weui-media-box__desc" align="center">女性居民数：${pd.womannumber}人&nbsp未登记性别数：${pd.unknownsex}人</p>

			          </div>
		        </div>
	      	</div>
	    </div>
	    
	    <div class="weui-panel">
	    
		    <div class="weui-panel__bd">
		    	<div class="weui-media-box weui-media-box_text">
		    
	      			<h4 class="weui-media-box__title" align="center"><strong>选择分组</strong></h4>    
					<div class="button_sp_area" align="center">
					
					<c:choose>
				    <c:when test="${not empty groupmap}">
    				<c:forEach items="${groupmap}" var="groupmap" varStatus="first"> 
				    	<a onclick="groupclass('${groupmap.grouptype}')" class="weui-btn weui-btn_mini weui-btn_default">${groupmap.grouptype}</a>
				    </c:forEach>
				    </c:when>
					<c:otherwise>
						<div>
							<h2 style="color:#008080;text-align:center;">暂无分组信息</h2>
						</div>
					</c:otherwise>
					</c:choose>
					
				    </div>
			     </div>  
	    	</div>
    	</div>
    <div class="container" id="container" style="background-color:#EAEAEA;"
<div class="weui-cells" style="margin-top:0px;">


	<c:choose>
    <c:when test="${not empty resident}">
    <c:forEach items="${resident}" var="resident" varStatus="vs1"> 
    
    
    <div class="weui-form-preview" style="margin-top:10px;">
  <div class="weui-form-preview__hd">
    <label class="weui-form-preview__label">居民姓名</label>
    <em class="weui-form-preview__value">${resident.name}</em>
  </div>
  
  <div class="weui-form-preview__bd">
  
   <div class="weui-form-preview__item">
      <label class="weui-form-preview__label">数据库编号</label>
      <span class="weui-form-preview__value"> ${resident.pid}</span>
    </div>
  
    <div class="weui-form-preview__item">
      <label class="weui-form-preview__label">所在组别</label>
      <span class="weui-form-preview__value"> ${resident.grouptype}</span>
    </div>

    <div class="weui-form-preview__item">
      <label class="weui-form-preview__label">联系方式</label>
      <span class="weui-form-preview__value">${resident.phone1}</span>
    </div>

  </div>
  <div class="weui-form-preview__ft">
    <a class="weui-form-preview__btn weui-form-preview__btn_default" onclick="showresident('${resident.pid}')">查看户籍关系</a>
    <button type="submit" class="weui-form-preview__btn weui-form-preview__btn_primary" onclick="showresident('${resident.pid}')">查看个人信息</button>
  </div>
</div>
    
 
  </c:forEach>

  </c:when>
  <c:otherwise>
	<div><h2 style="color:#008080;text-align:center;">暂无</h2></div>
	</c:otherwise>
  </c:choose>

	<div class="list"></div>
	<div class="weui-loadmore">
		<i class="weui-loading"></i> <span class="weui-loadmore__tips">正在加载</span>
	</div>
	<div id="more" style="display:none;text-align:center;">
		<span style="color:#808080;">没有更多内容了</span>
	</div>
</div>

	<script src="https://cdn.bootcss.com/jquery/1.11.0/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/jquery-weui.min.js"></script>

<!-- 如果使用了某些拓展插件还需要额外的JS -->
<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/swiper.min.js"></script>
<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/city-picker.min.js"></script>

<script>
$(document).ready(function(){
	var firstfeednum=${firstfeednum};
	if(firstfeednum<innerHeight/50){//隐藏加载
	$(".weui-loadmore").hide();
	}else{//出现加载
	}
	})
</script>

<script type="text/javascript">
var loading = false;  //状态标记
var length=${pd.length}+"";
var tip=1;
var searchtip=$("#searchtip").val();   //以此判断是否搜索页面
$(document.body).infinite().on("infinite", function() {
  if(loading) return;
  loading = true;
  $.ajax({  
					type: "POST",
					url: "<%=basePath%>resident/showresidentmore.do",
			    	data:  "tip="+tip+"&length="+length+"&searchtip="+searchtip,
					dataType:'json',
					cache: false,
					success: function(d){
					if(d.stop=="stop"){
					$(document.body).destroyInfinite();
					$("#more").css("display","block");
					$(".weui-loadmore").hide();
					}
					else if(d.success=="1"){
					$(".list").append("<div class=\"weui-form-preview\" style=\"margin-top:10px;\"><div class=\"weui-form-preview__hd\"><label class=\"weui-form-preview__label\">居民姓名</label><em class=\"weui-form-preview__value\">"+d.name1+"</em></div><div class=\"weui-form-preview__bd\"><div class=\"weui-form-preview__item\"><label class=\"weui-form-preview__label\">数据库编号</label><span class=\"weui-form-preview__value\">"+d.pid1+"</span></div><div class=\"weui-form-preview__item\"><label class=\"weui-form-preview__label\">所在组别</label><span class=\"weui-form-preview__value\">"+d.grouptype1+"</span></div><div class=\"weui-form-preview__item\"><label class=\"weui-form-preview__label\">联系方式</label><span class=\"weui-form-preview__value\">"+d.phone11+"</span></div></div><div class=\"weui-form-preview__ft\"><a class=\"weui-form-preview__btn weui-form-preview__btn_default\" onclick=\"showresident('"+d.pid1+"')\">查看户籍关系</a><button type=\"submit\" class=\"weui-form-preview__btn weui-form-preview__btn_primary\" onclick=\"showresident('"+d.pid1+"')\">查看个人信息</button></div></div>");
					loading = false;
					tip++;
					}
					else if(d.success=="2"){   //共有二个数据
					$(".list").append("<div class=\"weui-form-preview\" style=\"margin-top:10px;\"><div class=\"weui-form-preview__hd\"><label class=\"weui-form-preview__label\">居民姓名</label><em class=\"weui-form-preview__value\">"+d.name1+"</em></div><div class=\"weui-form-preview__bd\"><div class=\"weui-form-preview__item\"><label class=\"weui-form-preview__label\">数据库编号</label><span class=\"weui-form-preview__value\">"+d.pid1+"</span></div><div class=\"weui-form-preview__item\"><label class=\"weui-form-preview__label\">所在组别</label><span class=\"weui-form-preview__value\">"+d.grouptype1+"</span></div><div class=\"weui-form-preview__item\"><label class=\"weui-form-preview__label\">联系方式</label><span class=\"weui-form-preview__value\">"+d.phone11+"</span></div></div><div class=\"weui-form-preview__ft\"><a class=\"weui-form-preview__btn weui-form-preview__btn_default\" onclick=\"showresident('"+d.pid1+"')\">查看户籍关系</a><button type=\"submit\" class=\"weui-form-preview__btn weui-form-preview__btn_primary\" onclick=\"showresident('"+d.pid1+"')\">查看个人信息</button></div></div>");
					$(".list").append("<div class=\"weui-form-preview\" style=\"margin-top:10px;\"><div class=\"weui-form-preview__hd\"><label class=\"weui-form-preview__label\">居民姓名</label><em class=\"weui-form-preview__value\">"+d.name2+"</em></div><div class=\"weui-form-preview__bd\"><div class=\"weui-form-preview__item\"><label class=\"weui-form-preview__label\">数据库编号</label><span class=\"weui-form-preview__value\">"+d.pid2+"</span></div><div class=\"weui-form-preview__item\"><label class=\"weui-form-preview__label\">所在组别</label><span class=\"weui-form-preview__value\">"+d.grouptype2+"</span></div><div class=\"weui-form-preview__item\"><label class=\"weui-form-preview__label\">联系方式</label><span class=\"weui-form-preview__value\">"+d.phone12+"</span></div></div><div class=\"weui-form-preview__ft\"><a class=\"weui-form-preview__btn weui-form-preview__btn_default\" onclick=\"showresident('"+d.pid2+"')\">查看户籍关系</a><button type=\"submit\" class=\"weui-form-preview__btn weui-form-preview__btn_primary\" onclick=\"showresident('"+d.pid2+"')\">查看个人信息</button></div></div>");
					loading = false;
					tip++;
    				}
    				else{alert("未知错误！");}
					}
				});
  
  
  
});
</script>
	
	<script type="text/javascript">
function sousuo(){
var searchInput=$.trim($("#searchInput").val());
if(searchInput!=""){
window.location.href="<%=basePath%>resident/residentlist.do?searchInput="+searchInput+"&length="+${pd.length}+"&tip="+searchInput;

}
else{
$.toptip('搜索内容不能为空', 2000, 'success');
$("#searchInput").focus();
}
}

function groupclass(searchInput){
window.location.href="<%=basePath%>resident/residentlist.do?searchInput="+searchInput+"&length="+${pd.length}+"&tip="+searchInput;
}

function showresident(pid){
window.location.href="<%=basePath%>resident/showrescontent?pid="+pid;
}
</script>									
 </body>
</html>

