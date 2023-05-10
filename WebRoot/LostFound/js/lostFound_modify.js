$(function () {
	$.ajax({
		url : "LostFound/" + $("#lostFound_lostFoundId_edit").val() + "/update",
		type : "get",
		data : {
			//lostFoundId : $("#lostFound_lostFoundId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (lostFound, response, status) {
			$.messager.progress("close");
			if (lostFound) { 
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
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#lostFoundModifyButton").click(function(){ 
		if ($("#lostFoundEditForm").form("validate")) {
			$("#lostFoundEditForm").form({
			    url:"LostFound/" +  $("#lostFound_lostFoundId_edit").val() + "/update",
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
			$("#lostFoundEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
