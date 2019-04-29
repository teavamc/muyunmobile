<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML>
<html lang="zh-CN">
<head>
<title>${pd.SYSNAME}</title>
<base href="<%=basePath%>">
<meta charset="utf-8">
<base href="<%=basePath%>">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
<meta name="description" content="">

<link rel="stylesheet" href="//res.wx.qq.com/open/libs/weui/1.1.0/weui.min.css" />
<link rel="stylesheet" href="https://cdn.bootcss.com/jquery-weui/1.2.0/css/jquery-weui.min.css">

<script type="text/javascript" src="static/js/jquery.min.js"></script>
<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/jquery-weui.min.js"></script>
<script type="text/javascript" src="static/new/js/hmac-sha1.js"></script>

</head>


<body>

	<form action="" method="post" name="registerForm" id="registerForm">
	
		<input type="hidden" value="${shouquan}" id="shouquan"> 
		<input type="hidden" id="isparty" value="${isparty}" />
		
		
		<input type="hidden" name="openid" value="${webchatUser.openid} " />
		<input type="hidden" name="nickname" value="${webchatUser.nickname}" />
		<input type="hidden" name="sex" value="${webchatUser.sex}" />
		<input type="hidden" name="avatar" value="${webchatUser.headimgurl}" />
		
		

		<%-- <c:choose>
			<c:when test="${weixin=='weixin'}">
				微信服务号 
				<input type="hidden" name="openid" value="${webchatUser.openid} " />
				<input type="hidden" name="nickname" value="${webchatUser.nickname}" />
				<input type="hidden" name="sex" value="${webchatUser.sex}" />
				<input type="hidden" name="avatar" value="${webchatUser.headimgurl}" />
			</c:when>
			<c:otherwise>
				企业微信号
				<input type="hidden" name="openid" value="${webchatUser.userid} " />
				<input type="hidden" name="nickname" value="${webchatUser.name}" />
				<input type="hidden" name="sex" value="${webchatUser.gender}" />
				<input type="hidden" name="avatar" value="${webchatUser.avatar}" />
			</c:otherwise>
		</c:choose>
--%>
	</form>
	
	<input type="hidden" value="${user.uname}" id="uname">
	<input type="hidden" value="${user.uid}" id="uid">
	<input type="hidden" value="${user.headimg}" id="headimg">
	<input type="hidden" value="${user.utypes}" id="utypes">


	<div class="weui-toptips weui-toptips_warn" id="toptip" style="background-color:green;">错误提示</div>

	<!--header-end-->
		
		
	<div class="container" id="container" style="background-color:#EAEAEA;">

		<!-- <a style="margin-top:0px;">
			<img src="static/new/images/new/mainfuwu.png" alt=""
			 style="background-size:contain|cover;width:100%;
			 height: auto;" />
		 </a>  -->
			
			<div class="weui-panel weui-panel_access">
				<div class="weui-panel__bd">
				
				<a class="weui-media-box weui-media-box_appmsg">
				
			      <div class="weui-media-box__bd">
			        <h4 style="font-size:40px" id="wtem"></h4>
			        <span id="wnow"></span>
			        <p class="weui-media-box__desc" id="wlocation"></p>
			        
			      </div>
			      <div class="weui-media-box__ft">
		        	<img id="wcodepic" width="120px" heigth="120px">
		      		</div>
			    </a>
			    
			    
			 </div>
			 </div>
			 
	<%-- <div class="weui-panel weui-panel_access">
	    
		<div class="weui-panel__hd">我的账号信息</div>
		<div class="weui-panel__bd">
		    <a class="weui-media-box weui-media-box_appmsg" href="javascript:;" id="showyjt">
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
		

	</script>	 --%>	 
		
	<%-- 	
	<div class="weui-panel weui-panel_access">
	<input type="button" onclick="javascript:window.location.reload() " value="刷新"/>
		<div class="weui-panel__hd">我的账号信息</div>
		<div class="weui-panel__bd">
		    <a class="weui-media-box weui-media-box_appmsg">
		      <div class="weui-media-box__hd">
		        <img class="weui-media-box__thumb" src="${user.headimg}">
		      </div>
		      <div class="weui-media-box__bd">
		        <h4 class="weui-media-box__title">${user.uname}</h4>
		        <p class="weui-media-box__desc">权限等级：${user.utypes}</p>
		        <p class="weui-media-box__desc">我的id：${user.uid}</p>
		      </div>
		      <div class="weui-media-box__ft">
		        <img  src="static/new/yjt.png" href="javascript:;" id="showyjt" width="30px" heigth="30px">
		      </div>
		    </a>
		   
		  </div>
	</div> --%>
	
		
