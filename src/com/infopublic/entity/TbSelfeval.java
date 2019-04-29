package com.infopublic.entity;


public class TbSelfeval {
    private Integer sfid;

    private String pid;
    private String pname;

    private String title;

    private String state;

    private Integer score;

    private String sdate;

    private Integer uid;
    private String uname;

    private Boolean remark;

 



	public String getPid() {
        return pid;
    }

    public void setPid(String pid) {
        this.pid = pid == null ? null : pid.trim();
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title == null ? null : title.trim();
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state == null ? null : state.trim();
    }

    public Integer getScore() {
        return score;
    }

    public void setScore(Integer score) {
        this.score = score;
    }

    public String getSdate() {
        return sdate;
    }

    public void setSdate(String sdate) {
        this.sdate = sdate;
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public Boolean getRemark() {
        return remark;
    }

    public void setRemark(Boolean remark) {
        this.remark = remark;
    }

	public Integer getSfid() {
		return sfid;
	}

	public void setSfid(Integer sfid) {
		this.sfid = sfid;
	}

	public String getPname() {
		return pname;
	}

	public void setPname(String pname) {
		this.pname = pname;
	}

	public String getUname() {
		return uname;
	}

	public void setUname(String uname) {
		this.uname = uname;
	}

	@Override
	public String toString() {
		return "TbSelfeval [sfid=" + sfid + ", pid=" + pid + ", pname=" + pname
				+ ", title=" + title + ", state=" + state + ", score=" + score
				+ ", sdate=" + sdate + ", uid=" + uid + ", uname=" + uname
				+ ", remark=" + remark + "]";
	}

	
    
}