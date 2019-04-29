package com.infopublic.entity;

import java.util.Date;
import java.util.List;

public class Api360News {
	
    private String posterId; //posterId
    private String content;  //新闻内容
    private String posterScreenName;  //发布者名称
    private String tags;  //tags
    private String url;  //新闻链接
    private String publishDateStr; // 发布时间（UTC时间
    private String title;  // 标题
    private Integer publishDate;  //发布日期时间戳
    private String commentCount;  //评论数
    private String imageUrls;  // 图片
    private String id;  //新闻id
    
    
	public String getPosterId() {
		return posterId;
	}
	public void setPosterId(String posterId) {
		this.posterId = posterId;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getPosterScreenName() {
		return posterScreenName;
	}
	public void setPosterScreenName(String posterScreenName) {
		this.posterScreenName = posterScreenName;
	}
	public String getTags() {
		return tags;
	}
	public void setTags(String tags) {
		this.tags = tags;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getPublishDateStr() {
		return publishDateStr;
	}
	public void setPublishDateStr(String publishDateStr) {
		this.publishDateStr = publishDateStr;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Integer getPublishDate() {
		return publishDate;
	}
	public void setPublishDate(Integer publishDate) {
		this.publishDate = publishDate;
	}
	public String getCommentCount() {
		return commentCount;
	}
	public void setCommentCount(String commentCount) {
		this.commentCount = commentCount;
	}
	public String getImageUrls() {
		return imageUrls;
	}
	public void setImageUrls(String imageUrls) {
		this.imageUrls = imageUrls;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
    
}