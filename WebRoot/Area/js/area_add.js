$(function () {
	$("#area_areaName").validatebox({
		required : true, 
		missingMessage : '请输入学院名称',
	});

	//单击添加按钮
	$("#areaAddButton").click(function () {
		//验证表单 
		if(!$("#areaAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#areaAddForm").form({
			    url:"Area/add",
			    onSubmit: function(){
					if($("#areaAddForm").form("validate"))  { 
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
                        $("#areaAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#areaAddForm").submit();
		}
	});

	//单击清空按钮
	$("#areaClearButton").click(function () { 
		$("#areaAddForm").form("clear"); 
	});
});
