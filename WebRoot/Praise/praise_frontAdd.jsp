<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.LostFound" %>
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
<title>表扬添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>Praise/frontlist">表扬列表</a></li>
			    	<li role="presentation" class="active"><a href="#praiseAdd" aria-controls="praiseAdd" role="tab" data-toggle="tab">添加表扬</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="praiseList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="praiseAdd"> 
				      	<form class="form-horizontal" name="praiseAddForm" id="praiseAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="praise_lostFoundObj_lostFoundId" class="col-md-2 text-right">招领信息:</label>
						  	 <div class="col-md-8">
							    <select id="praise_lostFoundObj_lostFoundId" name="praise.lostFoundObj.lostFoundId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="praise_title" class="col-md-2 text-right">标题:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="praise_title" name="praise.title" class="form-control" placeholder="请输入标题">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="praise_contents" class="col-md-2 text-right">表扬内容:</label>
						  	 <div class="col-md-8">
							    <textarea id="praise_contents" name="praise.contents" rows="8" class="form-control" placeholder="请输入表扬内容"></textarea>
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="praise_addTimeDiv" class="col-md-2 text-right">表扬时间:</label>
						  	 <div class="col-md-8">
				                <div id="praise_addTimeDiv" class="input-group date praise_addTime col-md-12" data-link-field="praise_addTime">
				                    <input class="form-control" id="praise_addTime" name="praise.addTime" size="16" type="text" value="" placeholder="请选择表扬时间" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
						  	 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxPraiseAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#praiseAddForm .form-group {margin:10px;}  </style>
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
	//提交添加表扬信息
	function ajaxPraiseAdd() { 
		//提交之前先验证表单
		$("#praiseAddForm").data('bootstrapValidator').validate();
		if(!$("#praiseAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Praise/add",
			dataType : "json" , 
			data: new FormData($("#praiseAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#praiseAddForm").find("input").val("");
					$("#praiseAddForm").find("textarea").val("");
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
	//验证表扬添加表单字段
	$('#praiseAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"praise.title": {
				validators: {
					notEmpty: {
						message: "标题不能为空",
					}
				}
			},
			"praise.contents": {
				validators: {
					notEmpty: {
						message: "表扬内容不能为空",
					}
				}
			},
			"praise.addTime": {
				validators: {
					notEmpty: {
						message: "表扬时间不能为空",
					}
				}
			},
		}
	}); 
	//初始化招领信息下拉框值 
	$.ajax({
		url: basePath + "LostFound/listAll",
		type: "get",
		success: function(lostFounds,response,status) { 
			$("#praise_lostFoundObj_lostFoundId").empty();
			var html="";
    		$(lostFounds).each(function(i,lostFound){
    			html += "<option value='" + lostFound.lostFoundId + "'>" + lostFound.title + "</option>";
    		});
    		$("#praise_lostFoundObj_lostFoundId").html(html);
    	}
	});
	//表扬时间组件
	$('#praise_addTimeDiv').datetimepicker({
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
		$('#praiseAddForm').data('bootstrapValidator').updateStatus('praise.addTime', 'NOT_VALIDATED',null).validateField('praise.addTime');
	});
})
</script>
</body>
</html>
