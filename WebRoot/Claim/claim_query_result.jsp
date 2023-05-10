<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/claim.css" /> 

<div id="claim_manage"></div>
<div id="claim_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="claim_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="claim_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="claim_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="claim_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="claim_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="claimQueryForm" method="post">
			招领信息：<input class="textbox" type="text" id="lostFoundObj_lostFoundId_query" name="lostFoundObj.lostFoundId" style="width: auto"/>
			认领人：<input type="text" class="textbox" id="personName" name="personName" style="width:110px" />
			认领时间：<input type="text" id="claimTime" name="claimTime" class="easyui-datebox" editable="false" style="width:100px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="claim_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="claimEditDiv">
	<form id="claimEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">认领id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="claim_claimId_edit" name="claim.claimId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">招领信息:</span>
			<span class="inputControl">
				<input class="textbox"  id="claim_lostFoundObj_lostFoundId_edit" name="claim.lostFoundObj.lostFoundId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">认领人:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="claim_personName_edit" name="claim.personName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">认领时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="claim_claimTime_edit" name="claim.claimTime" />

			</span>

		</div>
		<div>
			<span class="label">描述说明:</span>
			<span class="inputControl">
				<textarea id="claim_contents_edit" name="claim.contents" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div>
			<span class="label">发布时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="claim_addTime_edit" name="claim.addTime" style="width:200px" />

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="Claim/js/claim_manage.js"></script> 
