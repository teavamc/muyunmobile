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
   <link rel="stylesheet" type="text/css" href="static/simditor-2.3.13/assets/styles/simditor.css" ><!-- 文本编辑器css-->
<script src="https://cdn.bootcss.com/jquery/1.11.0/jquery.min.js"></script><!-- jquery-->
<script src="http://cdn.amazeui.org/amazeui/2.7.2/js/amazeui.js"></script><!-- zmazeui-->
<script src="http://cdn.amazeui.org/amazeui/2.7.2/js/amazeui.ie8polyfill.js"></script><!-- zmazeui-->
<script src="http://cdn.amazeui.org/amazeui/2.7.2/js/amazeui.widgets.helper.js"></script><!-- zmazeui-->
<script src="static/source/js/swiper.min.js"></script><!-- 通栏-->
<script type="text/javascript" src="static/jqweui/jquery.qqFace.js"></script><!-- 留言表情-->
<script type="text/javascript" src="static/simditor-2.3.13/assets/scripts/jquery.min.js"></script><!-- 文本编辑器js-->      
<script type="text/javascript" src="static/simditor-2.3.13/assets/scripts/module.js"></script><!-- 文本编辑器js-->  
 <script type="text/javascript" src="static/simditor-2.3.13/assets/scripts/hotkeys.js"></script>  <!-- 文本编辑器js-->  
 <script type="text/javascript" src="static/simditor-2.3.13/assets/scripts/uploader.js"></script>  <!-- 文本编辑器js-->  
 <script type="text/javascript" src="static/simditor-2.3.13/assets/scripts/simditor.js"></script><!-- 文本编辑器js--> 

  </head>
  
  <body>
  
  <header data-am-widget="header" class="am-header am-header-default">
      <div class="am-header-left am-header-nav">
          <a href="javascript:history.back(-1)" class="">
                <i class="am-header-icon am-icon-reply"></i>
          </a>
      </div>
        <h1 class="am-header-title" >发表文章</h1>
  </header>
	

		<form action="" name="userForm" id="userForm" method="post">
<div class="weui-cells weui-cells_form" style="margin-top:0px;">

	<div class="weui-cell">
    <div class="weui-cell__hd"><label class="weui-label" style="color:#808080">标题</label></div>
    <div class="weui-cell__bd">
      <input class="weui-input" type="text" name="title"  id="title" placeholder="输入文章标题" >
    </div>
  </div>

    <div class="weui-cell weui-cell_select weui-cell_select-after">
        <div class="weui-cell__hd">
          <label for="" class="weui-label" style="color:#808080">类型</label>
        </div>
        <div class="weui-cell__bd">
          <select class="weui-select" id="type" name="type">
            <option value="小村家事 1">闲聊</option>
            <option value="小村家事 2">故事</option>
            <option value="小村家事 3">通知</option>
          </select>
        </div>
      </div>
    
    <div class="weui-cell">
        <div class="weui-cell__bd">
        <textarea id="content" rows="15"  name="content"  placeholder="此处输入文章内容" autofocus></textarea>
        </div>
      </div>
    



</div>

<div class="weui-loadmore" style="position: absolute;top:40%;width:100%;height:100%;display:none" >
		<i class="weui-loading" ></i> <span class="weui-loadmore__tips">正在加载</span>
	</div>

<div class="weui-btn-area" >
    <a class="am-btn am-btn-primary am-btn-block"  id="toinsert" onclick="toinsert()">提&nbsp;&nbsp;交</a>
</div>
</form>


<script src="https://cdn.bootcss.com/jquery/1.11.0/jquery.min.js"></script>
	<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/jquery-weui.min.js"></script>
	
<script type="text/javascript">

var editor = new Simditor({
  textarea: $('#content'),
   toolbar:['title','bold','italic','underline','color','ol','ul','image','hr','alignment'],

   pasteImage: true,
      upload: {
        url: 'saveimage.do',
        params: null,
        fileKey: "fileName",
        connectionCount: 1,
        leaveConfirm: "正在上传,确定要取消上传文件吗?"
      }
  //optional options
});

function toinsert(){
	var type=$("#type").val();
	var title=$("#title").val();  //上报的类型
	var content=$("#content").val();   //上报内容
	if($.trim(title)=="" || title==null){
		$.toptip('标题不能为空', 'warning');
	}else if($.trim(content)=="" || content==null){
	$.toptip('内容不能为空', 'warning');
	}else{
		$.confirm("确认提交?", "", function() {
			$(".weui-loadmore").css("display","block");
        	$.ajax({  
					type: "POST",
					url: "<%=basePath%>xiaocun/insertXiaocun.do",
			    	data:  "title="+title+"&content="+content+"&type="+type,  
					dataType:'json',
					cache: false,
					success: function(date){
						if(date.result=="success"){
						 window.location.href="<%=basePath%>xiaocun/xiaocuninsertsuccess";//跳到等待审核界面
						}
						else if(date.result=="error"){
						$(".weui-loadmore").css("display","none");
						$.toast("请不要频繁提交!","cancel");
						}
						else{
						$(".weui-loadmore").css("display","none");
						$.toast("文章发表失败!","cancel");
						}
					}
				});

        }, function() {
          //取消操作
        });
        }
}


</script>

  </body>
</html>
