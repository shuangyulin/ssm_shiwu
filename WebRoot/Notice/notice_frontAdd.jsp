<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
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
<title>站内通知添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
	<div class="row">
		<div class="col-md-12 wow fadeInUp" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li role="presentation" ><a href="<%=basePath %>Notice/frontlist">站内通知列表</a></li>
			    	<li role="presentation" class="active"><a href="#noticeAdd" aria-controls="noticeAdd" role="tab" data-toggle="tab">添加站内通知</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="noticeList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="noticeAdd"> 
				      	<form class="form-horizontal" name="noticeAddForm" id="noticeAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="notice_title" class="col-md-2 text-right">标题:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="notice_title" name="notice.title" class="form-control" placeholder="请输入标题">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="notice_content" class="col-md-2 text-right">内容:</label>
						  	 <div class="col-md-8">
							    <textarea id="notice_content" name="notice.content" rows="8" class="form-control" placeholder="请输入内容"></textarea>
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="notice_addTimeDiv" class="col-md-2 text-right">发布时间:</label>
						  	 <div class="col-md-8">
				                <div id="notice_addTimeDiv" class="input-group date notice_addTime col-md-12" data-link-field="notice_addTime">
				                    <input class="form-control" id="notice_addTime" name="notice.addTime" size="16" type="text" value="" placeholder="请选择发布时间" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
						  	 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxNoticeAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#noticeAddForm .form-group {margin:10px;}  </style>
					</div>
				</div>
			</div>
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
	//提交添加站内通知信息
	function ajaxNoticeAdd() { 
		//提交之前先验证表单
		$("#noticeAddForm").data('bootstrapValidator').validate();
		if(!$("#noticeAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Notice/add",
			dataType : "json" , 
			data: new FormData($("#noticeAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#noticeAddForm").find("input").val("");
					$("#noticeAddForm").find("textarea").val("");
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
	//验证站内通知添加表单字段
	$('#noticeAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"notice.title": {
				validators: {
					notEmpty: {
						message: "标题不能为空",
					}
				}
			},
			"notice.content": {
				validators: {
					notEmpty: {
						message: "内容不能为空",
					}
				}
			},
			"notice.addTime": {
				validators: {
					notEmpty: {
						message: "发布时间不能为空",
					}
				}
			},
		}
	}); 
	//发布时间组件
	$('#notice_addTimeDiv').datetimepicker({
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
		$('#noticeAddForm').data('bootstrapValidator').updateStatus('notice.addTime', 'NOT_VALIDATED',null).validateField('notice.addTime');
	});
})
</script>
</body>
</html>
