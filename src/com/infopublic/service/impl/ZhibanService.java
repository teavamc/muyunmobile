package com.infopublic.service.impl;


import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.infopublic.dao.DaoSupport;
import com.infopublic.entity.TbZhiban;
import com.infopublic.service.ZhibanManager;
import com.infopublic.util.PageData;

@Service("ZhibanService")
public class ZhibanService implements ZhibanManager{ 
	@Resource(name = "daoSupport") 
	private DaoSupport dao; 
	
	@SuppressWarnings("unchecked")
	@Override
	public List<TbZhiban> getAllZhiban(PageData pd) throws Exception {
		return (List<TbZhiban>)dao.findForList("TbZbMapping.getAllZhiban", pd);
	}
	
	@Override
	public TbZhiban getAllZhibannow(String localdate) throws Exception {
		return (TbZhiban)dao.findForObject("TbZbMapping.getAllZhibannow", localdate);
	}
	
	@Override
	public TbZhiban getZbFromzbid(String zhid) throws Exception {
		return (TbZhiban)dao.findForObject("TbZbMapping.getZbFromzbid", zhid);
	}
	
	
	
}
