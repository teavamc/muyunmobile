package com.infopublic.service.impl;


import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.infopublic.dao.DaoSupport;
import com.infopublic.entity.TbGuide;
import com.infopublic.entity.TbPartycircle;
import com.infopublic.entity.TbResident;
import com.infopublic.service.GuideManager;
import com.infopublic.service.PCircleManager;
import com.infopublic.service.ResidentManager;
import com.infopublic.util.PageData;

@Service("PCircleService")
public class PCircleService  implements PCircleManager{
	@Resource(name = "daoSupport")
	private DaoSupport dao;

	@SuppressWarnings("unchecked")
	@Override
	public List<TbPartycircle> getCircle(PageData pd) throws Exception {
		return  (List<TbPartycircle>) dao.findForList("TbPCircleMapping.getCircle", pd);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<TbPartycircle> getCircleByUid(PageData pd) throws Exception {
		return  (List<TbPartycircle>) dao.findForList("TbPCircleMapping.getCircleByUid", pd);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<TbPartycircle> getCircleOderBysennum(PageData pd)
			throws Exception {
		return  (List<TbPartycircle>) dao.findForList("TbPCircleMapping.getCircleOderBysennum", pd);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<TbPartycircle> getPcircleDateFromuid(PageData pd)
			throws Exception {
		return  (List<TbPartycircle>) dao.findForList("TbPCircleMapping.getPcircleDateFromuid", pd);
	}

	@Override
	public void insertPcircle(PageData pd) throws Exception {
		dao.save("TbPCircleMapping.insertPcircle", pd);
		
	}

	@Override
	public void deletecircle(PageData pd) throws Exception {
		dao.delete("TbPCircleMapping.deletecircle", pd);
		
	}



	@Override
	public void updatesennum(PageData pd) throws Exception {
		dao.update("TbPCircleMapping.updatesennum", pd);
		
	}

	@Override
	public Integer getSenTotalBypcid(PageData pd) throws Exception {
		return (Integer) dao.findForObject("TbPCircleMapping.getSenTotalBypcid", pd);
	}


	



}
