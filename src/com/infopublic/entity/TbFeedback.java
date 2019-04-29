package com.infopublic.entity;


public class TbFeedback {
    private Integer fbid;

    private Integer fbuid;

    private String title;

    private String ftype;

    private String fbdatetime;

    private Short isread;

    private Integer uid;

    private String uname;

    private String datetime;
    
    private String content;
    
    private String opinion;

    private Short remark;

    public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getOpinion() {
		return opinion;
	}

	public void setOpinion(String opinion) {
		this.opinion = opinion;
	}

	public String getFbdatetime() {
		return fbdatetime;
	}

	public void setFbdatetime(String fbdatetime) {
		this.fbdatetime = fbdatetime;
	}

	public String getDatetime() {
		return datetime;
	}

	public void setDatetime(String datetime) {
		this.datetime = datetime;
	}

	public Integer getFbid() {
        return fbid;
    }

    public void setFbid(Integer fbid) {
        this.fbid = fbid;
    }

    public Integer getFbuid() {
        return fbuid;
    }

    public void setFbuid(Integer fbuid) {
        this.fbuid = fbuid;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title == null ? null : title.trim();
    }

    public String getFtype() {
        return ftype;
    }

    public void setFtype(String ftype) {
        this.ftype = ftype == null ? null : ftype.trim();
    }





    public Short getIsread() {
		return isread;
	}

	public void setIsread(Short isread) {
		this.isread = isread;
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
}