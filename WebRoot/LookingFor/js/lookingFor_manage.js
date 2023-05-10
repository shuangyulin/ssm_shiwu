var lookingFor_manage_tool = null; 
$(function () { 
	initLookingForManageTool(); //建立LookingFor管理对象
	lookingFor_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#lookingFor_manage").datagrid({
		url : 'LookingFor/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "lookingForId",
		sortOrder : "desc",
		toolbar : "#lookingFor_manage_tool",
		columns : [[
			{
				field : "lookingForId",
				title : "寻物id",
				width : 70,
			},
			{
				field : "title",
				title : "标题",
				width : 140,
			},
			{
				field : "goodsName",
				title : "丢失物品",
				width : 140,
			},
			{
				field : "goodsPhoto",
				title : "物品照片",
				width : "70px",
				height: "65px",
				formatter: function(val,row) {
					return "<img src='" + val + "' width='65px' height='55px' />";
				}
 			},
			{
				field : "lostTime",
				title : "丢失时间",
				width : 140,
			},
			{
				field : "lostPlace",
				title : "丢失地点",
				width : 140,
			},
			{
				field : "reward",
				title : "报酬",
				width : 140,
			},
			{
				field : "telephone",
				title : "联系电话",
				width : 140,
			},
			{
				field : "userObj",
				title : "学生",
				width : 140,
			},
			{
				field : "addTime",
				title : "发布时间",
				width : 140,
			},
		]],
	});

	$("#lookingForEditDiv").dialog({
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
				if ($("#lookingForEditForm").form("validate")) {
					//验证表单 
					if(!$("#lookingForEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#lookingForEditForm").form({
						    url:"LookingFor/" + $("#lookingFor_lookingForId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#lookingForEditForm").form("validate"))  {
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
			                        $("#lookingForEditDiv").dialog("close");
			                        lookingFor_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#lookingForEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#lookingForEditDiv").dialog("close");
				$("#lookingForEditForm").form("reset"); 
			},
		}],
	});
});

function initLookingForManageTool() {
	lookingFor_manage_tool = {
		init: function() {
			$.ajax({
				url : "UserInfo/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#userObj_user_name_query").combobox({ 
					    valueField:"user_name",
					    textField:"name",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{user_name:"",name:"不限制"});
					$("#userObj_user_name_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#lookingFor_manage").datagrid("reload");
		},
		redo : function () {
			$("#lookingFor_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#lookingFor_manage").datagrid("options").queryParams;
			queryParams["title"] = $("#title").val();
			queryParams["goodsName"] = $("#goodsName").val();
			queryParams["lostTime"] = $("#lostTime").datebox("getValue"); 
			queryParams["lostPlace"] = $("#lostPlace").val();
			queryParams["telephone"] = $("#telephone").val();
			queryParams["userObj.user_name"] = $("#userObj_user_name_query").combobox("getValue");
			$("#lookingFor_manage").datagrid("options").queryParams=queryParams; 
			$("#lookingFor_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#lookingForQueryForm").form({
			    url:"LookingFor/OutToExcel",
			});
			//提交表单
			$("#lookingForQueryForm").submit();
		},
		remove : function () {
			var rows = $("#lookingFor_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var lookingForIds = [];
						for (var i = 0; i < rows.length; i ++) {
							lookingForIds.push(rows[i].lookingForId);
						}
						$.ajax({
							type : "POST",
							url : "LookingFor/deletes",
							data : {
								lookingForIds : lookingForIds.join(","),
							},
							beforeSend : function () {
								$("#lookingFor_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#lookingFor_manage").datagrid("loaded");
									$("#lookingFor_manage").datagrid("load");
									$("#lookingFor_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#lookingFor_manage").datagrid("loaded");
									$("#lookingFor_manage").datagrid("load");
									$("#lookingFor_manage").datagrid("unselectAll");
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
			var rows = $("#lookingFor_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "LookingFor/" + rows[0].lookingForId +  "/update",
					type : "get",
					data : {
						//lookingForId : rows[0].lookingForId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (lookingFor, response, status) {
						$.messager.progress("close");
						if (lookingFor) { 
							$("#lookingForEditDiv").dialog("open");
							$("#lookingFor_lookingForId_edit").val(lookingFor.lookingForId);
							$("#lookingFor_lookingForId_edit").validatebox({
								required : true,
								missingMessage : "请输入寻物id",
								editable: false
							});
							$("#lookingFor_title_edit").val(lookingFor.title);
							$("#lookingFor_title_edit").validatebox({
								required : true,
								missingMessage : "请输入标题",
							});
							$("#lookingFor_goodsName_edit").val(lookingFor.goodsName);
							$("#lookingFor_goodsName_edit").validatebox({
								required : true,
								missingMessage : "请输入丢失物品",
							});
							$("#lookingFor_goodsPhoto").val(lookingFor.goodsPhoto);
							$("#lookingFor_goodsPhotoImg").attr("src", lookingFor.goodsPhoto);
							$("#lookingFor_lostTime_edit").datetimebox({
								value: lookingFor.lostTime,
							    required: true,
							    showSeconds: true,
							});
							$("#lookingFor_lostPlace_edit").val(lookingFor.lostPlace);
							$("#lookingFor_lostPlace_edit").validatebox({
								required : true,
								missingMessage : "请输入丢失地点",
							});
							$("#lookingFor_goodDesc_edit").val(lookingFor.goodDesc);
							$("#lookingFor_goodDesc_edit").validatebox({
								required : true,
								missingMessage : "请输入物品描述",
							});
							$("#lookingFor_reward_edit").val(lookingFor.reward);
							$("#lookingFor_reward_edit").validatebox({
								required : true,
								missingMessage : "请输入报酬",
							});
							$("#lookingFor_telephone_edit").val(lookingFor.telephone);
							$("#lookingFor_telephone_edit").validatebox({
								required : true,
								missingMessage : "请输入联系电话",
							});
							$("#lookingFor_userObj_user_name_edit").combobox({
								url:"UserInfo/listAll",
							    valueField:"user_name",
							    textField:"name",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#lookingFor_userObj_user_name_edit").combobox("select", lookingFor.userObjPri);
									//var data = $("#lookingFor_userObj_user_name_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#lookingFor_userObj_user_name_edit").combobox("select", data[0].user_name);
						            //}
								}
							});
							$("#lookingFor_addTime_edit").val(lookingFor.addTime);
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
