<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/lookingFor.css" />
<div id="lookingFor_editDiv">
	<form id="lookingForEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">寻物id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="lookingFor_lookingForId_edit" name="lookingFor.lookingForId" value="<%=request.getParameter("lookingForId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">标题:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="lookingFor_title_edit" name="lookingFor.title" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">丢失物品:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="lookingFor_goodsName_edit" name="lookingFor.goodsName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">物品照片:</span>
			<span class="inputControl">
				<img id="lookingFor_goodsPhotoImg" width="200px" border="0px"/><br/>
    			<input type="hidden" id="lookingFor_goodsPhoto" name="lookingFor.goodsPhoto"/>
				<input id="goodsPhotoFile" name="goodsPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">丢失时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="lookingFor_lostTime_edit" name="lookingFor.lostTime" />

			</span>

		</div>
		<div>
			<span class="label">丢失地点:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="lookingFor_lostPlace_edit" name="lookingFor.lostPlace" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">物品描述:</span>
			<span class="inputControl">
				<textarea id="lookingFor_goodDesc_edit" name="lookingFor.goodDesc" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div>
			<span class="label">报酬:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="lookingFor_reward_edit" name="lookingFor.reward" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">联系电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="lookingFor_telephone_edit" name="lookingFor.telephone" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">学生:</span>
			<span class="inputControl">
				<input class="textbox"  id="lookingFor_userObj_user_name_edit" name="lookingFor.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">发布时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="lookingFor_addTime_edit" name="lookingFor.addTime" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="lookingForModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/LookingFor/js/lookingFor_modify.js"></script> 
