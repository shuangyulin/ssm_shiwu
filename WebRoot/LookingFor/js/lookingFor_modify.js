$(function () {
	$.ajax({
		url : "LookingFor/" + $("#lookingFor_lookingForId_edit").val() + "/update",
		type : "get",
		data : {
			//lookingForId : $("#lookingFor_lookingForId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (lookingFor, response, status) {
			$.messager.progress("close");
			if (lookingFor) { 
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
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#lookingForModifyButton").click(function(){ 
		if ($("#lookingForEditForm").form("validate")) {
			$("#lookingForEditForm").form({
			    url:"LookingFor/" +  $("#lookingFor_lookingForId_edit").val() + "/update",
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
                	var obj = jQuery.parseJSON(data);
                    if(obj.success){
                        $.messager.alert("消息","信息修改成功！");
                        $(".messager-window").css("z-index",10000);
                        //location.href="frontlist";
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    } 
			    }
			});
			//提交表单
			$("#lookingForEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
