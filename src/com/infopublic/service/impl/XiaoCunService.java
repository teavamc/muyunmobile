package com.infopublic.service.impl;


import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.infopublic.dao.DaoSupport;
import com.infopublic.entity.TbFeedback;
import com.infopublic.entity.TbJob;
import com.infopublic.entity.TbXiaocun;
import com.infopublic.entity.TbYuqing;
import com.infopublic.service.FeedBackManager;
import com.infopublic.service.JobManager;
import com.infopublic.service.XiaoCunManager;
import com.infopublic.service.YuQingManager;
import com.infopublic.util.PageData;

@Service("XiaoCunService")
public class XiaoCunService implements XiaoCunManager{
	@Resource(name = "daoSupport")
	private DaoSupport dao;

	@SuppressWarnings("unchecked")
	@Override
	public List<TbXiaocun> getXiaocun(PageData pd) throws Exception {
		return (List<TbXiaocun>)dao.findForList("XiaoCunMapping.getXiaocun", pd);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<TbXiaocun> getMyXiaocun(PageData pd) throws Exception {
		return (List<TbXiaocun>)dao.findForList("XiaoCunMapping.getMyXiaocun", pd);
	}
	

	@Override
	public TbXiaocun getXiaocunFromjsid(PageData pd) throws Exception {
		return (TbXiaocun)dao.findForObject("XiaoCunMapping.getXiaocunFromjsid", pd);
	}

	@Override
	public TbXiaocun getXiaocunDateFromjsid(PageData pd) throws Exception {
		return (TbXiaocun)dao.findForObject("XiaoCunMapping.getXiaocunDateFromjsid", pd);
	}

	@Override
	public void insertXiaocun(PageData pd) throws Exception {
		dao.save("XiaoCunMapping.insertXiaocun", pd);
		
	}

	@Override
	public void deletexiaocun(PageData pd) throws Exception {
		dao.delete("XiaoCunMapping.deletexiaocun", pd);
		
	}

	


}
