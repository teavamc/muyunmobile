<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html style="font-size:23.4375px;">
<head>
<title>${pd.SYSNAME}</title>
<base href="<%=basePath%>">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
<meta name="description" content="">

<link rel="stylesheet" href="https://cdn.bootcss.com/weui/1.1.2/style/weui.min.css">
<link rel="stylesheet" href="https://cdn.bootcss.com/jquery-weui/1.2.0/css/jquery-weui.min.css">
<link rel="stylesheet" type="text/css" href="static/new/css/base.css">
<link rel="stylesheet" type="text/css" href="static/login/css/headmain.css"/><!-- 分页-->
<script src="https://cdn.bootcss.com/jquery/1.11.0/jquery.min.js"></script>

</head>
  
<body ontouchstart>
  <input type="hidden" value="${pd.pagelength }" id="length">
  
  <header class="header" id="header" style="background-color:#e64340;position: static;">
<a href="javascript:history.back(-1)" target=_self class="back">返回</a>
<h1>文件中心</h1>
</header>

	    
	
	
	<!-- <form action="FileManager/fileupload" enctype="multipart/form-data" method="post">
            <tr>
                <td><input type="file" name="file"></td>
            </tr>
            <tr>
                <td><input type="submit" value="上传"></td>
            </tr>
    </form> -->
    <article class="weui-article" style="margin:0px" >
	    <div class="file-box"> 
		<form action="FileManager/fileupload" enctype="multipart/form-data" method="post"> 
		<input type='text' name='textfield' id='textfield' class='txt' /> 
		<input type='button' class='btn' value='浏览...' /> 
		<input type="file" name="file" class="file" id="fileField" size="28" onchange="document.getElementById('textfield').value=this.value" /> 
		<input type="submit" name="submit" class="btn" value="上传" /> 
		</form> 
		</div>
		
	</article>
	<style type="text/css">
	input{ vertical-align:middle; margin:0; padding:0}
	.file-box{ position:relative;width:340px}
	.txt{ height:22px; border:1px solid #cdcdcd; width:180px;}
	.btn{ background-color:#FFF; border:1px solid #CDCDCD;height:24px; width:70px;}
	.file{ position:absolute; top:0; right:80px; height:24px; filter:alpha(opacity:0);opacity: 0;width:260px }
	</style>
	
	
	
    <p  style="text-align:center;color:#9C9C9C;">- ${user.uname}, 这是最近上传的文件 -</p>
     
	 <article class="weui-article" style="margin:0px" >
    <c:choose>
    <c:when test="${not empty filelistall}">
    <c:forEach items="${filelistall}" var="listfile" varStatus="vs1"> 
    
 	<%-- <input type="hidden" value="${listfile.filename}" id="filename"> --%>
 	
  		<div class="weui-panel weui-panel_access" >
				<div class="weui-panel__bd">
				
				<a class="weui-media-box weui-media-box_appmsg" onclick="showfilecontent('${listfile.fileid}')">
				<input type="hidden" value="${vs1.index+1}">
				
			      <div class="weui-media-box__bd">
			        <h4 style="font-size:20px">${listfile.filename}</h4>
			        <span>文件大小:${listfile.filesize}M</span>&#160<span>下载次数:${listfile.downloadnum}次</span>
			        <p class="weui-media-box__desc" >上传时间:${listfile.uploaddate.substring(0,10)}</p>
			        
			      </div>
			      <div class="weui-media-box__ft">
			      
			      <%-- <a href="FileManager/filedownload?filename=${listfile.filename}"> --%>
				      <div class="weui-grid__icon">
	   						<img src="static/new/download.png" onclick="download">
	   						
			      		</div>
			      			<!-- <script type="text/javascript">
							var filename = $("#filename").val();
							function download(){
								 window.location.href="FileManager/filedownload?filename="+	filename;
									}
								</script> -->
      			 <!--  </a> -->
      			  
		      		</div>
			    </a>
			    
			    
			 </div>
			 </div>
			 
			 
  </c:forEach>

<!-- 	<br>
	<br>
	<div class="weui-footer">
	  <p class="weui-footer__text">Copyright © 2008-2016 张超 袁枭云</p>
	</div>  -->
	
	<nav id="nav_page"  >
	    <a id="MainContent_uPre" class="leftpage" onclick="onpage('${pd.type}')">〈上一页</a>
	    <span>${pd.one}/${pd.total} 页</span>
	    <a id="MainContent_uNext" class="rightpage" onclick="nextpage('${pd.type}')">下一页〉</a>
	  </nav>

  </c:when>
  <c:otherwise>
	<div><h2 style="color:#008080;text-align:center;">暂无文件</h2></div>
	</c:otherwise>
  </c:choose>
  
   </article>

<%-- <nav id="nav_page"  style="width:100%;height: 50px;position: fixed;bottom: 0;" >
	    <a id="MainContent_uPre" class="leftpage" onclick="onpage('${pd.type}')">〈上一页</a>
	    <span>${pd.one}/${pd.total} 页</span>
	    <a id="MainContent_uNext" class="rightpage" onclick="nextpage('${pd.type}')">下一页〉</a>
	  </nav> --%>




<script src="https://cdn.bootcss.com/jquery/1.11.0/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/jquery-weui.min.js"></script>

<script type="text/javascript">
var length=$("#length").val();

function showfilecontent(fileid){
		window.location.href="<%=basePath%>FileManager/filedownloadcontent.do?fileid="+fileid;
	}
	
function onpage(type){
var page=${pd.one}-1;
if(page==0){
$.toptip('这是第一页', 1000, 'success');
}
else{
window.location.href="<%=basePath%>FileManager/showfiles.do?type="+type+"&begin="+(length*page-length)+"&length="+length+"&tip="+"onpage";
}
}

function nextpage(type){
var page=${pd.one};
var pagetotal=${pd.total};
if(page>=pagetotal){
$.toptip('已经是最后一页了', 1000, 'success');
}
else{
window.location.href="<%=basePath%>FileManager/showfiles.do?type="+type+"&begin="+(length*page)+"&length="+length+"&tip="+"nextpage";
}
}



</script>



 </body>
</html>

