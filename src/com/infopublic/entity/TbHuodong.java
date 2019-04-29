package com.infopublic.entity;

public class TbHuodong {
    private String hdid;

    private String hdtitle;

    private String hdtype;

    private String hdloc;

    private String hdnum;

    private String hdbtime;

    private String hdetime;

    private String hdpic;

    private String hdsum;

    private String hdadddate;

    private String uid;

    private Short remark;

    public String getHdid() {
        return hdid;
    }

    public void setHdid(String hdid) {
        this.hdid = hdid == null ? null : hdid.trim();
    }

    public String getHdtitle() {
        return hdtitle;
    }

    public void setHdtitle(String hdtitle) {
        this.hdtitle = hdtitle == null ? null : hdtitle.trim();
    }

    public String getHdtype() {
        return hdtype;
    }

    public void setHdtype(String hdtype) {
        this.hdtype = hdtype == null ? null : hdtype.trim();
    }

    public String getHdloc() {
        return hdloc;
    }

    public void setHdloc(String hdloc) {
        this.hdloc = hdloc == null ? null : hdloc.trim();
    }

    public String getHdnum() {
        return hdnum;
    }

    public void setHdnum(String hdnum) {
        this.hdnum = hdnum == null ? null : hdnum.trim();
    }

    public String getHdbtime() {
        return hdbtime;
    }

    public void setHdbtime(String hdbtime) {
        this.hdbtime = hdbtime == null ? null : hdbtime.trim();
    }

    public String getHdetime() {
        return hdetime;
    }

    public void setHdetime(String hdetime) {
        this.hdetime = hdetime == null ? null : hdetime.trim();
    }

    public String getHdpic() {
        return hdpic;
    }

    public void setHdpic(String hdpic) {
        this.hdpic = hdpic == null ? null : hdpic.trim();
    }

    public String getHdsum() {
        return hdsum;
    }

    public void setHdsum(String hdsum) {
        this.hdsum = hdsum == null ? null : hdsum.trim();
    }

    public String getHdadddate() {
        return hdadddate;
    }

    public void setHdadddate(String hdadddate) {
        this.hdadddate = hdadddate == null ? null : hdadddate.trim();
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid == null ? null : uid.trim();
    }

    public Short getRemark() {
        return remark;
    }

    public void setRemark(Short remark) {
        this.remark = remark;
    }
}