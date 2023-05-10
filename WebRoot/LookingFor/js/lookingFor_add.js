$(function () {
	$("#lookingFor_title").validatebox({
		required : true, 
		missingMessage : '请输入标题',
	});

	$("#lookingFor_goodsName").validatebox({
		required : true, 
		missingMessage : '请输入丢失物品',
	});

	$("#lookingFor_lostTime").datetimebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	$("#lookingFor_lostPlace").validatebox({
		required : true, 
		missingMessage : '请输入丢失地点',
	});

	$("#lookingFor_goodDesc").validatebox({
		required : true, 
		missingMessage : '请输入物品描述',
	});

	$("#lookingFor_reward").validatebox({
		required : true, 
		missingMessage : '请输入报酬',
	});

	$("#lookingFor_telephone").validatebox({
		required : true, 
		missingMessage : '请输入联系电话',
	});

	$("#lookingFor_userObj_user_name").combobox({
	    url:'UserInfo/listAll',
	    valueField: "user_name",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#lookingFor_userObj_user_name").combobox("getData"); 
            if (data.length > 0) {
                $("#lookingFor_userObj_user_name").combobox("select", data[0].user_name);
            }
        }
	});
	//单击添加按钮
	$("#lookingForAddButton").click(function () {
		//验证表单 
		if(!$("#lookingForAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#lookingForAddForm").form({
			    url:"LookingFor/add",
			    onSubmit: function(){
					if($("#lookingForAddForm").form("validate"))  { 
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
                        $("#lookingForAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#lookingForAddForm").submit();
		}
	});

	//单击清空按钮
	$("#lookingForClearButton").click(function () { 
		$("#lookingForAddForm").form("clear"); 
	});
});
