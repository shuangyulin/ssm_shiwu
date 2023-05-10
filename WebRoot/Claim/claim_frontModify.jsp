<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Claim" %>
<%@ page import="com.chengxusheji.po.LostFound" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的lostFoundObj信息
    List<LostFound> lostFoundList = (List<LostFound>)request.getAttribute("lostFoundList");
    Claim claim = (Claim)request.getAttribute("claim");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改认领信息</TITLE>
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
  		<li class="active">认领信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="claimEditForm" id="claimEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="claim_claimId_edit" class="col-md-3 text-right">认领id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="claim_claimId_edit" name="claim.claimId" class="form-control" placeholder="请输入认领id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="claim_lostFoundObj_lostFoundId_edit" class="col-md-3 text-right">招领信息:</label>
		  	 <div class="col-md-9">
			    <select id="claim_lostFoundObj_lostFoundId_edit" name="claim.lostFoundObj.lostFoundId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="claim_personName_edit" class="col-md-3 text-right">认领人:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="claim_personName_edit" name="claim.personName" class="form-control" placeholder="请输入认领人">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="claim_claimTime_edit" class="col-md-3 text-right">认领时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date claim_claimTime_edit col-md-12" data-link-field="claim_claimTime_edit">
                    <input class="form-control" id="claim_claimTime_edit" name="claim.claimTime" size="16" type="text" value="" placeholder="请选择认领时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="claim_contents_edit" class="col-md-3 text-right">描述说明:</label>
		  	 <div class="col-md-9">
			    <textarea id="claim_contents_edit" name="claim.contents" rows="8" class="form-control" placeholder="请输入描述说明"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="claim_addTime_edit" class="col-md-3 text-right">发布时间:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="claim_addTime_edit" name="claim.addTime" class="form-control" placeholder="请输入发布时间">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxClaimModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#claimEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改认领界面并初始化数据*/
function claimEdit(claimId) {
	$.ajax({
		url :  basePath + "Claim/" + claimId + "/update",
		type : "get",
		dataType: "json",
		success : function (claim, response, status) {
			if (claim) {
				$("#claim_claimId_edit").val(claim.claimId);
				$.ajax({
					url: basePath + "LostFound/listAll",
					type: "get",
					success: function(lostFounds,response,status) { 
						$("#claim_lostFoundObj_lostFoundId_edit").empty();
						var html="";
		        		$(lostFounds).each(function(i,lostFound){
		        			html += "<option value='" + lostFound.lostFoundId + "'>" + lostFound.title + "</option>";
		        		});
		        		$("#claim_lostFoundObj_lostFoundId_edit").html(html);
		        		$("#claim_lostFoundObj_lostFoundId_edit").val(claim.lostFoundObjPri);
					}
				});
				$("#claim_personName_edit").val(claim.personName);
				$("#claim_claimTime_edit").val(claim.claimTime);
				$("#claim_contents_edit").val(claim.contents);
				$("#claim_addTime_edit").val(claim.addTime);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交认领信息表单给服务器端修改*/
function ajaxClaimModify() {
	$.ajax({
		url :  basePath + "Claim/" + $("#claim_claimId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#claimEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#claimQueryForm").submit();
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
    /*认领时间组件*/
    $('.claim_claimTime_edit').datetimepicker({
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
    claimEdit("<%=request.getParameter("claimId")%>");
 })
 </script> 
</body>
</html>

