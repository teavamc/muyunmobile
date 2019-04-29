package com.infopublic.entity;

public class TbYqcomment {
    private String yqcid;

    private String yqid;

    private Integer uid;
    
    private String headimg;
    
    private String uname;

    private String yqccontent;

    private String datetime;
    
    private short isusercom=0;

    
    public short getIsusercom() {
		return isusercom;
	}

	public void setIsusercom(short isusercom) {
		this.isusercom = isusercom;
	}

	public String getHeadimg() {
		return headimg;
	}

	public void setHeadimg(String headimg) {
		this.headimg = headimg;
	}

	public String getUname() {
		return uname;
	}

	public void setUname(String uname) {
		this.uname = uname;
	}

	public String getYqcid() {
        return yqcid;
    }

    public void setYqcid(String yqcid) {
        this.yqcid = yqcid == null ? null : yqcid.trim();
    }

    public String getYqid() {
        return yqid;
    }

    public void setYqid(String yqid) {
        this.yqid = yqid == null ? null : yqid.trim();
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public String getYqccontent() {
        return yqccontent;
    }

    public void setYqccontent(String yqccontent) {
        this.yqccontent = yqccontent == null ? null : yqccontent.trim();
    }

    public String getDatetime() {
        return datetime;
    }

    public void setDatetime(String datetime) {
        this.datetime = datetime == null ? null : datetime.trim();
    }
}