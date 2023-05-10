<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.LostFound" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    LostFound lostFound = (LostFound)request.getAttribute("lostFound");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改失物招领信息</TITLE>
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
  		<li class="active">失物招领信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="lostFoundEditForm" id="lostFoundEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="lostFound_lostFoundId_edit" class="col-md-3 text-right">招领id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="lostFound_lostFoundId_edit" name="lostFound.lostFoundId" class="form-control" placeholder="请输入招领id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="lostFound_title_edit" class="col-md-3 text-right">标题:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="lostFound_title_edit" name="lostFound.title" class="form-control" placeholder="请输入标题">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="lostFound_goodsName_edit" class="col-md-3 text-right">物品名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="lostFound_goodsName_edit" name="lostFound.goodsName" class="form-control" placeholder="请输入物品名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="lostFound_pickUpTime_edit" class="col-md-3 text-right">捡得时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date lostFound_pickUpTime_edit col-md-12" data-link-field="lostFound_pickUpTime_edit">
                    <input class="form-control" id="lostFound_pickUpTime_edit" name="lostFound.pickUpTime" size="16" type="text" value="" placeholder="请选择捡得时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="lostFound_pickUpPlace_edit" class="col-md-3 text-right">拾得地点:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="lostFound_pickUpPlace_edit" name="lostFound.pickUpPlace" class="form-control" placeholder="请输入拾得地点">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="lostFound_contents_edit" class="col-md-3 text-right">描述说明:</label>
		  	 <div class="col-md-9">
			    <textarea id="lostFound_contents_edit" name="lostFound.contents" rows="8" class="form-control" placeholder="请输入描述说明"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="lostFound_connectPerson_edit" class="col-md-3 text-right">联系人:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="lostFound_connectPerson_edit" name="lostFound.connectPerson" class="form-control" placeholder="请输入联系人">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="lostFound_phone_edit" class="col-md-3 text-right">联系电话:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="lostFound_phone_edit" name="lostFound.phone" class="form-control" placeholder="请输入联系电话">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="lostFound_addTime_edit" class="col-md-3 text-right">发布时间:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="lostFound_addTime_edit" name="lostFound.addTime" class="form-control" placeholder="请输入发布时间">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxLostFoundModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#lostFoundEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改失物招领界面并初始化数据*/
function lostFoundEdit(lostFoundId) {
	$.ajax({
		url :  basePath + "LostFound/" + lostFoundId + "/update",
		type : "get",
		dataType: "json",
		success : function (lostFound, response, status) {
			if (lostFound) {
				$("#lostFound_lostFoundId_edit").val(lostFound.lostFoundId);
				$("#lostFound_title_edit").val(lostFound.title);
				$("#lostFound_goodsName_edit").val(lostFound.goodsName);
				$("#lostFound_pickUpTime_edit").val(lostFound.pickUpTime);
				$("#lostFound_pickUpPlace_edit").val(lostFound.pickUpPlace);
				$("#lostFound_contents_edit").val(lostFound.contents);
				$("#lostFound_connectPerson_edit").val(lostFound.connectPerson);
				$("#lostFound_phone_edit").val(lostFound.phone);
				$("#lostFound_addTime_edit").val(lostFound.addTime);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交失物招领信息表单给服务器端修改*/
function ajaxLostFoundModify() {
	$.ajax({
		url :  basePath + "LostFound/" + $("#lostFound_lostFoundId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#lostFoundEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#lostFoundQueryForm").submit();
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
    /*捡得时间组件*/
    $('.lostFound_pickUpTime_edit').datetimepicker({
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
    lostFoundEdit("<%=request.getParameter("lostFoundId")%>");
 })
 </script> 
</body>
</html>

