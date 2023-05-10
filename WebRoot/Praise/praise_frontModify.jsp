<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Praise" %>
<%@ page import="com.chengxusheji.po.LostFound" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的lostFoundObj信息
    List<LostFound> lostFoundList = (List<LostFound>)request.getAttribute("lostFoundList");
    Praise praise = (Praise)request.getAttribute("praise");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改表扬信息</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li class="active">表扬信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="praiseEditForm" id="praiseEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="praise_praiseId_edit" class="col-md-3 text-right">表扬id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="praise_praiseId_edit" name="praise.praiseId" class="form-control" placeholder="请输入表扬id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="praise_lostFoundObj_lostFoundId_edit" class="col-md-3 text-right">招领信息:</label>
		  	 <div class="col-md-9">
			    <select id="praise_lostFoundObj_lostFoundId_edit" name="praise.lostFoundObj.lostFoundId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="praise_title_edit" class="col-md-3 text-right">标题:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="praise_title_edit" name="praise.title" class="form-control" placeholder="请输入标题">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="praise_contents_edit" class="col-md-3 text-right">表扬内容:</label>
		  	 <div class="col-md-9">
			    <textarea id="praise_contents_edit" name="praise.contents" rows="8" class="form-control" placeholder="请输入表扬内容"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="praise_addTime_edit" class="col-md-3 text-right">表扬时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date praise_addTime_edit col-md-12" data-link-field="praise_addTime_edit">
                    <input class="form-control" id="praise_addTime_edit" name="praise.addTime" size="16" type="text" value="" placeholder="请选择表扬时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxPraiseModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#praiseEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
   </div>
</div>


<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*弹出修改表扬界面并初始化数据*/
function praiseEdit(praiseId) {
	$.ajax({
		url :  basePath + "Praise/" + praiseId + "/update",
		type : "get",
		dataType: "json",
		success : function (praise, response, status) {
			if (praise) {
				$("#praise_praiseId_edit").val(praise.praiseId);
				$.ajax({
					url: basePath + "LostFound/listAll",
					type: "get",
					success: function(lostFounds,response,status) { 
						$("#praise_lostFoundObj_lostFoundId_edit").empty();
						var html="";
		        		$(lostFounds).each(function(i,lostFound){
		        			html += "<option value='" + lostFound.lostFoundId + "'>" + lostFound.title + "</option>";
		        		});
		        		$("#praise_lostFoundObj_lostFoundId_edit").html(html);
		        		$("#praise_lostFoundObj_lostFoundId_edit").val(praise.lostFoundObjPri);
					}
				});
				$("#praise_title_edit").val(praise.title);
				$("#praise_contents_edit").val(praise.contents);
				$("#praise_addTime_edit").val(praise.addTime);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交表扬信息表单给服务器端修改*/
function ajaxPraiseModify() {
	$.ajax({
		url :  basePath + "Praise/" + $("#praise_praiseId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#praiseEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#praiseQueryForm").submit();
            }else{
                alert(obj.message);
            } 
		},
		processData: false,
		contentType: false,
	});
}

$(function(){
        /*小屏幕导航点击关闭菜单*/
        $('.navbar-collapse a').click(function(){
            $('.navbar-collapse').collapse('hide');
        });
        new WOW().init();
    /*表扬时间组件*/
    $('.praise_addTime_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd hh:ii:ss',
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    praiseEdit("<%=request.getParameter("praiseId")%>");
 })
 </script> 
</body>
</html>

