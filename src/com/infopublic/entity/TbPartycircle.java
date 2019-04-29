package com.infopublic.entity;

import java.util.List;

public class TbPartycircle {
    private String pcid;

    private Integer uid;

    private String uname;
    
    private String pcontent;
    
    private String headimg;
    
    private String imgurl;

    private String adddate;
    
    private String prtotal;
    
    private List<TbPccomment> TbPccomment;
    
    private Integer pcsennum;   //该暮云圈说说的评论敏感条目数
    
    private List<TbPcpraise> TbPcpraise;
    
    private Short ismycircle=0; //是否是我发的，若是则置为1；根据uid 是否等于用户uid匹配进行判断  以此处理能否删除暮云圈
    
    private Short ispr; //是否已点赞，若是则为1；根据uid 是否等于用户uid匹配进行判断
    
    private Integer prnum=0; //点赞用户的序列号（显示时排在第几位） 初始值为0 ！
    
    private Short iscom; //是否已评论，若是则为1；根据uid 是否等于用户uid匹配进行判断
    
    private Integer comnum; //评论用户的序列号（显示时排在第几位）
    
    private List<String> url; //具体某个暮云圈内容的图片集合
    
    
    

	public Integer getPcsennum() {
		return pcsennum;
	}

	public void setPcsennum(Integer pcsennum) {
		this.pcsennum = pcsennum;
	}

	public Short getIsmycircle() {
		return ismycircle;
	}

	public void setIsmycircle(Short ismycircle) {
		this.ismycircle = ismycircle;
	}

	public List<String> getUrl() {
		return url;
	}

	public void setUrl(List<String> url) {
		this.url = url;
	}

	public Short getIscom() {
		return iscom;
	}

	public void setIscom(Short iscom) {
		this.iscom = iscom;
	}

	public Integer getComnum() {
		return comnum;
	}

	public void setComnum(Integer comnum) {
		this.comnum = comnum;
	}

	public Integer getPrnum() {
		return prnum;
	}

	public void setPrnum(Integer prnum) {
		this.prnum = prnum;
	}

	public Short getIspr() {
		return ispr;
	}

	public void setIspr(Short ispr) {
		this.ispr = ispr;
	}


    public String getPrtotal() {
		return prtotal;
	}

	public void setPrtotal(String prtotal) {
		this.prtotal = prtotal;
	}
    
    public List<TbPccomment> getTbPccomment() {
		return TbPccomment;
	}

	public void setTbPccomment(List<TbPccomment> tbPccomment) {
		TbPccomment = tbPccomment;
	}

	public List<TbPcpraise> getTbPcpraise() {
		return TbPcpraise;
	}

	public void setTbPcpraise(List<TbPcpraise> tbPcpraise) {
		TbPcpraise = tbPcpraise;
	}

	public String getPcontent() {
		return pcontent;
	}

	public void setPcontent(String pcontent) {
		this.pcontent = pcontent;
	}

	public String getHeadimg() {
		return headimg;
	}

	public void setHeadimg(String headimg) {
		this.headimg = headimg;
	}

	public String getImgurl() {
		return imgurl;
	}

	public void setImgurl(String imgurl) {
		this.imgurl = imgurl;
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

    public String getUname() {
        return uname;
    }

    public void setUname(String uname) {
        this.uname = uname == null ? null : uname.trim();
    }

    public String getAdddate() {
        return adddate;
    }

    public void setAdddate(String adddate) {
        this.adddate = adddate == null ? null : adddate.trim();
    }

	@Override
	public String toString() {
		return "TbPartycircle [pcid=" + pcid + ", uid=" + uid + ", uname="
				+ uname + ", TbPccomment=" + TbPccomment.toString() + "]";
	}

}