package com.infopublic.service;

import java.util.List;

import com.infopublic.entity.Page;
import com.infopublic.entity.PoInfo;
import com.infopublic.util.PageData;


public interface PoInfoManager {
	public List<PoInfo> querryAllBytype(String type) throws Exception;//根据type查询
	
	public List<PoInfo> querryAllBytitle(String title) throws Exception;//根据标题模糊查询
	
	public List<PoInfo> querryAllByRemark(String Remark)throws Exception;//根据公告是否有效查询
	
	public PoInfo querryById(String poinid) throws Exception;//根据id查询
	
	
	public List<PoInfo> showallinfo(PageData pd) throws Exception;//分页查询
	
	public int totalallinfo(String type) throws Exception;//分页查询本类别元组数目
	
	public List<PoInfo> showallinfofromsearch(PageData pd) throws Exception;//根据标题模糊查询 分页查询
	public int totalSearchPoInfoforpage(String content) throws Exception;//分页查询本模糊查询的元组数目
	
	
	
	public List<PoInfo> querryAll(Page page)throws Exception;
	
	
	public void deletePoInfoById(String poinid) throws Exception;
	
	public void editPoInfo(PageData pd) throws Exception;//修改公告
	
	public void insertPoInfo(PageData pd) throws Exception;//添加公告
	
}
