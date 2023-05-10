var claim_manage_tool = null; 
$(function () { 
	initClaimManageTool(); //建立Claim管理对象
	claim_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#claim_manage").datagrid({
		url : 'Claim/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "claimId",
		sortOrder : "desc",
		toolbar : "#claim_manage_tool",
		columns : [[
			{
				field : "claimId",
				title : "认领id",
				width : 70,
			},
			{
				field : "lostFoundObj",
				title : "招领信息",
				width : 140,
			},
			{
				field : "personName",
				title : "认领人",
				width : 140,
			},
			{
				field : "claimTime",
				title : "认领时间",
				width : 140,
			},
			{
				field : "addTime",
				title : "发布时间",
				width : 140,
			},
		]],
	});

	$("#claimEditDiv").dialog({
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
				if ($("#claimEditForm").form("validate")) {
					//验证表单 
					if(!$("#claimEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#claimEditForm").form({
						    url:"Claim/" + $("#claim_claimId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#claimEditForm").form("validate"))  {
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
			                        $("#claimEditDiv").dialog("close");
			                        claim_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#claimEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#claimEditDiv").dialog("close");
				$("#claimEditForm").form("reset"); 
			},
		}],
	});
});

function initClaimManageTool() {
	claim_manage_tool = {
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
			$("#claim_manage").datagrid("reload");
		},
		redo : function () {
			$("#claim_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#claim_manage").datagrid("options").queryParams;
			queryParams["lostFoundObj.lostFoundId"] = $("#lostFoundObj_lostFoundId_query").combobox("getValue");
			queryParams["personName"] = $("#personName").val();
			queryParams["claimTime"] = $("#claimTime").datebox("getValue"); 
			$("#claim_manage").datagrid("options").queryParams=queryParams; 
			$("#claim_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#claimQueryForm").form({
			    url:"Claim/OutToExcel",
			});
			//提交表单
			$("#claimQueryForm").submit();
		},
		remove : function () {
			var rows = $("#claim_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var claimIds = [];
						for (var i = 0; i < rows.length; i ++) {
							claimIds.push(rows[i].claimId);
						}
						$.ajax({
							type : "POST",
							url : "Claim/deletes",
							data : {
								claimIds : claimIds.join(","),
							},
							beforeSend : function () {
								$("#claim_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#claim_manage").datagrid("loaded");
									$("#claim_manage").datagrid("load");
									$("#claim_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#claim_manage").datagrid("loaded");
									$("#claim_manage").datagrid("load");
									$("#claim_manage").datagrid("unselectAll");
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
			var rows = $("#claim_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Claim/" + rows[0].claimId +  "/update",
					type : "get",
					data : {
						//claimId : rows[0].claimId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (claim, response, status) {
						$.messager.progress("close");
						if (claim) { 
							$("#claimEditDiv").dialog("open");
							$("#claim_claimId_edit").val(claim.claimId);
							$("#claim_claimId_edit").validatebox({
								required : true,
								missingMessage : "请输入认领id",
								editable: false
							});
							$("#claim_lostFoundObj_lostFoundId_edit").combobox({
								url:"LostFound/listAll",
							    valueField:"lostFoundId",
							    textField:"title",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#claim_lostFoundObj_lostFoundId_edit").combobox("select", claim.lostFoundObjPri);
									//var data = $("#claim_lostFoundObj_lostFoundId_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#claim_lostFoundObj_lostFoundId_edit").combobox("select", data[0].lostFoundId);
						            //}
								}
							});
							$("#claim_personName_edit").val(claim.personName);
							$("#claim_personName_edit").validatebox({
								required : true,
								missingMessage : "请输入认领人",
							});
							$("#claim_claimTime_edit").datetimebox({
								value: claim.claimTime,
							    required: true,
							    showSeconds: true,
							});
							$("#claim_contents_edit").val(claim.contents);
							$("#claim_addTime_edit").val(claim.addTime);
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
