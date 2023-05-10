<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/praise.css" />
<div id="praise_editDiv">
	<form id="praiseEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">表扬id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="praise_praiseId_edit" name="praise.praiseId" value="<%=request.getParameter("praiseId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">招领信息:</span>
			<span class="inputControl">
				<input class="textbox"  id="praise_lostFoundObj_lostFoundId_edit" name="praise.lostFoundObj.lostFoundId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">标题:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="praise_title_edit" name="praise.title" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">表扬内容:</span>
			<span class="inputControl">
				<textarea id="praise_contents_edit" name="praise.contents" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div>
			<span class="label">表扬时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="praise_addTime_edit" name="praise.addTime" />

			</span>

		</div>
		<div class="operation">
			<a id="praiseModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Praise/js/praise_modify.js"></script> 
