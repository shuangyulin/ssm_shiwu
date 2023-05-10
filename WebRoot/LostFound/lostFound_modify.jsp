<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/lostFound.css" />
<div id="lostFound_editDiv">
	<form id="lostFoundEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">招领id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="lostFound_lostFoundId_edit" name="lostFound.lostFoundId" value="<%=request.getParameter("lostFoundId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">标题:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="lostFound_title_edit" name="lostFound.title" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">物品名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="lostFound_goodsName_edit" name="lostFound.goodsName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">捡得时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="lostFound_pickUpTime_edit" name="lostFound.pickUpTime" />

			</span>

		</div>
		<div>
			<span class="label">拾得地点:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="lostFound_pickUpPlace_edit" name="lostFound.pickUpPlace" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">描述说明:</span>
			<span class="inputControl">
				<textarea id="lostFound_contents_edit" name="lostFound.contents" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div>
			<span class="label">联系人:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="lostFound_connectPerson_edit" name="lostFound.connectPerson" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">联系电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="lostFound_phone_edit" name="lostFound.phone" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">发布时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="lostFound_addTime_edit" name="lostFound.addTime" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="lostFoundModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/LostFound/js/lostFound_modify.js"></script> 
