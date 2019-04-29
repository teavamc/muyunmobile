package com.infopublic.entity;
/**
 * 角色
 * @ClassName Role
 * @Description TODO
 * @date 2016年11月15日 上午11:30:16
 */
public class Role {
	private String rid;//角色编号
	private String rname;//角色名称
	private String roletype;//角色类型
	private String menurights;//菜单权限
	private String buttonrights;//按鈕权限
	private String note;//备注
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getRname() {
		return rname;
	}
	public void setRname(String rname) {
		this.rname = rname;
	}
	public String getRoletype() {
		return roletype;
	}
	public void setRoletype(String roletype) {
		this.roletype = roletype;
	}
	public String getMenurights() {
		return menurights;
	}
	public void setMenurights(String menurights) {
		this.menurights = menurights;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public String getButtonrights() {
		return buttonrights;
	}
	public void setButtonrights(String buttonrights) {
		this.buttonrights = buttonrights;
	}
	
	
	
}
