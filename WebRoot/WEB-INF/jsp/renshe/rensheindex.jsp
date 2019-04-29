<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html lang="zh-CN" style="font-size: 10px;">
<head>
  <title>${pd.SYSNAME}</title>
  <base href="<%=basePath%>">
  <meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
		<meta name="description" content="">

       	<link rel="stylesheet" href="https://cdn.bootcss.com/weui/1.1.2/style/weui.min.css"><!-- weui-css -->
<link rel="stylesheet" href="https://cdn.bootcss.com/jquery-weui/1.2.0/css/jquery-weui.min.css"><!-- weui-js-css -->
<link rel="stylesheet" href="http://cdn.amazeui.org/amazeui/2.7.2/css/amazeui.css"><!-- zmazeui-->
<link rel="stylesheet" type="text/css" href="static/login/css/headmain.css"/><!-- 分页-->
   <link rel="stylesheet" type="text/css" href="static/simditor-2.3.13/assets/styles/simditor.css" ><!-- 文本编辑器css-->
<script src="https://cdn.bootcss.com/jquery/1.11.0/jquery.min.js"></script><!-- jquery-->
<script src="http://cdn.amazeui.org/amazeui/2.7.2/js/amazeui.js"></script><!-- zmazeui-->
<script src="http://cdn.amazeui.org/amazeui/2.7.2/js/amazeui.ie8polyfill.js"></script><!-- zmazeui-->
<script src="http://cdn.amazeui.org/amazeui/2.7.2/js/amazeui.widgets.helper.js"></script><!-- zmazeui-->
<script src="static/source/js/swiper.min.js"></script><!-- 通栏-->
<script type="text/javascript" src="static/jqweui/jquery.qqFace.js"></script><!-- 留言表情-->
<script type="text/javascript" src="static/simditor-2.3.13/assets/scripts/jquery.min.js"></script><!-- 文本编辑器js-->      
<script type="text/javascript" src="static/simditor-2.3.13/assets/scripts/module.js"></script><!-- 文本编辑器js-->  
 <script type="text/javascript" src="static/simditor-2.3.13/assets/scripts/hotkeys.js"></script>  <!-- 文本编辑器js-->  
 <script type="text/javascript" src="static/simditor-2.3.13/assets/scripts/uploader.js"></script>  <!-- 文本编辑器js-->  
 <script type="text/javascript" src="static/simditor-2.3.13/assets/scripts/simditor.js"></script><!-- 文本编辑器js--> 

  </head>

<!-- 开始内容 -->
<body>

<!-- 页头 -->
<header data-am-widget="header" class="am-header am-header-default">
      <div class="am-header-left am-header-nav">
          <a href="<%=basePath%>mainindex" class="">
                <i class="am-header-icon am-icon-reply"></i>
          </a>
      </div>
        <h1 class="am-header-title" >长沙人设测试</h1>
  </header>


		<!-- 页面内容 -->
		<a style="margin-top:0px;"><img src="static/new/images/new/hb.png" style="background-size:contain|cover;width:100%;height: auto;" alt=""/></a>
		<div class="weui-grids">
  
  <a href="https://mp.weixin.qq.com/mp/profile_ext?action=home&__biz=MjM5NDg4NDY2OA==&scene=123#wechat_redirect" class="weui-grid js_grid">
    <div class="weui-grid__icon">
      <img src="static/new/images/new/icon/juzhen/hnnd.jpg" alt="">
    </div>
    <p class="weui-grid__label">
      	湖南农业大学
    </p>
  </a>
  
  <a href="https://mp.weixin.qq.com/mp/profile_ext?action=home&__biz=MzIyNTE4OTk4Ng==&scene=123#wechat_redirect" class="weui-grid js_grid">
    <div class="weui-grid__icon">
      <img src="static/new/images/new/icon/juzhen/sxwl.jpg" alt="">
    </div>
    <p class="weui-grid__label">
      	思信网络
    </p>
  </a>
  <a href="https://mp.weixin.qq.com/mp/profile_ext?action=home&__biz=MzAxNzM3NTg3OQ==&scene=123#wechat_redirect" class="weui-grid js_grid">
    <div class="weui-grid__icon">
      <img src="static/new/images/new/icon/juzhen/csdj.jpg" alt="">
    </div>
    <p class="weui-grid__label">
      	长沙党建
    </p>
  </a>
  <a href="https://mp.weixin.qq.com/mp/profile_ext?action=home&__biz=MzA5NzQ1ODU5OQ==&scene=123#wechat_redirect" class="weui-grid js_grid">
    <div class="weui-grid__icon">
      <img src="static/new/images/new/icon/juzhen/kfdj.jpg" alt="">
    </div>
    <p class="weui-grid__label">
      	开福党建
    </p>
  </a>
  
  <a href="https://mp.weixin.qq.com/mp/profile_ext?action=home&__biz=MzAxNDA4NTc3NQ==&scene=123#wechat_redirect" class="weui-grid js_grid">
    <div class="weui-grid__icon">
      <img src="static/new/images/new/icon/juzhen/csxdj.jpg" alt="">
    </div>
    <p class="weui-grid__label">
      	长沙县党建
    </p>
  </a>
  
   <a href="https://mp.weixin.qq.com/mp/profile_ext?action=home&__biz=MzA5NjcwOTM3Mw==&scene=123#wechat_redirect" class="weui-grid js_grid">
    <div class="weui-grid__icon">
      <img src="static/new/images/new/icon/juzhen/hngddj.jpg" alt="">
    </div>
    <p class="weui-grid__label">
      	湖南广电党建
    </p>
  </a>
  
  <a href="https://mp.weixin.qq.com/mp/profile_ext?action=home&__biz=MzI1MjE2NTQ2Mg==&scene=123#wechat_redirect" class="weui-grid js_grid">
    <div class="weui-grid__icon">
      <img src="static/new/images/new/icon/juzhen/lydj.jpg" alt="">
    </div>
    <p class="weui-grid__label">
      	浏阳党建
    </p>
  </a>

  <a href="https://mp.weixin.qq.com/mp/profile_ext?action=home&__biz=MzA5MTYzMTIxOQ==&scene=123#wechat_redirect" class="weui-grid js_grid">
    <div class="weui-grid__icon">
      <img src="static/new/images/new/icon/juzhen/yydj.jpg" alt="">
    </div>
    <p class="weui-grid__label">
      	益阳党建
    </p>
  </a>
  
  <a href="https://mp.weixin.qq.com/mp/profile_ext?action=home&__biz=MzU1OTEwMzc3NA==&scene=123#wechat_redirect" class="weui-grid js_grid">
    <div class="weui-grid__icon">
      <img src="static/new/images/new/icon/juzhen/sydj.jpg" alt="">
    </div>
    <p class="weui-grid__label">
      	邵阳党建
    </p>
  </a>
  
  <a href="https://mp.weixin.qq.com/mp/profile_ext?action=home&__biz=MzA4NTQ5MTI3Nw==&scene=123#wechat_redirect" class="weui-grid js_grid">
    <div class="weui-grid__icon">
      <img src="static/new/images/new/icon/juzhen/xxdj.jpg" alt=""  >
    </div>
    <p class="weui-grid__label">
      	湘西党建
    </p>
  </a>

</div>




<script src="https://cdn.bootcss.com/jquery/1.11.0/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/jquery-weui.min.js"></script>
			

 </body>
</html>

