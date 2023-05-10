<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.LostFound" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<LostFound> lostFoundList = (List<LostFound>)request.getAttribute("lostFoundList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    String title = (String)request.getAttribute("title"); //标题查询关键字
    String goodsName = (String)request.getAttribute("goodsName"); //物品名称查询关键字
    String pickUpTime = (String)request.getAttribute("pickUpTime"); //捡得时间查询关键字
    String pickUpPlace = (String)request.getAttribute("pickUpPlace"); //拾得地点查询关键字
    String connectPerson = (String)request.getAttribute("connectPerson"); //联系人查询关键字
    String phone = (String)request.getAttribute("phone"); //联系电话查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>失物招领查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="row"> 
		<div class="col-md-9 wow fadeInDown" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li><a href="<%=basePath %>index.jsp">首页</a></li>
			    	<li role="presentation" class="active"><a href="#lostFoundListPanel" aria-controls="lostFoundListPanel" role="tab" data-toggle="tab">失物招领列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>LostFound/lostFound_frontAdd.jsp" style="display:none;">添加失物招领</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="lostFoundListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>招领id</td><td>标题</td><td>物品名称</td><td>捡得时间</td><td>拾得地点</td><td>联系人</td><td>联系电话</td><td>发布时间</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<lostFoundList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		LostFound lostFound = lostFoundList.get(i); //获取到失物招领对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=lostFound.getLostFoundId() %></td>
 											<td><%=lostFound.getTitle() %></td>
 											<td><%=lostFound.getGoodsName() %></td>
 											<td><%=lostFound.getPickUpTime() %></td>
 											<td><%=lostFound.getPickUpPlace() %></td>
 											<td><%=lostFound.getConnectPerson() %></td>
 											<td><%=lostFound.getPhone() %></td>
 											<td><%=lostFound.getAddTime() %></td>
 											<td>
 												<a href="<%=basePath  %>LostFound/<%=lostFound.getLostFoundId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="lostFoundEdit('<%=lostFound.getLostFoundId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="lostFoundDelete('<%=lostFound.getLostFoundId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
 											</td> 
 										</tr>
 										<%}%>
				    				</table>
				    				</div>
				    			</div>
				    		</div>

				    		<div class="row">
					            <div class="col-md-12">
						            <nav class="pull-left">
						                <ul class="pagination">
						                    <li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
						                     <%
						                    	int startPage = currentPage - 5;
						                    	int endPage = currentPage + 5;
						                    	if(startPage < 1) startPage=1;
						                    	if(endPage > totalPage) endPage = totalPage;
						                    	for(int i=startPage;i<=endPage;i++) {
						                    %>
						                    <li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
						                    <%  } %> 
						                    <li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						                </ul>
						            </nav>
						            <div class="pull-right" style="line-height:75px;" >共有<%=recordNumber %>条记录，当前第 <%=currentPage %>/<%=totalPage %> 页</div>
					            </div>
				            </div> 
				    </div>
				</div>
			</div>
		</div>
	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>失物招领查询</h1>
		</div>
		<form name="lostFoundQueryForm" id="lostFoundQueryForm" action="<%=basePath %>LostFound/frontlist" class="mar_t15" method="post">
			<div class="form-group">
				<label for="title">标题:</label>
				<input type="text" id="title" name="title" value="<%=title %>" class="form-control" placeholder="请输入标题">
			</div>






			<div class="form-group">
				<label for="goodsName">物品名称:</label>
				<input type="text" id="goodsName" name="goodsName" value="<%=goodsName %>" class="form-control" placeholder="请输入物品名称">
			</div>






			<div class="form-group">
				<label for="pickUpTime">捡得时间:</label>
				<input type="text" id="pickUpTime" name="pickUpTime" class="form-control"  placeholder="请选择捡得时间" value="<%=pickUpTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
			<div class="form-group">
				<label for="pickUpPlace">拾得地点:</label>
				<input type="text" id="pickUpPlace" name="pickUpPlace" value="<%=pickUpPlace %>" class="form-control" placeholder="请输入拾得地点">
			</div>






			<div class="form-group">
				<label for="connectPerson">联系人:</label>
				<input type="text" id="connectPerson" name="connectPerson" value="<%=connectPerson %>" class="form-control" placeholder="请输入联系人">
			</div>






			<div class="form-group">
				<label for="phone">联系电话:</label>
				<input type="text" id="phone" name="phone" value="<%=phone %>" class="form-control" placeholder="请输入联系电话">
			</div>






            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="lostFoundEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;失物招领信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
		</form> 
	    <style>#lostFoundEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxLostFoundModify();">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.lostFoundQueryForm.currentPage.value = currentPage;
    document.lostFoundQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.lostFoundQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.lostFoundQueryForm.currentPage.value = pageValue;
    documentlostFoundQueryForm.submit();
}

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
				$('#lostFoundEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除失物招领信息*/
function lostFoundDelete(lostFoundId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "LostFound/deletes",
			data : {
				lostFoundIds : lostFoundId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#lostFoundQueryForm").submit();
					//location.href= basePath + "LostFound/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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
})
</script>
</body>
</html>

