package com.infopublic.entity;

import java.util.Date;

public class TbGuide {
    private Integer guid;

    private String guname;

    private String gupic;

    private String gutype;

    private String content;

    private String address;

    private String fname;

    private String fphone;

    private Integer greadtotal;

    private String pushdate;

    private Integer uid;

    private String uname;

    private Short remark;

    public Integer getGuid() {
        return guid;
    }

    public void setGuid(Integer guid) {
        this.guid = guid;
    }

    public String getGuname() {
        return guname;
    }

    public void setGuname(String guname) {
        this.guname = guname == null ? null : guname.trim();
    }

    public String getGupic() {
        return gupic;
    }

    public void setGupic(String gupic) {
        this.gupic = gupic == null ? null : gupic.trim();
    }

    public String getGutype() {
        return gutype;
    }

    public void setGutype(String gutype) {
        this.gutype = gutype == null ? null : gutype.trim();
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address == null ? null : address.trim();
    }

    public String getFname() {
        return fname;
    }

    public void setFname(String fname) {
        this.fname = fname == null ? null : fname.trim();
    }

    public String getFphone() {
        return fphone;
    }

    public void setFphone(String fphone) {
        this.fphone = fphone == null ? null : fphone.trim();
    }

    public Integer getGreadtotal() {
        return greadtotal;
    }

    public void setGreadtotal(Integer greadtotal) {
        this.greadtotal = greadtotal;
    }

 

    public String getPushdate() {
		return pushdate;
	}

	public void setPushdate(String pushdate) {
		this.pushdate = pushdate;
	}

	public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public String getUname() {
        return uname;
    }

    public void setUname(String uname) {
        this.uname = uname == null ? null : uname.trim();
    }

    public Short getRemark() {
        return remark;
    }

    public void setRemark(Short remark) {
        this.remark = remark;
    }

	@Override
	public String toString() {
		return "TbGuide [guid=" + guid + ", guname=" + guname + ", gupic="
				+ gupic + ", gutype=" + gutype + ", content=" + content
				+ ", address=" + address + ", fname=" + fname + ", fphone="
				+ fphone + ", greadtotal=" + greadtotal + ", pushdate="
				+ pushdate + ", uid=" + uid + ", uname=" + uname + ", remark="
				+ remark + "]";
	}
    
    
}