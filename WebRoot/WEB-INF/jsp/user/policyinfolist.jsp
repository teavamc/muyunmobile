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
	 
	
<link rel="stylesheet" type="text/css" href="static/login/css/headmain.css"/><!-- 分页-->
<link rel="stylesheet" type="text/css" href="static/new/css/base.css"><!-- header-->

  </head>
  
  <body style="background-color:beige;">
  <input type="hidden" value="${pd.pagelength }" id="length">

<header class="header" id="header" style="background-color:#e64340;position:relative;z-index:100">
<a href="<%=basePath%>policyinfo/showpolicyforuser" target=_self class="back">返回</a>
<h1>${pd.type }</h1>
</header>


<div class="weui-search-bar" id="searchBar">
      <form class="weui-search-bar__form" id="sub">
        <div class="weui-search-bar__box">
          <i class="weui-icon-search"></i>
          <input type="search" class="weui-search-bar__input" id="searchInput" 
          			placeholder="搜索" required="" onkeydown="if(event.keyCode==13){sousuo();}">
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

		
  <div class="weui-cells" style="background-color:beige;">
    <c:choose>
    <c:when test="${not empty policyinfolistall}">
    <c:forEach items="${policyinfolistall}" var="policyinfoall" varStatus="vs1"> 
  <a class="weui-cell weui-cell_access" onclick="showpolicy('${policyinfoall.poinid}')">
  <input type="hidden" value="${vs1.index+1}">
    <div class="weui-cell__bd">
      <p style="font-weight:bold;font-style:oblique;">${policyinfoall.title}</p>
    </div>
    <div class="weui-cell__ft">
    ${policyinfoall.reldate}
    </div>
  </a>
  </c:forEach>

  <nav id="nav_page">
        <a id="MainContent_uPre" class="leftpage" onclick="onpage('${pd.type}')">〈上一页</a>
        <span>${pd.one}/${pd.total } 页</span>
        <a id="MainContent_uNext" class="rightpage" onclick="nextpage('${pd.type}')">下一页〉</a>
    </nav>
  </c:when>
  <c:otherwise>
	<div><h2 style="color:#008080;text-align:center;">暂无公告</h2></div>
	</c:otherwise>
  </c:choose>
</div>

	<script src="https://cdn.bootcss.com/jquery/1.11.0/jquery.min.js"></script>
	<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/jquery-weui.min.js"></script>	

<script type="text/javascript">
var length=$("#length").val();
function showpolicy(poinid){
		window.location.href="<%=basePath%>policyinfo/policyinfocontent.do?poinid="+poinid;
	}
function sousuo(){
var searchInput=$.trim($("#searchInput").val());
if(searchInput!=""){
window.location.href="<%=basePath%>policyinfo/policyinfolistsearch.do?searchInput="+searchInput+"&begin="+0+"&length="+length+"&tip="+"firstpage";

}
else{
$.toptip('搜索内容不能为空', 2000, 'success');
$("#searchInput").focus();
}
}

function onpage(type){
var page=${pd.one}-1;
if(page==0){
$.toptip('这是第一页', 1000, 'success');
}
else{
window.location.href="<%=basePath%>policyinfo/policyinfolist.do?type="+type+"&begin="+(length*page-length)+"&length="+length+"&tip="+"onpage";
}
}
function nextpage(type){
var page=${pd.one};
var pagetotal=${pd.total};
if(page>=pagetotal){
$.toptip('已经是最后一页了', 1000, 'success');
}
else{
window.location.href="<%=basePath%>policyinfo/policyinfolist.do?type="+type+"&begin="+(length*page)+"&length="+length+"&tip="+"nextpage";
}
}

</script>
  </body>
</html>
