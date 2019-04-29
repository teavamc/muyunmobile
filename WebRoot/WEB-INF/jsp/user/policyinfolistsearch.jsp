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
	  
<link rel="stylesheet" type="text/css" href="static/login/css/headmain.css"/>
  </head>
  
  <body style="background-color:beige;">

<header class="header" id="header" style="background-color:#e64340;position:relative;z-index:100">
<a href="javascript:history.back(-1)" target=_self class="back">返回</a>
<h1>搜索信息</h1>
</header>

<span style="font-size:15px;">搜索到关于“<span style="color:red;">${pd.searchInput }</span>”的结果共
<span style="color:red;">${pd.totalnum}&nbsp;</span>条：
</span>
		
  <div class="weui-cells" style="background-color:beige;">
    <c:choose>
    <c:when test="${not empty policyinfolistsearch}">
    <c:forEach items="${policyinfolistsearch}" var="policyinfosearch" varStatus="vs1"> 
  <a class="weui-cell weui-cell_access" onclick="showpolicy('${policyinfosearch.poinid}')">
  <input type="hidden" value="${vs1.index+1}">
    <div class="weui-cell__bd">
      <p style="font-weight:bold;font-style:oblique;">${policyinfosearch.type}&nbsp;&nbsp;&nbsp;${policyinfosearch.title}</p>
    </div>
    <div class="weui-cell__ft">
    ${policyinfosearch.reldate}
    </div>
  </a>
  </c:forEach>

  <nav id="nav_page">
        <a id="MainContent_uPre" class="leftpage" onclick="onpage('${pd.searchInput}')">〈上一页</a>
        <span>${pd.one}/${pd.total } 页</span>
        <a id="MainContent_uNext" class="rightpage" onclick="nextpage('${pd.searchInput}')">下一页〉</a>
    </nav>
  </c:when>
  <c:otherwise>
	<div><h2 style="color:#008080;text-align:center;">暂无您想要搜索的结果</h2></div>
	</c:otherwise>
  </c:choose>
</div>
<script src="https://cdn.bootcss.com/jquery/1.11.0/jquery.min.js"></script>
	<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/jquery-weui.min.js"></script>
<script type="text/javascript">
function showpolicy(poinid){
		window.location.href="<%=basePath%>policyinfo/policyinfocontent.do?poinid="+poinid;
	}


function onpage(search){
var page=${pd.one}-1;
if(page==0){
$.toptip('这是第一页', 1000, 'success');
}
else{
window.location.href="<%=basePath%>policyinfo/policyinfolistsearch.do?searchInput="+search+"&begin="+(8*page-8)+"&length="+8+"&tip="+"onpage";
}
}
function nextpage(search){
var page=${pd.one};
var pagetotal=${pd.total};
if(page==pagetotal){
$.toptip('已经是最后一页了', 1000, 'success');
}
else{
window.location.href="<%=basePath%>policyinfo/policyinfolistsearch.do?searchInput="+search+"&begin="+(8*page)+"&length="+8+"&tip="+"nextpage";
}
}

</script>
  </body>
</html>
