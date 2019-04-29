package com.infopublic.entity;

import java.util.Date;
import java.util.List;

public class TbEducation {
    private Integer eid;

    private String courtit;

    private String coursum;

    private String courass;

    private String adddate;

    private String uid;

    private String uname;

    private String courread;

    private String courpic;

    private Short remark;
    
    private List<TbEducomment> educomment;  //评论集合

    

	public List<TbEducomment> getEducomment() {
		return educomment;
	}

	public void setEducomment(List<TbEducomment> educomment) {
		this.educomment = educomment;
	}

    public Integer getEid() {
        return eid;
    }

    public void setEid(Integer eid) {
        this.eid = eid;
    }

    public String getCourtit() {
        return courtit;
    }

    public void setCourtit(String courtit) {
        this.courtit = courtit == null ? null : courtit.trim();
    }

    public String getCoursum() {
        return coursum;
    }

    public void setCoursum(String coursum) {
        this.coursum = coursum == null ? null : coursum.trim();
    }

    public String getCourass() {
        return courass;
    }

    public void setCourass(String courass) {
        this.courass = courass == null ? null : courass.trim();
    }

    public String getAdddate() {
        return adddate;
    }

    public void setAdddate(String adddate) {
        this.adddate = adddate;
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid == null ? null : uid.trim();
    }

    public String getUname() {
        return uname;
    }

    public void setUname(String uname) {
        this.uname = uname == null ? null : uname.trim();
    }

    public String getCourread() {
        return courread;
    }

    public void setCourread(String courread) {
        this.courread = courread;
    }

    public String getCourpic() {
        return courpic;
    }

    public void setCourpic(String courpic) {
        this.courpic = courpic == null ? null : courpic.trim();
    }

    public Short getRemark() {
        return remark;
    }

    public void setRemark(Short remark) {
        this.remark = remark;
    }


}