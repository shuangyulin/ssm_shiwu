<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/area.css" />
<div id="areaAddDiv">
	<form id="areaAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">学院名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="area_areaName" name="area.areaName" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="areaAddButton" class="easyui-linkbutton">添加</a>
			<a id="areaClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Area/js/area_add.js"></script> 
