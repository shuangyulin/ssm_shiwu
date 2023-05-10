<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/notice.css" />
<div id="notice_editDiv">
	<form id="noticeEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">通知id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="notice_noticeId_edit" name="notice.noticeId" value="<%=request.getParameter("noticeId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">标题:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="notice_title_edit" name="notice.title" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">内容:</span>
			<span class="inputControl">
				<textarea id="notice_content_edit" name="notice.content" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div>
			<span class="label">发布时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="notice_addTime_edit" name="notice.addTime" />

			</span>

		</div>
		<div class="operation">
			<a id="noticeModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Notice/js/notice_modify.js"></script> 
