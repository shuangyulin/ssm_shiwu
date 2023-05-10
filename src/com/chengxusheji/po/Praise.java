package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Praise {
    /*表扬id*/
    private Integer praiseId;
    public Integer getPraiseId(){
        return praiseId;
    }
    public void setPraiseId(Integer praiseId){
        this.praiseId = praiseId;
    }

    /*招领信息*/
    private LostFound lostFoundObj;
    public LostFound getLostFoundObj() {
        return lostFoundObj;
    }
    public void setLostFoundObj(LostFound lostFoundObj) {
        this.lostFoundObj = lostFoundObj;
    }

    /*标题*/
    @NotEmpty(message="标题不能为空")
    private String title;
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }

    /*表扬内容*/
    @NotEmpty(message="表扬内容不能为空")
    private String contents;
    public String getContents() {
        return contents;
    }
    public void setContents(String contents) {
        this.contents = contents;
    }

    /*表扬时间*/
    @NotEmpty(message="表扬时间不能为空")
    private String addTime;
    public String getAddTime() {
        return addTime;
    }
    public void setAddTime(String addTime) {
        this.addTime = addTime;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonPraise=new JSONObject(); 
		jsonPraise.accumulate("praiseId", this.getPraiseId());
		jsonPraise.accumulate("lostFoundObj", this.getLostFoundObj().getTitle());
		jsonPraise.accumulate("lostFoundObjPri", this.getLostFoundObj().getLostFoundId());
		jsonPraise.accumulate("title", this.getTitle());
		jsonPraise.accumulate("contents", this.getContents());
		jsonPraise.accumulate("addTime", this.getAddTime().length()>19?this.getAddTime().substring(0,19):this.getAddTime());
		return jsonPraise;
    }}