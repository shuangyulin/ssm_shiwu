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
<title>失物招领添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>LostFound/frontlist">失物招领列表</a></li>
			    	<li role="presentation" class="active"><a href="#lostFoundAdd" aria-controls="lostFoundAdd" role="tab" data-toggle="tab">添加失物招领</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="lostFoundList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="lostFoundAdd"> 
				      	<form class="form-horizontal" name="lostFoundAddForm" id="lostFoundAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="lostFound_title" class="col-md-2 text-right">标题:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="lostFound_title" name="lostFound.title" class="form-control" placeholder="请输入标题">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="lostFound_goodsName" class="col-md-2 text-right">物品名称:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="lostFound_goodsName" name="lostFound.goodsName" class="form-control" placeholder="请输入物品名称">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="lostFound_pickUpTimeDiv" class="col-md-2 text-right">捡得时间:</label>
						  	 <div class="col-md-8">
				                <div id="lostFound_pickUpTimeDiv" class="input-group date lostFound_pickUpTime col-md-12" data-link-field="lostFound_pickUpTime">
				                    <input class="form-control" id="lostFound_pickUpTime" name="lostFound.pickUpTime" size="16" type="text" value="" placeholder="请选择捡得时间" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="lostFound_pickUpPlace" class="col-md-2 text-right">拾得地点:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="lostFound_pickUpPlace" name="lostFound.pickUpPlace" class="form-control" placeholder="请输入拾得地点">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="lostFound_contents" class="col-md-2 text-right">描述说明:</label>
						  	 <div class="col-md-8">
							    <textarea id="lostFound_contents" name="lostFound.contents" rows="8" class="form-control" placeholder="请输入描述说明"></textarea>
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="lostFound_connectPerson" class="col-md-2 text-right">联系人:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="lostFound_connectPerson" name="lostFound.connectPerson" class="form-control" placeholder="请输入联系人">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="lostFound_phone" class="col-md-2 text-right">联系电话:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="lostFound_phone" name="lostFound.phone" class="form-control" placeholder="请输入联系电话">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="lostFound_addTime" class="col-md-2 text-right">发布时间:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="lostFound_addTime" name="lostFound.addTime" class="form-control" placeholder="请输入发布时间">
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxLostFoundAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#lostFoundAddForm .form-group {margin:10px;}  </style>
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
	//提交添加失物招领信息
	function ajaxLostFoundAdd() { 
		//提交之前先验证表单
		$("#lostFoundAddForm").data('bootstrapValidator').validate();
		if(!$("#lostFoundAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "LostFound/add",
			dataType : "json" , 
			data: new FormData($("#lostFoundAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#lostFoundAddForm").find("input").val("");
					$("#lostFoundAddForm").find("textarea").val("");
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
	//验证失物招领添加表单字段
	$('#lostFoundAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"lostFound.title": {
				validators: {
					notEmpty: {
						message: "标题不能为空",
					}
				}
			},
			"lostFound.goodsName": {
				validators: {
					notEmpty: {
						message: "物品名称不能为空",
					}
				}
			},
			"lostFound.pickUpTime": {
				validators: {
					notEmpty: {
						message: "捡得时间不能为空",
					}
				}
			},
			"lostFound.pickUpPlace": {
				validators: {
					notEmpty: {
						message: "拾得地点不能为空",
					}
				}
			},
			"lostFound.contents": {
				validators: {
					notEmpty: {
						message: "描述说明不能为空",
					}
				}
			},
			"lostFound.connectPerson": {
				validators: {
					notEmpty: {
						message: "联系人不能为空",
					}
				}
			},
			"lostFound.phone": {
				validators: {
					notEmpty: {
						message: "联系电话不能为空",
					}
				}
			},
		}
	}); 
	//捡得时间组件
	$('#lostFound_pickUpTimeDiv').datetimepicker({
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
		$('#lostFoundAddForm').data('bootstrapValidator').updateStatus('lostFound.pickUpTime', 'NOT_VALIDATED',null).validateField('lostFound.pickUpTime');
	});
})
</script>
</body>
</html>
