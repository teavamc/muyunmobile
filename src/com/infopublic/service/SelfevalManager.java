package com.infopublic.service;

import java.util.List;

import com.infopublic.entity.Page;
import com.infopublic.entity.TbSelfeval;
import com.infopublic.util.PageData;


public interface SelfevalManager {
	public TbSelfeval getassfromsfid(String sfid) throws Exception;  //根据sfid查找评价信息
	
	public List<TbSelfeval> getassessfromuid(PageData pd) throws Exception;// 根据测评人员编号uid查找自评信息
	
	public List<TbSelfeval> getassessfromuidtohim(PageData pd) throws Exception;// 根据测评人员编号uid查找我评信息
	
	public List<TbSelfeval> getassessfromuidtome(PageData pd) throws Exception;// 根据pid查找他评信息
	
	public int totalall1(PageData pd) throws Exception;//分页查自评元组数目
	public int totalall2(PageData pd) throws Exception;//分页查我评元组数目
	public int totalall3(PageData pd) throws Exception;//分页查他评元组数目
	
	public void insertsel(PageData pd)throws Exception; //新增自评互评信息
	
	public void updateselfromselfid(PageData pd)throws Exception; //更改自评互评信息
	
	public void deleteselfromselfid (String sfid)throws Exception;//根据自评互评编号selfid删除自评互评信息
	
}
