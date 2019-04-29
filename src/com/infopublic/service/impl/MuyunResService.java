package com.infopublic.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.infopublic.dao.DaoSupport;
import com.infopublic.util.PageData;

import java.util.List;
import java.util.Map;

import com.infopublic.entity.MuyunRes;
import com.infopublic.service.MuyunResManager;


@Service("MuyunResService")
public class MuyunResService implements MuyunResManager {
	
	@Resource(name = "daoSupport") 
	private DaoSupport dao; 
	
	@SuppressWarnings("unchecked")
	@Override
	public List<MuyunRes> getAll_res(PageData pd)throws Exception {
		return (List<MuyunRes>)dao.findForList("MuyunResMapping.getAll_res", pd);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<MuyunRes> getAll_res_byGroup(PageData pd) throws Exception {
		return (List<MuyunRes>)dao.findForList("MuyunResMapping.getAll_res_byGroup", pd);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<MuyunRes> get_res_bySearch(PageData pd) throws Exception {
		return (List<MuyunRes>)dao.findForList("MuyunResMapping.get_res_bySearch", pd);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Map<String,String>>  getCount_All_types(PageData pd)throws Exception{
		return (List<Map<String,String>>)dao.findForList("MuyunResMapping.getCount_All_types", pd);
	}
	
	@Override
	public MuyunRes get_res_byPid(String pid) throws Exception {
		return (MuyunRes)dao.findForObject("MuyunResMapping.get_res_byPid", pid);
	}
	
	@Override
	public int getCount_byGroup(String grouptype) throws Exception {
		return (int)dao.findForList("MuyunResMapping.getCount_byGroup", grouptype);
	}
	
	@Override
	public int getCount_bySex(String sex) throws Exception {
		return (int)dao.findForObject("MuyunResMapping.getCount_bySex", sex);
	}
	
	@Override
	public int getCount_Res(PageData pd)throws Exception {
		return (int)dao.findForObject("MuyunResMapping.getCount_Res", pd);
	}
	
}
