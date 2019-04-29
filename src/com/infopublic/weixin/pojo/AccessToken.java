package com.infopublic.weixin.pojo;

/** 
 * 微信通用接口凭证 
 */  

public class AccessToken {
	// 获取到的凭证  
    private String access_token;  
    // 凭证有效时间，单位：秒  
    private int expires_in;  
  
    private String user_ticket; 
	private String refresh_token;
	private String openid;
	private String scope;
	private String unionid;
	
	public String getUser_ticket() {
		return user_ticket;
	}
	public void setUser_ticket(String user_ticket) {
		this.user_ticket = user_ticket;
	}
	public String getAccess_token() {
		return access_token;
	}
	public void setAccess_token(String access_token) {
		this.access_token = access_token;
	}
	public int getExpires_in() {
		return expires_in;
	}
	public void setExpires_in(int expires_in) {
		this.expires_in = expires_in;
	}
	public String getRefresh_token() {
		return refresh_token;
	}
	public void setRefresh_token(String refresh_token) {
		this.refresh_token = refresh_token;
	}
	public String getOpenid() {
		return openid;
	}
	public void setOpenid(String openid) {
		this.openid = openid;
	}
	public String getScope() {
		return scope;
	}
	public void setScope(String scope) {
		this.scope = scope;
	}
	public String getUnionid() {
		return unionid;
	}
	public void setUnionid(String unionid) {
		this.unionid = unionid;
	} 
	
	
}
