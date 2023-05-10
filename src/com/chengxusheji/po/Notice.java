package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Notice {
    /*通知id*/
    private Integer noticeId;
    public Integer getNoticeId(){
        return noticeId;
    }
    public void setNoticeId(Integer noticeId){
        this.noticeId = noticeId;
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

    /*内容*/
    @NotEmpty(message="内容不能为空")
    private String content;
    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }

    /*发布时间*/
    @NotEmpty(message="发布时间不能为空")
    private String addTime;
    public String getAddTime() {
        return addTime;
    }
    public void setAddTime(String addTime) {
        this.addTime = addTime;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonNotice=new JSONObject(); 
		jsonNotice.accumulate("noticeId", this.getNoticeId());
		jsonNotice.accumulate("title", this.getTitle());
		jsonNotice.accumulate("content", this.getContent());
		jsonNotice.accumulate("addTime", this.getAddTime().length()>19?this.getAddTime().substring(0,19):this.getAddTime());
		return jsonNotice;
    }}