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
<title>认领添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>Claim/frontlist">认领列表</a></li>
			    	<li role="presentation" class="active"><a href="#claimAdd" aria-controls="claimAdd" role="tab" data-toggle="tab">添加认领</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="claimList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="claimAdd"> 
				      	<form class="form-horizontal" name="claimAddForm" id="claimAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="claim_lostFoundObj_lostFoundId" class="col-md-2 text-right">招领信息:</label>
						  	 <div class="col-md-8">
							    <select id="claim_lostFoundObj_lostFoundId" name="claim.lostFoundObj.lostFoundId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="claim_personName" class="col-md-2 text-right">认领人:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="claim_personName" name="claim.personName" class="form-control" placeholder="请输入认领人">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="claim_claimTimeDiv" class="col-md-2 text-right">认领时间:</label>
						  	 <div class="col-md-8">
				                <div id="claim_claimTimeDiv" class="input-group date claim_claimTime col-md-12" data-link-field="claim_claimTime">
				                    <input class="form-control" id="claim_claimTime" name="claim.claimTime" size="16" type="text" value="" placeholder="请选择认领时间" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="claim_contents" class="col-md-2 text-right">描述说明:</label>
						  	 <div class="col-md-8">
							    <textarea id="claim_contents" name="claim.contents" rows="8" class="form-control" placeholder="请输入描述说明"></textarea>
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="claim_addTime" class="col-md-2 text-right">发布时间:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="claim_addTime" name="claim.addTime" class="form-control" placeholder="请输入发布时间">
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxClaimAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#claimAddForm .form-group {margin:10px;}  </style>
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
	//提交添加认领信息
	function ajaxClaimAdd() { 
		//提交之前先验证表单
		$("#claimAddForm").data('bootstrapValidator').validate();
		if(!$("#claimAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Claim/add",
			dataType : "json" , 
			data: new FormData($("#claimAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#claimAddForm").find("input").val("");
					$("#claimAddForm").find("textarea").val("");
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
	//验证认领添加表单字段
	$('#claimAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"claim.personName": {
				validators: {
					notEmpty: {
						message: "认领人不能为空",
					}
				}
			},
			"claim.claimTime": {
				validators: {
					notEmpty: {
						message: "认领时间不能为空",
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
			$("#claim_lostFoundObj_lostFoundId").empty();
			var html="";
    		$(lostFounds).each(function(i,lostFound){
    			html += "<option value='" + lostFound.lostFoundId + "'>" + lostFound.title + "</option>";
    		});
    		$("#claim_lostFoundObj_lostFoundId").html(html);
    	}
	});
	//认领时间组件
	$('#claim_claimTimeDiv').datetimepicker({
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
		$('#claimAddForm').data('bootstrapValidator').updateStatus('claim.claimTime', 'NOT_VALIDATED',null).validateField('claim.claimTime');
	});
})
</script>
</body>
</html>
