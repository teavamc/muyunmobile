package com.infopublic.service.impl;


import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.infopublic.dao.DaoSupport;
import com.infopublic.entity.TbGuide;
import com.infopublic.entity.TbPartycircle;
import com.infopublic.entity.TbPccomment;
import com.infopublic.entity.TbResident;
import com.infopublic.service.GuideManager;
import com.infopublic.service.PCcommentManager;
import com.infopublic.service.PCircleManager;
import com.infopublic.service.ResidentManager;
import com.infopublic.util.PageData;

@Service("PCcommentService")
public class PCcommentService implements PCcommentManager{
	@Resource(name = "daoSupport")
	private DaoSupport dao;

	@SuppressWarnings("unchecked")
	@Override
	public List<TbPccomment> getPccomment(PageData pd) throws Exception {
		return (List<TbPccomment>) dao.findForList("TbPCcommentMapping.getPccomment", pd);
	}

	@Override
	public void addPccomment(PageData pd) throws Exception {
		dao.save("TbPCcommentMapping.addPccomment", pd);
	}

	@Override
	public void delPccomment(PageData pd) throws Exception {
		dao.delete("TbPCcommentMapping.delPccomment", pd);
	}

	@Override
	public TbPccomment getSensitiveBycoid(PageData pd) throws Exception {
		return (TbPccomment)dao.findForObject("TbPCcommentMapping.getSensitiveBycoid", pd);
	}

	



}
