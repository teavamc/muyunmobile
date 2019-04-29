package com.infopublic.entity;

import java.util.Date;

public class Users {
    private Integer uid;

    private String uname;

    private String utypes;

    private String loginid;

    private String password;
    
    private String headimg;

    private String regdate;

    private String phone;

    private String address;

    private Boolean isuse;

    private String lastdate;

    private String note;

    private String usex;

    private String uemail;

    private String wcid;

    private String wcname;

    private String idcard;

    private String aid;

    private int isparty;

    private int remark;
    
    private int type;  //管理者为1  否则为0

    
    public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String getHeadimg() {
		return headimg;
	}

	public void setHeadimg(String headimg) {
		this.headimg = headimg;
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

    public String getUtypes() {
        return utypes;
    }

    public void setUtypes(String utypes) {
        this.utypes = utypes == null ? null : utypes.trim();
    }

    public String getLoginid() {
        return loginid;
    }

    public void setLoginid(String loginid) {
        this.loginid = loginid == null ? null : loginid.trim();
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
    }




	public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone == null ? null : phone.trim();
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address == null ? null : address.trim();
    }

    public Boolean getIsuse() {
        return isuse;
    }

    public void setIsuse(Boolean isuse) {
        this.isuse = isuse;
    }



    public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public String getLastdate() {
		return lastdate;
	}

	public void setLastdate(String lastdate) {
		this.lastdate = lastdate;
	}

	public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note == null ? null : note.trim();
    }

    public String getUsex() {
        return usex;
    }

    public void setUsex(String usex) {
        this.usex = usex == null ? null : usex.trim();
    }

    public String getUemail() {
        return uemail;
    }

    public void setUemail(String uemail) {
        this.uemail = uemail == null ? null : uemail.trim();
    }

    public String getWcid() {
        return wcid;
    }

    public void setWcid(String wcid) {
        this.wcid = wcid == null ? null : wcid.trim();
    }

    public String getWcname() {
        return wcname;
    }

    public void setWcname(String wcname) {
        this.wcname = wcname == null ? null : wcname.trim();
    }

    public String getIdcard() {
        return idcard;
    }

    public void setIdcard(String idcard) {
        this.idcard = idcard == null ? null : idcard.trim();
    }

    public String getAid() {
        return aid;
    }

    public void setAid(String aid) {
        this.aid = aid == null ? null : aid.trim();
    }

    public int getIsparty() {
        return isparty;
    }

    public void setIsparty(int isparty) {
        this.isparty = isparty;
    }

    public int getRemark() {
        return remark;
    }

    public void setRemark(int remark) {
        this.remark = remark;
    }
}