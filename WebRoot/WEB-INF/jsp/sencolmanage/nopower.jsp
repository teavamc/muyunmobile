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
        <div class="weui-msg__icon-area"><i class="weui-icon-warn weui-icon_msg"></i></div>
        <div class="weui-msg__text-area">
            <h2 class="weui-msg__title">您暂无访问此处权限，请联系管理员</h2>
<!--             <p class="weui-msg__desc">内容详情，可根据实际需要安排，如果换行则不超过规定长度，居中展现<a href="javascript:void(0);">文字链接</a></p> -->
        </div>
        <div class="weui-msg__opr-area">
            <p class="weui-btn-area">
                <a href="javascript:history.go(-1)" class="weui-btn weui-btn_primary">
                <span id="howsecond">5</span>秒后返回上级菜单(点此立即返回)
                
                </a>
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

	</div>
	
	<script type="text/javascript">
			var i=4;
			timer = window.setTimeout("toback()","1000");
			function toback(){
				$("#howsecond").text(i);
				if(i==0){
				window.clearTimeout();
				window.history.go(-1);
				}
				i--;
				timer = window.setTimeout("toback()","1000");
			}
	
		
	</script>
</body>
</html>
