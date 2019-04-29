package com.infopublic.entity;

public class TbEducomment {
    private String educid;

    private String eid;

    private  Integer uid;
    
    private String headimg;
    
    private String uname;

    private String comment;

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

	public String getEducid() {
        return educid;
    }

    public void setEducid(String yqcid) {
        this.educid = educid == null ? null : educid.trim();
    }

    public String getEid() {
        return eid;
    }

    public void setEid(String yqid) {
        this.eid = eid == null ? null : eid.trim();
    }

    public  Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment == null ? null : comment.trim();
    }

    public String getDatetime() {
        return datetime;
    }

    public void setDatetime(String datetime) {
        this.datetime = datetime == null ? null : datetime.trim();
    }
}