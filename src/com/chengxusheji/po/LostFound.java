package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class LostFound {
    /*招领id*/
    private Integer lostFoundId;
    public Integer getLostFoundId(){
        return lostFoundId;
    }
    public void setLostFoundId(Integer lostFoundId){
        this.lostFoundId = lostFoundId;
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

    /*物品名称*/
    @NotEmpty(message="物品名称不能为空")
    private String goodsName;
    public String getGoodsName() {
        return goodsName;
    }
    public void setGoodsName(String goodsName) {
        this.goodsName = goodsName;
    }

    /*捡得时间*/
    @NotEmpty(message="捡得时间不能为空")
    private String pickUpTime;
    public String getPickUpTime() {
        return pickUpTime;
    }
    public void setPickUpTime(String pickUpTime) {
        this.pickUpTime = pickUpTime;
    }

    /*拾得地点*/
    @NotEmpty(message="拾得地点不能为空")
    private String pickUpPlace;
    public String getPickUpPlace() {
        return pickUpPlace;
    }
    public void setPickUpPlace(String pickUpPlace) {
        this.pickUpPlace = pickUpPlace;
    }

    /*描述说明*/
    @NotEmpty(message="描述说明不能为空")
    private String contents;
    public String getContents() {
        return contents;
    }
    public void setContents(String contents) {
        this.contents = contents;
    }

    /*联系人*/
    @NotEmpty(message="联系人不能为空")
    private String connectPerson;
    public String getConnectPerson() {
        return connectPerson;
    }
    public void setConnectPerson(String connectPerson) {
        this.connectPerson = connectPerson;
    }

    /*联系电话*/
    @NotEmpty(message="联系电话不能为空")
    private String phone;
    public String getPhone() {
        return phone;
    }
    public void setPhone(String phone) {
        this.phone = phone;
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
    	JSONObject jsonLostFound=new JSONObject(); 
		jsonLostFound.accumulate("lostFoundId", this.getLostFoundId());
		jsonLostFound.accumulate("title", this.getTitle());
		jsonLostFound.accumulate("goodsName", this.getGoodsName());
		jsonLostFound.accumulate("pickUpTime", this.getPickUpTime().length()>19?this.getPickUpTime().substring(0,19):this.getPickUpTime());
		jsonLostFound.accumulate("pickUpPlace", this.getPickUpPlace());
		jsonLostFound.accumulate("contents", this.getContents());
		jsonLostFound.accumulate("connectPerson", this.getConnectPerson());
		jsonLostFound.accumulate("phone", this.getPhone());
		jsonLostFound.accumulate("addTime", this.getAddTime());
		return jsonLostFound;
    }}