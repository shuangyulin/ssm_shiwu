<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/praise.css" />
<div id="praiseAddDiv">
	<form id="praiseAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">招领信息:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="praise_lostFoundObj_lostFoundId" name="praise.lostFoundObj.lostFoundId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">标题:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="praise_title" name="praise.title" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">表扬内容:</span>
			<span class="inputControl">
				<textarea id="praise_contents" name="praise.contents" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div>
			<span class="label">表扬时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="praise_addTime" name="praise.addTime" />

			</span>

		</div>
		<div class="operation">
			<a id="praiseAddButton" class="easyui-linkbutton">添加</a>
			<a id="praiseClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Praise/js/praise_add.js"></script> 
