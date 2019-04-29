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
<input type="hidden"  value="${pd.edit }" id="edit">
<input type="hidden"  value="${pd.isparty }" id="isparty">
<input type="hidden"  value="${pd.searchinfo }" id="searchinfo">
		<header class="header" id="header" style="background-color:#e64340;position:relative;z-index:100">
<a href="javascript:history.go(-1)" target=_self class="back">返回</a>
<h1>舆情上报</h1>
</header>

		 <article class="weui-article" style="margin:0px">
		<a onclick="writecom()" class="weui-btn weui-btn_default">上报舆情</a>
		 </article>
<script type="text/javascript">
	//发表
	function writecom(){
		window.location.href="<%=basePath%>yuqing/yuqinginsert";
	}
</script>	

    <c:choose>
    <c:when test="${not empty yuqing}">
    <c:forEach items="${yuqing}" var="yu" varStatus="vs"> 
        <div class="weui-panel" onclick="showyqid('${yu.yqid}')" style="overflow: visible;" id="tiptodel${yu.yqid}">
        <div class="weui-panel__bd">
          <div class="weui-media-box weui-media-box_text">
            <h4 class="weui-media-box__title" >${yu.yqtype}</h4>
            
            <p class="weui-media-box__desc">${yu.content}</p>
            <ul class="weui-media-box__info">
              <li class="weui-media-box__info__meta">上报时间：${yu.adddate} </li>
            </ul>
          </div> 
      
        </div>
        </div>
		<c:if test="${pd.isparty==1 &&  pd.edit=='toedit'}">
            <img onclick="del('${yu.yqid}')" src="static/images/delcircle.png" style="height:18px;width:22px;display:inline;float:right;right:10px;bottom:65px;position: relative;">
            </c:if>
  </c:forEach>

  </c:when>
  <c:otherwise>
  <div><h2 style="color:#008080;text-align:center;">暂无</h2></div>
	  <div class="weui-form-preview">
<div class="weui-form-preview__ft">
<c:if test="${pd.edit!='toedit'}">
<a type="submit" class="weui-form-preview__btn weui-form-preview__btn_primary" href="<%=basePath%>yuqing/yuqinginsert">
<span style="color:red;font-weight:bold;border-bottom:1px solid;">我要上报</span></a>
</c:if>
</div>
</div>
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
<script type="text/javascript">
	$("#searchInput1").calendar(  {dateFormat: 'yyyy-mm-dd'});
	
$(window).keydown(function(event){
	if(event.keyCode==13){
		var searchInput=$("#searchInput2").val();
		if(searchInput=="" || searchInput==null)
		sousuo('1');
		else
		sousuo('2');
	}
})

var qiehuan="notdate";
function tochange(){
	if(qiehuan=="notdate"){
	$("#searchInput1").css("display","block");
	$("#searchInput2").css("display","none");
	$("#sel").text("取消");
	qiehuan="isdate";
	}else{
	$("#searchInput1").css("display","none");
	$("#searchInput2").css("display","block");
	$("#sel").text("日期搜索");
	qiehuan="notdate";
	}
}
function sousuo(a){
	var edit=$("#edit").val();
	var searchInput=$("#searchInput"+a).val();
	window.location.href="<%=basePath%>yuqing/showallyuqing?searchinfo="+searchInput+"&edit="+edit;
}
</script>
	<script>
	function showyqid(yqid){
		var edit=$("#edit").val();
		window.location.href="<%=basePath%>yuqing/yuqingshowcontent?yqid="+yqid+"&edit="+edit;
	}
	function del(yqid){
	$.confirm("","确认删除？", function() {
		$.post("<%=basePath%>yuqing/yuqingdel",{yqid:yqid},function(date){
			if(date.result=="success")
   			{
   				$.toast("删除成功");
   				history.go(0);
   			}
		})
	}, function() {
 	 //取消
 	 });
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
	var searchinfo=$("#searchinfo").val();
	var isparty=$("#isparty").val();
	var edit=$("#edit").val();
  var loading = false;  //状态标记
var length=${pd.length}+"";
  var tip=1;
$(document.body).infinite().on("infinite", function() {
  if(loading) return;
  loading = true;
	  $.ajax({  
					type: "POST",
					url: "<%=basePath%>yuqing/showyuqingmore.do",
			    	data:  "tip="+tip+"&length="+length+"&searchinfo="+searchinfo,
					dataType:'json',
					cache: false,
					success: function(d){
					if(d.stop=="stop"){
					$(document.body).destroyInfinite();
					$("#more").css("display","block");
					$(".weui-loadmore").hide();
					}
					else if(d.success=="1"){					
					$(".list").append("<div class=\"weui-panel\" onclick=\"showyqid('"+d.yqid1+"')\" style=\"overflow: visible;\" id=\"tiptodel"+d.yqid1+"\"><div class=\"weui-panel__bd\"><div class=\"weui-media-box weui-media-box_text\"><h4 class=\"weui-media-box__title\" >"+d.yqtype1+"</h4><p class=\"weui-media-box__desc\">"+d.content1+"</p> <ul class=\"weui-media-box__info\"><li class=\"weui-media-box__info__meta\">上报时间："+d.adddate1+" </li> </ul> </div></div></div>");
					if(edit=='toedit' && isparty==1)
					$("#tiptodel"+d.yqid1).after("<img onclick=\"del('"+d.yqid1+"')\" src=\"static/images/delcircle.png\" style=\"height:18px;width:22px;display:inline;float:right;right:10px;bottom:65px;position: relative;\">");
					loading = false;
					tip++;
					}
					else if(d.success=="2"){   //共有二个数据
					$(".list").append("<div class=\"weui-panel\" onclick=\"showyqid('"+d.yqid1+"')\" style=\"overflow: visible;\" id=\"tiptodel"+d.yqid1+"\"><div class=\"weui-panel__bd\"><div class=\"weui-media-box weui-media-box_text\"><h4 class=\"weui-media-box__title\" >"+d.yqtype1+"</h4><p class=\"weui-media-box__desc\">"+d.content1+"</p> <ul class=\"weui-media-box__info\"><li class=\"weui-media-box__info__meta\">上报时间："+d.adddate1+" </li> </ul> </div></div></div>");
					$(".list").append("<div class=\"weui-panel\" onclick=\"showyqid('"+d.yqid2+"')\" style=\"overflow: visible;\" id=\"tiptodel"+d.yqid2+"\"><div class=\"weui-panel__bd\"><div class=\"weui-media-box weui-media-box_text\"><h4 class=\"weui-media-box__title\" >"+d.yqtype2+"</h4><p class=\"weui-media-box__desc\">"+d.content2+"</p> <ul class=\"weui-media-box__info\"><li class=\"weui-media-box__info__meta\">上报时间："+d.adddate2+" </li> </ul> </div></div></div>");
					if(edit=='toedit' && isparty==1){
					$("#tiptodel"+d.yqid1).after("<img onclick=\"del('"+d.yqid1+"')\" src=\"static/images/delcircle.png\" style=\"height:18px;width:22px;display:inline;float:right;right:10px;bottom:65px;position: relative;\">");
					$("#tiptodel"+d.yqid2).after("<img onclick=\"del('"+d.yqid2+"')\" src=\"static/images/delcircle.png\" style=\"height:18px;width:22px;display:inline;float:right;right:10px;bottom:65px;position: relative;\">");
					}
					loading = false;
					tip++;
    				}
    				else{$.toast("出现错误", "cancel");}
					}
				});
});

</script>	
	


</body>
</html>