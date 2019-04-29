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
            <h2 class="weui-msg__title">新增成功，请等待管理员审核</h2>
<!--             <p class="weui-msg__desc">内容详情，可根据实际需要安排，如果换行则不超过规定长度，居中展现<a href="javascript:void(0);">文字链接</a></p> -->
        </div>
        <div class="weui-msg__opr-area">
            <p class="weui-btn-area">
                <a href="<%=basePath%>xiaocun/showallxiaocun" class="weui-btn weui-btn_primary">点击返回小村家事列表</a>
               
            </p>
        </div>

        <div class="weui-msg__extra-area">
            <div class="weui-footer">
<!--                 <p class="weui-footer__links"> -->
<!--                     <a href="javascript:void(0);" class="weui-footer__link">底部链接文本</a> -->
<!--                 </p> -->
                <p class="weui-footer__text">Copyright &copy; 暮云新村</p>
            </div>
        </div>
    </div>
</div>
<!-- 		<div class="page msg_success js_show"> -->
<!-- 			<div class="weui-msg"> -->
<!-- 				<div class="weui-msg_icon-area"> -->
<!-- 					<i class="weui-icon-success weui-icon_msg"></i> -->
<!-- 				</div> -->
<!-- 				<div class="weui-msg_text-area"> -->
<!-- 					<h2 class="weui-msg_title">注册成功</h2> -->
<!-- 				</div> -->
<!-- 				<div class="weui-msg_extra-area"> -->
<!-- 					<div class="weui-footer"> -->
<!-- 	<p class="weui-footer_text">Copyright © 思信网络科技有限公司 </p> -->
<!-- </div> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
	</div>
</body>
</html>
