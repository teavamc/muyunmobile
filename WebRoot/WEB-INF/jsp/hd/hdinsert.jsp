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
<h1>发布活动</h1>
</header>



<form action="" name="userForm" id="userForm" method="post">

	

	<div class="weui-cells weui-cells_form">
	
	<div class="weui-cell">
        <label for="" class="weui-label" style="color:#808080">活动标题</label>
        <div class="weui-cell__bd">
          <textarea class="weui-textarea"  rows="1"  name="hdtitle" id="hdtitle" placeholder=""></textarea>
        </div>
    </div>
    <div class="weui-cell weui-cell_select weui-cell_select-after">
   
        <div class="weui-cell__hd">
          <label for="" class="weui-label" style="color:#808080">活动类型</label>
        </div>
        <div class="weui-cell__bd">
          <select class="weui-select" id="hdtype" name="hdtype">
            <option value="会议">会议</option>
            <option value="培训">培训</option>
            <option value="交流会">交流会</option>
          </select>
        </div>
      </div>
      <div class="weui-cell">
        <label for="" class="weui-label" style="color:#808080">活动地点</label>
        <div class="weui-cell__bd">
          <textarea class="weui-textarea"  rows="1"  name="hdloc" id="hdloc" placeholder=""></textarea>
        </div>
    </div>
    <div class="weui-cell">
        <label for="" class="weui-label" style="color:#808080">活动人数</label>
        <div class="weui-cell__bd">
          <textarea class="weui-textarea"  rows="1"  name="hdnum" id="hdnum" placeholder=""></textarea>
        </div>
    </div>
    <div class="weui-cells weui-cells_form">
    <div class="weui-cell">
        <div class="weui-cell__hd"><label for=" " class="weui-label">开始时间</label></div>
        <div class="weui-cell__bd">
          <input class="weui-input" id="hdbtime" type="text" value="2012年12月12日 12时13分">
        </div>
    </div>
    <div class="weui-cells weui-cells_form">
    <div class="weui-cell">
        <div class="weui-cell__hd"><label for=" " class="weui-label">结束时间</label></div>
        <div class="weui-cell__bd">
          <input class="weui-input" id="hdetime" type="text" value="2012年12月12日 12时13分">
        </div>
    </div>
    <div class="weui-cell">
        <label for="" class="weui-label" style="color:#808080">活动简介</label>
        <div class="weui-cell__bd">
          <textarea class="weui-textarea"  rows="5"  name="hdsum" id="hdsum" placeholder=""></textarea>
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
<script src="../js/jquery-weui.js"></script>
    <script>
      
      $("#hdbtime").datetimePicker({
        title: '活动开始时间',
        yearSplit: '年',
        monthSplit: '月',
        dateSplit: '日',
        times: function () {
          return [  // 自定义的时间
            {
              values: (function () {
                var hours = [];
                for (var i=0; i<24; i++) hours.push(i > 9 ? i : '0'+i);
                return hours;
              })()
            },
            {
              divider: true,  // 这是一个分隔符
              content: '时'
            },
            {
              values: (function () {
                var minutes = [];
                for (var i=0; i<59; i++) minutes.push(i > 9 ? i : '0'+i);
                return minutes;
              })()
            },
            {
              divider: true,  // 这是一个分隔符
              content: '分'
            }
          ];
        },
        onChange: function (picker, values, displayValues) {
          console.log(values);
        }
      });
      
      $("#hdetime").datetimePicker({
        title: '结束时间',
        yearSplit: '年',
        monthSplit: '月',
        dateSplit: '日',
        times: function () {
          return [  // 自定义的时间
            {
              values: (function () {
                var hours = [];
                for (var i=0; i<24; i++) hours.push(i > 9 ? i : '0'+i);
                return hours;
              })()
            },
            {
              divider: true,  // 这是一个分隔符
              content: '时'
            },
            {
              values: (function () {
                var minutes = [];
                for (var i=0; i<59; i++) minutes.push(i > 9 ? i : '0'+i);
                return minutes;
              })()
            },
            {
              divider: true,  // 这是一个分隔符
              content: '分'
            }
          ];
        },
        onChange: function (picker, values, displayValues) {
          console.log(values);
        }
      });
      
    </script>
	
<script type="text/javascript">

function toinsert(){
	
	var hdtitle=$("#hdtitle").val(); //活动标题
	var hdtype=$("#hdtype").val();  // 活动类型
	var hdloc=$("#hdloc").val();  //活动地点
	var hdnum=$("#hdnum").val();  //活动人数
	var hdbtime=$("#hdbtime").val();  //活动开始时间
	var hdetime=$("#hdetime").val();  //活动结束时间
	var hdsum=$("#hdsum").val();      //活动简介
	var hdpic="static\\hd\\defaulthd.jpg";
	
	if($.trim(hdtitle)=="" || hdtitle==null){
		$.toptip('标题不能为空', 'success');
		}else if($.trim(hdtype)=="" || hdtype==null){
		$.toptip('类型不能为空', 'success');
		}else if($.trim(hdloc)=="" || hdloc==null){
		$.toptip('活动地点不能为空', 'success');
		}else if($.trim(hdnum)=="" || hdnum==null){
		$.toptip('活动人数不能为空', 'success');
		}else if($.trim(hdbtime)=="" || hdbtime==null){
		$.toptip('活动开始时间不能为空', 'success');
		}else if($.trim(hdetime)=="" || hdetime==null){
		$.toptip('活动结束时间不能为空', 'success');
		}else if($.trim(hdsum)=="" || hdsum==null){
		$.toptip('活动简介不能为空', 'success');
	
	}else{
		$.confirm("确认提交?", "", function() {
			$(".weui-loadmore").css("display","block");
        	$.ajax({  
					type: "POST",
					url: "<%=basePath%>hd/insertHuodong.do",
			    	data:  "hdtitle="+hdtitle+"&hdtype="+hdtype+"&hdloc="+hdloc+"&hdnum="+hdnum+"&hdbtime="+hdbtime+"&hdetime="+hdetime+"&hdpic="+hdpic+"&hdsum="+hdsum,  
					dataType:'json',
					cache: false,
					success: function(date){
						if(date.result=="success"){
						 window.location.href="<%=basePath%>hd/hdinsertsuccess";//跳到等待审核界面
						}
						else if(date.result=="error"){
						$(".weui-loadmore").css("display","none");
						$.toast("不要重复创建","cancel");
						}
						else{
						$(".weui-loadmore").css("display","none");
						$.toast("创建失败","cancel");
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
