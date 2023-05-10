$(function () {
	$("#lostFound_title").validatebox({
		required : true, 
		missingMessage : '请输入标题',
	});

	$("#lostFound_goodsName").validatebox({
		required : true, 
		missingMessage : '请输入物品名称',
	});

	$("#lostFound_pickUpTime").datetimebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	$("#lostFound_pickUpPlace").validatebox({
		required : true, 
		missingMessage : '请输入拾得地点',
	});

	$("#lostFound_contents").validatebox({
		required : true, 
		missingMessage : '请输入描述说明',
	});

	$("#lostFound_connectPerson").validatebox({
		required : true, 
		missingMessage : '请输入联系人',
	});

	$("#lostFound_phone").validatebox({
		required : true, 
		missingMessage : '请输入联系电话',
	});

	//单击添加按钮
	$("#lostFoundAddButton").click(function () {
		//验证表单 
		if(!$("#lostFoundAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#lostFoundAddForm").form({
			    url:"LostFound/add",
			    onSubmit: function(){
					if($("#lostFoundAddForm").form("validate"))  { 
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
                        $("#lostFoundAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#lostFoundAddForm").submit();
		}
	});

	//单击清空按钮
	$("#lostFoundClearButton").click(function () { 
		$("#lostFoundAddForm").form("clear"); 
	});
});
