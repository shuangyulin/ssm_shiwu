<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.LookingFor" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<LookingFor> lookingForList = (List<LookingFor>)request.getAttribute("lookingForList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    String title = (String)request.getAttribute("title"); //标题查询关键字
    String goodsName = (String)request.getAttribute("goodsName"); //丢失物品查询关键字
    String lostTime = (String)request.getAttribute("lostTime"); //丢失时间查询关键字
    String lostPlace = (String)request.getAttribute("lostPlace"); //丢失地点查询关键字
    String telephone = (String)request.getAttribute("telephone"); //联系电话查询关键字
    UserInfo userObj = (UserInfo)request.getAttribute("userObj");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>寻物启事查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>LookingFor/frontlist">寻物启事信息列表</a></li>
  			<li class="active">查询结果显示</li>
  			<a class="pull-right" href="<%=basePath %>LookingFor/lookingFor_frontAdd.jsp" style="display:none;">添加寻物启事</a>
		</ul>
		<div class="row">
			<%
				/*计算起始序号*/
				int startIndex = (currentPage -1) * 5;
				/*遍历记录*/
				for(int i=0;i<lookingForList.size();i++) {
            		int currentIndex = startIndex + i + 1; //当前记录的序号
            		LookingFor lookingFor = lookingForList.get(i); //获取到寻物启事对象
            		String clearLeft = "";
            		if(i%4 == 0) clearLeft = "style=\"clear:left;\"";
			%>
			<div class="col-md-3 bottom15" <%=clearLeft %>>
			  <a  href="<%=basePath  %>LookingFor/<%=lookingFor.getLookingForId() %>/frontshow"><img class="img-responsive" src="<%=basePath%><%=lookingFor.getGoodsPhoto()%>" /></a>
			     <div class="showFields">
			     	<div class="field">
	            		寻物id:<%=lookingFor.getLookingForId() %>
			     	</div>
			     	<div class="field">
	            		标题:<%=lookingFor.getTitle() %>
			     	</div>
			     	<div class="field">
	            		丢失物品:<%=lookingFor.getGoodsName() %>
			     	</div>
			     	<div class="field">
	            		丢失时间:<%=lookingFor.getLostTime() %>
			     	</div>
			     	<div class="field">
	            		丢失地点:<%=lookingFor.getLostPlace() %>
			     	</div>
			     	<div class="field">
	            		报酬:<%=lookingFor.getReward() %>
			     	</div>
			     	<div class="field">
	            		联系电话:<%=lookingFor.getTelephone() %>
			     	</div>
			     	<div class="field">
	            		学生:<%=lookingFor.getUserObj().getName() %>
			     	</div>
			     	<div class="field">
	            		发布时间:<%=lookingFor.getAddTime() %>
			     	</div>
			        <a class="btn btn-primary top5" href="<%=basePath %>LookingFor/<%=lookingFor.getLookingForId() %>/frontshow">详情</a>
			        <a class="btn btn-primary top5" onclick="lookingForEdit('<%=lookingFor.getLookingForId() %>');" style="display:none;">修改</a>
			        <a class="btn btn-primary top5" onclick="lookingForDelete('<%=lookingFor.getLookingForId() %>');" style="display:none;">删除</a>
			     </div>
			</div>
			<%  } %>

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

	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>寻物启事查询</h1>
		</div>
		<form name="lookingForQueryForm" id="lookingForQueryForm" action="<%=basePath %>LookingFor/frontlist" class="mar_t15" method="post">
			<div class="form-group">
				<label for="title">标题:</label>
				<input type="text" id="title" name="title" value="<%=title %>" class="form-control" placeholder="请输入标题">
			</div>
			<div class="form-group">
				<label for="goodsName">丢失物品:</label>
				<input type="text" id="goodsName" name="goodsName" value="<%=goodsName %>" class="form-control" placeholder="请输入丢失物品">
			</div>
			<div class="form-group">
				<label for="lostTime">丢失时间:</label>
				<input type="text" id="lostTime" name="lostTime" class="form-control"  placeholder="请选择丢失时间" value="<%=lostTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
			<div class="form-group">
				<label for="lostPlace">丢失地点:</label>
				<input type="text" id="lostPlace" name="lostPlace" value="<%=lostPlace %>" class="form-control" placeholder="请输入丢失地点">
			</div>
			<div class="form-group">
				<label for="telephone">联系电话:</label>
				<input type="text" id="telephone" name="telephone" value="<%=telephone %>" class="form-control" placeholder="请输入联系电话">
			</div>
            <div class="form-group">
            	<label for="userObj_user_name">学生：</label>
                <select id="userObj_user_name" name="userObj.user_name" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(UserInfo userInfoTemp:userInfoList) {
	 					String selected = "";
 					if(userObj!=null && userObj.getUser_name()!=null && userObj.getUser_name().equals(userInfoTemp.getUser_name()))
 						selected = "selected";
	 				%>
 				 <option value="<%=userInfoTemp.getUser_name() %>" <%=selected %>><%=userInfoTemp.getName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
</div>
<div id="lookingForEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;寻物启事信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="lookingForEditForm" id="lookingForEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="lookingFor_lookingForId_edit" class="col-md-3 text-right">寻物id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="lookingFor_lookingForId_edit" name="lookingFor.lookingForId" class="form-control" placeholder="请输入寻物id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="lookingFor_title_edit" class="col-md-3 text-right">标题:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="lookingFor_title_edit" name="lookingFor.title" class="form-control" placeholder="请输入标题">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="lookingFor_goodsName_edit" class="col-md-3 text-right">丢失物品:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="lookingFor_goodsName_edit" name="lookingFor.goodsName" class="form-control" placeholder="请输入丢失物品">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="lookingFor_goodsPhoto_edit" class="col-md-3 text-right">物品照片:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="lookingFor_goodsPhotoImg" border="0px"/><br/>
			    <input type="hidden" id="lookingFor_goodsPhoto" name="lookingFor.goodsPhoto"/>
			    <input id="goodsPhotoFile" name="goodsPhotoFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="lookingFor_lostTime_edit" class="col-md-3 text-right">丢失时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date lookingFor_lostTime_edit col-md-12" data-link-field="lookingFor_lostTime_edit">
                    <input class="form-control" id="lookingFor_lostTime_edit" name="lookingFor.lostTime" size="16" type="text" value="" placeholder="请选择丢失时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="lookingFor_lostPlace_edit" class="col-md-3 text-right">丢失地点:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="lookingFor_lostPlace_edit" name="lookingFor.lostPlace" class="form-control" placeholder="请输入丢失地点">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="lookingFor_goodDesc_edit" class="col-md-3 text-right">物品描述:</label>
		  	 <div class="col-md-9">
			    <textarea id="lookingFor_goodDesc_edit" name="lookingFor.goodDesc" rows="8" class="form-control" placeholder="请输入物品描述"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="lookingFor_reward_edit" class="col-md-3 text-right">报酬:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="lookingFor_reward_edit" name="lookingFor.reward" class="form-control" placeholder="请输入报酬">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="lookingFor_telephone_edit" class="col-md-3 text-right">联系电话:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="lookingFor_telephone_edit" name="lookingFor.telephone" class="form-control" placeholder="请输入联系电话">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="lookingFor_userObj_user_name_edit" class="col-md-3 text-right">学生:</label>
		  	 <div class="col-md-9">
			    <select id="lookingFor_userObj_user_name_edit" name="lookingFor.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="lookingFor_addTime_edit" class="col-md-3 text-right">发布时间:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="lookingFor_addTime_edit" name="lookingFor.addTime" class="form-control" placeholder="请输入发布时间">
			 </div>
		  </div>
		</form> 
	    <style>#lookingForEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxLookingForModify();">提交</button>
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
    document.lookingForQueryForm.currentPage.value = currentPage;
    document.lookingForQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.lookingForQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.lookingForQueryForm.currentPage.value = pageValue;
    documentlookingForQueryForm.submit();
}

