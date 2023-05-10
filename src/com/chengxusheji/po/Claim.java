package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Claim {
    /*认领id*/
    private Integer claimId;
    public Integer getClaimId(){
        return claimId;
    }
    public void setClaimId(Integer claimId){
        this.claimId = claimId;
    }

    /*招领信息*/
    private LostFound lostFoundObj;
    public LostFound getLostFoundObj() {
        return lostFoundObj;
    }
    public void setLostFoundObj(LostFound lostFoundObj) {
        this.lostFoundObj = lostFoundObj;
    }

    /*认领人*/
    @NotEmpty(message="认领人不能为空")
    private String personName;
    public String getPersonName() {
        return personName;
    }
    public void setPersonName(String personName) {
        this.personName = personName;
    }

    /*认领时间*/
    @NotEmpty(message="认领时间不能为空")
    private String claimTime;
    public String getClaimTime() {
        return claimTime;
    }
    public void setClaimTime(String claimTime) {
        this.claimTime = claimTime;
    }

    /*描述说明*/
    private String contents;
    public String getContents() {
        return contents;
    }
    public void setContents(String contents) {
        this.contents = contents;
    }

    /*发布时间*/
    private String addTime;
    public String getAddTime() {
        return addTime;
    }
    public void setAddTime(String addTime) {
        this.addTime = addTime;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonClaim=new JSONObject(); 
		jsonClaim.accumulate("claimId", this.getClaimId());
		jsonClaim.accumulate("lostFoundObj", this.getLostFoundObj().getTitle());
		jsonClaim.accumulate("lostFoundObjPri", this.getLostFoundObj().getLostFoundId());
		jsonClaim.accumulate("personName", this.getPersonName());
		jsonClaim.accumulate("claimTime", this.getClaimTime().length()>19?this.getClaimTime().substring(0,19):this.getClaimTime());
		jsonClaim.accumulate("contents", this.getContents());
		jsonClaim.accumulate("addTime", this.getAddTime());
		return jsonClaim;
    }}