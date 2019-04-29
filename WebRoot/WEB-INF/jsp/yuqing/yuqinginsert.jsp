<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
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
       	<link rel="stylesheet" href="https://cdn.bootcss.com/weui/1.1.2/style/weui.min.css">
<link rel="stylesheet" href="https://cdn.bootcss.com/jquery-weui/1.2.0/css/jquery-weui.min.css">
     <link rel="stylesheet" type="text/css" href="static/new/css/base.css">

  </head>
  
  <body>
  
  
	
	<header class="header" id="header" style="background-color:#e64340;position:relative;z-index:100">
<a href="javascript:history.back(-1)" target=_self class="back">返回</a>
<h1>舆情上报</h1>
</header>

		<form action="" name="userForm" id="userForm" method="post">
<div class="weui-cells weui-cells_form">
    <div class="weui-cell weui-cell_select weui-cell_select-after">
        <div class="weui-cell__hd">
          <label for="" class="weui-label" style="color:#808080">类型</label>
        </div>
        <div class="weui-cell__bd">
          <select class="weui-select" id="yqtype" name="yqtype">
            <option value="寻衅滋事">寻衅滋事</option>
            <option value="此处类型1">此处类型1</option>
            <option value="此处类型2">此处类型2</option>
            <option value="此处类型3">此处类型3</option>
          </select>
        </div>
      </div>
    
    <div class="weui-cell">
        <div class="weui-cell__bd">
          <textarea class="weui-textarea"  rows="8"  name="content" id="content" placeholder="此处输入上报内容"></textarea>
        <!--   <div class="weui-textarea-counter"><span>0</span>/200</div>  --> 
        </div>
      </div>
    
        <div class="weui-cells weui-cells_form">
      <div class="weui-cell">
        <div class="weui-cell__bd">
          <div class="weui-uploader">
            <div class="weui-uploader__hd">
              <p class="weui-uploader__title" style="color:#808080">图片上传</p>
             <div class="weui-uploader__info"><span id="limitimg">0</span>/5</div>
            </div>
            <div class="weui-uploader__bd">
              <ul class="weui-uploader__files" id="uploaderFiles">
           <!--图片格式     <li class="weui-uploader__file" ></li>  -->
              </ul>
              <form name="myfrom" id="myform" method="post" action="">
               <div class="weui-uploader__input-box">
                <input id="uploaderInput" onchange="huoqu()" class="weui-uploader__input" type="file" accept="image/*" multiple="">
              </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>


</div>

<div class="weui-loadmore" style="position: absolute;top:40%;width:100%;height:100%;display:none" >
		<i class="weui-loading" ></i> <span class="weui-loadmore__tips">正在加载</span>
	</div>

<div class="weui-btn-area" >
    <a class="weui-btn weui-btn_warn"  id="toinsert" onclick="toinsert()">提&nbsp;&nbsp;交</a>
</div>
</form>


<script src="https://cdn.bootcss.com/jquery/1.11.0/jquery.min.js"></script>
	<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/jquery-weui.min.js"></script>
<script type="text/javascript">
var i=0;  //全局变量  将要上传图片总量
function huoqu(){
var file1=$("#uploaderInput").val();  //以此判断图片格式
var file = document.getElementById("uploaderInput").files[0]; //获得文件对象
		if(!/\.(jpg|jpeg|png|JPEG|JPG|PNG)$/.test(file1))
        {
          $.toptip('图片类型必须是jpeg,jpg,png中的一种！', 'success');
          return false;
        }else if(file.size/1024/1024>4){
      		$.toptip('原图片大小不得超过4MB！', 'success');
        	return false;
        }
        else{
	var reader =new FileReader();
	reader.readAsDataURL(file);
	reader.onload=function(e){  //将想要上传的图片回显在页面
	$("#uploaderFiles").append("<li class=\"weui-uploader__file\" id=\"liimg"+i+"\" onclick=\"del('"+i+"')\" ><img id=\"img"+i+"\" src=\""+this.result+"\" style=\"height:75px;\"></li>");
	$("#myfrom").submit();
	i++;  //上传图片数量的标志
	$("#limitimg").html(i); //限制上传的图片
	if(i>5){
  	$("#limitimg").css("color","red");
  	}else{$("#limitimg").css("color","#b2b2b2");}
	}
        }


}

