package com.infopublic.service.impl;


import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.infopublic.dao.DaoSupport;
import com.infopublic.entity.TbGuide;
import com.infopublic.entity.TbPartycircle;
import com.infopublic.entity.TbPccomment;
import com.infopublic.entity.TbResident;
import com.infopublic.entity.TbYqcomment;
import com.infopublic.service.GuideManager;
import com.infopublic.service.PCcommentManager;
import com.infopublic.service.PCircleManager;
import com.infopublic.service.ResidentManager;
import com.infopublic.service.YQcommentManager;
import com.infopublic.util.PageData;

@Service("YQcommentService")
public class YQcommentService implements YQcommentManager{
	@Resource(name = "daoSupport")
	private DaoSupport dao;


	@SuppressWarnings("unchecked")
	@Override
	public List<TbYqcomment> getYqcomment(PageData pd) throws Exception {
		return (List<TbYqcomment>) dao.findForList("TbYQcommentMapping.getYqcomment", pd);
	}

	@Override
	public void addYqcomment(PageData pd) throws Exception {
		dao.save("TbYQcommentMapping.addYqcomment", pd);
		
	}

	@Override
	public void delYqcomment(PageData pd) throws Exception {
		dao.delete("TbYQcommentMapping.delYqcomment", pd);
		
	}

	@Override
	public TbYqcomment getYqccontent(PageData pd) throws Exception {
		return (TbYqcomment)dao.findForObject("TbYQcommentMapping.getYqccontent", pd);
	}

	



}
