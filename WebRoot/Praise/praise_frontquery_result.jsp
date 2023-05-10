<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Praise" %>
<%@ page import="com.chengxusheji.po.LostFound" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Praise> praiseList = (List<Praise>)request.getAttribute("praiseList");
    //获取所有的lostFoundObj信息
    List<LostFound> lostFoundList = (List<LostFound>)request.getAttribute("lostFoundList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    LostFound lostFoundObj = (LostFound)request.getAttribute("lostFoundObj");
    String title = (String)request.getAttribute("title"); //标题查询关键字
    String addTime = (String)request.getAttribute("addTime"); //表扬时间查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>表扬查询</title>
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
			    	<li role="presentation" class="active"><a href="#praiseListPanel" aria-controls="praiseListPanel" role="tab" data-toggle="tab">表扬列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>Praise/praise_frontAdd.jsp" style="display:none;">添加表扬</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="praiseListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>表扬id</td><td>招领信息</td><td>标题</td><td>表扬内容</td><td>表扬时间</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<praiseList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		Praise praise = praiseList.get(i); //获取到表扬对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=praise.getPraiseId() %></td>
 											<td><%=praise.getLostFoundObj().getTitle() %></td>
 											<td><%=praise.getTitle() %></td>
 											<td><%=praise.getContents() %></td>
 											<td><%=praise.getAddTime() %></td>
 											<td>
 												<a href="<%=basePath  %>Praise/<%=praise.getPraiseId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="praiseEdit('<%=praise.getPraiseId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="praiseDelete('<%=praise.getPraiseId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
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
    		<h1>表扬查询</h1>
		</div>
		<form name="praiseQueryForm" id="praiseQueryForm" action="<%=basePath %>Praise/frontlist" class="mar_t15" method="post">
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
				<label for="title">标题:</label>
				<input type="text" id="title" name="title" value="<%=title %>" class="form-control" placeholder="请输入标题">
			</div>






			<div class="form-group">
				<label for="addTime">表扬时间:</label>
				<input type="text" id="addTime" name="addTime" class="form-control"  placeholder="请选择表扬时间" value="<%=addTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="praiseEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;表扬信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
		</form> 
	    <style>#praiseEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxPraiseModify();">提交</button>
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
    document.praiseQueryForm.currentPage.value = currentPage;
    document.praiseQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.praiseQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.praiseQueryForm.currentPage.value = pageValue;
    documentpraiseQueryForm.submit();
}

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
				$('#praiseEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除表扬信息*/
function praiseDelete(praiseId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Praise/deletes",
			data : {
				praiseIds : praiseId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#praiseQueryForm").submit();
					//location.href= basePath + "Praise/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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
})
</script>
</body>
</html>

