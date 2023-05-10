$(function () {
	$("#notice_title").validatebox({
		required : true, 
		missingMessage : '请输入标题',
	});

	$("#notice_content").validatebox({
		required : true, 
		missingMessage : '请输入内容',
	});

	$("#notice_addTime").datetimebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	//单击添加按钮
	$("#noticeAddButton").click(function () {
		//验证表单 
		if(!$("#noticeAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#noticeAddForm").form({
			    url:"Notice/add",
			    onSubmit: function(){
					if($("#noticeAddForm").form("validate"))  { 
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
                    //此处data={"Success":true}是字符串
                	var obj = jQuery.parseJSON(data); 
                    if(obj.success){ 
                        $.messager.alert("消息","保存成功！");
                        $(".messager-window").css("z-index",10000);
                        $("#noticeAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#noticeAddForm").submit();
		}
	});

	//单击清空按钮
	$("#noticeClearButton").click(function () { 
		$("#noticeAddForm").form("clear"); 
	});
});
