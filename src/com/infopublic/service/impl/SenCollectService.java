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
import com.infopublic.entity.TbSencollect;
import com.infopublic.service.GuideManager;
import com.infopublic.service.PCcommentManager;
import com.infopublic.service.PCircleManager;
import com.infopublic.service.ResidentManager;
import com.infopublic.service.EducommentManager;
import com.infopublic.service.SenCollectManager;
import com.infopublic.util.PageData;

@Service("SenCollectService")
public class SenCollectService implements SenCollectManager{
	@Resource(name = "daoSupport")
	private DaoSupport dao;

	@SuppressWarnings("unchecked")
	@Override
	public List<TbSencollect> getAllSenCol() throws Exception{
		return (List<TbSencollect>)dao.findForList("TbSenolMapping.getAllSenCol", "");
	}
	@Override
	public void addSenCol(PageData pd) throws Exception {
		dao.save("TbSenolMapping.addSenCol", pd);
		
	}
	@Override
	public void delSenCol(PageData pd) throws Exception {
		dao.delete("TbSenolMapping.delSenCol", pd);
		
	}

	



	



}
