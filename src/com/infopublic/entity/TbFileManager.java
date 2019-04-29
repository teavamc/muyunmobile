package com.infopublic.entity;

import java.util.Date;
import java.util.List;

public class TbFileManager {
    private Integer fileid;

    private String filename;

    private String uploaddate;

    private String uid;

    private String uname;
    
    private String url;
    
    private String filesize;

    private String downloadnum;

    private String zan;

    private Short remark;

	public Integer getFileid() {
		return fileid;
	}

	public void setFileid(Integer fileid) {
		this.fileid = fileid;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public String getUploaddate() {
		return uploaddate;
	}

	public void setUploaddate(String uploaddate) {
		this.uploaddate = uploaddate;
	}

	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	public String getUname() {
		return uname;
	}

	public void setUname(String uname) {
		this.uname = uname;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getFilesize() {
		return filesize;
	}

	public void setFilesize(String filesize) {
		this.filesize = filesize;
	}

	public String getDownloadnum() {
		return downloadnum;
	}

	public void setDownloadnum(String downloadnum) {
		this.downloadnum = downloadnum;
	}

	public String getZan() {
		return zan;
	}

	public void setZan(String zan) {
		this.zan = zan;
	}

	public Short getRemark() {
		return remark;
	}

	public void setRemark(Short remark) {
		this.remark = remark;
	}

}