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
<link rel="stylesheet" type="text/css" href="static/login/css/headmain.css"/><!-- 分页-->
<script src="https://cdn.bootcss.com/jquery/1.11.0/jquery.min.js"></script>

</head>
  
<body ontouchstart>

  <input type="hidden" value="${pd.length }" id="length">
  <input type="hidden" value="${pd.grouptype }" id="type">
  
  <header class="header" id="header" style="background-color:#e64340;position: static;">
<a href="<%=basePath%>partygroup/showgroup" target=_self class="back">返回</a>
<h1>组别:${pd.grouptype}</h1>
</header>

	 <article class="weui-article" style="margin:0px" >
    <c:choose>
    <c:when test="${not empty typelist}">
    <c:forEach items="${typelist}" var="typelist" varStatus="vs1"> 
    
 	
  		<div class="weui-panel weui-panel_access" >
			<div class="weui-panel__bd">
				<input type="hidden" value="${vs1.index+1}">
				<a class="weui-media-box weui-media-box_appmsg" onclick="showfilecontent('${typelist.pid}')">
			      <div class="weui-media-box__bd">
			        <h4 style="font-size:20px">${typelist.uname}</h4>
			        <p class="weui-media-box__desc" >${typelist.address}</p>
			      </div>
			    </a> 
		 	</div>
		</div>
			 
			 
  </c:forEach>

<!-- 	<br>
	<br>
	<div class="weui-footer">
	  <p class="weui-footer__text">Copyright © 2008-2016 张超 袁枭云</p>
	</div>  -->
	
	<nav id="nav_page"  >
	    <a id="MainContent_uPre" class="leftpage" onclick="onpage('${pd.type}')">〈上一页</a>
	    <span>${pd.one}/${pd.total} 页</span>
	    <a id="MainContent_uNext" class="rightpage" onclick="nextpage('${pd.type}')">下一页〉</a>
	  </nav>

  </c:when>
  <c:otherwise>
	<div><h2 style="color:#008080;text-align:center;">暂无文件</h2></div>
	</c:otherwise>
  </c:choose>
  
   </article>


<script src="https://cdn.bootcss.com/jquery/1.11.0/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/jquery-weui.min.js"></script>

<script type="text/javascript">S

var length=$("#length").val();
var type=$("#type").val();

function showfilecontent(pid){
		window.location.href="<%=basePath%>partygroup/groupinfo.do?pid="+pid;
	}
	
function onpage(type){
var page=${pd.one}-1;
if(page==0){
$.toptip('这是第一页', 1000, 'success');
}
else{
window.location.href="<%=basePath%>partygroup/typecontent?type="+type+"&begin="+(length*page-length)+"&length="+length+"&tip="+"onpage";
}
}

function nextpage(type){
var page=${pd.one};
var pagetotal=${pd.total};
if(page>=pagetotal){
$.toptip('已经是最后一页了', 1000, 'success');
}
else{
window.location.href="<%=basePath%>partygroup/typecontent?type="+type+"&begin="+(length*page)+"&length="+length+"&tip="+"nextpage";
}
}



</script>



 </body>
</html>

