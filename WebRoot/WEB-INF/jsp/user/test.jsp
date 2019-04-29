<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html lang="zh-CN">
 <head>
  <title>${pd.SYSNAME}</title>
  <base href="<%=basePath%>">
 <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">
<meta content="yes" name="apple-mobile-web-app-capable" />
<meta content="black" name="apple-mobile-web-app-status-bar-style" />
<meta content="telephone=no" name="format-detection" />
  <link rel="stylesheet" href="https://cdn.bootcss.com/weui/1.1.2/style/weui.min.css">
<link rel="stylesheet" href="https://cdn.bootcss.com/jquery-weui/1.2.0/css/jquery-weui.min.css">
<script src="static/new/js/common.js"></script>
  <link rel="stylesheet" type="text/css" href="static/new/css/base.css">
<style>
.comment{width:680px; margin:20px auto; position:relative}
.comment h3{height:28px; line-height:28px}
.com_form{width:100%; position:relative}
.input{width:99%; height:60px; border:1px solid #ccc}
.com_form p{height:28px; line-height:28px; position:relative}
span.emotion{width:42px; height:20px; background:url(icon.gif) no-repeat 2px 2px; padding-left:20px; cursor:pointer}
span.emotion:hover{background-position:2px -28px}
.qqFace{margin-top:4px;background:#fff;padding:2px;border:1px #dfe6f6 solid;}
.qqFace table td{padding:0px;}
.qqFace table td img{cursor:pointer;border:1px #fff solid;}
.qqFace table td img:hover{border:1px #0066cc solid;}
#show{width:680px; margin:20px auto}

.sub_btn {
	position:absolute; right:0px; top:0;
	display: inline-block;
	zoom: 1; /* zoom and *display = ie7 hack for display:inline-block */
	*display: inline;
	vertical-align: baseline;
	margin: 0 2px;
	outline: none;
	cursor: pointer;
	text-align: center;
	font: 14px/100% Arial, Helvetica, sans-serif;
	padding: .5em 2em .55em;
	text-shadow: 0 1px 1px rgba(0,0,0,.6);
	-webkit-border-radius: 3px; 
	-moz-border-radius: 3px;
	border-radius: 3px;
	-webkit-box-shadow: 0 1px 2px rgba(0,0,0,.2);
	-moz-box-shadow: 0 1px 2px rgba(0,0,0,.2);
	box-shadow: 0 1px 2px rgba(0,0,0,.2);
	color: #e8f0de;
	border: solid 1px #538312;
	background: #64991e;
	background: -webkit-gradient(linear, left top, left bottom, from(#7db72f), to(#4e7d0e));
	background: -moz-linear-gradient(top,  #7db72f,  #4e7d0e);
	filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#7db72f', endColorstr='#4e7d0e');
}
.sub_btn:hover {
	background: #538018;
	background: -webkit-gradient(linear, left top, left bottom, from(#6b9d28), to(#436b0c));
	background: -moz-linear-gradient(top,  #6b9d28,  #436b0c);
	filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#6b9d28', endColorstr='#436b0c');
}
</style>

 </head>
 

 <body>
 <div class="weui-toptips weui-toptips_warn" id="toptip">错误提示</div>
<header class="header" id="header" style="background-color:red;position:relative;">
<a href="javascript:history.go(-1)" target=_self class="back">返回</a>
<h1>接口测试</h1>
</header>

成员的UserId <input type="text" name="userid"  value="${webchatUser.Userid}"  /></br>
<input type="text" name="user_ticket"  value="${webchatUser.user_ticket}"  /></br>


			成员的userId <input type="text" name="userid"  value="${webchatUser.userid}"  /></br>

			成员的名字 <input type="text" name="name"  value="${webchatUser.name}"  /></br>
			成员的头像 <input type="text" name="avatar"  value="${webchatUser.avatar}"  /></br>

	
	
	<!--  
	<form action="<%=basePath%>policyinfo/test" method="post" enctype="multipart/form-data">
	<input name="user" id="user" value="" type="text"></br>
	<input name="pic"  type="file"></br>
	<input type="submit" value="提交">
	</form>
	-->


<div id="main">
     <div id="show"></div>
     <div class="comment">
        <div class="com_form">
        	<textarea class="input" id="saytext" name="saytext"></textarea>
        	<p><input type="button" class="sub_btn" value="提交"><span class="emotion">表情</span></p>
        </div>
     </div>    
</div>
<script type="text/javascript">
$(function(){
	$('.emotion').qqFace({
		id : 'facebox', //表情盒子的ID
		assign:'saytext', //给那个控件赋值
		path:'face/'	//表情存放的路径
	});
	$(".sub_btn").click(function(){
		var str = $("#saytext").val();
		$("#show").html(replace_em(str));
	});
});
//查看结果
function replace_em(str){
	str = str.replace(/\</g,'&lt;');
	str = str.replace(/\>/g,'&gt;');
	str = str.replace(/\n/g,'<br/>');
	str = str.replace(/\[em_([0-9]*)\]/g,'<img src="face/$1.gif" border="0" />');
	return str;
}
</script>

<script type="text/javascript" src="static/jqweui/jquery.qqFace.js"></script>
	<script src="https://cdn.bootcss.com/jquery/1.11.0/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/jquery-weui.min.js"></script>

<!-- 如果使用了某些拓展插件还需要额外的JS -->
<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/swiper.min.js"></script>
<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/city-picker.min.js"></script>

<script>

</script>

										
 </body>
</html>

