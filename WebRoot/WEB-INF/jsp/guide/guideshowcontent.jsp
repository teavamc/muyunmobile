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
       	<link rel="stylesheet" href="https://cdn.bootcss.com/weui/1.1.2/style/weui.min.css">
<script src="https://cdn.bootcss.com/jquery/1.11.0/jquery.min.js"></script>

<link rel="stylesheet" href="http://cdn.amazeui.org/amazeui/2.7.2/css/amazeui.css">
<script src="http://cdn.amazeui.org/amazeui/2.7.2/js/amazeui.js"></script>
<script src="http://cdn.amazeui.org/amazeui/2.7.2/js/amazeui.ie8polyfill.js"></script>
<script src="http://cdn.amazeui.org/amazeui/2.7.2/js/amazeui.widgets.helper.js"></script>

  </head>
  
  <body>
  

	
	<header data-am-widget="header" class="am-header am-header-default">
      <div class="am-header-left am-header-nav">
          <a href="javascript:history.back(-1)" class="">
                <i class="am-header-icon am-icon-reply"></i>
          </a>
      </div>
        <h1 class="am-header-title">
          <a href="#title-link" class="">办事指南</a>
      </h1>
  </header>



	<form action="" name="userForm" id="userForm" method="post" >
<div class="weui-cells weui-cells_form" style="margin-top:0em;">
  <div class="weui-cell" >
        <div class="weui-cell__hd">
            <label class="weui-label" style="color:#808080">名称</label>
        </div>
        <div class="weui-cell__bd ">
            <input name="title" id="title" class="weui-input" type="text" readonly="readonly" value="${guide.guname}"
				>
        </div>
    </div>

    <div class="weui-cell">
        <div class="weui-cell__hd">
            <label class="weui-label" style="color:#808080">类型</label>
        </div>
        <div class="weui-cell__bd ">
            <input name="title" id="title" class="weui-input" type="text" readonly="readonly" value="${guide.gutype}"
				>
        </div>
    </div>
    
      <div class="weui-cell">
        <div class="weui-cell__hd">
            <label class="weui-label" style="color:#808080">发布时间</label>
        </div>
        <div class="weui-cell__bd ">
            <input name="ftype" id="ftype" class="weui-input" type="text" value="${guide.pushdate }" 
				readonly="readonly">
        </div>
    </div>
     <div class="weui-cell">
        <div class="weui-cell__hd">
            <label class="weui-label" style="color:#808080">浏览</label>
        </div>
        <div class="weui-cell__bd " style="color:red;">
            <input name="title" id="title" class="weui-input" type="text" readonly="readonly" value="${guide.greadtotal}"
				>
        </div>
    </div>
    
    <article class="weui-article"> 
   ${guide.content }
    </article>
        <div class="weui-cells weui-cells_form">
      <div class="weui-cell">
        <div class="weui-cell__bd">
          <div class="weui-uploader">
            <div class="weui-uploader__hd">
              <p class="weui-uploader__title" style="color:#808080">图集</p>
             
            </div>
            <div class="weui-uploader__bd">
              <ul class="weui-uploader__files" id="uploaderFiles" >  
              <c:choose>
              	<c:when test="${not empty url }">
              	<c:forEach items="${url }" var="u" varStatus="vs">
              		<li class="weui-uploader__file" onclick="showguideimg(${vs.index+1})" >
                	<img src="<%=basePath%>guide/showguideimage?url='${u}'" style="height:75px;">
                	</li>
              	</c:forEach>
              	</c:when>
              	<c:otherwise>
					<li class="weui-uploader__file weui-uploader__file_status">
              <div class="weui-uploader__file-content">暂无图片</div>
            </li>
				</c:otherwise>
     			</c:choose>
				
              </ul>
            </div>
          </div>
        </div>
      </div>
    </div>

   

</div>



