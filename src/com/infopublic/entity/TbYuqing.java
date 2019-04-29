package com.infopublic.entity;

import java.util.Date;
import java.util.List;

public class TbYuqing {
    private Integer yqid;

    private String yqtype;

    private String content;

    private String uploadimage;

    private String adddate;

    private Integer adduid;

    private String adduname;

    private Short remark;
    
    private List<TbYqcomment> yqcomment;  //评论集合

   

	public List<TbYqcomment> getYqcomment() {
		return yqcomment;
	}

	public void setYqcomment(List<TbYqcomment> yqcomment) {
		this.yqcomment = yqcomment;
	}

	public Integer getYqid() {
        return yqid;
    }

    public void setYqid(Integer yqid) {
        this.yqid = yqid;
    }

    public String getYqtype() {
        return yqtype;
    }

    public void setYqtype(String yqtype) {
        this.yqtype = yqtype == null ? null : yqtype.trim();
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

    public String getUploadimage() {
        return uploadimage;
    }

    public void setUploadimage(String uploadimage) {
        this.uploadimage = uploadimage == null ? null : uploadimage.trim();
    }



    public String getAdddate() {
		return adddate;
	}

	public void setAdddate(String adddate) {
		this.adddate = adddate;
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

    public Short getRemark() {
        return remark;
    }

    public void setRemark(Short remark) {
        this.remark = remark;
    }
}