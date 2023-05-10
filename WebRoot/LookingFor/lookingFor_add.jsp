<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/lookingFor.css" />
<div id="lookingForAddDiv">
	<form id="lookingForAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">标题:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="lookingFor_title" name="lookingFor.title" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">丢失物品:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="lookingFor_goodsName" name="lookingFor.goodsName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">物品照片:</span>
			<span class="inputControl">
				<input id="goodsPhotoFile" name="goodsPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">丢失时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="lookingFor_lostTime" name="lookingFor.lostTime" />

			</span>

		</div>
		<div>
			<span class="label">丢失地点:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="lookingFor_lostPlace" name="lookingFor.lostPlace" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">物品描述:</span>
			<span class="inputControl">
				<textarea id="lookingFor_goodDesc" name="lookingFor.goodDesc" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div>
			<span class="label">报酬:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="lookingFor_reward" name="lookingFor.reward" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">联系电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="lookingFor_telephone" name="lookingFor.telephone" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">学生:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="lookingFor_userObj_user_name" name="lookingFor.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">发布时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="lookingFor_addTime" name="lookingFor.addTime" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="lookingForAddButton" class="easyui-linkbutton">添加</a>
			<a id="lookingForClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/LookingFor/js/lookingFor_add.js"></script> 
