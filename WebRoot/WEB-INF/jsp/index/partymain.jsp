<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html lang="zh-CN">
<html style="font-size:23.4375px;">
 <head>
<title>${pd.SYSNAME}</title>
<base href="<%=basePath%>">
  <meta charset="utf-8">
   <base href="<%=basePath%>">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
  <meta name="description" content="">
  
          <link rel="stylesheet" href="//res.wx.qq.com/open/libs/weui/1.1.0/weui.min.css"/>
          <link rel="stylesheet" href="https://cdn.bootcss.com/jquery-weui/1.2.0/css/jquery-weui.min.css">

		<script type="text/javascript" src="static/js/jquery.min.js"></script>
		<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
</head>
 
 
 
 

 <body>


<!--header-end-->

<input type="hidden" value="${user.uname}" id="uname">
<input type="hidden" value="${user.uid}" id="uid">
<input type="hidden" value="${user.headimg}" id="headimg">
<input type="hidden" value="${user.utypes}" id="utypes">

<div class="container" id="container" style="background-color:#EAEAEA;"> 

<!-- <a style="margin-top:0px;"><img src="static/new/images/new/maindangyuan.png" 
alt="" style="background-size:contain|cover;width:100%;height: auto;" /></a> -->

<div class="weui-panel weui-panel_access">
	    
		<div class="weui-panel__hd">我的账号信息</div>
			<div class="weui-panel__bd">
			    <a class="weui-media-box weui-media-box_appmsg" >
			      <div  class="weui-media-box__hd">
			        <img id="pickimg" class="weui-media-box__thumb" src="${user.headimg} width="60px" heigth="60px" ">
			      </div>
			      <div id="pickuname" class="weui-media-box__bd">
			      </div>
			      <div class="weui-media-box__ft">
			        <img href="javascript:;" id="showyjt"  src="static/new/yjt.png" width="30px" heigth="30px">
			      </div>
			    </a>
		  	</div>
		</div>
	
	

<div class="weui-panel weui-panel_access">
	<div class="weui-grids">
	
	<a href="<%=basePath%>resident/residentlist" class="weui-grid js_grid">
	    <div class="weui-grid__icon">
	      <img src="static/new/images/new/icon/cunminxinxi.png" alt="">
	    </div>
	    <p class="weui-grid__label"> 村民信息 </p>
	  </a>
	    
	  <a href="<%=basePath%>partymember/selecttomanage" class="weui-grid js_grid">
	    <div class="weui-grid__icon">
	      <img src="static/new/images/new/icon/cunshiguanli.png" alt="">
	    </div>
	    <p class="weui-grid__label">
	      	村事管理
	    </p>
	  </a>
	  
	  <a href="<%=basePath%>shishi/showallshishi" class="weui-grid js_grid">
	    <div class="weui-grid__icon">
	      <img src="static/new/images/new/icon/shishizhenshi.png" alt="">
	    </div>
	    <p class="weui-grid__label">
	      	实时政事
	    </p>
	  </a>
	  
	  
	  <a href="<%=basePath%>selfeval/assessmentmain" class="weui-grid js_grid">
	    <div class="weui-grid__icon">
	      <img src="static/new/images/new/icon/zipinghuping.png" alt="">
	    </div>
	    <p class="weui-grid__label">
	      	自评互评
	    </p>
	  </a>
	  
	  <a href="<%=basePath%>partygroup/showgroup" class="weui-grid js_grid">
	    <div class="weui-grid__icon">
	      <img src="static/new/images/new/icon/dangyuanxiaozu.png" alt="">
	    </div>
	    <p class="weui-grid__label">
	      	党员小组
	    </p>
	  </a>
	  
	  <a href="<%=basePath%>hd/showallhd" class="weui-grid js_grid">
	    <div class="weui-grid__icon">
	      <img src="static/new/images/new/icon/dangzhang.png" alt="">
	    </div>
	    <p class="weui-grid__label">
	                         党员活动
	    </p>
	  </a>
	
	  <a href="<%=basePath%>zhiban/showallzhiban" class="weui-grid js_grid">
	    <div class="weui-grid__icon">
	      <img src="static/new/images/new/icon/dangyuanzhiban.png" alt="">
	    </div>
	    <p class="weui-grid__label">
	      	党员值班
	    </p>
	  </a>
	
	  <a href="<%=basePath%>sencol/sencollist" class="weui-grid js_grid">
	    <div class="weui-grid__icon">
	      <img src="static/new/images/new/icon/zipinghuping.png" alt="">
	    </div>
	    <p class="weui-grid__label">
	      	敏感字符集管理
	    </p>
	  </a>
	  
	  <a href="<%=basePath%>FileManager/showfiles.do?begin=0&length=10&tip=firstpage"  class="weui-grid js_grid">
			  
	    <div class="weui-grid__icon">
	      <img src="static/new/file.png" alt="">
	    </div>
	    <p class="weui-grid__label">
	      	文件管理中心
	    </p>
	  </a>
	  
	</div>