</form>
	
	<script src="https://cdn.bootcss.com/jquery/1.11.0/jquery.min.js"></script>
	<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/jquery-weui.min.js"></script>
	<script src="static/jqweui/swiper.js" charset='utf-8'></script>
	<script type="text/javascript">
	var urlsize=${pd.urlnum};  //图片总数   限制5张
	var imgsrc=new Array(urlsize);//定义图片数组的长度=图片总数
	for(var i=0;i<urlsize;i++){
	imgsrc[i]=$("img")[i].src;
	
	}
	
	switch(urlsize){
		case 0: break;
		case 1: var pb1 = $.photoBrowser({
	 			items: [
           		{
            image: imgsrc[0],
            //caption: "<a class='weui-btn weui-btn_disabled' href=\"yuqing/downloadimg?url="+imgsrc[0]+"&tip='img1' \">下载原图</a>",
          },
       			]
     			}); break;
     	case 2: var pb1 = $.photoBrowser({
	 			items: [
           		{
            image: imgsrc[0],
          // caption: "<a  class='weui-btn weui-btn_disabled' href=\"yuqing/downloadimg?url="+imgsrc[0]+"&tip='img1' \">下载原图</a>",
          },
          		{
            image: imgsrc[1],
         //  caption: "<a  class='weui-btn weui-btn_disabled' href=\"yuqing/downloadimg?url="+imgsrc[1]+"&tip='img2' \">下载原图</a>",
          },
       			]
     			}); break;
     	case 3: var pb1 = $.photoBrowser({
	 			items: [
           		{
            image: imgsrc[0],
           // caption: "<a  class='weui-btn weui-btn_disabled' href=\"yuqing/downloadimg?url="+imgsrc[0]+"&tip='img1' \">下载原图</a>",
          },
          		{
            image: imgsrc[1],
           // caption: "<a  class='weui-btn weui-btn_disabled' href=\"yuqing/downloadimg?url="+imgsrc[1]+"&tip='img2' \">下载原图</a>",
          },
         		{
            image: imgsrc[2],
           //caption: "<a  class='weui-btn weui-btn_disabled' href=\"yuqing/downloadimg?url="+imgsrc[2]+"&tip='img3' \">下载原图</a>",
          },
       			]
     			}); break;	
     	case 4: var pb1 = $.photoBrowser({
	 			items: [
	 		{
            image: imgsrc[0],
           // caption: "<a  class='weui-btn weui-btn_disabled' href=\"yuqing/downloadimg?url="+imgsrc[0]+"&tip='img1' \">下载原图</a>",
          },
          		{
            image: imgsrc[1],
            //caption: "<a  class='weui-btn weui-btn_disabled' href=\"yuqing/downloadimg?url="+imgsrc[1]+"&tip='img2' \">下载原图</a>",
          },
         	{
            image: imgsrc[2],
           // caption: "<a  class='weui-btn weui-btn_disabled' href=\"yuqing/downloadimg?url="+imgsrc[2]+"&tip='img3' \">下载原图</a>",
          },
         	{
            image: imgsrc[3],
           // caption: "<a  class='weui-btn weui-btn_disabled' href=\"yuqing/downloadimg?url="+imgsrc[3]+"&tip='img4' \">下载原图</a>",
          },
          	]
     			}); break;
     	case 5: var pb1 = $.photoBrowser({
	 			items: [
           		{
            image: imgsrc[0],
           // caption: "<a  class='weui-btn weui-btn_disabled' href=\"yuqing/downloadimg?url="+imgsrc[0]+"&tip='img1' \">下载原图</a>",
          },
          		{
            image: imgsrc[1],
           // caption: "<a  class='weui-btn weui-btn_disabled' href=\"yuqing/downloadimg?url="+imgsrc[1]+"&tip='img2' \">下载原图</a>",
          },
         		{
            image: imgsrc[2],
          // caption: "<a  class='weui-btn weui-btn_disabled' href=\"yuqing/downloadimg?url="+imgsrc[2]+"&tip='img3' \">下载原图</a>",
          },
         		{
            image: imgsrc[3],
           // caption: "<a  class='weui-btn weui-btn_disabled' href=\"yuqing/downloadimg?url="+imgsrc[3]+"&tip='img4' \">下载原图</a>",
          },
         		{
            image: imgsrc[4],
          //  caption: "<a  class='weui-btn weui-btn_disabled' href=\"yuqing/downloadimg?url="+imgsrc[4]+"&tip='img5' \">下载原图</a>",
          },
       			]
     			}); break;
	}
	
    
    function showguideimg(k){
	pb1.open(k-1);
	}
	</script>

  </body>
</html>
