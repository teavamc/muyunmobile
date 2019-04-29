package com.infopublic.entity;

public class TbGroup {
    private Integer gid;

    private String name;

    private Short number;

    private String people;

    private Integer uid;

    private String uname;

    private String datetime;

    private String introduction;

    private Short remark;

    public Integer getGid() {
        return gid;
    }

    public void setGid(Integer gid) {
        this.gid = gid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public Short getNumber() {
        return number;
    }

    public void setNumber(Short number) {
        this.number = number;
    }

    public String getPeople() {
        return people;
    }

    public void setPeople(String people) {
        this.people = people == null ? null : people.trim();
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

    public String getDatetime() {
        return datetime;
    }

    public void setDatetime(String datetime) {
        this.datetime = datetime == null ? null : datetime.trim();
    }

 

    public String getIntroduction() {
		return introduction;
	}

	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}

	public Short getRemark() {
        return remark;
    }

    public void setRemark(Short remark) {
        this.remark = remark;
    }

	@Override
	public String toString() {
		return "TbGroup [gid=" + gid + ", name=" + name + ", number=" + number
				+ ", people=" + people + ", uid=" + uid + ", uname=" + uname
				+ ", datetime=" + datetime + ", introduction=" + introduction
				+ ", remark=" + remark + "]";
	}

	
    
}