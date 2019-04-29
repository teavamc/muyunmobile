package com.infopublic.service.impl;


import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.infopublic.dao.DaoSupport;
import com.infopublic.entity.TbGuide;
import com.infopublic.service.GuideManager;
import com.infopublic.util.PageData;

@Service("GuideService")
public class GuideService implements GuideManager{
	@Resource(name = "daoSupport")
	private DaoSupport dao;

	@SuppressWarnings("unchecked")
	@Override
	public List<TbGuide> getGuideFromGreadtotal(PageData pd) throws Exception {
		return (List<TbGuide>)dao.findForList("TbguideMapping.getGuideFromGreadtotal", pd);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<TbGuide> getGuideFromTitleOrType(PageData pd) throws Exception {
		return (List<TbGuide>)dao.findForList("TbguideMapping.getGuideFromTitleOrType", pd);
	}

	@Override
	public TbGuide getGuideFromguid(PageData pd) throws Exception {
		return (TbGuide)dao.findForObject("TbguideMapping.getGuideFromguid", pd);
	}

	@Override
	public void updatereadtotal(PageData pd) throws Exception {
		dao.update("TbguideMapping.updatereadtotal", pd);
		
	}

	@SuppressWarnings("unchecked")
	public List<TbGuide> getGuideFromGreadtotalbyremark(int remark) throws Exception {
		return (List<TbGuide>)dao.findForList("TbguideMapping.getGuideFromGreadtotalbyremark", remark);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<TbGuide> getGuidebyremark(int remark) throws Exception {
		return (List<TbGuide>)dao.findForList("TbguideMapping.getGuidebyremark", remark);
	}

	@Override
	public int totalallbyremark(int remark) throws Exception {
		return (int) dao.findForObject("TbguideMapping.totalallbyremark", remark);
	}



}
