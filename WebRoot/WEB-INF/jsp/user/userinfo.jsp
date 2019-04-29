<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="en" style="font-size: 23.4375px;">

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
  

	<body >
	<input type="hidden" id="isparty" value="${user.isparty }">
	<a style="margin-top:0px;"><img style="background-size:contain|cover;width:100%;height: auto;" src="static/new/images/new/userinfo.png" alt=""/></a>
	<style>
        .justify{
            justify-content: center;
        }
        .align{
            align-items: center;
        }
        .wid{
            height: 5em;
        }
        
    </style>
    <style>
        .right{
		background:url("static/new/images/geren.png");
		width:200px;
		height=100px;
		}
    </style>
    
 <div class="page__bd page__bd_spacing  " style="margin-top:20px;">
	<div class="weui-flex">
		  <div class="weui-flex__item weui-flex justify align" >
				<span>
					<img src="${user.headimg}" style="border-radius:200px;height:60px;width:60px;">
				</span>
			</div>
		</div>
		
		<div class="weui-flex">
		  <div class="weui-flex__item weui-flex justify align" >
					<p>${user.uname}</p>
			</div>
		</div>	
	</div>

		
		<div class="weui-cells">
		
	
			   <a class="weui-cell weui-cell_access" href="<%=basePath%>users/edituser"">
				    <div class="weui-cell__hd"><img src="static/images/geren.png" style="height:32px;width:32px"></div>
				    <div class="weui-cell__bd">
				      <p>我的资料</p>
				    </div>
			    </a>
			   
		 
		  
		  
		  <a class="weui-cell weui-cell_access" href="<%=basePath%>partymember/yanzhengpartymem">
			    <div class="weui-cell__hd"><img src="static/images/bangding.png" style="height:32px;width:32px"></div>
			    <div class="weui-cell__bd">
			      <p>党员账号绑定</p>
			    </div>
		    </a>
		    
		  
		  

		  <a class="weui-cell weui-cell_access" href="<%=basePath%>login_toLogin">
		    <div class="weui-cell__hd"><img src="static/images/denglu.png" style="height:32px;width:32px"></div>
		    <div class="weui-cell__bd">
		       <p>党员账号登陆</p>
		    </div>
		   </a>

		  
		  <a class="weui-cell weui-cell_access" href="<%=basePath%>users/pwdedit">
		    <div class="weui-cell__hd"><img src="static/images/huanbang.png" style="height:32px;width:32px"></div>
		    <div class="weui-cell__bd">
		        <p>账号换绑</p>
		    </div>
		   </a>
		   
		   <a class="weui-cell weui-cell_access" href="javascript:;" id='exitsys'>
		    <div class="weui-cell__hd"><img src="static/images/zhuxiao.png" style="height:32px;width:32px"></div>
		    <div class="weui-cell__bd">
		        <p>退出账号</p>
		    </div>
		   </a>


	
		  
		</div>
		
		
		
   
		
		 <div class="weui-tabbar">
        <a href="<%=basePath%>mainindex" class="weui-tabbar__item">
          <div class="weui-tabbar__icon">
            <img src="static/new/images/dating.png" alt="">
          </div>
          <p class="weui-tabbar__label">用户服务</p>
        </a>
        <a onclick="partyzhuanqu()" class="weui-tabbar__item">
          <div class="weui-tabbar__icon">
            <img src="static/new/images/dangyuanzaixian.png" alt="">
          </div>
          <p class="weui-tabbar__label">党员在线</p>
        </a>
        <a href="<%=basePath%>users/showuserinfo.do" class="weui-tabbar__item weui-bar__item--on">
          <div class="weui-tabbar__icon">
            <img src="static/new/images/geren.png" alt="">
          </div>
          <p class="weui-tabbar__label">个人中心</p>
        </a>
      </div>
    </div>
	
	<script src="static/js/jquery.min.js"></script>
    <script src="https://cdn.bootcss.com/jquery/1.11.0/jquery.min.js"></script>
	<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/jquery-weui.min.js"></script>
	
	<script type="text/javascript">

 $(document).on("click", "#exitsys", function() {
        $.confirm("您确定要系统吗?", "退出系统", function() {
          window.location.href="<%=basePath%>logout"
        }, function() {
          //取消操作
        });
      });



function partyzhuanqu(){
if($("#isparty").val()=="1"){
window.location.href="<%=basePath%>partymember/partyzhuanqu.do";
}
else{
$.confirm("你还不是党员","是否先进行党员登陆？", function() {
 window.location.href="<%=basePath%>login_toLogin"
  }, function() {
  //点击取消后的回调函数
  });
}
}
	</script>	

	</body>
</html>
