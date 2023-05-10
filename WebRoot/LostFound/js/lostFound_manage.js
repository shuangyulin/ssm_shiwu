var lostFound_manage_tool = null; 
$(function () { 
	initLostFoundManageTool(); //建立LostFound管理对象
	lostFound_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#lostFound_manage").datagrid({
		url : 'LostFound/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "lostFoundId",
		sortOrder : "desc",
		toolbar : "#lostFound_manage_tool",
		columns : [[
			{
				field : "lostFoundId",
				title : "招领id",
				width : 70,
			},
			{
				field : "title",
				title : "标题",
				width : 140,
			},
			{
				field : "goodsName",
				title : "物品名称",
				width : 140,
			},
			{
				field : "pickUpTime",
				title : "捡得时间",
				width : 140,
			},
			{
				field : "pickUpPlace",
				title : "拾得地点",
				width : 140,
			},
			{
				field : "connectPerson",
				title : "联系人",
				width : 140,
			},
			{
				field : "phone",
				title : "联系电话",
				width : 140,
			},
			{
				field : "addTime",
				title : "发布时间",
				width : 140,
			},
		]],
	});

	$("#lostFoundEditDiv").dialog({
		title : "修改管理",
		top: "50px",
		width : 700,
		height : 515,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#lostFoundEditForm").form("validate")) {
					//验证表单 
					if(!$("#lostFoundEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#lostFoundEditForm").form({
						    url:"LostFound/" + $("#lostFound_lostFoundId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#lostFoundEditForm").form("validate"))  {
				                	$.messager.progress({
										text : "正在提交数据中...",
									});
				                	return true;
				                } else { 
				                    return false; 
				                }
						    },
						    success:function(data){
						    	$.messager.progress("close");
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#lostFoundEditDiv").dialog("close");
			                        lostFound_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#lostFoundEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#lostFoundEditDiv").dialog("close");
				$("#lostFoundEditForm").form("reset"); 
			},
		}],
	});
});

function initLostFoundManageTool() {
	lostFound_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#lostFound_manage").datagrid("reload");
		},
		redo : function () {
			$("#lostFound_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#lostFound_manage").datagrid("options").queryParams;
			queryParams["title"] = $("#title").val();
			queryParams["goodsName"] = $("#goodsName").val();
			queryParams["pickUpTime"] = $("#pickUpTime").datebox("getValue"); 
			queryParams["pickUpPlace"] = $("#pickUpPlace").val();
			queryParams["connectPerson"] = $("#connectPerson").val();
			queryParams["phone"] = $("#phone").val();
			$("#lostFound_manage").datagrid("options").queryParams=queryParams; 
			$("#lostFound_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#lostFoundQueryForm").form({
			    url:"LostFound/OutToExcel",
			});
			//提交表单
			$("#lostFoundQueryForm").submit();
		},
		remove : function () {
			var rows = $("#lostFound_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var lostFoundIds = [];
						for (var i = 0; i < rows.length; i ++) {
							lostFoundIds.push(rows[i].lostFoundId);
						}
						$.ajax({
							type : "POST",
							url : "LostFound/deletes",
							data : {
								lostFoundIds : lostFoundIds.join(","),
							},
							beforeSend : function () {
								$("#lostFound_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#lostFound_manage").datagrid("loaded");
									$("#lostFound_manage").datagrid("load");
									$("#lostFound_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#lostFound_manage").datagrid("loaded");
									$("#lostFound_manage").datagrid("load");
									$("#lostFound_manage").datagrid("unselectAll");
									$.messager.alert("消息",data.message);
								}
							},
						});
					}
				});
			} else {
				$.messager.alert("提示", "请选择要删除的记录！", "info");
			}
		},
		edit : function () {
			var rows = $("#lostFound_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "LostFound/" + rows[0].lostFoundId +  "/update",
					type : "get",
					data : {
						//lostFoundId : rows[0].lostFoundId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (lostFound, response, status) {
						$.messager.progress("close");
						if (lostFound) { 
							$("#lostFoundEditDiv").dialog("open");
							$("#lostFound_lostFoundId_edit").val(lostFound.lostFoundId);
							$("#lostFound_lostFoundId_edit").validatebox({
								required : true,
								missingMessage : "请输入招领id",
								editable: false
							});
							$("#lostFound_title_edit").val(lostFound.title);
							$("#lostFound_title_edit").validatebox({
								required : true,
								missingMessage : "请输入标题",
							});
							$("#lostFound_goodsName_edit").val(lostFound.goodsName);
							$("#lostFound_goodsName_edit").validatebox({
								required : true,
								missingMessage : "请输入物品名称",
							});
							$("#lostFound_pickUpTime_edit").datetimebox({
								value: lostFound.pickUpTime,
							    required: true,
							    showSeconds: true,
							});
							$("#lostFound_pickUpPlace_edit").val(lostFound.pickUpPlace);
							$("#lostFound_pickUpPlace_edit").validatebox({
								required : true,
								missingMessage : "请输入拾得地点",
							});
							$("#lostFound_contents_edit").val(lostFound.contents);
							$("#lostFound_contents_edit").validatebox({
								required : true,
								missingMessage : "请输入描述说明",
							});
							$("#lostFound_connectPerson_edit").val(lostFound.connectPerson);
							$("#lostFound_connectPerson_edit").validatebox({
								required : true,
								missingMessage : "请输入联系人",
							});
							$("#lostFound_phone_edit").val(lostFound.phone);
							$("#lostFound_phone_edit").validatebox({
								required : true,
								missingMessage : "请输入联系电话",
							});
							$("#lostFound_addTime_edit").val(lostFound.addTime);
						} else {
							$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
