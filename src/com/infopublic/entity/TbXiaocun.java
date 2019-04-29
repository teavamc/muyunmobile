package com.infopublic.entity;



public class TbXiaocun {
    private Integer jsid;

    private String title;

    private String type;

    private String adddate;

    private String reldate;

    private String content;

    private Integer adduid;

    private String adduname;

    private Integer uid;

    private String uname;

    private Short remark;
    
    private String headimg;


	

	public String getHeadimg() {
		return headimg;
	}

	public void setHeadimg(String headimg) {
		this.headimg = headimg;
	}

	public Integer getJsid() {
        return jsid;
    }

    public void setJsid(Integer jsid) {
        this.jsid = jsid;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title == null ? null : title.trim();
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type == null ? null : type.trim();
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
        this.content = content == null ? null : content.trim();
    }

    public Integer getAdduid() {
        return adduid;
    }

    public void setAdduid(Integer adduid) {
        this.adduid = adduid;
    }

    public String getAdduname() {
        return adduname;
    }

    public void setAdduname(String adduname) {
        this.adduname = adduname == null ? null : adduname.trim();
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
		return "TbXiaocun [jsid=" + jsid + ", title=" + title + ", type="
				+ type + ", adddate=" + adddate + ", reldate=" + reldate
				+ ", content=" + content + ", adduid=" + adduid + ", adduname="
				+ adduname + ", uid=" + uid + ", uname=" + uname + ", remark="
				+ remark + "]";
	}
    
}