<div class="weui-panel weui-panel_access">
<div class="weui-panel__hd">服务中心</div>
		<div class="weui-grids">

			<a href="<%=basePath%>policyinfo/showpolicyforuser.do"
				class="weui-grid js_grid">
				<div class="weui-grid__icon">
					<img src="static/new/images/new/icon/newgonggao.png" alt="">
				</div>
				<p class="weui-grid__label">政策公告</p>
			</a> <a href="<%=basePath%>edu/showalledu" class="weui-grid js_grid">
				<div class="weui-grid__icon">
					<img src="static/new/images/new/icon/newvideo.png" alt="">
				</div>
				<p class="weui-grid__label">在线学习</p>
			</a> <a href="<%=basePath%>pcircle/showpcircle" class="weui-grid js_grid">
				<div class="weui-grid__icon">
					<img src="static/new/images/new/icon/quan.png" alt="">
				</div>
				<p class="weui-grid__label">暮云圈</p>
			</a> <a href=" <%=basePath%>jobs/showj" class="weui-grid js_grid">
				<div class="weui-grid__icon">
					<img src="static/new/images/new/icon/newzhaoping.png" alt="">
				</div>
				<p class="weui-grid__label">求职招聘</p>
			</a> <a href="<%=basePath%>yuqing/showallyuqing"
				class="weui-grid js_grid">
				<div class="weui-grid__icon">
					<img src="static/new/images/new/icon/yuqing.png" alt="">
				</div>
				<p class="weui-grid__label">舆情上报</p>
			</a> <a href="<%=basePath%>guide/showguide" class="weui-grid js_grid">
				<div class="weui-grid__icon">
					<img src="static/new/images/new/icon/newzhinan.png" alt="">
				</div>
				<p class="weui-grid__label">办事指南</p>
			</a> <a href="<%=basePath%>feedback/selecttofeed"
				class="weui-grid js_grid">
				<div class="weui-grid__icon">
					<img src="static/new/images/new/icon/zixun.png" height=32 width=32
						alt="">
				</div>
				<p class="weui-grid__label">投诉咨询</p>
			</a> <a href="<%=basePath%>xiaocun/showallxiaocun"
				class="weui-grid js_grid">
				<div class="weui-grid__icon">
					<img src="static/new/images/new/icon/xiaocun.png" alt="">
				</div>
				<p class="weui-grid__label">小村家事</p>
			</a> <a href="<%=basePath%>friends/juzhen" class="weui-grid js_grid">
				<div class="weui-grid__icon">
					<img src="static/new/images/new/icon/huoban.png" alt="">
				</div>
				<p class="weui-grid__label">合作伙伴</p>
			</a>


		</div>
		</div>
		
		
		<div class="weui-panel weui-panel_access">
  <div class="weui-panel__hd">办事大厅</div>
  <div class="weui-panel__bd">
   
    <!-- <a  id="goshebao" class="weui-media-box weui-media-box_appmsg">
      <div class="weui-media-box__hd">
        <img class="weui-media-box__thumb" src="static/new/cars.jpg">
      </div>
      <div class="weui-media-box__bd">
        <h4 class="weui-media-box__title">长沙人设</h4>
        <p class="weui-media-box__desc"></p>
      </div>
    </a> -->
    
    <a href="javascript:;" id="goshebao2" class="weui-media-box weui-media-box_appmsg">
      <div class="weui-media-box__hd">
        <img class="weui-media-box__thumb" src="static/new/zhrs.jpg">
      </div>
      <div class="weui-media-box__bd">
        <h4 class="weui-media-box__title">智慧人设</h4>
        <p class="weui-media-box__desc">查询湖南省内五险一金（湖南社保）、查询社保信息；查询社保卡（社会保障卡）办理进度、激活社保卡（社会保障卡）等</p>
      </div>
    </a>
    
    <a href="javascript:;" id="gogongjijin" class="weui-media-box weui-media-box_appmsg">
      <div class="weui-media-box__hd">
        <img class="weui-media-box__thumb" src="static/new/csgjj.jpg">
      </div>
      <div class="weui-media-box__bd">
        <h4 class="weui-media-box__title">长沙公积金查询</h4>
        <p class="weui-media-box__desc">本服务由长沙住房公积金管理中心提供</p>
      </div>
    </a>
    
    <a href="javascript:;" id="gojiaotongweifachaban" class="weui-media-box weui-media-box_appmsg">
      <div class="weui-media-box__hd">
        <img class="weui-media-box__thumb" src="static/new/csgajj.jpg">
      </div>
      <div class="weui-media-box__bd">
        <h4 class="weui-media-box__title">长沙交通违法查询</h4>
        <p class="weui-media-box__desc">本服务由长沙交警提供</p>
      </div>
    </a>    
    
