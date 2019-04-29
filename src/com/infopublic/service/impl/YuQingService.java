package com.infopublic.service.impl;


import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.infopublic.dao.DaoSupport;
import com.infopublic.entity.TbFeedback;
import com.infopublic.entity.TbJob;
import com.infopublic.entity.TbYuqing;
import com.infopublic.service.FeedBackManager;
import com.infopublic.service.JobManager;
import com.infopublic.service.YuQingManager;
import com.infopublic.util.PageData;

@Service("YuQingService")
public class YuQingService implements YuQingManager{
	@Resource(name = "daoSupport")
	private DaoSupport dao;

	@SuppressWarnings("unchecked")
	@Override
	public List<TbYuqing> getYuqing(PageData pd) throws Exception {
		return (List<TbYuqing>)dao.findForList("YuQingMapping.getYuqing", pd);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<TbYuqing> getYuqingFromInfo(PageData pd) throws Exception {
		return (List<TbYuqing>)dao.findForList("YuQingMapping.getYuqingFromInfo", pd);
	}

	@Override
	public TbYuqing getYuqingFromyqid(PageData pd) throws Exception {
		return (TbYuqing)dao.findForObject("YuQingMapping.getYuqingFromyqid", pd);
	}

	@Override
	public void updateYuqing(PageData pd) throws Exception {
		dao.update("YuQingMapping.updateYuqing", pd);
		
	}

	@Override
	public void insertYuqing(PageData pd) throws Exception {
		dao.save("YuQingMapping.insertYuqing", pd);
		
	}

	@Override
	public void deleteYuqing(PageData pd) throws Exception {
		dao.delete("YuQingMapping.deleteYuqing", pd);
		
	}

	@Override
	public TbYuqing getYuqingDateFromyqid(PageData pd) throws Exception {
		return (TbYuqing)dao.findForObject("YuQingMapping.getYuqingDateFromyqid", pd);
	}




}
