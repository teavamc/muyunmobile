<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en" style="font-size: 23.4375px;">

<head>
<title>${pd.SYSNAME}</title>
<base href="<%=basePath%>">
<meta charset="UTF-8" />
<meta name="renderer" content="webkit">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<link rel="stylesheet" href="https://cdn.bootcss.com/weui/1.1.2/style/weui.min.css">
<link rel="stylesheet" href="https://cdn.bootcss.com/jquery-weui/1.2.0/css/jquery-weui.min.css">
 <link rel="stylesheet" type="text/css" href="static/new/css/base.css">

<style type="text/css">
body{
  background: #efeff4;
}
.container{
   padding: 15px;
}
</style>
 <style type="text/css">
  </style>
</head>
<body>

		<header class="header" id="header" style="background-color:#e64340;position:relative;z-index:100">
<a href="javascript:history.back(-1)" target=_self class="back">返回</a>
<h1>新增测评</h1>
</header>
<div class="page home">

<div class="page__bd" >
<form action="" method="post" name="registerForm"
				id="registerForm">
				<input type="hidden" value="${tbmember.pid}">
<div class="weui-cells weui-cells_form">
    <div class="weui-cell">
        <div class="weui-cell__hd">
            <label class="weui-label">测评对象</label>
        </div>
        <div class="weui-cell__bd ">
            <input name="pname" id="pname" class="weui-input" type="text" placeholder="输入要测评的党员姓名">
        </div>
    </div>
    <div class="weui-cell">
        <div class="weui-cell__hd">
            <div class="weui-label">测评主题</div>
        </div>
        <div class="weui-cell__bd ">
           <input type="text" name="ptitle" class="weui-input" id="ptitle" value="" placeholder="输入测评主题"/>
        </div>
    </div>
         <div class="weui-cell weui-cell_select weui-cell_select-after">
        <div class="weui-cell__hd">
          <label for="" class="weui-label">测评状态</label>
        </div>
        <div class="weui-cell__bd">
          <select class="weui-select" name="pstate">
            <option value="完成">完成</option>
            <option value="未完成">未完成</option>
          </select>
        </div>
      </div>
    <div class="weui-cell">
        <div class="weui-cell__hd">
            <div class="weui-label">测评分数</div>
        </div>
        <div class="weui-cell__bd ">
            <input type="number" name="pscore"  class="weui-input" id="pscore"  value="" placeholder="请输入测评分数"/>
        </div>
    </div>
    <div class="weui-cell">
        <div class="weui-cell__hd">
            <div class="weui-label">测评人</div>
        </div>
        <div class="weui-cell__bd ">
            <input type="text" name="puidname"  class="weui-input" id="puidname"  value="${tbmember.pname }" readonly="readonly"/>
        </div>
    </div>

</div>

<div class="weui-btn-area">
    <a class="weui-btn weui-btn_warn"  id="save">提交</a>
</div>

</form>
<div class="page__ft">
<div class="weui-footer" >
	<p class="weui-footer_text" style="text-align:center;">Copyright &copy;  暮云新村 思信科技</p>
</div>
</div>
</div>

</div>
<!-- </div> -->
	<script src="https://cdn.bootcss.com/jquery/1.11.0/jquery.min.js"></script>
	<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/jquery-weui.min.js"></script>
	<script type="text/javascript">
    $(function(){ 
    $("#save").click(function(e){
        var pairs = $("#registerForm").serialize().split(/&/gi);
        var data = {};
        pairs.forEach(function(pair) {
            pair = pair.split('=');
            data[pair[0]] = decodeURIComponent(pair[1] || '');
        });
        if(!data.pname){
            $.toptip('请输入要测评的党员姓名', 1000,'success');
            $("#pname").focus();
        }
        else if(!data.ptitle){
       		$.toptip('请输入测评主题', 1000,'success');
            $("#ptitle").focus();
        }
        else if(!data.pscore){
       		$.toptip('请输入测评分数', 1000,'success');
            $("#pscore").focus();
           
        }
        
        else{
					$.ajax({
					type: "POST",
					url: "<%=basePath%>selfeval/assinsert.do",
			    	data:  $("#registerForm").serializeArray(),
					dataType:'json',
					cache: false,
					success: function(data1){
						if("errorname" == data1.result){
							$.toptip('您想测评的党员不存在', 1000,'success');
            				return;		
						}
						//存在党员，进行新增测评操作
						else if("success"==data1.result){
							$.toast("新增测评成功");
							window.location.href="<%=basePath%>selfeval/assessmentmain";
						}
						else{
						$.toast("新增失败", "cancel");
						}
					}
				});
						
		}					
		
		
    });

    });
 
	</script>

</body>

</html>