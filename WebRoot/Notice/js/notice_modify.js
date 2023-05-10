$(function () {
	$.ajax({
		url : "Notice/" + $("#notice_noticeId_edit").val() + "/update",
		type : "get",
		data : {
			//noticeId : $("#notice_noticeId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (notice, response, status) {
			$.messager.progress("close");
			if (notice) { 
				$("#notice_noticeId_edit").val(notice.noticeId);
				$("#notice_noticeId_edit").validatebox({
					required : true,
					missingMessage : "请输入通知id",
					editable: false
				});
				$("#notice_title_edit").val(notice.title);
				$("#notice_title_edit").validatebox({
					required : true,
					missingMessage : "请输入标题",
				});
				$("#notice_content_edit").val(notice.content);
				$("#notice_content_edit").validatebox({
					required : true,
					missingMessage : "请输入内容",
				});
				$("#notice_addTime_edit").datetimebox({
					value: notice.addTime,
					required: true,
					showSeconds: true,
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#noticeModifyButton").click(function(){ 
		if ($("#noticeEditForm").form("validate")) {
			$("#noticeEditForm").form({
			    url:"Notice/" +  $("#notice_noticeId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#noticeEditForm").form("validate"))  {
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
			$("#noticeEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
