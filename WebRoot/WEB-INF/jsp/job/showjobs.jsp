<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html style="font-size:8px;">
<!DOCTYPE HTML>
<head>
  <title>${pd.SYSNAME}</title>
  <base href="<%=basePath%>">
  <meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
		<meta name="description" content="">
	<link rel="stylesheet" href="https://cdn.bootcss.com/weui/1.1.2/style/weui.min.css">
	<link rel="stylesheet" href="https://cdn.bootcss.com/jquery-weui/1.2.0/css/jquery-weui.min.css">

<script src="https://cdn.bootcss.com/jquery/1.11.0/jquery.min.js"></script>



<link rel="stylesheet" href="http://cdn.amazeui.org/amazeui/2.7.2/css/amazeui.css">
<script src="http://cdn.amazeui.org/amazeui/2.7.2/js/amazeui.js"></script>
<script src="http://cdn.amazeui.org/amazeui/2.7.2/js/amazeui.ie8polyfill.js"></script>
<script src="http://cdn.amazeui.org/amazeui/2.7.2/js/amazeui.widgets.helper.js"></script>

<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/jquery-weui.min.js"></script>


<script src="static/source/js/swiper.min.js"></script>
	 
	
<link rel="stylesheet" type="text/css" href="static/login/css/headmain.css"/><!-- 分页-->
  </head>

<!-- 开始内容 -->
<body>
<input type="hidden" value="${pd.pagelength}" id="length">

<!-- 页头 -->
	
	<header data-am-widget="header" class="am-header am-header-default">
      <div class="am-header-left am-header-nav">
          <a href="<%=basePath%>mainindex" class="">
                <i class="am-header-icon am-icon-reply"></i>
          </a>
             
      </div>
      
       <span class="am-header-title">
               招聘列表
              </span>
      
         
  </header>
	

<!-- 搜索 -->
<!-- <div class="weui-search-bar" id="searchBar">
      <form class="weui-search-bar__form" id="sub">
        <div class="weui-search-bar__box">
          <i class="weui-icon-search"></i>
          <input type="search" class="weui-search-bar__input" id="searchInput" 
          			placeholder="输入职位或职位类型" required="" onkeydown="if(event.keyCode==13){sousuo();}">
          <input type="text" style="display:none">
          <a href="javascript:" class="weui-icon-clear" id="searchClear"></a>
        </div>
        <label class="weui-search-bar__label" id="searchText" style="transform-origin: 0px 0px 0px; opacity: 1; transform: scale(1, 1);">
          <i class="weui-icon-search"></i>
          <span>搜索</span>
        </label>
      </form>
      <a href="javascript:" class="weui-search-bar__cancel-btn" id="searchCancel">取消</a>
    </div> -->

		<!-- 页面内容 -->
<div class="weui-cells" >

<!-- JSTL库 -->
  <c:choose>
  
  <c:when test="${not empty joblistall}">
    <c:forEach items="${joblistall}" var="joball" varStatus="vs"> 

      <a class="weui-cell weui-cell_access" onclick="showjob('${joball.jid}')">

      <input type="hidden" value="${vs.index+1}">
      <input type="hidden" value="${joball.remark}">

      <div class="weui-cell__bd">
      <p style="font-weight:bold;font-style:oblique;">${joball.position}</p>
      </div>

      <div class="weui-cell__ft">${joball.phone}</div>

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


<script type="text/javascript">

 var length=$("#length").val();

	function showjob(jid){
		window.location.href="<%=basePath%>jobs/showcontent?jid="+jid;
	}

  // 当前页面
  function onpage(remark){
  var page=${pd.one}-1;
  var remark=${pd.remark};
  if(page==0){
  $.toptip('这是第一页', 1000, 'warning');
  }
  else{
  window.location.href="<%=basePath%>jobs/showjobs.do?remark="+remark+"&begin="+(length*page-length)+"&length="+length+"&tip="+"onpage";
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
  window.location.href="<%=basePath%>jobs/showjobs.do?remark="+remark+"&begin="+(length*page)+"&length="+length+"&tip="+"nextpage";
  }
  }
</script>			

 </body>
</html>

