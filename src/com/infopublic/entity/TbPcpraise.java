package com.infopublic.entity;

public class TbPcpraise {
    private String prid;

    private String pcid;
    
    private String uname;

    private Integer uid;
    

	public String getUname() {
		return uname;
	}

	public void setUname(String uname) {
		this.uname = uname;
	}

	public String getPrid() {
        return prid;
    }

    public void setPrid(String prid) {
        this.prid = prid == null ? null : prid.trim();
    }

    public String getPcid() {
        return pcid;
    }

    public void setPcid(String pcid) {
        this.pcid = pcid == null ? null : pcid.trim();
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }
    
}