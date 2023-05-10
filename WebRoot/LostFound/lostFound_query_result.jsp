<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/lostFound.css" /> 

<div id="lostFound_manage"></div>
<div id="lostFound_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="lostFound_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="lostFound_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="lostFound_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="lostFound_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="lostFound_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="lostFoundQueryForm" method="post">
			标题：<input type="text" class="textbox" id="title" name="title" style="width:110px" />
			物品名称：<input type="text" class="textbox" id="goodsName" name="goodsName" style="width:110px" />
			捡得时间：<input type="text" id="pickUpTime" name="pickUpTime" class="easyui-datebox" editable="false" style="width:100px">
			拾得地点：<input type="text" class="textbox" id="pickUpPlace" name="pickUpPlace" style="width:110px" />
			联系人：<input type="text" class="textbox" id="connectPerson" name="connectPerson" style="width:110px" />
			联系电话：<input type="text" class="textbox" id="phone" name="phone" style="width:110px" />
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="lostFound_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="lostFoundEditDiv">
	<form id="lostFoundEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">招领id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="lostFound_lostFoundId_edit" name="lostFound.lostFoundId" style="width:200px" />
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
	</form>
</div>
<script type="text/javascript" src="LostFound/js/lostFound_manage.js"></script> 
