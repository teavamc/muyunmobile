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
  <input type="hidden" value="${pd.type }" id="type"/>	
	<header class="header" id="header" style="background-color:#e64340;position:relative;z-index:100">
<a href="javascript:history.back(-1)" target=_self class="back">返回</a>
<h1>评价信息</h1>
</header>

	
	<form action="" name="userForm" id="userForm" method="post">
			<input type="hidden" value="${selfeval.uid }" id="uid" name="uid"/>
		<input type="hidden" value="${selfeval.pid }" id="pid" name="pid"/>
		<input type="hidden" value="${selfeval.sfid }" id="sfid" name="sfid"/>
		<input type="hidden" value="${selfeval.state }" id="pstate" name="pstate"/>
<div class="weui-cells weui-cells_form">
    <div class="weui-cell">
        <div class="weui-cell__hd">
            <label class="weui-label">被评人</label>
        </div>
        <div class="weui-cell__bd ">
            <input name="pname" id="pname" class="weui-input" type="text" value="${selfeval.pname }" style="color:red"
				readonly="readonly">
        </div>
    </div>
    <div class="weui-cell">
        <div class="weui-cell__hd">
            <div class="weui-label">评价标题</div>
        </div>
        <div class="weui-cell__bd ">
           <input type="text" name="title" class="weui-input" id="title" value="${selfeval.title }"/>
        </div>
    </div>
         <div class="weui-cell weui-cell_select weui-cell_select-after">
        <div class="weui-cell__hd">
          <label for="" class="weui-label">评价状态</label>
        </div>
        <div class="weui-cell__bd">
          <select class="weui-select" name="state">
            <option value="完成">完成</option>
            <option value="未完成">未完成</option>
          </select>
        </div>
      </div>
    <div class="weui-cell">
        <div class="weui-cell__hd">
            <div class="weui-label">评价分数</div>
        </div>
        <div class="weui-cell__bd ">
            <input type="text" name="score"  class="weui-input" id="score"  value="${selfeval.score }" />
        </div>
    </div>
    <div class="weui-cell">
        <div class="weui-cell__hd">
            <div class="weui-label">评价人</div>
        </div>
        <div class="weui-cell__bd ">
            <input type="text" name="uname"  class="weui-input" id="uname"  value="${selfeval.uname }"
				readonly="readonly" style="color:red"/>
        </div>
    </div>

</div>

<div class="weui-btn-area">
    <a class="weui-btn weui-btn_warn"  id="tosave" onclick="save()">修改</a>
</div>

</form>
	<script src="https://cdn.bootcss.com/jquery/1.11.0/jquery.min.js"></script>
	<script src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/jquery-weui.min.js"></script>
	
	<script type="text/javascript">
	$(function(){
	var type=$("#type").val();
	$(".weui-select").val($("#pstate").val());
	if(type=="ass1" || type=="ass2"){
		$("#tosave").show();
	}else{
	$("#tosave").hide();
	$(".weui-input").attr("readonly","readonly");
	}
	});
	</script>
	<script type="text/javascript">
	function save(){
	var title=$("#title").val();
	var score=$("#score").val();
		if($.trim(title)==""){$.toptip('标题不能为空',1000, 'success');$("#title").focus();}
		else if($.trim(score)==""){$.toptip('测评分数不能为空',1000, 'success');$("#score").focus();}
		else{
		$.ajax({
					type: "POST",
					url: "<%=basePath%>selfeval/updateass.do",
					data : $("#userForm").serializeArray(),
					dataType : 'json',
					cache : false,
					success : function(data) {
						if ("success" == data.result) {
							window.history.go(0); //刷新页面
							$.toast("保存成功",20000);
						} else {
							$.toast("保存失败", "cancel");
						}
					}
				});
		}
	}
	
	</script>
  </body>
</html>