</div>


	<div class="weui-panel weui-panel_access">
		<div class="weui-panel">
	        <div class="weui-panel__hd">实时政事推送</div>
		        <div class="weui-panel__bd">
			          <div class="weui-media-box weui-media-box_text">
			            <h4 class="weui-media-box__title">习近平推崇的英雄精神</h4>
			            <p class="weui-media-box__desc">缅怀英烈祭忠魂，抚今追昔思奋进。党的十八大以来，习近平总书记...</p>
			            <ul class="weui-media-box__info">
			              <li class="weui-media-box__info__meta">文字来源:中国共产党新闻网</li>
			              <li class="weui-media-box__info__meta">时间:2018-05-25</li>
			              <li class="weui-media-box__info__meta weui-media-box__info__meta_extra">转跳</li>
			            </ul>
			          </div>
		        </div>
	      	</div>
	    </div>
	
	
<!--container-end-->

<br>
<br>
<br>
<div class="weui-footer">
  <p class="weui-footer__text">Copyright © 2008-2016 张超 袁枭云</p>
</div>

<!--footer-->
<div class="weui-tabbar" style="position:fixed;bottom:0px;">
        <a href="<%=basePath%>mainindex" class="weui-tabbar__item">
          <div class="weui-tabbar__icon">
            <img src="static/new/images/dating.png" alt="">
          </div>
          <p class="weui-tabbar__label">用户服务</p>
        </a>
        <a onclick="partyzhuanqu()" class="weui-tabbar__item weui-bar__item--on">
          <div class="weui-tabbar__icon">
            <img src="static/new/images/dangyuanzaixian.png" alt="">
          </div>
          <p class="weui-tabbar__label">党员在线</p>
        </a>
        <a href="<%=basePath%>users/showuserinfo.do" class="weui-tabbar__item">
          <div class="weui-tabbar__icon">
            <img src="static/new/images/geren.png" alt="">
          </div>
          <p class="weui-tabbar__label">个人中心</p>
        </a>
      </div>
    </div>
<!--footer-end-->

<!--栏目更多-->

<!-- <script type="text/javascript">
$(".ind-nav").each(function(){	
  var self = $(this); 
  var n=self.find("ul li").length;
  if(n<=8){
  self.find( ".more").addClass("hide-more");
  }else{
  self.find(".more").removeClass("hide-more");
  } 
 self.find(".more").click(function(){
    self.find( "ul" ).toggleClass("intro");
	self.find(".more").toggleClass("add-more");
  });
  });
</script> -->

<!--栏目更多--> 
<script type="text/javascript">
		var uname = $("#uname").val();
		var uimg = $("#headimg").val();
		
		$("#test02").text(uname);
		if(uname != null && uname != "" ){ 
			document.getElementById("pickuname").innerHTML="<h4  class=\"weui-media-box__title\">${user.uname}</h4><p class=\"weui-media-box__desc\">权限等级：${user.utypes}</p><p class=\"weui-media-box__desc\">我的id：${user.uid}</p>";
			$("#pickimg").attr("src",uimg);		
		}
		else{
			document.getElementById("pickuname").innerHTML="<h4 class=\"weui-media-box__title\">未获取用户数据</h4><p class=\"weui-media-box__desc\">请进入个人中心再返回本页</p>"
			$("#pickimg").attr("src","static/new/nodata.jpg");
			}
			
		$(document).on("click", "#showyjt", function() {
		window.location.href="<%=basePath%>users/edituser"
      });
		
	</script>		 
	
	
												
 </body>
</html>

