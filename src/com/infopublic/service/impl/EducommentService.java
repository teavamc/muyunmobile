package com.infopublic.service.impl;


import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.infopublic.dao.DaoSupport;
import com.infopublic.entity.TbGuide;
import com.infopublic.entity.TbPartycircle;
import com.infopublic.entity.TbPccomment;
import com.infopublic.entity.TbResident;
import com.infopublic.entity.TbEducomment;
import com.infopublic.service.GuideManager;
import com.infopublic.service.PCcommentManager;
import com.infopublic.service.PCircleManager;
import com.infopublic.service.ResidentManager;
import com.infopublic.service.EducommentManager;
import com.infopublic.util.PageData;

@Service("EducommentService")
public class EducommentService implements EducommentManager{
	@Resource(name = "daoSupport")
	private DaoSupport dao;


	@SuppressWarnings("unchecked")
	@Override
	public List<TbEducomment> getEducomment(PageData pd) throws Exception {
		return (List<TbEducomment>) dao.findForList("EducommentMapping.getEducomment", pd);
	}

	@Override
	public void addEducomment(PageData pd) throws Exception {
		dao.save("EducommentMapping.addEducomment", pd);
		
	}

	@Override
	public void delEducomment(PageData pd) throws Exception {
		dao.delete("EducommentMapping.delEducomment", pd);
		
	}

	@Override
	public TbEducomment getComment(PageData pd) throws Exception {
		return (TbEducomment)dao.findForObject("EducommentMapping.getComment", pd);
	}

	



}
