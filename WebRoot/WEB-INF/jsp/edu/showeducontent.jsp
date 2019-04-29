<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<head>
<title>${pd.SYSNAME}</title>
<base href="<%=basePath%>">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
<meta name="description" content="">

<link rel="stylesheet" href="https://cdn.bootcss.com/weui/1.1.2/style/weui.min.css">
<link rel="stylesheet" href="https://cdn.bootcss.com/jquery-weui/1.2.0/css/jquery-weui.min.css">
<link rel="stylesheet" type="text/css" href="static/new/css/base.css">

<script src="https://cdn.bootcss.com/jquery/1.11.0/jquery.min.js"></script>


<script type="text/javascript" src="static/jqweui/yuqingjquery.qqFace.js"></script><!-- 表情js -->


<script type="text/javascript" src="static/js/ckplayer.js" charset="utf-8"></script>
	
	  
<style type="text/css">
.qqFace { margin-top: -4px; background: #fff; padding: 2px; border: 1px #dfe6f6 solid;}
.qqFace table td { padding: 0px; }
.qqFace table td img { cursor: pointer; border: 1px #fff solid; }
.qqFace table td img:hover { border: 1px #0066cc solid; }
</style>

</head>
  
<body ontouchstart>
  
  <header class="header" id="header" style="background-color:#e64340;position: static;">
<a href="javascript:history.back(-1)" target=_self class="back">返回</a>
</header>

<!-- 视频播放正文内容 -->
<article class="weui-article">
<h1 class="demos-title">${edu.courtit}</h1>
      <section>
      <ur class="weui-media-box__info">
      	<li class="weui-media-box__info__meta">${edu.uname}</li>
      	<li class="weui-media-box__info__meta">${edu.adddate}</li>
      </ur>
      </article>
      
      <article class="weui-article">
        <section>
  	
         	<input type="hidden" value="${edu.courass }" id="courass">
			<div id="videotest" style="width:640px;height:264px;"></div>
			
			 ${edu.coursum}
			
        </section>
      </section>
    </article>
    <!-- 以上是视频正文内容 -->
    
    <!-- 评论正文内容  提交表单-->
    <form action="" name="userForm" id="userForm" method="post" >
    <!-- 拿到数据 -->
		<input type="hidden" value="${user.uname }" id="uname">
		<input type="hidden" value="${user.headimg }" id="headimg">
		<input type="hidden" value="${user.uid }" id="uid">
		<input type="hidden" value="${edu.eid }" id="eid">
		
<!-- 写自己的评论开始   这里id是allcom -->
<div class="weui-panel" style="background:#EAEAEA;margin-top:0px;" id="allcom">
<!-- 点击评论 这里触发的方法是 com()  -->
	<div class="weui-panel__hd" style="font-size:15px;padding:8px;" >评论
		<a style="float:right;padding:2px;" onclick="com()"><img src="static/images/comm1.png" style="height:18px;width:22px;"></a>
	</div>
<!-- 评论框  这里id是ctip  -->	
	<div id="ctip" class="weui-cell" style="margin-top:5px;padding:8px;display:none">
		<!-- 评论输入框  这里id是ccontent  -->	
		<div class="weui-cell__bd">
			<input id="ccontent" class="weui-input" type="text" placeholder="评论内容由此输入">
		</div>
		<!-- 表情点击  这里的id是showwmoji 触发的方法是 showemoji() -->	
		<div class="weui-cell__ft">
			<a id="showemoji" onclick="showemoji()" ><img src="static/images/facesmile.png" style="height:26px;width:26px;display:inline"></a>
		</div>
	<!-- 评论提交 这里的id是ccommit 触发的方法是ccommit()-->
		<div class="weui-cell__ft">
			<a id="ccommit" onclick="ccommit()" class="weui-btn weui-btn_mini weui-btn_disabled weui-btn_primary" style="border-radius:10px;pointer-events: none;">发送</a>
		</div>
	</div>
<!-- 写自己的评论结束 -->

<!-- 遍历数据库相关的评论，显示在下方 -->
		<c:forEach items="${edu.educomment }" var="educomment" varStatus="vs">
		
        <div class="weui-panel__bd"  id="mycom${educomment.educid}${vs.index+1}">
        
        <div class="weui-media-box weui-media-box_appmsg" id="allowdel${educomment.educid }">
            <!-- 拿到头像 -->
            <div class="weui-media-box__hd" style="height:40px;margin-right:0px;">
              <img class="weui-media-box__thumb" style="border-radius:200px;height:40px;width:40px" src="${educomment.headimg }">
              </div>
            <!-- 拿到内容 -->  
            <div class="weui-media-box__bd">
              <p id="em${educomment.educid}" class="weui-media-box__desc" style="color:#000" onclick="showcomcon(${educomment.educid})">${educomment.comment }</p>
            <!-- 删除按钮 -->
            <p class="weui-media-box__desc" style="padding-top:4px;">${educomment.uname } ${educomment.datetime }
	          <a  style="float:right;">
	         	 <img onclick="delcom('${vs.index+1}','${educomment.educid}','${educomment.uid }')" class="cojud${educomment.isusercom}"  src="static/images/del.png" style="height:25px;width:20px;padding-top:5px;display:inline;pointer-events: none;">
	    	  </a>  
            </p>
            </div>
		</div>
		
        </div>
        
       <script>
           		$(toemoji('${educomment.educid}'));
           		function toemoji(educid){
           		var str = $("#em"+educid).text();
				$("#em"+educid).html(replace_em(str));
	           		}
		           		function replace_em(str){
						str = str.replace(/\</g,'&lt;');
						str = str.replace(/\>/g,'&gt;');
						str = str.replace(/\n/g,'<br/>');
						str = str.replace(/\[em_([0-9]*)\]/g,'<img src="static/jqweui/emoji/$1.gif" style="height:25px;width:25px;display:inline;" border="0" />');
						return str;
					}
   		</script>
        </c:forEach>

      </div>
<div ><input type="hidden"" id="end" readonly="readonly"></div>

</form>
<!-- 评论正文内容结束 -->

<!-- 视频播放器参数设置 -->
	<script type="text/javascript">
	var courass=$("#courass").val();
	
	var videoObject = {
		container: '#videotest',//“#”代表容器的ID，“.”或“”代表容器的class
		variable: 'player',//该属性必需设置，值等于下面的new chplayer()的对象
		flashplayer:false,//如果强制使用flashplayer则设置成true
		video: courass //视频地址
	};
	var player=new ckplayer(videoObject);
</script>

<!-- emoji黄豆表情展示 -->
<script type="text/javascript">
	$(showemoji());
	function showemoji(){
	$("#ctip").qqFace({
		id : 'facebox', 
		assign:'ccontent', 
		path:'static/jqweui/emoji/',	//表情存放的路径	
		imgid: 'showemoji',
		myemoji: 'ctip'
	});
	}

</script>

<script>
	//删除评论
	$(document).ready(function(){
$(".cojud1").css("pointer-events","auto");//前一个1代表已评价，后一个1代表评价的具体条目   //将本人评价的置为可删除
$(".cojud1").attr("src","static/images/mydel.png");
});
	
	function showcomcon(educid){
	//查看评论详情;
	window.location.href="<%=basePath%>edu/showeducomment?educid="+educid;
	}
	</script>

<script type="text/javascript">
function com(){ //点击评论按钮
$("#ctip").css("display","");
$("#ccontent").focus();
$("#ccontent").bind('input',function() {//发送按钮设置
  if($.trim($("#ccontent").val())!=""){
  $("#ccommit").css("pointer-events","auto"); //可点击
  $("#ccommit").attr("class","weui-btn weui-btn_mini weui-btn_primary"); //非灰态
  }else{
  $("#ccommit").css("pointer-events","none");//不可点击
  $("#ccommit").attr("class","weui-btn weui-btn_mini weui-btn_disabled weui-btn_primary");//灰态
  }
});
}

var num=-1;//标记每一次提交的序列号
function ccommit(){  //提交评论  新增
var uid=$("#uid").val();
var eid=$("#eid").val();
var date=new Date();
var coid=uid+date.getFullYear()+date.getMonth()+date.getDate()+date.getHours()+date.getMinutes()+date.getSeconds()+date.getMilliseconds()+""; //获取当前毫秒数
var comdate=date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate()+" "+date.getHours()+":"+date.getMinutes()+":"+date.getSeconds();
//以此作为评论编号 uid+年月日时分秒毫秒
var ccontent=$("#ccontent").val();
var headimg=$("#headimg").val();
 	var cuname=$("#uname").val();
 	var comstring="<div class=\"weui-panel__bd\"  id=\"mycom"+coid+num+"\">";
 	comstring+="<div class=\"weui-media-box weui-media-box_appmsg\" id=\"allowdel"+coid+"\">";
 	comstring+="<div class=\"weui-media-box__hd\" style=\"height:40px;margin-right:0px;\">";
 	comstring+="<img class=\"weui-media-box__thumb\" style=\"border-radius:200px;height:40px;width:40px\"    src=\""+headimg+"\"></div>";
 	comstring+="<div class=\"weui-media-box__bd\"><p id=\"mycomemoji"+num+"\" class=\"weui-media-box__desc\" style=\"color:#000\" onclick=\"showcomcon("+coid+")\">"+ccontent+"</p>";
 	comstring+="<p class=\weui-media-box__desc\" style=\"color:#999;font-size:13px;padding-top:4px;\">"+cuname+" "+comdate;
 	comstring+="<a onclick=\"delcom('"+num+"','"+coid+"','"+uid+"')\" style=\"float:right;\">";
 	comstring+="<img src=\"static/images/mydel.png\" style=\"height:25px;width:20px;padding-top:5px;display:inline;pointer-events: none;\">";
 	comstring+="</a></p></div></div></div>";
 	$("#allcom").append(comstring);  
 	$("#end").focus();
	$("#mycomemoji"+num).html(replace_em($("#mycomemoji"+num).text())); //解析表情
	$("#ccontent").val(""); //置空串
	$("#ccommit").css("pointer-events","none"); //不可点击
	$("#ccommit").attr("class","weui-btn weui-btn_mini weui-btn_disabled weui-btn_primary");//灰态
	$("#ctip").css("display","none");//隐藏
	num--;
	//后台操作
	$.post("edu/addeducomment",{uid:uid,educid:coid,comment:ccontent,eid:eid,datetime:comdate},function(data){
   			if(data.result!="success")
   			$.toast("出现错误", "cancel"); 
 			});
}

function delcom(comnum,educid,eid){//删除评论
var uid=$("#uid").val();
	if(uid==cuid){ //本人删除本人的评论
	$.confirm("","确认删除？", function() {
	$("#mycom"+educid+comnum).empty();
	//后台操作
	$.post("edu/deleteeducomment",{educid:educid},function(data){
   			if(data.result!="success")
   			$.toast("出现错误", "cancel"); 
 			});
			}, function() {
 	 //取消
 	 });
	}else{$.toast("错误操作", "cancel"); 
	}
	
}

</script>

<script type="text/javascript">
function replace_em(str){
					str = str.replace(/\</g,'&lt;');
					str = str.replace(/\>/g,'&gt;');
					str = str.replace(/\n/g,'<br/>');
					str = str.replace(/\[em_([0-9]*)\]/g,'<img src="static/jqweui/emoji/$1.gif" style="height:25px;width:25px;display:inline;" border="0" />');
					return str;
					}
</script>

  </body>
</html>
