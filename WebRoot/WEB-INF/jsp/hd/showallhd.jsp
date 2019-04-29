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
	<a href="<%=basePath%>partymember/partyzhuanqu.do" target=_self class="back">返回</a><h1>党员活动</h1>
	<img onclick="writehd(${h.hdid})" style="display:inline;height:30px;width:30px;margin:8px 8px;" src="static/images/writecom.png">
</header>
<script type="text/javascript">

	function writehd(hdid){
		window.location.href="<%=basePath%>hd/hdinsert?hdid="+hdid;
	}
</script>

<c:choose>
	<c:when test="${not empty hd}">
	
		<c:forEach items="${hd}" var="h" varStatus="vs"> 
		<article class="weui-article">
		<div class="weui-panel"  style="margin-top:0px;" onclick="showhdid('${h.hdid}')" >
			<div class="weui-form-preview">
	      <div class="weui-form-preview__hd">
	      <img alt="" src="${h.hdpic}" style="height:142px;width:345px" >
	        <div class="weui-form-preview__item">
	          <h1>${h.hdtitle}</h1>
	        </div>
	        
	      </div>
	      <div class="weui-form-preview__bd">
	      
	        <div class="weui-form-preview__item">
	          <label class="weui-form-preview__label">活动类型</label>
	          <span class="weui-form-preview__value">${h.hdtype}</span>
	        </div>
	        <div class="weui-form-preview__item">
	          <label class="weui-form-preview__label">活动地点</label>
	          <span class="weui-form-preview__value">${h.hdloc}</span>
	        </div>
	        <div class="weui-form-preview__item">
	          <label class="weui-form-preview__label">活动人数</label>
	          <span class="weui-form-preview__value">${h.hdnum}</span>
	        </div>
	        <div class="weui-form-preview__item">
	          <label class="weui-form-preview__label">活动时间</label>
	          <span class="weui-form-preview__value">${h.hdbtime}</span>
	        </div>
	        
	      </div>
	      
	    </div>
		</div>
		 </article>
		
		
		</c:forEach>
		
	</c:when>
	<c:otherwise>
		<div><h2 style="color:#008080;text-align:center;">暂无</h2></div>
	</c:otherwise>
	
</c:choose>


<div class="list"></div>
<div class="weui-loadmore">
	<i class="weui-loading"></i> 
	<span class="weui-loadmore__tips">正在加载</span>
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
	function showhdid(hdid){
		window.location.href="<%=basePath%>hd/showhdcontent?hdid="+hdid;
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
				url: "<%=basePath%>hd/showhdmore.do",
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
				$(".list").append("<article class=\"weui-article\"><div class=\"weui-panel\" style=\"margin-top:0px;\" onclick=\"showhdid('"+d.hdid1+"')\" ><div class=\"weui-form-preview\"><div class=\"weui-form-preview__hd\"><img alt=\"\" src=\""+d.hdpic1+"\" style=\"height:142px;width:345px\" ><div class=\"weui-form-preview__item\"><h1>"+d.hdtitle1+"</h1></div></div><div class=\"weui-form-preview__bd\"><div class=\"weui-form-preview__item\"><label class=\"weui-form-preview__label\">活动类型</label><span class=\"weui-form-preview__value\">"+d.hdtype1+"</span></div><div class=\"weui-form-preview__item\"><label class=\"weui-form-preview__label\">活动地点</label><span class=\"weui-form-preview__value\">"+d.hdloc1+"</span></div><div class=\"weui-form-preview__item\"><label class=\"weui-form-preview__label\">活动人数</label><span class=\"weui-form-preview__value\">"+d.hdnum1+"</span></div><div class=\"weui-form-preview__item\"><label class=\"weui-form-preview__label\">活动时间</label><span class=\"weui-form-preview__value\">"+d.hdbtime1+"</span></div></div></div></div></article>");
				
				loading = false;
				tip++;
				}
				else if(d.success=="2"){   //共有二个数据
				$(".list").append("<article class=\"weui-article\"><div class=\"weui-panel\" style=\"margin-top:0px;\" onclick=\"showhdid('"+d.hdid1+"')\" ><div class=\"weui-form-preview\"><div class=\"weui-form-preview__hd\"><img alt=\"\" src=\""+d.hdpic1+"\" style=\"height:142px;width:345px\" ><div class=\"weui-form-preview__item\"><h1>"+d.hdtitle1+"</h1></div></div><div class=\"weui-form-preview__bd\"><div class=\"weui-form-preview__item\"><label class=\"weui-form-preview__label\">活动类型</label><span class=\"weui-form-preview__value\">"+d.hdtype1+"</span></div><div class=\"weui-form-preview__item\"><label class=\"weui-form-preview__label\">活动地点</label><span class=\"weui-form-preview__value\">"+d.hdloc1+"</span></div><div class=\"weui-form-preview__item\"><label class=\"weui-form-preview__label\">活动人数</label><span class=\"weui-form-preview__value\">"+d.hdnum1+"</span></div><div class=\"weui-form-preview__item\"><label class=\"weui-form-preview__label\">活动时间</label><span class=\"weui-form-preview__value\">"+d.hdbtime1+"</span></div></div></div></div></article>");
				$(".list").append("<article class=\"weui-article\"><div class=\"weui-panel\" style=\"margin-top:0px;\" onclick=\"showhdid('"+d.hdid2+"')\" ><div class=\"weui-form-preview\"><div class=\"weui-form-preview__hd\"><img alt=\"\" src=\""+d.hdpic2+"\" style=\"height:142px;width:345px\" ><div class=\"weui-form-preview__item\"><h1>"+d.hdtitle2+"</h1></div></div><div class=\"weui-form-preview__bd\"><div class=\"weui-form-preview__item\"><label class=\"weui-form-preview__label\">活动类型</label><span class=\"weui-form-preview__value\">"+d.hdtype2+"</span></div><div class=\"weui-form-preview__item\"><label class=\"weui-form-preview__label\">活动地点</label><span class=\"weui-form-preview__value\">"+d.hdloc2+"</span></div><div class=\"weui-form-preview__item\"><label class=\"weui-form-preview__label\">活动人数</label><span class=\"weui-form-preview__value\">"+d.hdnum2+"</span></div><div class=\"weui-form-preview__item\"><label class=\"weui-form-preview__label\">活动时间</label><span class=\"weui-form-preview__value\">"+d.hdbtime2+"</span></div></div></div></div></article>");
				
				loading = false;
// 				window.location.reload();
				tip++;
	  				}
	  				else{$.toast("出现错误", "cancel");}
				}
			});
	});

</script>
	

</body>
</html>