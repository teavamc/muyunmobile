package com.infopublic.service.impl;


import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.infopublic.dao.DaoSupport;
import com.infopublic.entity.TbGuide;
import com.infopublic.entity.TbResident;
import com.infopublic.service.GuideManager;
import com.infopublic.service.ResidentManager;
import com.infopublic.util.PageData;

@Service("ResidentService")
public class ResidentService implements ResidentManager{
	@Resource(name = "daoSupport")
	private DaoSupport dao;


	@SuppressWarnings("unchecked")
	@Override
	public List<TbResident> getResAll(PageData pd) throws Exception {
		return (List<TbResident>)dao.findForList("TbResidentMapping.getResAll", pd);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<TbResident> getResByKey(PageData pd) throws Exception {
		return (List<TbResident>)dao.findForList("TbResidentMapping.getResByKey", pd);
	}

	@Override
	public TbResident getResidentFromrid(PageData pd) throws Exception {
		return (TbResident) dao.findForObject("TbResidentMapping.getResidentFromrid", pd);
	}

	



}
