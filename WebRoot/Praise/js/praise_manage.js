var praise_manage_tool = null; 
$(function () { 
	initPraiseManageTool(); //建立Praise管理对象
	praise_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#praise_manage").datagrid({
		url : 'Praise/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "praiseId",
		sortOrder : "desc",
		toolbar : "#praise_manage_tool",
		columns : [[
			{
				field : "praiseId",
				title : "表扬id",
				width : 70,
			},
			{
				field : "lostFoundObj",
				title : "招领信息",
				width : 140,
			},
			{
				field : "title",
				title : "标题",
				width : 140,
			},
			{
				field : "contents",
				title : "表扬内容",
				width : 140,
			},
			{
				field : "addTime",
				title : "表扬时间",
				width : 140,
			},
		]],
	});

	$("#praiseEditDiv").dialog({
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
				if ($("#praiseEditForm").form("validate")) {
					//验证表单 
					if(!$("#praiseEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#praiseEditForm").form({
						    url:"Praise/" + $("#praise_praiseId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#praiseEditForm").form("validate"))  {
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
			                        $("#praiseEditDiv").dialog("close");
			                        praise_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#praiseEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#praiseEditDiv").dialog("close");
				$("#praiseEditForm").form("reset"); 
			},
		}],
	});
});

function initPraiseManageTool() {
	praise_manage_tool = {
		init: function() {
			$.ajax({
				url : "LostFound/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#lostFoundObj_lostFoundId_query").combobox({ 
					    valueField:"lostFoundId",
					    textField:"title",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{lostFoundId:0,title:"不限制"});
					$("#lostFoundObj_lostFoundId_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#praise_manage").datagrid("reload");
		},
		redo : function () {
			$("#praise_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#praise_manage").datagrid("options").queryParams;
			queryParams["lostFoundObj.lostFoundId"] = $("#lostFoundObj_lostFoundId_query").combobox("getValue");
			queryParams["title"] = $("#title").val();
			queryParams["addTime"] = $("#addTime").datebox("getValue"); 
			$("#praise_manage").datagrid("options").queryParams=queryParams; 
			$("#praise_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#praiseQueryForm").form({
			    url:"Praise/OutToExcel",
			});
			//提交表单
			$("#praiseQueryForm").submit();
		},
		remove : function () {
			var rows = $("#praise_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var praiseIds = [];
						for (var i = 0; i < rows.length; i ++) {
							praiseIds.push(rows[i].praiseId);
						}
						$.ajax({
							type : "POST",
							url : "Praise/deletes",
							data : {
								praiseIds : praiseIds.join(","),
							},
							beforeSend : function () {
								$("#praise_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#praise_manage").datagrid("loaded");
									$("#praise_manage").datagrid("load");
									$("#praise_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#praise_manage").datagrid("loaded");
									$("#praise_manage").datagrid("load");
									$("#praise_manage").datagrid("unselectAll");
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
			var rows = $("#praise_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Praise/" + rows[0].praiseId +  "/update",
					type : "get",
					data : {
						//praiseId : rows[0].praiseId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (praise, response, status) {
						$.messager.progress("close");
						if (praise) { 
							$("#praiseEditDiv").dialog("open");
							$("#praise_praiseId_edit").val(praise.praiseId);
							$("#praise_praiseId_edit").validatebox({
								required : true,
								missingMessage : "请输入表扬id",
								editable: false
							});
							$("#praise_lostFoundObj_lostFoundId_edit").combobox({
								url:"LostFound/listAll",
							    valueField:"lostFoundId",
							    textField:"title",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#praise_lostFoundObj_lostFoundId_edit").combobox("select", praise.lostFoundObjPri);
									//var data = $("#praise_lostFoundObj_lostFoundId_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#praise_lostFoundObj_lostFoundId_edit").combobox("select", data[0].lostFoundId);
						            //}
								}
							});
							$("#praise_title_edit").val(praise.title);
							$("#praise_title_edit").validatebox({
								required : true,
								missingMessage : "请输入标题",
							});
							$("#praise_contents_edit").val(praise.contents);
							$("#praise_contents_edit").validatebox({
								required : true,
								missingMessage : "请输入表扬内容",
							});
							$("#praise_addTime_edit").datetimebox({
								value: praise.addTime,
							    required: true,
							    showSeconds: true,
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
