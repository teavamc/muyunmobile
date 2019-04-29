<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html style="font-size:10px;">
<head>
<meta charset="utf-8"/>
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

 <header data-am-widget="header" class="am-header am-header-default">
      <div class="am-header-left am-header-nav">
          <a href="javascript:history.back(-1)" class="">
                <i class="am-header-icon am-icon-reply"></i>
          </a>
      </div>
        <h1 class="am-header-title" >投诉咨询</h1>
  </header>

		<input type="hidden" value="${pd.ftype }" id="ftype">
<div class="button_sp_area" style="height:40px;text-align:right">
		 <a href="<%=basePath%>feedback/editallfeed?ftype=咨询" id="a1" class="weui-btn weui-btn_mini weui-btn_warn" style="margin-right:90px;border-radius:5px;">回复咨询</a>
        <a href="<%=basePath%>feedback/editallfeed?ftype=投诉" id="a2" class="weui-btn weui-btn_mini weui-btn_disabled weui-btn_warn" style="margin-right:55px;border-radius:5px;">回复投诉</a>
          </div>



    <c:choose>
    <c:when test="${not empty feed1}">
    <c:forEach items="${feed1}" var="feedtousu" varStatus="vs"> 

     <div class="weui-cells" onclick="showfeed('${feedtousu.fbid}')">
          <div class="weui-cell " >
            <div class="weui-cell__bd">
              <div class="weui-cell">
                <div class="weui-cell__bd">
                <p><span style="color:red;">${feedtousu.ftype }：</span>${feedtousu.title}</p>
                </div>
                <div class="weui-cell__ft">${feedtousu.fbdatetime}</div>
              </div>
            </div>
          </div>
        </div>

  </c:forEach>

  </c:when>
  <c:otherwise>
  <div style="height:30px;"></div>
	<div><h2 style="color:#008080;text-align:center;font-size:25px">暂无</h2></div>
	</c:otherwise>
  </c:choose>


	<div class="list"></div>
	
	<div class="weui-loadmore">
		<i class="weui-loading"></i> <span class="weui-loadmore__tips">正在加载</span>
	</div>
	
	<div id="more" style="display:none;text-align:center;">
		<span style="color:#808080;">没有更多内容了</span>
	</div>

	<script src="https://cdn.bootcss.com/jquery/1.11.0/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/jquery-weui.min.js"></script>

<!-- 如果使用了某些拓展插件还需要额外的JS -->
<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/swiper.min.js"></script>
<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/city-picker.min.js"></script>
	<script>
	$(document).ready(function(){
	var ftype=$("#ftype").val();
	if(ftype=="投诉"){
	$("#a1").attr("class","weui-btn weui-btn_mini weui-btn_disabled weui-btn_warn");
	$("#a2").attr("class","weui-btn weui-btn_mini weui-btn_warn");
	}

	var firstfeednum=${firstfeednum};
	if(firstfeednum<innerHeight/65){//隐藏加载
	$(".weui-loadmore").hide();
	}else{//出现加载
	}
	})
	</script>
	<script type="text/javascript">
  var loading = false;  //状态标记
var length=${pd.length}+"";
var ftype=$("#ftype").val();
  var tip=1;
$(document.body).infinite().on("infinite", function() {
  if(loading) return;
  loading = true;
	  $.ajax({  
					type: "POST",
					url: "<%=basePath%>feedback/showfeedmore2.do",
			    	data:  "tip="+tip+"&length="+length+"&ftype="+ftype,
					dataType:'json',
					cache: false,
					success: function(d){
					if(d.stop=="stop"){
					$(document.body).destroyInfinite();
					$("#more").css("display","block");
					$(".weui-loadmore").hide();
					}
					else if(d.success=="1"){					
					$(".list").append("<div class=\"weui-cells\" onclick=\"showfeed('"+d.fbid1+"')\"><div class=\"weui-cell \" ><div class=\"weui-cell__bd\" ><div class=\"weui-cell\"><div class=\"weui-cell__bd\"><p><span style=\"color:red;\">"+d.ftype1+"：</span>"+d.title1+"</p></div><div class=\"weui-cell__ft\">"+d.fbdatetime1+"</div></div></div><div class=\"weui-cell__ft\" ></div></div></div>");
					loading = false;
					tip++;
					}
					else if(d.success=="2"){   //共有二个数据
					$(".list").append("<div class=\"weui-cells\" onclick=\"showfeed('"+d.fbid1+"')\"><div class=\"weui-cell \" ><div class=\"weui-cell__bd\" ><div class=\"weui-cell\"> <div class=\"weui-cell__bd\"> <p> <span style=\"color:red;\">"+d.ftype1+"：</span>"+d.title1+"</p> </div><div class=\"weui-cell__ft\">"+d.fbdatetime1+"</div> </div></div> <div class=\"weui-cell__ft\" ></div> </div></div>");
					$(".list").append("<div class=\"weui-cells\" onclick=\"showfeed('"+d.fbid2+"')\"><div class=\"weui-cell \" ><div class=\"weui-cell__bd\" ><div class=\"weui-cell\"> <div class=\"weui-cell__bd\"> <p> <span style=\"color:red;\">"+d.ftype2+"：</span>"+d.title2+"</p> </div><div class=\"weui-cell__ft\">"+d.fbdatetime2+"</div> </div></div> <div class=\"weui-cell__ft\" ></div> </div></div>");
					loading = false;
					tip++;
    				}
    				else{alert("未知错误！");}
					}
				});
});

</script>	

<script type="text/javascript">
function showfeed(fbid){
window.location.href="<%=basePath%>feedback/editfeedcontent?fbid="+fbid;
}
</script>

</body>
</html>