function del(n){  //图片删除
	$("#liimg"+n).remove();  //n为0 对应第一张图片
	i--;
	$("#limitimg").html(i);  //限制上传的图片
	if(i>5){
  	$("#limitimg").css("color","red");
  	}else{$("#limitimg").css("color","#b2b2b2");}
	//alert("删除第"+n+"张图片----"+"此时i的值（数量）为"+i);
}

function toinsert(){
	var yqtype=$("#yqtype").val();  //上报的类型
	var content=$("#content").val();   //上报内容
	var limitimg=$("#limitimg").html(); //上传的图片数（判断是否超出）
	var total=i;//图片数量	
	if($.trim(content)!="" && limitimg<=5){
	
	if(total==0){
		$.confirm("还没有上传图片，确认上报?", "", function() {
			$(".weui-loadmore").css("display","block");
        	$.ajax({  
					type: "POST",
					url: "<%=basePath%>yuqing/insertYuqing.do",
			    	data:  "yqtype="+yqtype+"&content="+content+"&tip=haveNoImg",  //tip为判断标识
					dataType:'json',
					cache: false,
					success: function(date){
						if(date.result=="success"){
						 window.location.href="<%=basePath%>yuqing/yuqinginsertsuccess";//跳到等待审核界面
						}
						else if(date.result=="error"){
						$(".weui-loadmore").css("display","none");
						$.toast("请不要频繁上报!","cancel");
						}
						else{
						$(".weui-loadmore").css("display","none");
						$.toast("舆情上报失败!","cancel");
						}
					}
				});

        }, function() {
          //取消操作
        });
	}else{
	$.confirm("若内容虚假，您将为您的行为负责，确认上报?", "", function() {
	 $(".weui-loadmore").css("display","block");
	for(var num=0;num<i;num++){
	var base64=$("img")[num].src; //得到img下的src属性   [0]对应第一个
	var newBase64 = base64.replace(/\+/g, "%2B"); //将+号转义
	//alert("上传第"+num+"张图片-----此时剩余"+(total-1)+"张图片");
	$.ajax({  
					type: "POST",
					url: "<%=basePath%>yuqing/insertimage.do",
			    	data:  "newBase64="+newBase64+"&num="+num,
					dataType:'json',
					cache: false,
					success: function(date){
						if(date.result=="success"){
							if(date.num==i){ //图片全部上传完毕，进行写入数据库操作
							//alert("写入数据库");
								$.ajax({  
									type: "POST",
									url: "<%=basePath%>yuqing/insertYuqing.do",
			    					data: "yqtype="+yqtype+"&content="+content,
									dataType:'json',
									cache: false,
									success: function(date1){
										if(date1.result=="success"){
										window.location.href="<%=basePath%>yuqing/yuqinginsertsuccess";//跳到等待审核界面
										}
										else{
										$(".weui-loadmore").css("display","none");
										$.toast("舆情上报失败!","cancel");
										}
									}				
									});
							}
						}
						else if(date.result=="error"){
						$(".weui-loadmore").css("display","none");
						$.toast("请不要频繁上报!","cancel");
						}
						else{
						$(".weui-loadmore").css("display","none");
						$.toast("图片上传失败!","cancel");
						}
					}
				});
	total--;
	}
		 }, function() {
          //取消操作
        });
	}
	}else if(limitimg>5){
		$.toptip('图片数量超出限制！', 'success');
	}else{
		$.toptip('内容不能为空！', 'success');
	}
}


</script>
	

	
	

  </body>
</html>
