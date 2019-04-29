<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html style="font-size: 23.4375px;">
<head>
<meta charset="utf-8"/>
<title>${pd.SYSNAME}</title>
<base href="<%=basePath%>">
  <meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
		<meta name="description" content="">

   <link rel="stylesheet" type="text/css" href="static/login/css/headmain.css"/>
   	<link rel="stylesheet" href="https://cdn.bootcss.com/weui/1.1.2/style/weui.min.css">
<link rel="stylesheet" href="https://cdn.bootcss.com/jquery-weui/1.2.0/css/jquery-weui.min.css">
   <link rel="stylesheet" type="text/css" href="static/new/css/base.css">

<script src="static/source/js/jquery.js"></script>
<script src="static/source/js/swiper.min.js"></script>

	  <style>
	 .tab_proList{padding:1% 3% 0 3%;overflow:hidden;background:white;margin:0;}
.tab_proList dt{padding:.1rem 0;height:35px;display:box;display:-webkit-box;display:-moz-box;border-bottom:1px #d2d2d2 solid;}
.tab_proList dt a{display:block;box-flex:1;-webkit-box-flex:1;-moz-box-flex:1;border-right:1px #d2d2d2 solid;text-align:center;}
.tab_proList dt a:last-child{border:none;}
.tab_proList dt .currStyle{color:#ff7d00;}
.tab_proList dd{margin:.23rem 0;}
.tab_proList dd li{overflow:hidden;border-bottom:1px #f1f1f1 dotted;padding:.15rem 0;}
.tab_proList dd li:last-child{margin:0;}
	 </style>

</head>
<body>
<input type="hidden" value="${judgeass}" id="judgeass">
<input type="hidden" value="${pd.pagelength }" id="length">
 

<header class="header" id="header" style="background-color:#e64340;position:relative;z-index:100">
<a href="<%=basePath%>partymember/partyzhuanqu" target=_self class="back">返回</a>
<h1>自评、互评</h1>
</header>


	


<!--Tab:productList-->
<dl class="tab_proList" >
 <dt style="font-size:20px;color:#06c1ae;">
   <a>自&nbsp;&nbsp;&nbsp;评</a>
  <a>我对别人</a>
  <a>别人对我</a>
 </dt>
 
 <dd>
 
 

    <c:choose>
    <c:when test="${not empty tbself}">
    <c:forEach items="${tbself}" var="self" varStatus="vs"> 
     <div class="weui-cells" >
     <input type="hidden" value="${vs.index+1}">
          <div class="weui-cell weui-cell_swiped" >
            <div class="weui-cell__bd" style="transform: translate3d(0px, 0px, 0px);">
              <div class="weui-cell">
                <div class="weui-cell__bd">
                  <p >${self.title}</p>
                </div>
                <div class="weui-cell__ft">${self.sdate}&nbsp;<img src="static/images/leftleft.png" style="height:13px;width:13px;display:Inline;"></div>
              </div>
            </div>
            <div class="weui-cell__ft">
             <a class="weui-swiped-btn weui-swiped-btn_warn close-swipeout" onclick="showpolicy('${self.sfid}','ass1')">查看</a>
              <a class="weui-swiped-btn weui-swiped-btn_default delete-swipeout" onclick="deletepolicy('${self.sfid}','ass1')">删除</a>
            </div>
          </div>
        </div>

  </c:forEach>
  
  
  
  </c:when>
  <c:otherwise>
	<div><h2 style="color:#008080;text-align:center;">暂无</h2></div>
	</c:otherwise>
  </c:choose>
  <div class="weui-form-preview">
<div class="weui-form-preview__ft">
<a type="submit" class="weui-form-preview__btn weui-form-preview__btn_primary" href="<%=basePath%>selfeval/insertassess">
<span style="color:red;font-weight:bold;border-bottom:1px solid;">新增评价</span></a>
</div>
</div>
  <nav id="nav_page">
        <a id="MainContent_uPre" class="leftpage" onclick="onpage('ass1')">〈上一页</a>
        <span>${pd.one1}/${pd.total1 } 页</span>
        <a id="MainContent_uNext" class="rightpage" onclick="nextpage('ass1')">下一页〉</a>
    </nav>



 </dd>
 
 <dd>
 

    <c:choose>
    <c:when test="${not empty tbself1}">
    <c:forEach items="${tbself1}" var="self" varStatus="vs"> 
    
     <div class="weui-cells">
      <input type="hidden" value="${vs.index+1}">
          <div class="weui-cell weui-cell_swiped" >
            <div class="weui-cell__bd" style="transform: translate3d(0px, 0px, 0px);">
              <div class="weui-cell">
                <div class="weui-cell__bd">
                  <p>${self.pname}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${self.title}</p>
                </div>
                <div class="weui-cell__ft">${self.sdate}&nbsp;<img src="static/images/leftleft.png" style="height:13px;width:13px;display:Inline;"></div>
              </div>
            </div>
            <div class="weui-cell__ft">
            <a class="weui-swiped-btn weui-swiped-btn_warn close-swipeout"  onclick="showpolicy('${self.sfid}','ass2')">查看</a>
              <a class="weui-swiped-btn weui-swiped-btn_default delete-swipeout"  onclick="deletepolicy('${self.sfid}','ass2')">删除</a>
              
            </div>
          </div>
        </div>
    
  
  
  </c:forEach>
 
  </c:when>
  <c:otherwise>
	<div><h2 style="color:#008080;text-align:center;">暂无</h2></div>
	</c:otherwise>
  </c:choose>
   <div class="weui-form-preview">
<div class="weui-form-preview__ft">
<a type="submit" class="weui-form-preview__btn weui-form-preview__btn_primary" href="<%=basePath%>selfeval/insertassess">
<span style="color:red;font-weight:bold;border-bottom:1px solid;">新增评价</span></a>
</div>
</div>
    <nav id="nav_page">
        <a id="MainContent_uPre" class="leftpage" onclick="onpage('ass2')">〈上一页</a>
        <span>${pd.one2}/${pd.total2 } 页</span>
        <a id="MainContent_uNext" class="rightpage" onclick="nextpage('ass2')">下一页〉</a>
    </nav>



 </dd>
 
 
 <dd>

    <c:choose>
    <c:when test="${not empty tbself2}">
    <c:forEach items="${tbself2}" var="self" varStatus="vs"> 
     <div class="weui-cells">
       <input type="hidden" value="${vs.index+1}">
          <div class="weui-cell weui-cell_swiped" >
            <div class="weui-cell__bd" style="transform: translate3d(0px, 0px, 0px);">
              <div class="weui-cell">
                <div class="weui-cell__bd">
                  <p>${self.title} &nbsp;&nbsp;</p>
                </div>
                <div class="weui-cell__ft">${self.uname} &nbsp;${self.sdate}&nbsp;<img src="static/images/leftleft.png" style="height:13px;width:13px;display:Inline;"></div>
              </div>
            </div>
            <div class="weui-cell__ft">
             
              <a class="weui-swiped-btn weui-swiped-btn_warn close-swipeout" onclick="showpolicy('${self.sfid}','ass3')">查看</a>
            </div>
          </div>
        </div>
 
  
  </c:forEach>
  <div class="weui-form-preview">

</div>
  </c:when>
  <c:otherwise>
	<div><h2 style="color:#008080;text-align:center;">暂无</h2></div>
	</c:otherwise>
  </c:choose>
    <nav id="nav_page">
        <a id="MainContent_uPre" class="leftpage" onclick="onpage('ass3')">〈上一页</a>
        <span>${pd.one3}/${pd.total3 } 页</span>
        <a id="MainContent_uNext" class="rightpage" onclick="nextpage('ass3')">下一页〉</a>
    </nav>

 
 </dd>
 
</dl>


	<script src="https://cdn.bootcss.com/jquery/1.11.0/jquery.min.js"></script>
	<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/jquery-weui.min.js"></script>
	  <script>
	  //滑动编辑
	  function showpolicy(poinid,type){//查看
		window.location.href="<%=basePath%>selfeval/showassess.do?sfid="+poinid+"&type="+type;
	}
	 function deletepolicy(poinid,ass){//删除
        $.confirm("确定删除?", "", function() {
        	$.ajax({  
					type: "POST",
					url: "<%=basePath%>selfeval/deleteass.do",
			    	data:  "sfid="+poinid,
					dataType:'json',
					cache: false,
					success: function(date){
						if(date.result=="success"){
						 $.toast("删除成功!");
						 window.location.href="<%=basePath%>selfeval/assessmentmain.do?ass="+ass;
						}
						else{
						$.toast("删除失败!","cancel");
						}
					}
				});

        }, function() {
          //取消操作
        });
	}
 
    </script>
	<script>
$(document).ready(function(){
    var judgeass=$("#judgeass").val();	
	//product list:Tab
	$(".tab_proList dd").eq(judgeass).show().siblings(".tab_proList dd").hide();
	$(".tab_proList dt a").eq(judgeass).addClass("currStyle");
	$(".tab_proList dt a").click(function(){
	var liindex = $(".tab_proList dt a").index(this);
	$(this).addClass("currStyle").siblings().removeClass("currStyle");
	$(".tab_proList dd").eq(liindex).fadeIn(150).siblings(".tab_proList dd").hide();
	});

});
</script>
  <script type="text/javascript">
  var length=$("#length").val();
	function showpolicy(poinid,type){
		window.location.href="<%=basePath%>selfeval/showassess.do?sfid="+poinid+"&type="+type;
	}
	
	function onpage(ass){
	if(ass=="ass1"){
var page=${pd.one1}-1;
if(page==0){
$.toptip('这是第一页', 1000,'success');
}
else{
window.location.href="<%=basePath%>selfeval/assessmentmain.do?ass="+ass+"&begin1="+(length*page-length)+"&length="+length+"&tip="+"onpage";
}
}
else if(ass=="ass2"){
var page=${pd.one2}-1;
if(page==0){
$.toptip('这是第一页', 1000,'success');
}
else{
window.location.href="<%=basePath%>selfeval/assessmentmain.do?ass="+ass+"&begin2="+(length*page-length)+"&length="+length+"&tip="+"onpage";
}
}
else{
var page=${pd.one3}-1;
if(page==0){
$.toptip('这是第一页',1000, 'success');
}
else{
window.location.href="<%=basePath%>selfeval/assessmentmain.do?ass="+ass+"&begin3="+(length*page-length)+"&length="+length+"&tip="+"onpage";
}
}

}


function nextpage(ass){
	if(ass=="ass1"){
	var page=${pd.one1};
var pagetotal=${pd.total1};
if(page>=pagetotal){
$.toptip('已经是最后一页了',1000, 'success');
}
else{
window.location.href="<%=basePath%>selfeval/assessmentmain.do?ass="+ass+"&begin1="+(length*page)+"&length="+length+"&tip="+"nextpage";
}
	}
	else if(ass=="ass2"){
	var page=${pd.one2};
var pagetotal=${pd.total2};
if(page>=pagetotal){
$.toptip('已经是最后一页了',1000, 'success');
}
else{
window.location.href="<%=basePath%>selfeval/assessmentmain.do?ass="+ass+"&begin2="+(length*page)+"&length="+length+"&tip="+"nextpage";
}
	}
	else{
	var page=${pd.one3};
var pagetotal=${pd.total3};
if(page>=pagetotal){
$.toptip('已经是最后一页了',1000, 'success');
}
else{
window.location.href="<%=basePath%>selfeval/assessmentmain.do?ass="+ass+"&begin3="+(length*page)+"&length="+length+"&tip="+"nextpage";
}
	}

}

	
	</script>
	

</body>
</html>