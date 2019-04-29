<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html style="font-size:10px;">
 <head>
  <title>${pd.SYSNAME}</title>
  <base href="<%=basePath%>">
 <meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
		<meta name="description" content="">
		
       	<link rel="stylesheet" href="https://cdn.bootcss.com/weui/1.1.2/style/weui.min.css"><!-- weui-css -->
<link rel="stylesheet" href="https://cdn.bootcss.com/jquery-weui/1.2.0/css/jquery-weui.min.css"><!-- weui-js-css -->
<link rel="stylesheet" href="http://cdn.amazeui.org/amazeui/2.7.2/css/amazeui.css"><!-- zmazeui-->
<link rel="stylesheet" type="text/css" href="static/login/css/headmain.css"/><!-- 分页-->
<script src="https://cdn.bootcss.com/jquery/1.11.0/jquery.min.js"></script><!-- jquery-->
<script src="http://cdn.amazeui.org/amazeui/2.7.2/js/amazeui.js"></script><!-- zmazeui-->
<script src="http://cdn.amazeui.org/amazeui/2.7.2/js/amazeui.ie8polyfill.js"></script><!-- zmazeui-->
<script src="http://cdn.amazeui.org/amazeui/2.7.2/js/amazeui.widgets.helper.js"></script><!-- zmazeui-->
<script src="static/source/js/swiper.min.js"></script><!-- 通栏-->
<script type="text/javascript" src="static/jqweui/jquery.qqFace.js"></script><!-- 留言表情-->

  </head>
  
  <body>



 <header data-am-widget="header" class="am-header am-header-default">
      <div class="am-header-left am-header-nav">
          <a href="javascript:history.back(-1)" class="">
                <i class="am-header-icon am-icon-reply"></i>
          </a>
      </div>
        <h1 class="am-header-title" id="spanisread"></h1>
  </header>

	<form action="" name="userForm" id="userForm" method="post">
	<input type="hidden" value="${feed.fbid }" id="fbid" name="fbid"/>
			<input type="hidden" value="${feed.isread }" id="isread" name="isread"/>
			<input type="hidden" value="${feed.fbuid }" id="fbuid" name="fbuid"/>
			<input type="hidden" value="${feed.ftype }" id="ftype" name="ftype"/>
<div class="weui-cells weui-cells_form">
    <div class="weui-cell">
        <div class="weui-cell__hd">
            <label class="weui-label" style="color:#808080">标题</label>
        </div>
        <div class="weui-cell__bd ">
            <input name="title" id="title" class="weui-input" type="text" value="${feed.title }" 
				>
        </div>
    </div>
    
      <div class="weui-cell">
        <div class="weui-cell__hd">
            <label class="weui-label" style="color:#808080">类型</label>
        </div>
        <div class="weui-cell__bd ">
            <input name="ftype" id="ftype" class="weui-input" type="text" value="${feed.ftype }" 
				readonly="readonly">
        </div>
    </div>
    
    <div class="weui-cell">
        <div class="weui-cell__hd">
            <div class="weui-label" style="color:#808080">${feed.ftype }时间</div>
        </div>
        <div class="weui-cell__bd ">
           <input type="text"  class="weui-input" value="${feed.fbdatetime }" readonly="readonly">
        </div>
    </div>

      <div class="weui-cell">
        <div class="weui-cell__bd">
          <textarea class="weui-textarea"  rows="9" placeholder="内容由此输入" name="content" id="content" >${feed.content }</textarea>
        <!--   <div class="weui-textarea-counter"><span>0</span>/200</div>--> 
        </div>
      </div>
      

     <div id="huifu"> 
      <div class="weui-cells__title">以下是回复内容</div>
    <div class="weui-cell">
        <div class="weui-cell__hd">
            <div class="weui-label" style="color:#808080">回复时间</div>
        </div>
        <div class="weui-cell__bd ">
           <input type="text" class="weui-input"  value="${feed.datetime }" readonly="readonly"/>
        </div>
    </div>
      <div class="weui-cell">
        <div class="weui-cell__bd">
          <textarea class="weui-textarea"  rows="4" placeholder="回复内容" 	readonly="readonly">${feed.opinion }</textarea>
        <!--   <div class="weui-textarea-counter"><span>0</span>/200</div>--> 
        </div>
      </div>
   </div>
      
</div>

<div class="weui-btn-area" >
    <a class="weui-btn weui-btn_warn"  id="toupdate" onclick="toupdate()">修改</a>
</div>
<div class="weui-btn-area" >
    <a class="weui-btn weui-btn_warn weui-btn_disabled"  id="todelete" onclick="todelete()">删除</a>
</div>

</form>
	

	<script src="https://cdn.bootcss.com/jquery/1.11.0/jquery.min.js"></script>
	<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/jquery-weui.min.js"></script>
	
	<script type="text/javascript">
	$(function(){
	var isread=$("#isread").val();
	if(isread=="1"){  //已回复
	$("#title").attr("readonly","readonly");
	$("#content").attr("readonly","readonly");
	$("#huifu").show();
	$(".weui-btn-area").hide();
	$("#spanisread").append("已回复");
	}else{
	$("#huifu").hide();
	$(".weui-btn-area").show();
	$("#spanisread").append("待回复");
	}
	});
	</script>
	<script type="text/javascript">
	function toupdate(){
	var title=$("#title").val();
	var content=$("#content").val();
	var isread=$("#isread").val();
		if($.trim(title)==""){$.toptip('标题不能为空', 'success');$("#title").focus();}
		else if($.trim(content)==""){$.toptip('内容不能为空', 'success');$("#content").focus();}
		else{
		$.ajax({
					type: "POST",
					url: "<%=basePath%>feedback/updateFeed.do",
					data : $("#userForm").serializeArray(),
					dataType : 'json',
					cache : false,
					success : function(data) {
						if ("success" == data.result) {
							 $.toast("修改成功!");
							window.history.go(0); //刷新页面
						} else {
							 $.toast("修改失败!","cancel");
							window.location.href="<%=basePath%>feedback/showallfeed?isread="+isread;
						}
					}
				});
		}
	}
	
	function todelete(){
	var fbid=$("#fbid").val();
	var isread=$("#isread").val();
			$.confirm("确定删除?", "", function() {
        	$.ajax({  
					type: "POST",
					url: "<%=basePath%>feedback/deleteFeed.do",
			    	data:  "fbid="+fbid,
					dataType:'json',
					cache: false,
					success: function(date){
						if(date.result=="success"){
						 $.toast("删除成功!");
						 window.location.href="<%=basePath%>feedback/showallfeed?isread="+isread;
						}
						else{
						$.toast("删除失败!","cancel");
						}
					}
				});

        }, function() {
          //取消操作
        });
	}
	

	</script>
  </body>
</html>
