package com.infopublic.service.impl;


import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.infopublic.dao.DaoSupport;
import com.infopublic.entity.TbGuide;
import com.infopublic.entity.TbPartycircle;
import com.infopublic.entity.TbPcpraise;
import com.infopublic.entity.TbResident;
import com.infopublic.service.GuideManager;
import com.infopublic.service.PCircleManager;
import com.infopublic.service.PCpraiseManager;
import com.infopublic.service.ResidentManager;
import com.infopublic.util.PageData;

@Service("PCpraiseService")
public class PCpraiseService implements PCpraiseManager{
	@Resource(name = "daoSupport")
	private DaoSupport dao;

	@Override
	public void addPcpraise(PageData pd) throws Exception {
		dao.save("TbPCpraiseMapping.addPcpraise", pd);
	}

	@Override
	public void delPcpraise(PageData pd) throws Exception {
		dao.delete("TbPCpraiseMapping.delPcpraise", pd);
	}

	@Override
	public String getPraiseTotle(PageData pd) throws Exception {
		return (String) dao.findForObject("TbPCpraiseMapping.getPraiseTotle", pd);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<TbPcpraise> getpraiseUname(PageData pd) throws Exception {
		return (List<TbPcpraise>) dao.findForList("TbPCpraiseMapping.getpraiseUname", pd);
	}

	



}