/*弹出修改寻物启事界面并初始化数据*/
function lookingForEdit(lookingForId) {
	$.ajax({
		url :  basePath + "LookingFor/" + lookingForId + "/update",
		type : "get",
		dataType: "json",
		success : function (lookingFor, response, status) {
			if (lookingFor) {
				$("#lookingFor_lookingForId_edit").val(lookingFor.lookingForId);
				$("#lookingFor_title_edit").val(lookingFor.title);
				$("#lookingFor_goodsName_edit").val(lookingFor.goodsName);
				$("#lookingFor_goodsPhoto").val(lookingFor.goodsPhoto);
				$("#lookingFor_goodsPhotoImg").attr("src", basePath +　lookingFor.goodsPhoto);
				$("#lookingFor_lostTime_edit").val(lookingFor.lostTime);
				$("#lookingFor_lostPlace_edit").val(lookingFor.lostPlace);
				$("#lookingFor_goodDesc_edit").val(lookingFor.goodDesc);
				$("#lookingFor_reward_edit").val(lookingFor.reward);
				$("#lookingFor_telephone_edit").val(lookingFor.telephone);
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#lookingFor_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#lookingFor_userObj_user_name_edit").html(html);
		        		$("#lookingFor_userObj_user_name_edit").val(lookingFor.userObjPri);
					}
				});
				$("#lookingFor_addTime_edit").val(lookingFor.addTime);
				$('#lookingForEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除寻物启事信息*/
function lookingForDelete(lookingForId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "LookingFor/deletes",
			data : {
				lookingForIds : lookingForId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#lookingForQueryForm").submit();
					//location.href= basePath + "LookingFor/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交寻物启事信息表单给服务器端修改*/
function ajaxLookingForModify() {
	$.ajax({
		url :  basePath + "LookingFor/" + $("#lookingFor_lookingForId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#lookingForEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#lookingForQueryForm").submit();
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

    /*丢失时间组件*/
    $('.lookingFor_lostTime_edit').datetimepicker({
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

