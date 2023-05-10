var area_manage_tool = null; 
$(function () { 
	initAreaManageTool(); //建立Area管理对象
	area_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#area_manage").datagrid({
		url : 'Area/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "areaId",
		sortOrder : "desc",
		toolbar : "#area_manage_tool",
		columns : [[
			{
				field : "areaId",
				title : "学院id",
				width : 70,
			},
			{
				field : "areaName",
				title : "学院名称",
				width : 140,
			},
		]],
	});

	$("#areaEditDiv").dialog({
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
				if ($("#areaEditForm").form("validate")) {
					//验证表单 
					if(!$("#areaEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#areaEditForm").form({
						    url:"Area/" + $("#area_areaId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#areaEditForm").form("validate"))  {
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
			                        $("#areaEditDiv").dialog("close");
			                        area_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#areaEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#areaEditDiv").dialog("close");
				$("#areaEditForm").form("reset"); 
			},
		}],
	});
});

function initAreaManageTool() {
	area_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#area_manage").datagrid("reload");
		},
		redo : function () {
			$("#area_manage").datagrid("unselectAll");
		},
		search: function() {
			$("#area_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#areaQueryForm").form({
			    url:"Area/OutToExcel",
			});
			//提交表单
			$("#areaQueryForm").submit();
		},
		remove : function () {
			var rows = $("#area_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var areaIds = [];
						for (var i = 0; i < rows.length; i ++) {
							areaIds.push(rows[i].areaId);
						}
						$.ajax({
							type : "POST",
							url : "Area/deletes",
							data : {
								areaIds : areaIds.join(","),
							},
							beforeSend : function () {
								$("#area_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#area_manage").datagrid("loaded");
									$("#area_manage").datagrid("load");
									$("#area_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#area_manage").datagrid("loaded");
									$("#area_manage").datagrid("load");
									$("#area_manage").datagrid("unselectAll");
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
			var rows = $("#area_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Area/" + rows[0].areaId +  "/update",
					type : "get",
					data : {
						//areaId : rows[0].areaId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (area, response, status) {
						$.messager.progress("close");
						if (area) { 
							$("#areaEditDiv").dialog("open");
							$("#area_areaId_edit").val(area.areaId);
							$("#area_areaId_edit").validatebox({
								required : true,
								missingMessage : "请输入学院id",
								editable: false
							});
							$("#area_areaName_edit").val(area.areaName);
							$("#area_areaName_edit").validatebox({
								required : true,
								missingMessage : "请输入学院名称",
							});
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
