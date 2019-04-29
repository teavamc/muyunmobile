<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html style="font-size:23.4375px;">
 <head>
  <title>${pd.SYSNAME}</title>
  <base href="<%=basePath%>">

 <meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
		<meta name="description" content="">
       	<link rel="stylesheet" href="static/jqweui/weui.min.css"> <!-- 去掉了某些css position 使图片播放无线条 -->
       	
<link rel="stylesheet" href="https://cdn.bootcss.com/jquery-weui/1.2.0/css/jquery-weui.min.css">
<script src="https://cdn.bootcss.com/jquery/1.11.0/jquery.min.js"></script>
	<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/jquery-weui.min.js"></script>
	  <script type="text/javascript" src="static/jqweui/yuqingjquery.qqFace.js"></script><!-- 表情js -->
     <link rel="stylesheet" type="text/css" href="static/new/css/base.css">
<style type="text/css">
.qqFace { margin-top: -4px; background: #fff; padding: 2px; border: 1px #dfe6f6 solid;}
.qqFace table td { padding: 0px; }
.qqFace table td img { cursor: pointer; border: 1px #fff solid; }
.qqFace table td img:hover { border: 1px #0066cc solid; }

</style>
  </head>
  
  <body>
  

	
	<header class="header" id="header" style="background-color:#e64340;position: static;">
<a href="javascript:history.back(-1)" target=_self class="back">返回</a>
<h1>${yuqing.yqtype}</h1>
</header>

	<form action="" name="userForm" id="userForm" method="post" >
	<input type="hidden" value="${user.uname }" id="uname">
	<input type="hidden" value="${user.headimg }" id="headimg">
		<input type="hidden" value="${user.uid }" id="uid">
		<input type="hidden" value="${yuqing.yqid }" id="yqid">
<div class="weui-cells weui-cells_form" style="margin-top:0px;">
   
    
    <div class="weui-cell">
        <div class="weui-cell__bd">
          <textarea class="weui-textarea"  rows="8" value="" name="content" id="content" readonly="readonly">${yuqing.content }</textarea>
        <!--   <div class="weui-textarea-counter"><span>0</span>/200</div>  --> 
        </div>
      </div>
      
       <div class="weui-cell">
        <div class="weui-cell__hd">
            <label class="weui-label" style="color:#808080">类型</label>
        </div>
        <div class="weui-cell__bd ">
            <input name="title" id="title" class="weui-input" type="text" readonly="readonly" value="${yuqing.yqtype}"
				>
        </div>
    </div>
    
      <div class="weui-cell">
        <div class="weui-cell__hd">
            <label class="weui-label" style="color:#808080">上报时间</label>
        </div>
        <div class="weui-cell__bd ">
            <input name="ftype" id="ftype" class="weui-input" type="text" value="${yuqing.adddate }" 
				readonly="readonly">
        </div>
    </div>
    
        <div class="weui-cells weui-cells_form" style="margin-top:0px;">
      <div class="weui-cell">
        <div class="weui-cell__bd">
          <div class="weui-uploader">
            <div class="weui-uploader__hd">
              <p class="weui-uploader__title" style="color:#808080">现场图集</p>
             
            </div>
            <div class="weui-uploader__bd">
              <ul class="weui-uploader__files" id="uploaderFiles" >  
              <c:choose>
              	<c:when test="${not empty url }">
              	<c:forEach items="${url }" var="u" varStatus="vs">
              		<li class="weui-uploader__file" onclick="showimg(${vs.index+1})" >
                	<img src="<%=basePath%>yuqing/showyuqingimage?url='${u}'" style="height:75px;">
                	</li>
              	</c:forEach>
              	</c:when>
              	<c:otherwise>
					<li class="weui-uploader__file weui-uploader__file_status">
              <div class="weui-uploader__file-content">暂无图片</div>
            </li>
				</c:otherwise>
     			</c:choose>
				
              </ul>
            </div>
          </div>
        </div>
      </div>
    </div>
    </div>
    
    
        


<div class="weui-panel" style="background:beige" id="allcom">

<div class="weui-panel__hd" style="font-size:15px;padding:8px;" >评论
<a style="float:right;padding:2px;" onclick="com()"><img src="static/images/comm1.png" style="height:18px;width:22px;"></a>

</div>
<div id="ctip" class="weui-cell" style="margin-top:5px;padding:8px;display:none">
		<div class="weui-cell__bd">
		<input id="ccontent" class="weui-input" type="text" placeholder="评论内容由此输入">
		</div>
		
		<!-- 1.24评论表情 -->
	<div class="weui-cell__ft">
	<a id="showemoji" onclick="showemoji()" ><img src="static/images/facesmile.png" style="height:26px;width:26px;display:inline"></a>
	</div>
	
	<div class="weui-cell__ft">
		<a id="ccommit" onclick="ccommit()" class="weui-btn weui-btn_mini weui-btn_disabled weui-btn_primary" style="border-radius:10px;pointer-events: none;">发送</a>
	</div>
	</div>

		<c:forEach items="${yuqing.yqcomment }" var="yqcomment" varStatus="vs">
        <div class="weui-panel__bd"  id="mycom${yqcomment.yqcid}${vs.index+1}">
        <div class="weui-media-box weui-media-box_appmsg" id="allowdel${yqcomment.yqcid }">
            <div class="weui-media-box__hd" style="height:40px;margin-right:0px;">
              <img class="weui-media-box__thumb" style="border-radius:200px;height:40px;width:40px"    src="${yqcomment.headimg }">
              </div>
              
            <div class="weui-media-box__bd">
              <p id="em${yqcomment.yqcid}" class="weui-media-box__desc" style="color:#000" onclick="showcomcon(${yqcomment.yqcid})">${yqcomment.yqccontent }</p>
            <p class="weui-media-box__desc" style="padding-top:4px;">${yqcomment.uname } ${yqcomment.datetime }
          <a  style="float:right;">
          <img onclick="delcom('${vs.index+1}','${yqcomment.yqcid}','${yqcomment.uid }')" class="cojud${yqcomment.isusercom}"  src="static/images/del.png" style="height:25px;width:20px;padding-top:5px;display:inline;pointer-events: none;">
    </a>  
            </p>
            </div>
            
		</div>
        </div>
        <script>
             		$(toemoji('${yqcomment.yqcid}'));
             		function toemoji(yqcid){
             		var str = $("#em"+yqcid).text();
					$("#em"+yqcid).html(replace_em(str));
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
<div ><input type="text" id="end" readonly="readonly"></div>

</form>
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
	
	<script src="static/jqweui/swiper.js" charset='utf-8'></script>
	<script>
	$(document).ready(function(){
$(".cojud1").css("pointer-events","auto");  
$(".cojud0").css("pointer-events","auto");   //将评价的置为可删除
$(".cojud1").attr("src","static/images/mydel.png");
$(".cojud0").attr("src","static/images/mydel.png");
});
	
	function showcomcon(yqcid){
	alert(yqcid);
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
var yqid=$("#yqid").val();
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
	$.post("yuqing/addyqcomment",{uid:uid,yqcid:coid,yqccontent:ccontent,yqid:yqid,datetime:comdate},function(data){
   			if(data.result!="success")
   			$.toast("出现错误", "cancel"); 
 			});
}

function delcom(comnum,yqcid,cuid){//删除评论

	$.confirm("","确认删除？", function() {
	$("#mycom"+yqcid+comnum).empty();
	//后台操作
	$.post("yuqing/deleteyqcomment",{yqcid:yqcid},function(data){
   			if(data.result!="success")
   			$.toast("出现错误", "cancel"); 
 			});
			}, function() {
 	 //取消
 	 });

	
}


// 	function yuqingtoremark(yqid){
// 	$.post("<%=basePath%>yuqing/yuqingtoremark",{yqid:yqid},function(date){
// 			if(date.result=="success")
//    			{$.toast("审核成功");
//    			history.go(-1);
//    			}
// 		})
// 	}
</script>

	<script type="text/javascript">
	function showimg(k){
	var urlsize=${pd.urlnum};  //图片总数   限制5张
	var imgsrc=new Array(urlsize);//定义图片数组的长度=图片总数
	for(var i=0;i<urlsize;i++){
	imgsrc[i]=$("img")[i].src;
	}
	switch(urlsize){
		case 0: break;
		case 1: $.photoBrowser({
	 			items: [
           		{
            image: imgsrc[0],
            caption: "<a class='weui-btn weui-btn_disabled' href=\"yuqing/downloadimg?url="+imgsrc[0]+"&tip='img1' \">下载原图</a>",
          },
       			],initIndex:k-1
     			}).open(k-1);; break;
     	case 2: $.photoBrowser({
	 			items: [
           		{
            image: imgsrc[0],
           caption: "<a  class='weui-btn weui-btn_disabled' href=\"yuqing/downloadimg?url="+imgsrc[0]+"&tip='img1' \">下载原图</a>",
          },
          		{
            image: imgsrc[1],
           caption: "<a  class='weui-btn weui-btn_disabled' href=\"yuqing/downloadimg?url="+imgsrc[1]+"&tip='img2' \">下载原图</a>",
          },
       			],initIndex:k-1
     			}).open(k-1);; break;
     	case 3: $.photoBrowser({
	 			items: [
           		{
            image: imgsrc[0],
            caption: "<a  class='weui-btn weui-btn_disabled' href=\"yuqing/downloadimg?url="+imgsrc[0]+"&tip='img1' \">下载原图</a>",
          },
          		{
            image: imgsrc[1],
            caption: "<a  class='weui-btn weui-btn_disabled' href=\"yuqing/downloadimg?url="+imgsrc[1]+"&tip='img2' \">下载原图</a>",
          },
         		{
            image: imgsrc[2],
           caption: "<a  class='weui-btn weui-btn_disabled' href=\"yuqing/downloadimg?url="+imgsrc[2]+"&tip='img3' \">下载原图</a>",
          },
       			],initIndex:k-1
     			}).open(k-1);; break;	
     	case 4: $.photoBrowser({
	 			items: [
	 		{
            image: imgsrc[0],
            caption: "<a  class='weui-btn weui-btn_disabled' href=\"yuqing/downloadimg?url="+imgsrc[0]+"&tip='img1' \">下载原图</a>",
          },
          		{
            image: imgsrc[1],
            caption: "<a  class='weui-btn weui-btn_disabled' href=\"yuqing/downloadimg?url="+imgsrc[1]+"&tip='img2' \">下载原图</a>",
          },
         	{
            image: imgsrc[2],
            caption: "<a  class='weui-btn weui-btn_disabled' href=\"yuqing/downloadimg?url="+imgsrc[2]+"&tip='img3' \">下载原图</a>",
          },
         	{
            image: imgsrc[3],
            caption: "<a  class='weui-btn weui-btn_disabled' href=\"yuqing/downloadimg?url="+imgsrc[3]+"&tip='img4' \">下载原图</a>",
          },
          	],initIndex:k-1
     			}).open(k-1);; break;
     	case 5: $.photoBrowser({
	 			items: [
           		{
            image: imgsrc[0],
            caption: "<a  class='weui-btn weui-btn_disabled' href=\"yuqing/downloadimg?url="+imgsrc[0]+"&tip='img1' \">下载原图</a>",
          },
          		{
            image: imgsrc[1],
            caption: "<a  class='weui-btn weui-btn_disabled' href=\"yuqing/downloadimg?url="+imgsrc[1]+"&tip='img2' \">下载原图</a>",
          },
         		{
            image: imgsrc[2],
            caption: "<a  class='weui-btn weui-btn_disabled' href=\"yuqing/downloadimg?url="+imgsrc[2]+"&tip='img3' \">下载原图</a>",
          },
         		{
            image: imgsrc[3],
            caption: "<a  class='weui-btn weui-btn_disabled' href=\"yuqing/downloadimg?url="+imgsrc[3]+"&tip='img4' \">下载原图</a>",
          },
         		{
            image: imgsrc[4],
            caption: "<a  class='weui-btn weui-btn_disabled' href=\"yuqing/downloadimg?url="+imgsrc[4]+"&tip='img5' \">下载原图</a>",
          },
       			],initIndex:k-1
     			}).open(k-1); break;
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
