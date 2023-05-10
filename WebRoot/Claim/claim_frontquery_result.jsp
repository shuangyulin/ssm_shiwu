<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Claim" %>
<%@ page import="com.chengxusheji.po.LostFound" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Claim> claimList = (List<Claim>)request.getAttribute("claimList");
    //获取所有的lostFoundObj信息
    List<LostFound> lostFoundList = (List<LostFound>)request.getAttribute("lostFoundList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    LostFound lostFoundObj = (LostFound)request.getAttribute("lostFoundObj");
    String personName = (String)request.getAttribute("personName"); //认领人查询关键字
    String claimTime = (String)request.getAttribute("claimTime"); //认领时间查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>认领查询</title>
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
			    	<li role="presentation" class="active"><a href="#claimListPanel" aria-controls="claimListPanel" role="tab" data-toggle="tab">认领列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>Claim/claim_frontAdd.jsp" style="display:none;">添加认领</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="claimListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>认领id</td><td>招领信息</td><td>认领人</td><td>认领时间</td><td>发布时间</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<claimList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		Claim claim = claimList.get(i); //获取到认领对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=claim.getClaimId() %></td>
 											<td><%=claim.getLostFoundObj().getTitle() %></td>
 											<td><%=claim.getPersonName() %></td>
 											<td><%=claim.getClaimTime() %></td>
 											<td><%=claim.getAddTime() %></td>
 											<td>
 												<a href="<%=basePath  %>Claim/<%=claim.getClaimId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="claimEdit('<%=claim.getClaimId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="claimDelete('<%=claim.getClaimId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
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
    		<h1>认领查询</h1>
		</div>
		<form name="claimQueryForm" id="claimQueryForm" action="<%=basePath %>Claim/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="lostFoundObj_lostFoundId">招领信息：</label>
                <select id="lostFoundObj_lostFoundId" name="lostFoundObj.lostFoundId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(LostFound lostFoundTemp:lostFoundList) {
	 					String selected = "";
 					if(lostFoundObj!=null && lostFoundObj.getLostFoundId()!=null && lostFoundObj.getLostFoundId().intValue()==lostFoundTemp.getLostFoundId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=lostFoundTemp.getLostFoundId() %>" <%=selected %>><%=lostFoundTemp.getTitle() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="personName">认领人:</label>
				<input type="text" id="personName" name="personName" value="<%=personName %>" class="form-control" placeholder="请输入认领人">
			</div>






			<div class="form-group">
				<label for="claimTime">认领时间:</label>
				<input type="text" id="claimTime" name="claimTime" class="form-control"  placeholder="请选择认领时间" value="<%=claimTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="claimEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;认领信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
		</form> 
	    <style>#claimEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxClaimModify();">提交</button>
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
    document.claimQueryForm.currentPage.value = currentPage;
    document.claimQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.claimQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.claimQueryForm.currentPage.value = pageValue;
    documentclaimQueryForm.submit();
}

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
				$('#claimEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除认领信息*/
function claimDelete(claimId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Claim/deletes",
			data : {
				claimIds : claimId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#claimQueryForm").submit();
					//location.href= basePath + "Claim/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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
})
</script>
</body>
</html>

