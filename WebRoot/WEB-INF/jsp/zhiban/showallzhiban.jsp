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
<link rel="stylesheet" href="https://cdn.bootcss.com/weui/1.1.2/style/weui.min.css">
<link rel="stylesheet" href="https://cdn.bootcss.com/jquery-weui/1.2.0/css/jquery-weui.min.css">


</head>
<body>

<form action="" method="post" name="registerForm"  id="registerForm"></form>

<header class="header" id="header" style="background-color:#e64340;position:relative;z-index:100">
	<a href="<%=basePath%>partymember/partyzhuanqu.do" target=_self class="back">返回</a>
	<h1>今日党员</h1>
</header>
		
	<div class="weui-search-bar" id="searchBar">
      <form class="weui-search-bar__form" action="#">
        <div class="weui-search-bar__box">
          <i class="weui-icon-search"></i>
          <input type="search" class="weui-search-bar__input" id="searchInputZhiban" placeholder="搜索" required="">
          <a href="javascript:" class="weui-icon-clear" id="searchClear"></a>
        </div>
        <label class="weui-search-bar__label" id="searchText" style="transform-origin: 0px 0px 0px; opacity: 1; transform: scale(1, 1);">
          <i class="weui-icon-search"></i>
          <span>搜索</span>
        </label>
      </form>
      <a href="javascript:" class="weui-search-bar__cancel-btn" id="searchCancel">取消</a>
    </div>


<c:choose>
	<c:when test="${not empty getnowzhiban}">
		<article class="weui-article">
		<div class="weui-panel"  style="margin-top:0px;" onclick="showzbid('${getnowzhiban.zbid}')" >

			<img alt="" src="${getnowzhiban.zbpic}"   style="height:300px;width:300px"  >
					<div class="weui-cell">
				        <div class="weui-cell__hd">
				            <img alt="" src="static\zhiban\showall\zbdy.png" style="height:27px;width:80px" >
				        </div>
				        <div class="weui-cell__bd ">
				            <h5 ><strong>${getnowzhiban.pname}</strong></h5>
				        </div>
				    </div>
				    <div class="weui-cell">
				        <div class="weui-cell__hd">
				            <img alt="" src="static\zhiban\showall\dyzw.png" style="height:27px;width:80px" >
				        </div>
				        <div class="weui-cell__bd ">
				            <h4 >${getnowzhiban.position}</h4>
				        </div>
				    </div>
				    <div class="weui-cell">
				        <div class="weui-cell__hd">
				            <img alt="" src="static\zhiban\showall\dyjj.png" style="height:27px;width:80px" >
				        </div>
				        <div class="weui-cell__bd ">
				            <h4 >${getnowzhiban.zbsum}</h4>
				        </div>
				    </div>
				    <div class="weui-cell">
				        <div class="weui-cell__hd">
				            <img alt="" src="static\zhiban\showall\fwkh.png" style="height:27px;width:80px" >
				        </div>
				        <div class="weui-cell__bd ">
				            <h4 >${getnowzhiban.zbwords}</h4>
				        </div>
				    </div>
					<div class="weui-cell">
				        <div class="weui-cell__hd">
				            <img alt="" src="static\zhiban\showall\zhibanshijian.png" style="height:27px;width:80px" >
				        </div>
				        <div class="weui-cell__bd ">
				            <h4 >${getnowzhiban.zbdate}</h4>
				        </div>
				    </div>
	  		</div>
		</article>
	</c:when>
	<c:otherwise>
		<div><h2 style="color:#008080;text-align:center;">暂无值班信息</h2></div>
	</c:otherwise>
</c:choose>



<script src="https://cdn.bootcss.com/jquery/1.11.0/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/jquery-weui.min.js"></script>

<!-- 如果使用了某些拓展插件还需要额外的JS -->
<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/swiper.min.js"></script>
<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/city-picker.min.js"></script>

	
	<script>
      $("#searchInputZhiban").calendar({
        value: ['2016-12-12'],
        dateFormat: 'yyyy年mm月dd日'  // 自定义格式的时候，不能通过 input 的value属性赋值 '2016年12月12日' 来定义初始值，这样会导致无法解析初始值而报错。只能通过js中设置 value 的形式来赋值，并且需要按标准形式赋值（yyyy-mm-dd 或者时间戳)
      });
    </script>
	
	<script>
	function showzbid(zbid){
		window.location.href="<%=basePath%>zhiban/showzbcontent?zbid="+zbid;
	}
	</script>
	
</body>
</html>