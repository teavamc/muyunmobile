<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <base href="<%=basePath%>">
    
    <title>${pd.SYSNAME }</title>
    <meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<!-- 引入 WeUI -->
<link rel="stylesheet" href="//res.wx.qq.com/open/libs/weui/1.1.0/weui.min.css"/>

<script type="text/javascript" src="static/js/jquery.min.js"></script>
  </head>
  
  <body>
	<div class="container" id="container">
		<div class="page">
    <div class="weui-msg">
        <div class="weui-msg__icon-area"><i class="weui-icon-success weui-icon_msg"></i></div>
        <div class="weui-msg__text-area">
            <h2 class="weui-msg__title">活动创建成功</h2>

        </div>
        <div class="weui-msg__opr-area">
            <p class="weui-btn-area">
                <a href="<%=basePath%>hd/showallhd" class="weui-btn weui-btn_primary">返回</a>
               
            </p>
        </div>

        <div class="weui-msg__extra-area">
            <div class="weui-footer">

                <p class="weui-footer__text">Copyright &copy; 暮云新村</p>
            </div>
        </div>
    </div>
</div>

	</div>
</body>
</html>
