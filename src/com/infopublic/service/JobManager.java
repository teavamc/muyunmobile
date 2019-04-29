package com.infopublic.service;

import java.util.List;

import com.infopublic.entity.TbJob;
import com.infopublic.util.PageData;


public interface JobManager {
	
	
	public List<TbJob> getjobbydate(PageData pd)throws Exception; //下拉分页职业信息

	public TbJob getcontentfromjid(String jid) throws Exception; //根据职业编号查询招聘信息
	
	public List<TbJob> getjobbyremark(int Remark)throws Exception;//根据公告是否有效查询
	
	public List<TbJob> getJobByPoOrTit(PageData pd)throws Exception; //根据类型 或职位 模糊查询
	
	public int totalalljob(String position) throws Exception;//查询所有职位数量
	
	public int totalalljobbyremark(int remark) throws Exception; //根据是否有效查询职位数量
	
}
