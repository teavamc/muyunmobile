<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html >
<head>
<meta charset="utf-8"/>
<title>${pd.SYSNAME}</title>
<base href="<%=basePath%>">
  <meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
		<meta name="description" content="">

<link rel="stylesheet" href="https://cdn.bootcss.com/weui/1.1.2/style/weui.min.css">

<script src="https://cdn.bootcss.com/jquery/1.11.0/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/jquery-weui.min.js"></script>
<link rel="stylesheet" href="https://cdn.bootcss.com/jquery-weui/1.2.0/css/jquery-weui.min.css"><%-- weui-js-css --%>

<link rel="stylesheet" href="http://cdn.amazeui.org/amazeui/2.7.2/css/amazeui.css">


<script type="text/javascript" src="static/jqweui/jquery.qqFace.js"></script><!-- 表情js -->

<style type="text/css">

.qqFace { margin-top: -4px; background: #fff; padding: 2px; border: 1px #dfe6f6 solid;}
.qqFace table td { padding: 0px; }
.qqFace table td img { cursor: pointer; border: 1px #fff solid; }
.qqFace table td img:hover { border: 1px #0066cc solid; }

</style>

</head>
<body>
<div id="show"></div>


<header data-am-widget="header" class="am-header am-header-default">
      <div class="am-header-left am-header-nav">
          <a href="javascript:history.go(-1)" class="">
                <i class="am-header-icon am-icon-reply"></i>
          </a>
      </div>
        <h1 class="am-header-title">
          <a href="#title-link" class="">暮云圈</a>
      </h1>
       <div class="am-header-right am-header-nav">
          <a onclick="writecom(${user.uid})" class="">
                <i class="am-header-icon am-icon-plus"></i>
          </a>
      </div>
  </header>


<script type="text/javascript">
	//发表暮云圈
	function writecom(uid){
		var edit=$("#edit").val(); 
		if(edit!="toedit"){ //管理者进入管理暮云圈
		window.location.href="<%=basePath%>pcircle/pcircleinsert?uid="+uid;
		}else{
			$.toast("管理员不支持在此发布暮云圈！", "cancel"); 
		}
	}
</script>


<div>

<div style="position:relative;">
 <img  class="am-img-responsive" src="static/new/images/new/pyqtt.jpg" />
    <div style="position:absolute; top:170px; right:15px;">
    <img class="am-img-thumbnail am-radius"  onclick="openmycircle(${user.uid})" alt="120*120" src="${userheadimg}" width="120" height="120" />
    </div>
     <div style="position:absolute; top:165px; right:145px;">
    <p style="margin-top:50px;color:#F8F8FF;align="right"" ><strong>${user.uname}</strong></p>
    </div>
</div>
<p style="margin-top:50px;" ><strong></strong></p>
</div>
		
		<input type="hidden" value="${user.uname}" id="uname">
		<input type="hidden" value="${user.uid}" id="uid">
		
		<input type="hidden" value="${mytip}" id="mytip"> <!-- 个人标志 -->
		<input type="hidden" value="${downuid}" id="downuid"> <!-- 个人暮云圈的uid -->
		
		<input type="hidden" value="${pd.edit}" id="edit"><!-- 管理者进入修改权限 -->
		
    <c:choose>
    <c:when test="${not empty pcircle}">
    <c:forEach items="${pcircle}" var="circle" varStatus="vs"> 
     <!-- 新 -->
   	<input type="hidden" value="${circle.ispr}" id="ispr${circle.pcid}" >
   	<input type="hidden" value="${circle.prnum}" id="prnum${circle.pcid}">
             
        <div class="weui-panel" >
        <div class="weui-panel__bd">
        <div class="weui-media-box weui-media-box_appmsg" >
            <div class="weui-media-box__hd" style="height:40px;margin-right:0px;">
              <img class="weui-media-box__thumb" onclick="openmycircle(${circle.uid})" style="border-radius:200px;height:40px;width:40px" src="${circle.headimg}">
              </div>
            <div class="weui-media-box__bd">
              <h4 class="weui-media-box__title" style="color:#0000FF;">${circle.uname}</h4>
              <p class="weui-media-box__desc">${circle.adddate}</p>
            </div>
            <div class="weui-cell__ft" style="height:60px;text-align:left;">
            <!-- 新 1.21  加入2个class="${circle.ispr}"-->
            
            <a id="zanf${circle.pcid}" class="pr${circle.ispr}" onclick="zan(${circle.pcid},${circle.tbPcpraise.size()})" style="height:18px;margin-bottom:5px;"><img class="pr${circle.ispr}" id="zani${circle.pcid}" src="static/images/zan1.png" style="height:22px;width:22px;display:inline">赞</a>
            <a onclick="com(${circle.pcid})"><img src="static/images/comm1.png" style="height:18px;width:22px;display:inline;">评论</a>
         <a class="delcir${circle.ismycircle}" onclick="delcir('${circle.pcid}','${circle.uid}')" style="display:none;"><img src="static/images/delcircle.png" style="height:18px;width:22px;display:inline">删除</a>
            
            </div>
          
          </div>
        <div class="weui-media-box weui-media-box_appmsg" >
        <div class="weui-media-box__bd">
        <!-- 1.23 表情插入 -->
        
             <h4 class="weui-media-box__title" id="em${circle.pcid}" onclick="toemoji('${circle.pcid}')" style="margin-top:-10px;white-space:normal;">${circle.pcontent}
              
             </h4>
             
             	<script>
             		$(toemoji('${circle.pcid}'));
             		function toemoji(pcid){
             		var str = $("#em"+pcid).text();
					$("#em"+pcid).html(replace_em(str));
             		}
             		function replace_em(str){
					str = str.replace(/\</g,'&lt;');
					str = str.replace(/\>/g,'&gt;');
					str = str.replace(/\n/g,'<br/>');
					str = str.replace(/\[em_([0-9]*)\]/g,'<img src="static/jqweui/emoji/$1.gif" style="height:25px;width:25px;display:inline;" border="0" />');
					return str;
					}
             	</script>
             <!-- 1.22 图片 -->
             
             <div class="weui-uploader__bd">
             
              <ul class="weui-uploader__files" >  
              <c:choose>
              	<c:when test="${not empty circle.url }">
              	<c:forEach items="${circle.url }" var="u" varStatus="vs">
              		<li class="weui-uploader__file" onclick="showimg(${circle.pcid},${circle.url.size()},${vs.index+1})" >
                	<img id="img${circle.pcid}${vs.index+1}" src="<%=basePath%>pcircle/showpcircleimage?url='${u}'" style="height:75px;">
                	</li>
              	</c:forEach>
              	</c:when>
     			</c:choose>
              </ul>
            </div>
            
             
			<!-- 新 -->
			<p class="co${circle.pcid}" class="weui-media-box__desc" style="padding-bottom:8px;color:#0000FF;font-size:15px;display:none;background:beige;">
			<img class="pr${circle.pcid}" src="static/images/zan.png" style="height:30px;width:30px;display:inline;"></p>
             
             <c:if test="${circle.tbPcpraise.size()!=0}">
             <p id="co${circle.pcid}" class="weui-media-box__desc" style="padding-bottom:8px;color:#0000FF;font-size:15px;background:beige;">
			<img id="pr${circle.pcid}" src="static/images/zan.png" style="height:30px;width:30px;display:inline">
             <c:forEach items="${circle.tbPcpraise}" var="praise" varStatus="vs">
           <!-- 新 增加span -->  <span id="${circle.pcid}${vs.index+1}"> ${praise.uname}，</span>
             </c:forEach>
           <!-- 新 增加span input-->  
           <input type="hidden" id="ptinput${circle.pcid}" value="${circle.prtotal }"> 
           	等<span id="ptotal${circle.pcid}">${circle.prtotal}</span>人觉得赞</p>
             </c:if>
             <c:if test="${circle.tbPccomment!=null}">
             <c:forEach items="${circle.tbPccomment}" var="comment" varStatus="vs">
             <!-- 1.21 -->
             <p id="mycom${circle.pcid}${vs.index+1}" class="weui-media-box__desc" style="font-size:15px;background:beige;">
             <!-- comment 用span环绕 -->
             <span style="color:#0000FF">${comment.uname}:</span><span id="mycomemoji${circle.pcid}${vs.index+1}">${comment.ccontent}</span>
     <img class="cojud${circle.iscom}${comment.isusercom}" onclick="delcom(${circle.pcid},${vs.index+1},'${comment.coid}')" src="static/images/del.png" style="height:25px;width:20px;padding-top:10px;display:inline;pointer-events: none;">
             </p>
             <!-- 解析评论表情 -->
             <script>
             		$(comtoemoji('${circle.pcid}','${vs.index+1}'));
             		function comtoemoji(pcid,index){
             		var str = $("#mycomemoji"+pcid+index).text();
					$("#mycomemoji"+pcid+index).html(replace_em(str));
             		}
             	</script>
             </c:forEach>
             </c:if>
								
		<div id="ctip${circle.pcid}" class="weui-cell" style="margin-top:5px;padding:5px 5px;display:none">
		<div class="weui-cell__bd">
		<input id="ccontent${circle.pcid}" class="weui-input" type="text" placeholder="评论内容由此输入">
		</div>
		
		<!-- 1.24评论表情 -->
	<div class="weui-cell__ft">
	<a id="showemoji${circle.pcid}" onclick="showemoji('${circle.pcid}')" ><img src="static/images/facesmile.png" style="height:26px;width:26px;display:inline"></a>
	</div>
	<script type="text/javascript">
		//表情
		$(showemoji('${circle.pcid}'));
		function showemoji(pcid){
		$("#ctip"+pcid).qqFace({
			id : 'facebox', 
			assign:'ccontent'+pcid, 
			path:'static/jqweui/emoji/',	//表情存放的路径	
			imgid: 'showemoji'+pcid,
			myemoji: 'ctip'+pcid
		});
		}
	
	</script>
				<div class="weui-cell__ft">
					<a id="ccommit${circle.pcid}" onclick="ccommit(${circle.pcid})" class="weui-btn weui-btn_mini weui-btn_disabled weui-btn_primary" style="border-radius:10px;pointer-events: none;">发送</a>
				</div>			
			</div>
			
			</div>
          </div> 
        </div>
      </div>
  </c:forEach>
  </c:when>
  <c:otherwise>
  <div><h2 style="color:#008080;text-align:center;">暂无</h2></div>
	</c:otherwise>
  </c:choose>
  



	<div class="list"></div>
	
	<div class="weui-loadmore">
		<i class="weui-loading"></i> <span class="weui-loadmore__tips">正在加载</span>
	</div>
	
	<div id="more" style="display:none;text-align:center;">
		<span style="color:#808080;">没有更多内容了</span>
	</div>
	
	
	<!-- 敏感词汇集合-->
	<c:forEach items="${SenList}" var="sen" varStatus="vs">
     	<input id="sen${vs.index}" value="${SenList[vs.index]}" type="hidden"/> 
     </c:forEach>


<!-- 如果使用了某些拓展插件还需要额外的JS -->

<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/swiper.min.js"></script>
<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/city-picker.min.js"></script>
 <script type="text/javascript">
  function delcom(pcid,comnum,coid){//删除评论
	//alert(coid);
	var edit=$("#edit").val(); 
	if(edit=="toedit"){ //管理者进入管理暮云圈
	$("#mycom"+pcid+comnum).empty();
	//后台操作
	$.post("pcircle/deletecomment",{coid:coid},function(data){
   			if(data.result!="success")
   			$.toast("出现错误", "cancel"); 
 			});
 		}else{
 			$.toast("错误操作", "cancel"); 
 		}
 		
 			
}
 </script>
<script type="text/javascript">
$(document).ready(function(){//根据ispr 已点赞其class值为1，将对应的CSS变化
$(".pr1").css("color","#d81e06");
$(".pr1").attr("src","static/images/zan2.png");
	var edit=$("#edit").val(); 
	if(edit=="toedit"){ //管理者进入管理暮云圈
	$(".cojud11").css("pointer-events","auto");//前一个1代表已评价，后一个1代表评价的具体条目   //将本人评价的置为可删除
	$(".cojud11").attr("src","static/images/mydel.png");
	$(".cojud1").css("pointer-events","auto");  //非本人评论可删除
    $(".cojud1").attr("src","static/images/mydel.png");
    $(".cojud").css("pointer-events","auto");  //非本人评论可删除
    $(".cojud").attr("src","static/images/mydel.png");
	$(".delcir1").css("display","inline"); //使暮云圈可删除
	$(".delcir0").css("display","inline"); 
	}
});



</script>
	<script type="text/javascript">
	var uid=$("#uid").val();
function zan(pcid,size){
var uname=$("#uname").val();
var prnum=$("#prnum"+pcid).val();
var ptinput=Number($("#ptinput"+pcid).val());
	if($("#ispr"+pcid).val()==1){//判断用户是否已点赞   
	$("#zanf"+pcid).css("color","#999");
	$("#zani"+pcid).attr("src","static/images/zan1.png");
	$("#ispr"+pcid).val(0);
	$("#"+pcid+prnum).empty();//已点赞，取消点赞
	$("#prnum"+pcid).val(0);
	$("#ptotal"+pcid).text(ptinput-1);
	$("#ptinput"+pcid).val(ptinput-1);
	if(ptinput==1){
	$("#co"+pcid).hide();
	$(".co"+pcid).hide();
	}
	//后台请求
	$.post("pcircle/deletepraise",{uid:uid,pcid:pcid},function(data){
   			if(data.result!="success")
   			$.toast("出现错误", "cancel"); 
 			});
	}
	else if(size==0){ //没有一个人点赞  进行点赞
	$("#co"+pcid).show();
	$(".co"+pcid).show();
	$("#pr"+pcid).after("<span id=\""+pcid+"0\">"+uname+"，");
	$("#ptotal"+pcid).text(ptinput+1);
	$("#ptinput"+pcid).val(ptinput+1);
	$(".pr"+pcid).after("<span id=\""+pcid+"0\">"+uname+"，等<span id=\"ptotal"+pcid+"\">1</span>人觉得赞</span><input type=\"hidden\" id=\"ptinput"+pcid+"\" value=\"1\">");
	$(".co"+pcid).css("display","block");
	$("#zanf"+pcid).css("color","#d81e06");
	$("#zani"+pcid).attr("src","static/images/zan2.png");
	$("#ispr"+pcid).val(1);
	$("#prnum"+pcid).val(0);
	//后台功能
	$.post("pcircle/addpraise",{uid:uid,pcid:pcid},function(data){
   			if(data.result!="success")
   			$.toast("出现错误", "cancel"); 
 			});
	}
	else{ //用户没点赞，进行点赞
	$("#co"+pcid).show();
	$("#pr"+pcid).after("<span id=\""+pcid+"0\">"+uname+"，</span>");  
	$("#zanf"+pcid).css("color","#d81e06");
	$("#zani"+pcid).attr("src","static/images/zan2.png");
	$("#ispr"+pcid).val(1);
	$("#ptotal"+pcid).text(ptinput+1);
	$("#ptinput"+pcid).val(ptinput+1);
	//后台功能
	$.post("pcircle/addpraise",{uid:uid,pcid:pcid},function(data){
   			if(data.result!="success")
   			$.toast("出现错误", "cancel"); 
 			});
	}

}

function com(pcid){ //点击评论按钮
var edit=$("#edit").val(); 
if(edit!="toedit"){
$("#ctip"+pcid).css("display","");
$("#ccontent"+pcid).focus();
$("#ccontent"+pcid).bind('input',function() {//发送按钮设置
  if($.trim($("#ccontent"+pcid).val())!=""){
  $("#ccommit"+pcid).css("pointer-events","auto"); //可点击
  $("#ccommit"+pcid).attr("class","weui-btn weui-btn_mini weui-btn_primary"); //非灰态
  }else{
  $("#ccommit"+pcid).css("pointer-events","none");//不可点击
  $("#ccommit"+pcid).attr("class","weui-btn weui-btn_mini weui-btn_disabled weui-btn_primary");//灰态
  }
});	}else{
	$.toast("管理员不支持在此评论暮云圈！", "cancel"); 
}

}

var num=-1;//标记每一次提交的序列号
function ccommit(pcid){  //提交评论  新增
var date=new Date();
var coid=uid+date.getFullYear()+date.getMonth()+date.getDate()+date.getHours()+date.getMinutes()+date.getSeconds()+date.getMilliseconds()+""; //获取当前毫秒数
//以此作为评论编号 uid+年月日时分秒毫秒
var ccontent=$("#ccontent"+pcid).val();
 	var cuname=$("#uname").val();
 	$("#ctip"+pcid).before("<p id=\"mycom"+pcid+num+"\" class=\"weui-media-box__desc\" style=\"font-size:15px;background:beige;\"><span style=\"color:#0000FF\">"+cuname+":</span><span id=\"mycomemoji"+pcid+num+"\">"+ccontent+"</span><img onclick=\"delcom('"+pcid+"','"+num+"','"+coid+"')\" src=\"static/images/del.png\" style=\"height:25px;width:20px;padding-top:10px;display:inline;\"></p>");  
		$("#mycomemoji"+pcid+num).html(replace_em($("#mycomemoji"+pcid+num).text())); //解析表情
	$("#ccontent"+pcid).val(""); //置空串
	$("#ccommit"+pcid).css("pointer-events","none"); //不可点击
	$("#ccommit"+pcid).attr("class","weui-btn weui-btn_mini weui-btn_disabled weui-btn_primary");//灰态
	$("#ctip"+pcid).css("display","none");//隐藏
	num--;
	
	//判断评论内容是否含有敏感字符
    var sennum=${sennum};
    var sensitiveWordsList=new Array(sennum);//定义敏感数组的长度=传递过来的敏感数组长度
    for(var k=0;k<sennum;k++){
	sensitiveWordsList[k]=$("#sen"+k).val();// 敏感词库
	}
    // 过滤后的文字
    var outText = "";
    // 遍历敏感词库，替换为*，并把处理后的文字赋值给outText
    for(var i=0;i<sensitiveWordsList.length;i++){
        var pattern = new RegExp(sensitiveWordsList[i],"ig");  // i --对大小写不敏感的匹配        //  g --全局匹配
        if(i == 0){
            outText = ccontent.replace(pattern,"*");          
        }else{
            outText = outText.replace(pattern,"*");      
        }             
    };
    if(outText!=ccontent){//含有敏感字符
        var judgesen=1;
        alert("含有敏感字符");
        alert(outText);
    }else{  //不含有
        var judgesen=0;
    }
	
	
	//后台操作
	$.post("pcircle/addcomment",{uid:uid,pcid:pcid,ccontent:ccontent,coid:coid,issensitive:judgesen},function(data){
   			if(data.result!="success")
   			$.toast("出现错误", "cancel"); 
 			});
}



 function delcir(pcid,deluid){//删除我的暮云圈
 
	$.confirm("","确认删除？", function() {
  	var edit=$("#edit").val(); 
	if(edit=="toedit"){ //管理者进入管理暮云圈
  		//后台操作
  		$.post("pcircle/deletecircle",{pcid:pcid},function(data){
   			if(data.result!="success")
   			$.toast("出现错误", "cancel"); 
   			else history.go(0);
 			});
  	}
  	}, function() {
 	 //取消
 	 });
  	} 



</script>
	<script type="text/javascript">
		$(document).ready(function(){
		var my=$("#myxiaocun").val();
		if(my=="myxiaocun"){
		$("#a1").attr("class","weui-btn weui-btn_mini weui-btn_disabled weui-btn_warn");
		$("#a2").attr("class","weui-btn weui-btn_mini weui-btn_warn");
		}else{
		}
	var firstfeednum=${firstfeednum};
	if(firstfeednum<innerHeight/120){//隐藏加载
	$(".weui-loadmore").hide();
	}else{//出现加载
	}
	});
	var edit=$("#edit").val(); //管理者进入管理暮云圈标志
	var mytip=$("#mytip").val();//以此判断是个人暮云圈还是全部
	var downuid=$("#downuid").val();//以此判断是个人暮云圈还是全部
  	var loading = false;  //状态标记
	var length=${pd.length}+"";
  	var tip=1;
	$(document.body).infinite().on("infinite", function() {
  	if(loading) return;
  	loading = true;
	  $.ajax({  
					type: "POST",
					url: "<%=basePath%>pcircle/showpcirclemore.do",
			    	data:  "tip="+tip+"&length="+length+"&mytip="+mytip+"&downuid="+downuid,
					dataType:'json',
					cache: false,
					success: function(d){
					if(d.stop=="stop"){
					$(document.body).destroyInfinite();
					$("#more").css("display","block");
					$(".weui-loadmore").hide();
					}
					else if(d.success=="1"){	
					//alert(d.praise1);	
					//评论表情解析
					var aphtml1="<div class=\"weui-cell__ft\"><a id=\"showemoji"+d.pcid1+"\" onclick=\"showemoji('"+d.pcid1+"')\" ><img src=\"static/images/facesmile.png\" style=\"height:26px;width:26px;display:inline\"></a></div>";		
					aphtml1+="<div class=\"weui-cell__ft\"><a id=\"ccommit"+d.pcid1+"\" onclick=\"ccommit('"+d.pcid1+"')\" class=\"weui-btn weui-btn_mini weui-btn_disabled weui-btn_primary\" style=\"border-radius:10px;pointer-events: none;\">发送</a></div></div></div></div></div></div>";
					$(".list").append("<input type=\"hidden\" value=\""+d.ispr1+"\" id=\"ispr"+d.pcid1+"\"><input type=\"hidden\" value=\""+d.prnum1+"\" id=\"prnum"+d.pcid1+"\"><div class=\"weui-panel\" ><div class=\"weui-panel__bd\"><div class=\"weui-media-box weui-media-box_appmsg\" ><div class=\"weui-media-box__hd\" style=\"height:40px;margin-right:0px;\"><img onclick=\"openmycircle("+d.pcid1+")\" class=\"weui-media-box__thumb\" style=\"border-radius:200px;height:40px;width:40px\" src=\""+d.headimg1+"\"></div><div class=\"weui-media-box__bd\"><h4 class=\"weui-media-box__title\" style=\"color:#0000FF;\">"+d.uname1+"</h4><p class=\"weui-media-box__desc\">"+d.adddate1+"</p></div><div class=\"weui-cell__ft\" style=\"height:60px;text-align:left;\"><a id=\"zanf"+d.pcid1+"\" class=\"down"+d.ispr1+"\" onclick=\"zan('"+d.pcid1+"','"+d.prtotal1+"')\" style=\"height:18px;margin-bottom:5px;\"><img class=\"down"+d.ispr1+"\" id=\"zani"+d.pcid1+"\" src=\"static/images/zan1.png\" style=\"height:18px;width:22px;display:inline\">赞</a><a onclick=\"com('"+d.pcid1+"')\"><img src=\"static/images/comm1.png\" style=\"height:18px;width:22px;display:inline\">评论</a><a class=\"delcir"+d.ismycircle1+"\" onclick=\"delcir('"+d.pcid1+"','"+d.uid1+"')\" style=\"display:none;\"><img src=\"static/images/delcircle.png\" style=\"height:18px;width:22px;display:inline\">删除</a></div></div><div class=\"weui-media-box weui-media-box_appmsg\" ><div class=\"weui-media-box__bd\"><h4 id=\"em"+d.pcid1+"\" onclick=\"toemoji('"+d.pcid1+"')\" class=\"weui-media-box__title\" style=\"margin-top:-10px;\">"+d.pcontent1+"</h4><div class=\"weui-uploader__bd\"><ul class=\"weui-uploader__files\" id=\"imgulid"+d.pcid1+"\"></ul></div><p id=\"co"+d.pcid1+"\" class=\"weui-media-box__desc\" style=\"padding-bottom:8px;color:#0000FF;font-size:15px;background:beige;\"><img id=\"pr"+d.pcid1+"\" src=\"static/images/zan.png\" style=\"height:30px;width:30px;display:inline\"><input type=\"hidden\" id=\"ptinput"+d.pcid1+"\" value=\""+d.prtotal1+"\">等<span id=\"ptotal"+d.pcid1+"\">"+d.prtotal1+"</span>人觉得赞</p><div id=\"ctip"+d.pcid1+"\" class=\"weui-cell\" style=\"margin-top:5px;padding:5px 5px;display:none\"><div class=\"weui-cell__bd\"><input id=\"ccontent"+d.pcid1+"\" class=\"weui-input\" type=\"text\" placeholder=\"评论内容由此输入\"></div>"+aphtml1);
						if(edit=="toedit"){
						$(".delcir1").css("display","inline");
						$(".delcir0").css("display","inline"); 
						} //管理员 置暮云圈可删除
					showemoji(d.pcid1);//初始化表情选择
					
					toemoji(d.pcid1);//解析表情
					$(".down1").css("color","#d81e06"); //将已点赞的人的图标 字体换色
					$(".down1").attr("src","static/images/zan2.png");
					if(d.praise1=="" || d.praise1==null) //若无赞则隐藏
					$("#co"+d.pcid1).hide(); 
					$.each(d.url1, function(i,item){ //图片集合
					i=d.urltotal1-i;
                	$("#imgulid"+d.pcid1).after("<li class=\"weui-uploader__file\" onclick=\"showimg("+d.pcid1+","+d.urltotal1+","+i+")\" ><img id=\"img"+d.pcid1+i+"\" src=\"<%=basePath%>pcircle/showpcircleimage?url='"+item+"'\" style=\"height:75px;\"></li>"); 
            		});
					$.each(d.praise1, function(i,item){ //点赞集合
                	$("#pr"+d.pcid1).after("<span id="+d.pcid1+(++i)+"> "+item.uname+"，</span>"); 
            		});
            		$.each(d.comment1, function(i,item){ //评论集合
                	$("#co"+d.pcid1).after("<p id=\"mycom"+d.pcid1+(++i)+"\" class=\"weui-media-box__desc\" style=\"font-size:15px;background:beige;\"><span style=\"color:#0000FF\">"+item.uname+":</span><span id=\"mycomemoji"+d.pcid1+i+"\">"+item.ccontent+"</span><img class=\"cojud"+d.iscom1+item.isusercom+"\" onclick=\"delcom('"+d.pcid1+"','"+i+"','"+item.coid+"')\" src=\"static/images/del.png\" style=\"height:25px;width:20px;padding-top:10px;display:inline;pointer-events:none;\"></p>"); 
            		comtoemoji(d.pcid1,i);//解析评论表情
            		});
            			if(edit=="toedit"){
            			$(".cojud11").css("pointer-events","auto");  //本人评论可删除
            			$(".cojud11").attr("src","static/images/mydel.png");
            			$(".cojud1null").css("pointer-events","auto");  //非本人评论可删除
            			$(".cojud1null").attr("src","static/images/mydel.png");
            			}
					loading = false;
					tip++;
					}
					else if(d.success=="2"){   //共有二个数据
					//评论表情解析
					var aphtml1="<div class=\"weui-cell__ft\"><a id=\"showemoji"+d.pcid1+"\" onclick=\"showemoji('"+d.pcid1+"')\" ><img src=\"static/images/facesmile.png\" style=\"height:26px;width:26px;display:inline\"></a></div>";		
					aphtml1+="<div class=\"weui-cell__ft\"><a id=\"ccommit"+d.pcid1+"\" onclick=\"ccommit('"+d.pcid1+"')\" class=\"weui-btn weui-btn_mini weui-btn_disabled weui-btn_primary\" style=\"border-radius:10px;pointer-events: none;\">发送</a></div></div></div></div></div></div>";
					$(".list").append("<input type=\"hidden\" value=\""+d.ispr1+"\" id=\"ispr"+d.pcid1+"\"><input type=\"hidden\" value=\""+d.prnum1+"\" id=\"prnum"+d.pcid1+"\"><div class=\"weui-panel\" ><div class=\"weui-panel__bd\"><div class=\"weui-media-box weui-media-box_appmsg\" ><div class=\"weui-media-box__hd\" style=\"height:40px;margin-right:0px;\"><img onclick=\"openmycircle("+d.uid1+")\" class=\"weui-media-box__thumb\" style=\"border-radius:200px;height:40px;width:40px\" src=\""+d.headimg1+"\"></div><div class=\"weui-media-box__bd\"><h4 class=\"weui-media-box__title\" style=\"color:#0000FF;\">"+d.uname1+"</h4><p class=\"weui-media-box__desc\">"+d.adddate1+"</p></div><div class=\"weui-cell__ft\" style=\"height:60px;text-align:left;\"><a id=\"zanf"+d.pcid1+"\" class=\"down"+d.ispr1+"\" onclick=\"zan('"+d.pcid1+"','"+d.prtotal1+"')\" style=\"height:18px;margin-bottom:5px;\"><img class=\"down"+d.ispr1+"\" id=\"zani"+d.pcid1+"\" src=\"static/images/zan1.png\" style=\"height:18px;width:22px;display:inline\">赞</a><a onclick=\"com('"+d.pcid1+"')\"><img src=\"static/images/comm1.png\" style=\"height:18px;width:22px;display:inline\">评论</a><a class=\"delcir"+d.ismycircle1+"\" onclick=\"delcir('"+d.pcid1+"','"+d.uid1+"')\" style=\"display:none;\"><img src=\"static/images/delcircle.png\" style=\"height:18px;width:22px;display:inline\">删除</a></div></div><div class=\"weui-media-box weui-media-box_appmsg\" ><div class=\"weui-media-box__bd\"><h4 id=\"em"+d.pcid1+"\" onclick=\"toemoji('"+d.pcid1+"')\" class=\"weui-media-box__title\" style=\"margin-top:-10px;\">"+d.pcontent1+"</h4><div class=\"weui-uploader__bd\"><ul class=\"weui-uploader__files\" id=\"imgulid"+d.pcid1+"\"></ul></div><p id=\"co"+d.pcid1+"\" class=\"weui-media-box__desc\" style=\"padding-bottom:8px;color:#0000FF;font-size:15px;background:beige;\"><img id=\"pr"+d.pcid1+"\" src=\"static/images/zan.png\" style=\"height:30px;width:30px;display:inline\"><input type=\"hidden\" id=\"ptinput"+d.pcid1+"\" value=\""+d.prtotal1+"\">等<span id=\"ptotal"+d.pcid1+"\">"+d.prtotal1+"</span>人觉得赞</p><div id=\"ctip"+d.pcid1+"\" class=\"weui-cell\" style=\"margin-top:5px;padding:5px 5px;display:none\"><div class=\"weui-cell__bd\"><input id=\"ccontent"+d.pcid1+"\" class=\"weui-input\" type=\"text\" placeholder=\"评论内容由此输入\"></div>"+aphtml1);
					showemoji(d.pcid1);//初始化表情选择
					
					var aphtml2="<div class=\"weui-cell__ft\"><a id=\"showemoji"+d.pcid2+"\" onclick=\"showemoji('"+d.pcid2+"')\" ><img src=\"static/images/facesmile.png\" style=\"height:26px;width:26px;display:inline\"></a></div>";
					aphtml2+="<div class=\"weui-cell__ft\"><a id=\"ccommit"+d.pcid2+"\" onclick=\"ccommit('"+d.pcid2+"')\" class=\"weui-btn weui-btn_mini weui-btn_disabled weui-btn_primary\" style=\"border-radius:10px;pointer-events: none;\">发送</a></div></div></div></div></div></div>";
					$(".list").append("<input type=\"hidden\" value=\""+d.ispr2+"\" id=\"ispr"+d.pcid2+"\"><input type=\"hidden\" value=\""+d.prnum2+"\" id=\"prnum"+d.pcid2+"\"><div class=\"weui-panel\" ><div class=\"weui-panel__bd\"><div class=\"weui-media-box weui-media-box_appmsg\" ><div class=\"weui-media-box__hd\" style=\"height:40px;margin-right:0px;\"><img onclick=\"openmycircle("+d.uid2+")\" class=\"weui-media-box__thumb\" style=\"border-radius:200px;height:40px;width:40px\" src=\""+d.headimg2+"\"></div><div class=\"weui-media-box__bd\"><h4 class=\"weui-media-box__title\" style=\"color:#0000FF;\">"+d.uname2+"</h4><p class=\"weui-media-box__desc\">"+d.adddate2+"</p></div><div class=\"weui-cell__ft\" style=\"height:60px;text-align:left;\"><a id=\"zanf"+d.pcid2+"\" class=\"down"+d.ispr2+"\" onclick=\"zan('"+d.pcid2+"','"+d.prtotal2+"')\" style=\"height:18px;margin-bottom:5px;\"><img class=\"down"+d.ispr2+"\" id=\"zani"+d.pcid2+"\" src=\"static/images/zan1.png\" style=\"height:18px;width:22px;display:inline\">赞</a><a onclick=\"com('"+d.pcid2+"')\"><img src=\"static/images/comm1.png\" style=\"height:18px;width:22px;display:inline\">评论</a><a class=\"delcir"+d.ismycircle2+"\" onclick=\"delcir('"+d.pcid2+"','"+d.uid2+"')\" style=\"display:none;\"><img src=\"static/images/delcircle.png\" style=\"height:18px;width:22px;display:inline\">删除</a></div></div><div class=\"weui-media-box weui-media-box_appmsg\" ><div class=\"weui-media-box__bd\"><h4 id=\"em"+d.pcid2+"\" onclick=\"toemoji('"+d.pcid2+"')\" class=\"weui-media-box__title\" style=\"margin-top:-10px;\">"+d.pcontent2+"</h4><div class=\"weui-uploader__bd\"><ul class=\"weui-uploader__files\" id=\"imgulid"+d.pcid2+"\"></ul></div><p id=\"co"+d.pcid2+"\" class=\"weui-media-box__desc\" style=\"padding-bottom:8px;color:#0000FF;font-size:15px;background:beige;\"><img id=\"pr"+d.pcid2+"\" src=\"static/images/zan.png\" style=\"height:30px;width:30px;display:inline\"><input type=\"hidden\" id=\"ptinput"+d.pcid2+"\" value=\""+d.prtotal2+"\">等<span id=\"ptotal"+d.pcid2+"\">"+d.prtotal2+"</span>人觉得赞</p><div id=\"ctip"+d.pcid2+"\" class=\"weui-cell\" style=\"margin-top:5px;padding:5px 5px;display:none\"><div class=\"weui-cell__bd\"><input id=\"ccontent"+d.pcid2+"\" class=\"weui-input\" type=\"text\" placeholder=\"评论内容由此输入\"></div>"+aphtml2);
						if(edit=="toedit"){
						$(".delcir1").css("display","inline");
						$(".delcir0").css("display","inline"); 
						} //以此判断暮云圈是否为本人所写 ，是则可删除
					showemoji(d.pcid2);//初始化表情选择
					
					toemoji(d.pcid1);//解析表情
					toemoji(d.pcid2);//解析表情
					$(".down1").css("color","#d81e06");//将已点赞的人的图标 字体换色
					$(".down1").attr("src","static/images/zan2.png");
					if(d.praise1=="" || d.praise1==null) //若无赞则隐藏
					$("#co"+d.pcid1).hide(); 
					if(d.praise2=="" || d.praise2==null) //若无赞则隐藏
					$("#co"+d.pcid2).hide(); 
					$.each(d.url1, function(i,item){ //图片集合
					i=d.urltotal1-i;
                	$("#imgulid"+d.pcid1).after("<li class=\"weui-uploader__file\" onclick=\"showimg("+d.pcid1+","+d.urltotal1+","+i+")\" ><img id=\"img"+d.pcid1+i+"\" src=\"<%=basePath%>pcircle/showpcircleimage?url='"+item+"'\" style=\"height:75px;\"></li>"); 
            		});
            		$.each(d.url2, function(i,item){ //图片集合
            		i=d.urltotal2-i;
                	$("#imgulid"+d.pcid2).after("<li class=\"weui-uploader__file\" onclick=\"showimg("+d.pcid2+","+d.urltotal2+","+i+")\" ><img id=\"img"+d.pcid2+i+"\" src=\"<%=basePath%>pcircle/showpcircleimage?url='"+item+"'\" style=\"height:75px;\"></li>"); 
            		});
					$.each(d.praise1, function(i,item){
                	$("#pr"+d.pcid1).after("<span id="+d.pcid1+(++i)+"> "+item.uname+"，</span>");  
            		}); 
            		 $.each(d.praise2, function(i,item){  
                	$("#pr"+d.pcid2).after("<span id="+d.pcid2+(++i)+"> "+item.uname+"，</span>");   
            		});
            		$.each(d.comment1, function(i,item){  
                	$("#co"+d.pcid1).after("<p id=\"mycom"+d.pcid1+(++i)+"\" class=\"weui-media-box__desc\" style=\"font-size:15px;background:beige;\"><span style=\"color:#0000FF\">"+item.uname+":</span><span id=\"mycomemoji"+d.pcid1+i+"\">"+item.ccontent+"</span><img class=\"cojud"+d.iscom1+item.isusercom+"\" onclick=\"delcom('"+d.pcid1+"','"+i+"','"+item.coid+"')\" src=\"static/images/del.png\" style=\"height:25px;width:20px;padding-top:10px;display:inline;pointer-events:none;\"></p>"); 
            		comtoemoji(d.pcid1,i);//解析评论表情
            		});
            		$.each(d.comment2, function(i,item){  
                	$("#co"+d.pcid2).after("<p id=\"mycom"+d.pcid2+(++i)+"\" class=\"weui-media-box__desc\" style=\"font-size:15px;background:beige;\"><span style=\"color:#0000FF\">"+item.uname+":</span><span id=\"mycomemoji"+d.pcid2+i+"\">"+item.ccontent+"</span><img class=\"cojud"+d.iscom2+item.isusercom+"\" onclick=\"delcom('"+d.pcid2+"','"+i+"','"+item.coid+"')\" src=\"static/images/del.png\" style=\"height:25px;width:20px;padding-top:10px;display:inline;pointer-events:none;\"></p>"); 
            		comtoemoji(d.pcid2,i);//解析评论表情
            		});
            			if(edit=="toedit"){
            			$(".cojud11").css("pointer-events","auto");//评论可删除
            			$(".cojud11").attr("src","static/images/mydel.png");
            			$(".cojud1null").css("pointer-events","auto");  //评论可删除
            			$(".cojud1null").attr("src","static/images/mydel.png");
            			}
					loading = false;
					tip++;
    				}
    				else{$.toast("出现错误", "cancel");}
					}
				});
});

</script>	

<script type="text/javascript">
//具体个人的暮云圈
var edit=$("#edit").val(); 
function openmycircle(uid){
	if(edit=="toedit"){ //管理者进入管理暮云圈
	window.location.href="<%=basePath%>pcircle/showpcircle?uid="+uid+"&mytip=mytip&edit=edit";
	}else{
	window.location.href="<%=basePath%>pcircle/showpcircle?uid="+uid+"&mytip=mytip";
	}
}
</script>

<script type="text/javascript">

function showimg(pcid,urltotal,urlindex){
var urlarray=new Array(urltotal);//定义图片数组的长度=图片总数
for(var i=1;i<=urltotal;i++){
	urlarray[i]=$("#img"+pcid+i).attr("src");
}
switch(urltotal){
	case 0: break;
	case 1:$.photoBrowser({
  	items: [
    urlarray[1]
  ],initIndex:urlindex-1
  }).open(urlindex-1); break;
	case 2:$.photoBrowser({
  	items: [
    urlarray[1],
    urlarray[2]
  ],initIndex:urlindex-1
  }).open(urlindex-1); break;
  case 3:$.photoBrowser({
  	items: [
    urlarray[1],
    urlarray[2],
    urlarray[3]
  ],initIndex:urlindex-1
  }).open(urlindex-1); break;
  case 4:$.photoBrowser({
  	items: [
    urlarray[1],
    urlarray[2],
    urlarray[3],
    urlarray[4]
  ],initIndex:urlindex-1
  }).open(urlindex-1); break;
  case 5:$.photoBrowser({
  	items: [
    urlarray[1],
    urlarray[2],
    urlarray[3],
    urlarray[4],
    urlarray[5]
  ],initIndex:urlindex-1
  }).open(urlindex-1); break;
}


}

</script>
<script src="static/jqweui/swiper.js" charset='utf-8'></script>
    
</body>
</html>