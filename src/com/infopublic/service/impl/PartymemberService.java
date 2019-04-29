package com.infopublic.service.impl;


import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.infopublic.dao.DaoSupport;
import com.infopublic.entity.TbPartymember;
import com.infopublic.service.PartymemberManager;
import com.infopublic.util.PageData;

@Service("partymemberService")
public class PartymemberService implements PartymemberManager{
	@Resource(name = "daoSupport")
	private DaoSupport dao;

	public String yanzhengpartymember(String idcard) throws Exception {
		return (String)dao.findForObject("TbPartymember.yanzhengppartymember", idcard);
	}

	public void edituid(PageData pd) throws Exception {
		dao.findForObject("TbPartymember.edituid", pd);
	}


	public String getpartymemberidcard(String uid) throws Exception {
		return (String)dao.findForObject("TbPartymember.getpartymemberidcard", uid);
	}

	public TbPartymember getpartyinfofromidcard(String idcard) throws Exception {
		return (TbPartymember)dao.findForObject("TbPartymember.getpartyinfofromidcard", idcard);
	}

	@Override
	public TbPartymember getpartymemberfromuid(String uid) throws Exception {
		return (TbPartymember)dao.findForObject("TbPartymember.getpartymemberfromuid", uid);
	}

	@Override
	public String getpidbypname(String pname) throws Exception {
		return (String)dao.findForObject("TbPartymember.getpidbypname", pname);
	}

	@Override
	public void changephone(PageData pd) throws Exception {
		dao.update("TbPartymember.changephone", pd);
		
	}

}
