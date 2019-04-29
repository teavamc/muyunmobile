package com.infopublic.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.infopublic.dao.DaoSupport;
import com.infopublic.entity.TbGroup;
import com.infopublic.service.PartyGroupManager;
import com.infopublic.util.PageData;

@Service("PartyGroupService")
public class PartyGroupService implements PartyGroupManager{
	@Resource(name = "daoSupport")
	private DaoSupport dao;

	@Override
	public TbGroup getGroupByGid(PageData pd) throws Exception {
		return (TbGroup) dao.findForObject("TbGroupMapping.getGroupByGid", pd);
	}

	@Override
	public TbGroup getGroupByuid(PageData pd) throws Exception {
		return (TbGroup) dao.findForObject("TbGroupMapping.getGroupByuid", pd);
	}

	
	

}