<!--     <a  id="go360news" class="weui-media-box weui-media-box_appmsg">
      <div class="weui-media-box__hd">
        <img class="weui-media-box__thumb" src="static/new/xsj.png">
      </div>
      <div class="weui-media-box__bd">
        <h4 class="weui-media-box__title">api接口测试</h4>
        <p class="weui-media-box__desc"></p>
      </div>
    </a> -->
    
  </div>
</div>
		
		
		<div class="weui-panel weui-panel_access">
  <div class="weui-panel__hd">优质应用推荐</div>
  <div class="weui-panel__bd">
    <a href="javascript:;" id="go" class="weui-media-box weui-media-box_appmsg">
      <div class="weui-media-box__hd">
        <img class="weui-media-box__thumb" src="static/new/xsj.png">
      </div>
      <div class="weui-media-box__bd">
        <h4 class="weui-media-box__title">星视界</h4>
        <p class="weui-media-box__desc">长沙县广播电视台出品，一款集电视直播回看新闻资讯为一体的本地生活化视频播放平台。</p>
      </div>
    </a>

    
  </div>
  <div class="weui-panel__ft">
    <a href="javascript:;" id="moreapps" class="weui-cell weui-cell_access weui-cell_link">
      <div class="weui-cell__bd">更多应用推荐</div>
      <span class="weui-cell__ft"></span>
    </a>    
  </div>
</div>

<!-- 这里是页面底部留白  误删  -->

<br>
<br>
<br>
<div class="weui-footer">
  <p class="weui-footer__text">Copyright © 2008-2016 张超 袁枭云</p>
