<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/lostFound.css" />
<div id="lostFoundAddDiv">
	<form id="lostFoundAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">标题:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="lostFound_title" name="lostFound.title" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">物品名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="lostFound_goodsName" name="lostFound.goodsName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">捡得时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="lostFound_pickUpTime" name="lostFound.pickUpTime" />

			</span>

		</div>
		<div>
			<span class="label">拾得地点:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="lostFound_pickUpPlace" name="lostFound.pickUpPlace" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">描述说明:</span>
			<span class="inputControl">
				<textarea id="lostFound_contents" name="lostFound.contents" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div>
			<span class="label">联系人:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="lostFound_connectPerson" name="lostFound.connectPerson" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">联系电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="lostFound_phone" name="lostFound.phone" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">发布时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="lostFound_addTime" name="lostFound.addTime" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="lostFoundAddButton" class="easyui-linkbutton">添加</a>
			<a id="lostFoundClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/LostFound/js/lostFound_add.js"></script> 
