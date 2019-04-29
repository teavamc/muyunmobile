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
	
	<header class="header" id="header" style="background-color:#e64340;position:static;z-index:100">
<a href="javascript:history.go(-1)" target=_self class="back">返回</a>
<h1 style="margin-right:1.0rem;">敏感字符管理</h1>
<img onclick="addsen()" style="display:inline;height:30px;width:30px;margin:8px 8px;" src="static/images/writecom.png">
</header>

<!-- <div class="weui-search-bar" id="searchBar">
      <form class="weui-search-bar__form" id="sub">
        <div class="weui-search-bar__box">
          <i class="weui-icon-search"></i>
          <input type="search" class="weui-search-bar__input" id="searchInput" 
          			placeholder="姓名/住址/家庭类别/身份证" required="" onkeydown="if(event.keyCode==13){sousuo();}">
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
    
    
    
    
<div class="weui-cells" style="margin-top:0px;">
	<c:choose>
    <c:when test="${not empty sencol}">
    <c:forEach items="${sencol}" var="sen" varStatus="vs1"> 
  <a class="weui-cell weui-cell_access" >
    <div class="weui-cell__bd">
      <p style="font-weight:bold;font-style:oblique;">${sen.sencollect}</p>
    </div>
    <div  onclick="delsen('${sen.id}')">
    	<img src="static/images/delcircle.png" style="height:18px;width:22px;display:inline">
    </div>
  </a>
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



 <%-- <c:choose>
    <c:when test="${not empty sencol}">
    <c:forEach items="${sencol}" var="sen" varStatus="vs1"> 
     <div class="weui-cells" >
     <input type="hidden" value="${vs.index+1}">
          <div class="weui-cell weui-cell_swiped" >
            <div class="weui-cell__bd" style="transform: translate3d(0px, 0px, 0px);">
              <div class="weui-cell">
                <div class="weui-cell__bd">
                  <p >${sen.sencollect}</p>
                </div>
                <div class="weui-cell__ft">&nbsp;<img src="static/images/leftleft.png" style="height:13px;width:13px;display:Inline;"></div>
              </div>
            </div>
            <div class="weui-cell__ft">
             <a class="weui-swiped-btn weui-swiped-btn_warn close-swipeout" onclick="showsen()">查看</a>
              <a class="weui-swiped-btn weui-swiped-btn_default delete-swipeout" onclick="delsen('${sen.id}')">删除</a>
            </div>
          </div>
        </div>

  </c:forEach>
  
  </c:when>
  <c:otherwise>
	<div><h2 style="color:#008080;text-align:center;">暂无</h2></div>
	</c:otherwise>
  </c:choose> --%>

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
function addsen(){//新增敏感字符
$.prompt({
  title: '新增敏感字符',
  text: '必须少于10个字符，英文大小写敏感',
  input: '',
  empty: false, // 是否允许为空
  onOK: function (input) {
    if(input.length>10){
    	$.toptip('长度必须小于10个字符', 'success');
    }else{
    	$.post("sencol/insertsen",{sencollect:input},function(date){
    	if(date.result=="success"){
    		$.toast("新增成功");
    		history.go(0);
    	}
    })
    }
  },
  onCancel: function () {
    //点击取消
  }
});
  
}

function delsen(id){
	$.confirm("确认删除此敏感字符？", function() {
  		$.post("sencol/delsen",{senid:id},function(date){
    	if(date.result=="success"){
    		$.toast("删除成功");
    		history.go(0);
    	}
    })
  }, function() {
  //点击取消后的回调函数
  });
  }
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
					$(".list").append("<a class=\"weui-cell weui-cell_access\" onclick=\"showresident('"+d.rid1+"')\"><div class=\"weui-cell__bd\"><p style=\"font-weight:bold;font-style:oblique;\">"+d.name1+"</p></div><div class=\"weui-cell__ft\">"+d.phone1+"</div></a>");
					loading = false;
					tip++;
					}
					else if(d.success=="2"){   //共有二个数据
					$(".list").append("<a class=\"weui-cell weui-cell_access\" onclick=\"showresident('"+d.rid1+"')\"><div class=\"weui-cell__bd\"><p style=\"font-weight:bold;font-style:oblique;\">"+d.name1+"</p></div><div class=\"weui-cell__ft\">"+d.phone1+"</div></a>");
					$(".list").append("<a class=\"weui-cell weui-cell_access\" onclick=\"showresident('"+d.rid2+"')\"><div class=\"weui-cell__bd\"><p style=\"font-weight:bold;font-style:oblique;\">"+d.name2+"</p></div><div class=\"weui-cell__ft\">"+d.phone2+"</div></a>");
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
		function showresident(rid){
		window.location.href="<%=basePath%>resident/showrescontent?rid="+rid;
		}
		</script>									
 </body>
</html>

