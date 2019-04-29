package com.infopublic.service.impl;


import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.infopublic.dao.DaoSupport;
import com.infopublic.entity.PoInfo;
import com.infopublic.entity.TbJob;
import com.infopublic.service.JobManager;
import com.infopublic.util.PageData;

@Service("JobService")
public  class JobService implements JobManager{
	@Resource(name = "daoSupport")
	private DaoSupport dao;

	@SuppressWarnings("unchecked")
	@Override
	public List<TbJob> getjobbydate(PageData pd) throws Exception {
		return (List<TbJob>)dao.findForList("TbjobMapping.getjobbydate", pd);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<TbJob> getjobbyremark(int remark) throws Exception{
		return (List<TbJob>)dao.findForList("TbjobMapping.getjobbyremark", remark);
	}
	
	@Override //根据类别查询所有通知的个数
	public int totalalljobbyremark(int remark) throws Exception {
		return (int) dao.findForObject("TbjobMapping.totalalljobbyremark", remark);
	}
	
	@Override
	public TbJob getcontentfromjid(String jid) throws Exception {
		return (TbJob) dao.findForObject("TbjobMapping.getcontentfromjid", jid);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<TbJob> getJobByPoOrTit(PageData pd) throws Exception {
		return (List<TbJob>)dao.findForList("TbjobMapping.getJobByPoOrTit", pd);
	}
	
	@Override //根据类别查询所有通知的个数
	public int totalalljob(String position) throws Exception {
		return (int) dao.findForObject("TbjobMapping.totalalljob", position);
	}

/*	@SuppressWarnings("unchecked")
	@Override
	public List<TbJob> getjobbyremark(String remark) throws Exception {
		return (List<TbJob>)dao.findForList("TbjobMapping.getjobbyremark", remark);
	}*/
	
	


}
