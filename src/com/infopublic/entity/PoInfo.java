package com.infopublic.entity;

public class PoInfo {
	private String poinid;//公告编号
	private String title;//标题
	private String type;//公告类型
	private String adddate;//添加日期	
	private String reldate;//发布日期
	private String content;//公告内容
	private String uid;//添加人用户编号
	private String uname;//添加人用户姓名
	private String remark;//是否有效
	
	
	public PoInfo() {
		super();
		// TODO Auto-generated constructor stub
	}
	@Override
	public String toString() {
		return "PolicyInfo [poinid=" + poinid + ", title=" + title + ", type="
				+ type + ", adddate=" + adddate + ", reldate=" + reldate
				+ ", content=" + content + ", uid=" + uid + ", uname="
				+ uname + ", remark=" + remark + "]";
	}
	public PoInfo(String poinid, String title, String type, String adddate,
			String reldate, String content, String uid, String uname,
			String remark) {
		super();
		this.poinid = poinid;
		this.title = title;
		this.type = type;
		this.adddate = adddate;
		this.reldate = reldate;
		this.content = content;
		this.uid = uid;
		this.uname = uname;
		this.remark = remark;
	}
	public String getPoinid() {
		return poinid;
	}
	public void setPoinid(String poinid) {
		this.poinid = poinid;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getAdddate() {
		return adddate;
	}
	public void setAdddate(String adddate) {
		this.adddate = adddate;
	}
	public String getReldate() {
		return reldate;
	}
	public void setReldate(String reldate) {
		this.reldate = reldate;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getUname() {
		return uname;
	}
	public void setUname(String uname) {
		this.uname = uname;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	
}
