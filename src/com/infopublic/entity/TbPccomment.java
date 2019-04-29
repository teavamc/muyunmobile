package com.infopublic.entity;

public class TbPccomment {
    private String coid;

    private String pcid;
    
    private Integer uid;
    
    private String uname;

    private String ccontent;
    
    private String issensitive;   //是否为敏感评论 是为1  否为0

    private String cdate;
    
    private Short isusercom;  //用户是否使这条评论的主人  是则为1

   

	

	public String getIssensitive() {
		return issensitive;
	}

	public void setIssensitive(String issensitive) {
		this.issensitive = issensitive;
	}

	public Short getIsusercom() {
		return isusercom;
	}

	public void setIsusercom(Short isusercom) {
		this.isusercom = isusercom;
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
		this.uname = uname;
	}

	public String getCoid() {
        return coid;
    }

    public void setCoid(String coid) {
        this.coid = coid == null ? null : coid.trim();
    }

    public String getPcid() {
        return pcid;
    }

    public void setPcid(String pcid) {
        this.pcid = pcid == null ? null : pcid.trim();
    }

    public String getCcontent() {
        return ccontent;
    }

    public void setCcontent(String ccontent) {
        this.ccontent = ccontent == null ? null : ccontent.trim();
    }

    public String getCdate() {
        return cdate;
    }

    public void setCdate(String cdate) {
        this.cdate = cdate == null ? null : cdate.trim();
    }

	
    
}