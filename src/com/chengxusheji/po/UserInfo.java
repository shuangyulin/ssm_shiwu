package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class UserInfo {
    /*学号*/
    @NotEmpty(message="学号不能为空")
    private String user_name;
    public String getUser_name(){
        return user_name;
    }
    public void setUser_name(String user_name){
        this.user_name = user_name;
    }

    /*登录密码*/
    @NotEmpty(message="登录密码不能为空")
    private String password;
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }

    /*所在学院*/
    private Area areaObj;
    public Area getAreaObj() {
        return areaObj;
    }
    public void setAreaObj(Area areaObj) {
        this.areaObj = areaObj;
    }

    /*姓名*/
    @NotEmpty(message="姓名不能为空")
    private String name;
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    /*性别*/
    @NotEmpty(message="性别不能为空")
    private String sex;
    public String getSex() {
        return sex;
    }
    public void setSex(String sex) {
        this.sex = sex;
    }

    /*学生照片*/
    private String userPhoto;
    public String getUserPhoto() {
        return userPhoto;
    }
    public void setUserPhoto(String userPhoto) {
        this.userPhoto = userPhoto;
    }

    /*出生日期*/
    @NotEmpty(message="出生日期不能为空")
    private String birthday;
    public String getBirthday() {
        return birthday;
    }
    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    /*联系电话*/
    @NotEmpty(message="联系电话不能为空")
    private String telephone;
    public String getTelephone() {
        return telephone;
    }
    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    /*家庭地址*/
    @NotEmpty(message="家庭地址不能为空")
    private String address;
    public String getAddress() {
        return address;
    }
    public void setAddress(String address) {
        this.address = address;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonUserInfo=new JSONObject(); 
		jsonUserInfo.accumulate("user_name", this.getUser_name());
		jsonUserInfo.accumulate("password", this.getPassword());
		jsonUserInfo.accumulate("areaObj", this.getAreaObj().getAreaName());
		jsonUserInfo.accumulate("areaObjPri", this.getAreaObj().getAreaId());
		jsonUserInfo.accumulate("name", this.getName());
		jsonUserInfo.accumulate("sex", this.getSex());
		jsonUserInfo.accumulate("userPhoto", this.getUserPhoto());
		jsonUserInfo.accumulate("birthday", this.getBirthday().length()>19?this.getBirthday().substring(0,19):this.getBirthday());
		jsonUserInfo.accumulate("telephone", this.getTelephone());
		jsonUserInfo.accumulate("address", this.getAddress());
		return jsonUserInfo;
    }}