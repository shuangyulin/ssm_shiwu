<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/notice.css" /> 

<div id="notice_manage"></div>
<div id="notice_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="notice_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="notice_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="notice_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="notice_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="notice_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="noticeQueryForm" method="post">
			标题：<input type="text" class="textbox" id="title" name="title" style="width:110px" />
			发布时间：<input type="text" id="addTime" name="addTime" class="easyui-datebox" editable="false" style="width:100px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="notice_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="noticeEditDiv">
	<form id="noticeEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">通知id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="notice_noticeId_edit" name="notice.noticeId" style="width:200px" />
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
	</form>
</div>
<script type="text/javascript" src="Notice/js/notice_manage.js"></script> 
