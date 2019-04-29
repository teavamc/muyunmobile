<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="utf-8">
   <base href="<%=basePath%>">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
  <meta name="description" content="">
   <link rel="stylesheet" type="text/css" href="static/new/css/base.css">
	    	<link rel="stylesheet" href="https://cdn.bootcss.com/weui/1.1.2/style/weui.min.css">
<link rel="stylesheet" href="https://cdn.bootcss.com/jquery-weui/1.2.0/css/jquery-weui.min.css">
  <title></title>



</head>

<body>
<a onclick="tochange()" style="font-size:30px;"> 点我</a>  


<div>
经纬度：<p id="google_geo"></p><br>

</div>


	<script src="https://cdn.bootcss.com/jquery/1.11.0/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/jquery-weui.min.js"></script>

<!-- 如果使用了某些拓展插件还需要额外的JS -->
<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/swiper.min.js"></script>
<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/city-picker.min.js"></script>

<script type="text/javascript">
$(document).ready(function(){

//$("#google_geo").html('正在定位...'); 
});

function tochange(){
getLocation();
}


function getLocation(){ 
  if (navigator.geolocation){ 
    navigator.geolocation.getCurrentPosition(showPosition,showError); 
  }else{ 
    alert("浏览器不支持地理定位。"); 
  } 
} 

function showError(error){ 
  switch(error.code) { 
    case error.PERMISSION_DENIED: 
      alert("定位失败,用户拒绝请求地理定位"); 
      break; 
    case error.POSITION_UNAVAILABLE: 
      alert("定位失败,位置信息是不可用"); 
      break; 
    case error.TIMEOUT: 
      alert("定位失败,请求获取用户位置超时"); 
      break; 
    case error.UNKNOWN_ERROR: 
      alert("定位失败,定位系统失效"); 
      break; 
  } 
}

function showPosition(position){ 
  var lat = position.coords.latitude; //纬度 
  var lag = position.coords.longitude; //经度 
  alert('纬度:'+lat+',经度:'+lag); 
} 


function showPosition(position){ 
  var latlon = position.coords.latitude+','+position.coords.longitude; 
 
  //google 
  var url = 'http://maps.google.cn/maps/api/geocode/json?latlng='+latlon+'&language=CN'; 
  $.ajax({ 
    type: "GET", 
    url: url, 
    beforeSend: function(){ 
      $("#google_geo").html('正在定位...'); 
    }, 
    success: function (json) { 
      if(json.status=='OK'){ 
      var results = json.results; 
        $.each(results,function(index,array){ 
          if(index==0){ 
            $("#google_geo").html(array['formatted_address']); 
          } 
        }); 
      } 
    }, 
    error: function (XMLHttpRequest, textStatus, errorThrown) { 
      $("#google_geo").html(latlon+"地址位置获取失败"); 
    } 
  }); 
}

</script>

</body></html>