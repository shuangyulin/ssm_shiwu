$(function () {
	$("#claim_lostFoundObj_lostFoundId").combobox({
	    url:'LostFound/listAll',
	    valueField: "lostFoundId",
	    textField: "title",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#claim_lostFoundObj_lostFoundId").combobox("getData"); 
            if (data.length > 0) {
                $("#claim_lostFoundObj_lostFoundId").combobox("select", data[0].lostFoundId);
            }
        }
	});
	$("#claim_personName").validatebox({
		required : true, 
		missingMessage : '请输入认领人',
	});

	$("#claim_claimTime").datetimebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	//单击添加按钮
	$("#claimAddButton").click(function () {
		//验证表单 
		if(!$("#claimAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#claimAddForm").form({
			    url:"Claim/add",
			    onSubmit: function(){
					if($("#claimAddForm").form("validate"))  { 
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
                        $("#claimAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#claimAddForm").submit();
		}
	});

	//单击清空按钮
	$("#claimClearButton").click(function () { 
		$("#claimAddForm").form("clear"); 
	});
});
