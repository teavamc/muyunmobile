package com.infopublic.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.infopublic.dao.DaoSupport;
import com.infopublic.entity.TbSelfeval;
import com.infopublic.service.SelfevalManager;
import com.infopublic.util.PageData;

@Service("selfevalService")
public class SelfevalService implements SelfevalManager{
	@Resource(name = "daoSupport")
	private DaoSupport dao;

	@SuppressWarnings("unchecked")
	@Override
	public List<TbSelfeval> getassessfromuid(PageData pd) throws Exception {
		return (List<TbSelfeval>)dao.findForList("Tbselfmapping.getassessfromuid", pd);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<TbSelfeval> getassessfromuidtohim(PageData pd) throws Exception {
		return (List<TbSelfeval>)dao.findForList("Tbselfmapping.getassessfromuidtohim", pd);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<TbSelfeval> getassessfromuidtome(PageData pd) throws Exception {
		return (List<TbSelfeval>)dao.findForList("Tbselfmapping.getassessfromuidtome", pd);
	}

	@Override
	public void insertsel(PageData pd) throws Exception {
		dao.save("Tbselfmapping.insertsel", pd);
		
	}

	@Override
	public void updateselfromselfid(PageData pd) throws Exception {
		dao.update("Tbselfmapping.updateselfromselfid", pd);
		
	}

	@Override
	public void deleteselfromselfid(String sfid) throws Exception {
		dao.delete("Tbselfmapping.deleteselfromselfid", sfid);
		
	}

	@Override
	public TbSelfeval getassfromsfid(String sfid) throws Exception {
		return (TbSelfeval) dao.findForObject("Tbselfmapping.getassfromsfid", sfid);
	}

	@Override
	public int totalall1(PageData pd) throws Exception {
		return (int) dao.findForObject("Tbselfmapping.totalSearchAssforpage1", pd);
	}
	@Override
	public int totalall2(PageData pd) throws Exception {
		return (int) dao.findForObject("Tbselfmapping.totalSearchAssforpage2", pd);
	}
	@Override
	public int totalall3(PageData pd) throws Exception {
		return (int) dao.findForObject("Tbselfmapping.totalSearchAssforpage3", pd);
	}
	
	
	
}
