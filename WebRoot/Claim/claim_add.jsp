<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/claim.css" />
<div id="claimAddDiv">
	<form id="claimAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">招领信息:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="claim_lostFoundObj_lostFoundId" name="claim.lostFoundObj.lostFoundId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">认领人:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="claim_personName" name="claim.personName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">认领时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="claim_claimTime" name="claim.claimTime" />

			</span>

		</div>
		<div>
			<span class="label">描述说明:</span>
			<span class="inputControl">
				<textarea id="claim_contents" name="claim.contents" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div>
			<span class="label">发布时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="claim_addTime" name="claim.addTime" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="claimAddButton" class="easyui-linkbutton">添加</a>
			<a id="claimClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Claim/js/claim_add.js"></script> 
