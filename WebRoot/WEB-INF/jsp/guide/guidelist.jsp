<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<head>
  <title>${pd.SYSNAME}</title>
  <base href="<%=basePath%>">
  <meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
		<meta name="description" content="">
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
  </head>
  
  <body>
  <input type="hidden" value="${pd.pagelength }" id="length">

	
	<header data-am-widget="header" class="am-header am-header-default">
      <div class="am-header-left am-header-nav">
          <a href="<%=basePath%>mainindex" class="">
                <i class="am-header-icon am-icon-reply"></i>
          </a>
      </div>
          <span class="am-header-title" style="font-size:23px;">
              办事指南
              </span>
  </header>


<div class="weui-search-bar" id="searchBar">
      <form class="weui-search-bar__form" id="sub">
        <div class="weui-search-bar__box">
          <i class="weui-icon-search"></i>
          <input type="search" class="weui-search-bar__input" id="searchInput" 
          			placeholder="输入类型或标题" required="" onkeydown="if(event.keyCode==13){sousuo();}">
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


<div class="weui-cells" >

<!-- JSTL库 -->
  <c:choose>
  
  <c:when test="${not empty getguide}">
    <c:forEach items="${getguide}" var="gg" varStatus="vs"> 
      <a class="weui-cell weui-cell_access" onclick="showguid('${gg.guid}')">
      
      <input type="hidden" value="${vs.index+1}">
      
      <input type="hidden" value="${gg.remark}">
      <div class="weui-cell__bd">
      <p style="font-weight:bold;font-style:oblique;">${gg.guname}</p>
      </div>
      <div class="weui-cell__ft">${gg.pushdate}</div>
      </a>
    </c:forEach>
    <nav id="nav_page">
        <a id="MainContent_uPre" class="leftpage" onclick="onpage('${pd.remark}')">〈上一页</a>
        <span>${pd.one}/${pd.total } 页</span>
        <a id="MainContent_uNext" class="rightpage" onclick="nextpage('${pd.remark}')">下一页〉</a>
    </nav>
  </c:when>
    <c:otherwise>
      <div><h2 style="color:#008080;text-align:center;">暂无</h2></div>
    </c:otherwise>
  </c:choose>
</div>

	<script src="https://cdn.bootcss.com/jquery/1.11.0/jquery.min.js"></script>
	<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/jquery-weui.min.js"></script>	

	<script>
	 var length=$("#length").val();
	
	function sousuo(){
		var searchInput=$.trim($("#searchInput").val());
		if(searchInput!=""){
		window.location.href="<%=basePath%>guide/showallguide.do?searchInput="+searchInput+"&length="+${pd.length}+"&tip="+searchInput;
		
		}
		else{
		$.toptip('搜索内容不能为空', 2000, 'warning');
		$("#searchInput").focus();
		}
		}
		
	function showguid(guid){
		window.location.href="<%=basePath%>guide/showallguide?guid="+guid;
	}
	
	// 当前页面
	  function onpage(remark){
	  var page=${pd.one}-1;
	  var remark=${pd.remark};
	  if(page==0){
	  $.toptip('这是第一页', 1000, 'warning');
	  }
	  else{
	  window.location.href="<%=basePath%>guide/guidelist.do?remark="+remark+"&begin="+(length*page-length)+"&length="+length+"&tip="+"onpage";
	  }
	  }

  // 下一页
	  function nextpage(remark){
	  var page=${pd.one};
	  var remark=${pd.remark};
	  var pagetotal=${pd.total};
	  if(page>=pagetotal){
	  $.toptip('已经是最后一页了', 1000, 'warning');
	  }
	  else{
	  window.location.href="<%=basePath%>guide/guidelist.do?remark="+remark+"&begin="+(length*page)+"&length="+length+"&tip="+"nextpage";
	  }
	  }

	</script>
	
  </body>
</html>
