<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>寻物启事添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-12 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>LookingFor/frontlist">寻物启事管理</a></li>
  			<li class="active">添加寻物启事</li>
		</ul>
		<div class="row">
			<div class="col-md-10">
		      	<form class="form-horizontal" name="lookingForAddForm" id="lookingForAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
				  <div class="form-group">
				  	 <label for="lookingFor_title" class="col-md-2 text-right">标题:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="lookingFor_title" name="lookingFor.title" class="form-control" placeholder="请输入标题">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="lookingFor_goodsName" class="col-md-2 text-right">丢失物品:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="lookingFor_goodsName" name="lookingFor.goodsName" class="form-control" placeholder="请输入丢失物品">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="lookingFor_goodsPhoto" class="col-md-2 text-right">物品照片:</label>
				  	 <div class="col-md-8">
					    <img  class="img-responsive" id="lookingFor_goodsPhotoImg" border="0px"/><br/>
					    <input type="hidden" id="lookingFor_goodsPhoto" name="lookingFor.goodsPhoto"/>
					    <input id="goodsPhotoFile" name="goodsPhotoFile" type="file" size="50" />
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="lookingFor_lostTimeDiv" class="col-md-2 text-right">丢失时间:</label>
				  	 <div class="col-md-8">
		                <div id="lookingFor_lostTimeDiv" class="input-group date lookingFor_lostTime col-md-12" data-link-field="lookingFor_lostTime">
		                    <input class="form-control" id="lookingFor_lostTime" name="lookingFor.lostTime" size="16" type="text" value="" placeholder="请选择丢失时间" readonly>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
		                </div>
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="lookingFor_lostPlace" class="col-md-2 text-right">丢失地点:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="lookingFor_lostPlace" name="lookingFor.lostPlace" class="form-control" placeholder="请输入丢失地点">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="lookingFor_goodDesc" class="col-md-2 text-right">物品描述:</label>
				  	 <div class="col-md-8">
					    <textarea id="lookingFor_goodDesc" name="lookingFor.goodDesc" rows="8" class="form-control" placeholder="请输入物品描述"></textarea>
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="lookingFor_reward" class="col-md-2 text-right">报酬:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="lookingFor_reward" name="lookingFor.reward" class="form-control" placeholder="请输入报酬">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="lookingFor_telephone" class="col-md-2 text-right">联系电话:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="lookingFor_telephone" name="lookingFor.telephone" class="form-control" placeholder="请输入联系电话">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="lookingFor_userObj_user_name" class="col-md-2 text-right">学生:</label>
				  	 <div class="col-md-8">
					    <select id="lookingFor_userObj_user_name" name="lookingFor.userObj.user_name" class="form-control">
					    </select>
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="lookingFor_addTime" class="col-md-2 text-right">发布时间:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="lookingFor_addTime" name="lookingFor.addTime" class="form-control" placeholder="请输入发布时间">
					 </div>
				  </div>
		          <div class="form-group">
		             <span class="col-md-2""></span>
		             <span onclick="ajaxLookingForAdd();" class="btn btn-primary bottom5 top5">添加</span>
		          </div> 
		          <style>#lookingForAddForm .form-group {margin:5px;}  </style>  
				</form> 
			</div>
			<div class="col-md-2"></div> 
	    </div>
	</div>
</div>
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript" src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script>
var basePath = "<%=basePath%>";
	//提交添加寻物启事信息
	function ajaxLookingForAdd() { 
		//提交之前先验证表单
		$("#lookingForAddForm").data('bootstrapValidator').validate();
		if(!$("#lookingForAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "LookingFor/add",
			dataType : "json" , 
			data: new FormData($("#lookingForAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#lookingForAddForm").find("input").val("");
					$("#lookingForAddForm").find("textarea").val("");
				} else {
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
	//验证寻物启事添加表单字段
	$('#lookingForAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"lookingFor.title": {
				validators: {
					notEmpty: {
						message: "标题不能为空",
					}
				}
			},
			"lookingFor.goodsName": {
				validators: {
					notEmpty: {
						message: "丢失物品不能为空",
					}
				}
			},
			"lookingFor.lostTime": {
				validators: {
					notEmpty: {
						message: "丢失时间不能为空",
					}
				}
			},
			"lookingFor.lostPlace": {
				validators: {
					notEmpty: {
						message: "丢失地点不能为空",
					}
				}
			},
			"lookingFor.goodDesc": {
				validators: {
					notEmpty: {
						message: "物品描述不能为空",
					}
				}
			},
			"lookingFor.reward": {
				validators: {
					notEmpty: {
						message: "报酬不能为空",
					}
				}
			},
			"lookingFor.telephone": {
				validators: {
					notEmpty: {
						message: "联系电话不能为空",
					}
				}
			},
		}
	}); 
	//初始化学生下拉框值 
	$.ajax({
		url: basePath + "UserInfo/listAll",
		type: "get",
		success: function(userInfos,response,status) { 
			$("#lookingFor_userObj_user_name").empty();
			var html="";
    		$(userInfos).each(function(i,userInfo){
    			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
    		});
    		$("#lookingFor_userObj_user_name").html(html);
    	}
	});
	//丢失时间组件
	$('#lookingFor_lostTimeDiv').datetimepicker({
		language:  'zh-CN',  //显示语言
		format: 'yyyy-mm-dd hh:ii:ss',
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		minuteStep: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0
	}).on('hide',function(e) {
		//下面这行代码解决日期组件改变日期后不验证的问题
		$('#lookingForAddForm').data('bootstrapValidator').updateStatus('lookingFor.lostTime', 'NOT_VALIDATED',null).validateField('lookingFor.lostTime');
	});
})
</script>
</body>
</html>
