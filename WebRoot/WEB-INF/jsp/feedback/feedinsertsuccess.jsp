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
<!--         <link rel="stylesheet" href="static/register/weui.min.css"/> -->
<script type="text/javascript" src="static/js/jquery.min.js"></script>
  </head>
  
  <body>
	<div class="container" id="container">
		<div class="page">
    <div class="weui-msg">
        <div class="weui-msg__icon-area"><i class="weui-icon-success weui-icon_msg"></i></div>
        <div class="weui-msg__text-area">
            <h2 class="weui-msg__title">新增成功，请耐心等待回复</h2>
<!--             <p class="weui-msg__desc">内容详情，可根据实际需要安排，如果换行则不超过规定长度，居中展现<a href="javascript:void(0);">文字链接</a></p> -->
        </div>
        <div class="weui-msg__opr-area">
            <p class="weui-btn-area">
                <a href="<%=basePath%>feedback/showallfeed?isread=0" class="weui-btn weui-btn_primary">查看我的内容</a>
                <a href="<%=basePath%>mainindex" class="weui-btn weui-btn_primary">回到首页</a>
            </p>
        </div>
        <script>
        </script>

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
