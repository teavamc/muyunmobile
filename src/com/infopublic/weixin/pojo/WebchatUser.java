package com.infopublic.weixin.pojo;

public class WebchatUser {
	 private String  userid;  //企业成员的唯一标识 
	 private String  name;  //企业成员的姓名 
	 private String  gender;//性别。0表示未定义，1表示男性，2表示女性
	 private String  avatar;//头像url。注：如果要获取小图将url最后的”/0”改成”/100”即可
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getAvatar() {
		return avatar;
	}
	@Override
	public String toString() {
		return "WebchatUser [userid=" + userid + ", name=" + name + ", gender="
				+ gender + ", avatar=" + avatar + "]";
	}
	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}
	 
	
	  
	  
}