</div>

	<!--container-end-->

	<div class="weui-tabbar" style="position:fixed;bottom:0px;" >
		<a href="<%=basePath%>mainindex"
			class="weui-tabbar__item weui-bar__item--on">
			<div class="weui-tabbar__icon">
				<img src="static/new/images/dating.png" alt="">
			</div>
			<p class="weui-tabbar__label">用户服务</p>
		</a> <a onclick="partyzhuanqu()" class="weui-tabbar__item">
			<div class="weui-tabbar__icon">
				<img src="static/new/images/dangyuanzaixian.png" alt="">
			</div>
			<p class="weui-tabbar__label">党员在线</p>
		</a> <a href="<%=basePath%>users/showuserinfo.do"
			class="weui-tabbar__item">
			<div class="weui-tabbar__icon">
				<img src="static/new/images/geren.png" alt="">
			</div>
			<p class="weui-tabbar__label">个人中心</p>
		</a>
	</div>
	</div>

	<script src="static/js/jquery.min.js"></script>
	<script src="static/js/jquery-1.7.2.js"></script>
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript" src="static/js/jquery.cookie.js"></script>
	<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/jquery-weui.min.js"></script>
	<script type="text/javascript">
	
	$(document).ready(function(){  
	var shouquan=$("#shouquan").val();
	
	if(shouquan=="shouquan"){//授权跳转而来         自动注册
			$.ajax({
					type: "POST",
					url: "<%=basePath%>mainindexfunction.do",
			    	data: $("#registerForm").serializeArray(),
					dataType:'json',
					cache: false,
					success: function(data1){
						if("sessionno" == data1.sessionno){
							window.location.href="<%=basePath%>login_toLogin";
						}
						else{
						$("#isparty").val(data1.isparty);
						}
					}
				});  		
}else{
	var isparty=${isparty}
	$("#isparty").val(isparty);
	}

	});
	</script>
	
	<script type="text/javascript">
	//调用心知天气api
	
	  var UID = "UCED0E4AAB"; // 我自己的id
	  var KEY = "uo8gc9i0ecvmxrxw"; // 我自己key 免费版
	  var API = "http://api.seniverse.com/v3/weather/now.json"; // 获取天气实况
	  var LOCATION = "changsha"; // 除拼音外，还可以使用 v3 id、汉语等形式
	  
	  // 获取当前时间戳
	  var ts = Math.floor((new Date()).getTime() / 1000);
	  
	  // 构造验证参数字符串
	  var str = "ts=" + ts + "&uid=" + UID;
	  
	  // 使用 HMAC-SHA1 方式，以 API 密钥（key）对上一步生成的参数字符串（raw）进行加密
	  // 并将加密结果用 base64 编码，并做一个 urlencode，得到签名 sig
	  var sig = CryptoJS.HmacSHA1(str, KEY).toString(CryptoJS.enc.Base64);
	  sig = encodeURIComponent(sig);
	  str = str + "&sig=" + sig;
	  
	  var jsonpCallback = function(data) {
	    //var obj = document.getElementById('weathervalue01');
	    var weather = data.results[0];
	     
	    //var text = [];
	    /* text.push("位置: " + weather.location.name);
	    text.push("天气情况: " + weather.now.text);
	    text.push("现在温度: " + weather.now.temperature + "°C");
	    obj.innerText = text.join("\n"); */
	    
	    //单独拿出来
	    var weather_location =  weather.location.name;
	    var weather_now = weather.now.text;
	    var weather_now_tem = weather.now.temperature;
	    var weather_now_code = weather.now.code;
	    
	    //都扔给html
	    $("#wlocation").text("今日" + weather_location);
	    $("#wnow").text("当前天气：" + weather_now);
	    $("#wtem").text(weather_now_tem + "°C");
	    
	    //根据code显示图片
    	if(weather_now_code){
	    	$("#wcodepic").attr("src","static/new/3d_60/"+weather_now_code+".png");
	    }else{
	    	$("#wcodepic").attr("src","static/new/3d_60/99.png");
	    }
	   }
	  
	  // 构造最终请求的 url
	  var url = API + "?location=" + LOCATION + "&" + str + "&callback=jsonpCallback";
	  
	  // 向 HTML 中动态插入 script 标签，通过 JSONP 的方式进行调用
	  var newScript = document.createElement('script');
	  newScript.type = 'text/javascript';
	  newScript.src = url;
	  $('body').append(newScript);
	
	</script>


	<script type="text/javascript">

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



<script type="text/javascript">

$(document).ready(function(appchoose) {
    var userdevices = navigator.userAgent, app = navigator.appVersion;
    var isAndroid = userdevices.indexOf('Android') > -1 || userdevices.indexOf('Linux') > -1; //android终端或者uc浏览器
    var isiOS = !!userdevices.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/); //ios终端
    if(isAndroid == true){
        //alert("这是Android手机")
        $("#go").attr("href","http://count.liqucn.com/d.php?id=1007541&urlos=android&from_type=web ");
    }
    else if(isiOS == true){
        //alert("这是IOS手机")
        $("#go").attr("href","https://itunes.apple.com/cn/app/%E6%98%9F%E6%B2%99%E6%98%9F%E8%A7%86%E7%95%8C/id1331848755?mt=8");
    }
});


$(document).on("click", "#moreapps", function() {
        $.alert("暂无更多应用推荐哟~");
      });

   
$(document).on("click", "#goshebao2", function() {
	window.location.href="http://www.e91job.com/apptest/pages/person/main.jsp?apptype=zhrs&ToolBar=0&checkcode=c031acf8a3354e1892912d0de06dadfc&intype=0&openid=ocP_VskMN-l3bOeacYRzt0-meav8&secondTakeOpenid=secondTakeOpenid";
});

$(document).on("click", "#gogongjijin", function() {
	window.location.href="https://wx.csgjj.com.cn/dsbcs/weixin/login.jsp"
});

$(document).on("click", "#gojiaotongweifachaban", function() {
	window.location.href="http://csjj.daxiangw.com/reception/personalcenter/tube"
});



<%-- $(document).on("click", "#go360news", function() {
	window.location.href="<%=basePath%>news360/shownews"
}); --%>

</script>

</body>
</html>

