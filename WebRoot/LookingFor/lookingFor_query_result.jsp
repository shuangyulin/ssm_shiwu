<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/lookingFor.css" /> 

<div id="lookingFor_manage"></div>
<div id="lookingFor_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="lookingFor_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="lookingFor_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="lookingFor_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="lookingFor_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="lookingFor_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="lookingForQueryForm" method="post">
			标题：<input type="text" class="textbox" id="title" name="title" style="width:110px" />
			丢失物品：<input type="text" class="textbox" id="goodsName" name="goodsName" style="width:110px" />
			丢失时间：<input type="text" id="lostTime" name="lostTime" class="easyui-datebox" editable="false" style="width:100px">
			丢失地点：<input type="text" class="textbox" id="lostPlace" name="lostPlace" style="width:110px" />
			联系电话：<input type="text" class="textbox" id="telephone" name="telephone" style="width:110px" />
			学生：<input class="textbox" type="text" id="userObj_user_name_query" name="userObj.user_name" style="width: auto"/>
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="lookingFor_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="lookingForEditDiv">
	<form id="lookingForEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">寻物id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="lookingFor_lookingForId_edit" name="lookingFor.lookingForId" style="width:200px" />
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
	</form>
</div>
<script type="text/javascript" src="LookingFor/js/lookingFor_manage.js"></script> 
