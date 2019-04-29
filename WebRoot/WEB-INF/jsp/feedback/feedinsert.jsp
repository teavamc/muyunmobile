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
        <h1 class="am-header-title">新增${pd.ftype }</h1>
  </header>


	<form action="" name="userForm" id="userForm" method="post">
<div class="weui-cells weui-cells_form">
    <div class="weui-cell">
        <div class="weui-cell__hd">
            <label class="weui-label" style="color:#808080">标题</label>
        </div>
        <div class="weui-cell__bd ">
            <input name="title" id="title" class="weui-input" type="text" placeholder="请输入标题" 
				>
        </div>
    </div>
    
      <div class="weui-cell">
        <div class="weui-cell__hd">
            <label class="weui-label" style="color:#808080">类型</label>
        </div>
        <div class="weui-cell__bd ">
            <input name="ftype" id="ftype" class="weui-input" type="text" value="${pd.ftype }" style="color:red;"
				readonly="readonly">
        </div>
    </div>

      <div class="weui-cell">
        <div class="weui-cell__bd">
          <textarea class="weui-textarea"  rows="10" placeholder="${pd.ftype }内容由此输入" name="content" id="content" ></textarea>
        <!--   <div class="weui-textarea-counter"><span>0</span>/200</div>--> 
        </div>
      </div>

      
</div>

<div class="weui-btn-area" >
    <a class="am-btn am-btn-primary am-btn-block"  id="toupdate" onclick="toinsert()">新增</a>
</div>

</form>
	

	<script src="https://cdn.bootcss.com/jquery/1.11.0/jquery.min.js"></script>
	<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/jquery-weui.min.js"></script>
	<script type="text/javascript">
	function toinsert(){
	var title=$("#title").val();
	var content=$("#content").val();
	var ftype=$("#ftype").val();
		if($.trim(title)==""){$.toptip('标题不能为空', 1000,'warning');$("#title").focus();}
		else if($.trim(content)==""){$.toptip('内容不能为空',1000, 'warning');$("#content").focus();}
		else{
		$.ajax({
					type: "POST",
					url: "<%=basePath%>feedback/insertFeed.do",
					data : $("#userForm").serializeArray(),
					dataType : 'json',
					cache : false,
					success : function(data) {
						if ("success" == data.result) {
							 $.toast("新增成功!");
							window.location.href="<%=basePath%>feedback/feedinsertsuccess";
						} else if("error" == data.result) {
							 $.toast("请不要重复新增相关的"+ftype, "forbidden");
						}else{
							$.toast("新增失败", "cancel");
						}
					}
				});
		}
	}
	
	
	</script>
  </body>
</html>
