package com.infopublic.service.impl;


import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.infopublic.dao.DaoSupport;
import com.infopublic.entity.TbFeedback;
import com.infopublic.entity.TbJob;
import com.infopublic.service.FeedBackManager;
import com.infopublic.service.JobManager;
import com.infopublic.util.PageData;

@Service("FeedService")
public class FeedBackService implements FeedBackManager{
	@Resource(name = "daoSupport")
	private DaoSupport dao;

	@SuppressWarnings("unchecked")
	public List<TbFeedback> getFeebBackFromFtype(PageData pd) throws Exception {
		return (List<TbFeedback>)dao.findForList("TbfeedbackMapping.getFeebBackFromFtype", pd);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<TbFeedback> getFeebBackEdit(PageData pd) throws Exception {
		return (List<TbFeedback>)dao.findForList("TbfeedbackMapping.getFeebBackEdit", pd);
	}

	public TbFeedback getFeedBackByFbid(PageData pd) throws Exception {
		return (TbFeedback) dao.findForObject("TbfeedbackMapping.getFeedBackByFbid", pd);
	}

	@Override
	public void updateFeed(PageData pd) throws Exception {
		dao.update("TbfeedbackMapping.updateFeed", pd);
	}

	@Override
	public void insertFeed(PageData pd) throws Exception {
		dao.save("TbfeedbackMapping.insertFeed", pd);
		
	}

	@Override
	public void deleteFeed(PageData pd) throws Exception {
	dao.delete("TbfeedbackMapping.deleteFeed", pd);
		
	}

	@Override
	public TbFeedback getFeedBackByFuidAndTitle(PageData pd) throws Exception {
		return (TbFeedback) dao.findForObject("TbfeedbackMapping.getFeedBackByFuidAndTitle", pd);
	}

	
	

}
