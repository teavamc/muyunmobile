package com.infopublic.entity;

public class TbZhiban {
    private String zbid;

    private String pid;

    private String pname;

    private String position;

    private String zbpic;

    private String zbsum;

    private String zbwords;

    private String zbdate;

    private String adddate;

    private Short remark;

    public String getZbid() {
        return zbid;
    }

    public void setZbid(String zbid) {
        this.zbid = zbid == null ? null : zbid.trim();
    }

    public String getPid() {
        return pid;
    }

    public void setPid(String pid) {
        this.pid = pid == null ? null : pid.trim();
    }

    public String getPname() {
        return pname;
    }

    public void setPname(String pname) {
        this.pname = pname == null ? null : pname.trim();
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position == null ? null : position.trim();
    }

    public String getZbpic() {
        return zbpic;
    }

    public void setZbpic(String zbpic) {
        this.zbpic = zbpic == null ? null : zbpic.trim();
    }

    public String getZbsum() {
        return zbsum;
    }

    public void setZbsum(String zbsum) {
        this.zbsum = zbsum == null ? null : zbsum.trim();
    }

    public String getZbwords() {
        return zbwords;
    }

    public void setZbwords(String zbwords) {
        this.zbwords = zbwords == null ? null : zbwords.trim();
    }

    public String getZbdate() {
        return zbdate;
    }

    public void setZbdate(String zbdate) {
        this.zbdate = zbdate == null ? null : zbdate.trim();
    }

    public String getAdddate() {
        return adddate;
    }

    public void setAdddate(String adddate) {
        this.adddate = adddate == null ? null : adddate.trim();
    }

    public Short getRemark() {
        return remark;
    }

    public void setRemark(Short remark) {
        this.remark = remark;
    }
}