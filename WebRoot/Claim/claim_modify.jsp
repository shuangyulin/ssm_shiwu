<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/claim.css" />
<div id="claim_editDiv">
	<form id="claimEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">认领id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="claim_claimId_edit" name="claim.claimId" value="<%=request.getParameter("claimId") %>" style="width:200px" />
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
		<div class="operation">
			<a id="claimModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Claim/js/claim_modify.js"></script> 
