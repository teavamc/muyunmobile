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

		<header class="header" id="header" style="background-color:#e64340;position:relative;z-index:100">
<a href="<%=basePath%>mainindex" target=_self class="back">返回</a>
<h1>小村家事</h1>
</header>
		
		<div class="button_sp_area" style="height:40px;text-align:right">
		 <a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_disabled weui-btn_warn" style="margin-right:25px;border-radius:5px;">全部文章</a>
        <a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_warn" style="margin-right:25px;border-radius:5px;">我的文章</a>
        <a href="<%=basePath%>xiaocun/xiaocuninsert" class="weui-btn weui-btn_mini weui-btn_disabled weui-btn_warn"style="margin-right:25px;border-radius:5px;">发表文章</a>
      </div>




    <c:choose>
    <c:when test="${not empty xiaocun}">
    <c:forEach items="${xiaocun}" var="xiaocun" varStatus="vs"> 
        <div class="weui-panel" onclick="showyqid('${xiaocun.jsid}')">
        <div class="weui-panel__bd">
        <div class="weui-media-box weui-media-box_appmsg" >
            <div class="weui-media-box__hd" style="height:40px;margin-right:0px;">
              <img class="weui-media-box__thumb" style="border-radius:200px;height:40px;width:40px"    src="${xiaocun.headimg}">
              </div>
            <div class="weui-media-box__bd">
              <h4 class="weui-media-box__title" style="color:red;">${xiaocun.adduname}</h4>
              <p class="weui-media-box__desc">${xiaocun.adddate}</p>
            </div>
          </div>
        <div class="weui-media-box weui-media-box_appmsg" >
        <div class="weui-media-box__bd">
             <h4 class="weui-media-box__title" style="margin-top:-10px;margin-bottom:10px">${xiaocun.title}</h4>
            <p class="weui-media-box__desc" style="font-size:15px;">${xiaocun.content}</p>
          </div>
             </div> 
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

	<script src="https://cdn.bootcss.com/jquery/1.11.0/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/jquery-weui.min.js"></script>

<!-- 如果使用了某些拓展插件还需要额外的JS -->
<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/swiper.min.js"></script>
<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/city-picker.min.js"></script>
	<script>
	function showyqid(jsid){
		window.location.href="<%=basePath%>xiaocun/xiaocunshowcontent?jsid="+jsid;
	}
	</script>
	<script type="text/javascript">
		$(document).ready(function(){

	var firstfeednum=${firstfeednum};
	if(firstfeednum<innerHeight/120){//隐藏加载
	$(".weui-loadmore").hide();
	}else{//出现加载
	}
	});
  var loading = false;  //状态标记
var length=${pd.length}+"";
  var tip=1;
$(document.body).infinite().on("infinite", function() {
  if(loading) return;
  loading = true;
	  $.ajax({  
					type: "POST",
					url: "<%=basePath%>xiaocun/showxiaocunmore.do",
			    	data:  "tip="+tip+"&length="+length,
					dataType:'json',
					cache: false,
					success: function(d){
					if(d.stop=="stop"){
					$(document.body).destroyInfinite();
					$("#more").css("display","block");
					$(".weui-loadmore").hide();
					}
					else if(d.success=="1"){					
					$(".list").append("<div class=\"weui-panel\" onclick=\"showyqid('"+d.jsid1+"')\"><div class=\"weui-panel__bd\"><div class=\"weui-media-box weui-media-box_appmsg\" ><div class=\"weui-media-box__hd\" style=\"height:40px;margin-right:0px;\"><img class=\"weui-media-box__thumb\" style=\"border-radius:200px;height:40px;width:40px\" src=\""+d.headimg1+"\"></div><div class=\"weui-media-box__bd\"><h4 class=\"weui-media-box__title\" style=\"color:red;\">"+d.adduname1+"</h4><p class=\"weui-media-box__desc\">"+d.adddate1+"</p></div></div><div class=\"weui-media-box weui-media-box_appmsg\"><div class=\"weui-media-box__bd\"><h4 class=\"weui-media-box__title\" style=\"margin-top:-10px;margin-bottom:10px\">"+d.title1+"</h4><p class=\"weui-media-box__desc\" style=\"font-size:15px;\">"+d.content1+"</p></div></div></div></div>");
					loading = false;
					tip++;
					}
					else if(d.success=="2"){   //共有二个数据
					$(".list").append("<div class=\"weui-panel\" onclick=\"showyqid('"+d.jsid1+"')\"><div class=\"weui-panel__bd\"><div class=\"weui-media-box weui-media-box_appmsg\" ><div class=\"weui-media-box__hd\" style=\"height:40px;margin-right:0px;\"><img class=\"weui-media-box__thumb\" style=\"border-radius:200px;height:40px;width:40px\" src=\""+d.headimg1+"\"></div><div class=\"weui-media-box__bd\"><h4 class=\"weui-media-box__title\" style=\"color:red;\">"+d.adduname1+"</h4><p class=\"weui-media-box__desc\">"+d.adddate1+"</p></div></div><div class=\"weui-media-box weui-media-box_appmsg\"><div class=\"weui-media-box__bd\"><h4 class=\"weui-media-box__title\" style=\"margin-top:-10px;margin-bottom:10px\">"+d.title1+"</h4><p class=\"weui-media-box__desc\" style=\"font-size:15px;\">"+d.content1+"</p></div></div></div></div>");
					$(".list").append("<div class=\"weui-panel\" onclick=\"showyqid('"+d.jsid2+"')\"><div class=\"weui-panel__bd\"><div class=\"weui-media-box weui-media-box_appmsg\" ><div class=\"weui-media-box__hd\" style=\"height:40px;margin-right:0px;\"><img class=\"weui-media-box__thumb\" style=\"border-radius:200px;height:40px;width:40px\" src=\""+d.headimg2+"\"></div><div class=\"weui-media-box__bd\"><h4 class=\"weui-media-box__title\" style=\"color:red;\">"+d.adduname2+"</h4><p class=\"weui-media-box__desc\">"+d.adddate2+"</p></div></div><div class=\"weui-media-box weui-media-box_appmsg\"><div class=\"weui-media-box__bd\"><h4 class=\"weui-media-box__title\" style=\"margin-top:-10px;margin-bottom:10px\">"+d.title2+"</h4><p class=\"weui-media-box__desc\" style=\"font-size:15px;\">"+d.content2+"</p></div></div></div></div>");
					loading = false;
					tip++;
    				}
    				else{$.toast("出现错误", "cancel");}
					}
				});
});

</script>	

<script type="text/javascript">
function showfeed(fbid){
window.location.href="<%=basePath%>feedback/feedshowcontent?fbid="+fbid;
}
</script>

</body>
</html>