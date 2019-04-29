package com.infopublic.service.impl;


import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.infopublic.dao.DaoSupport;
import com.infopublic.entity.TbHuodong;
import com.infopublic.entity.TbYuqing;
import com.infopublic.service.HdManager;
import com.infopublic.util.PageData;

@Service("HdService")
public class HdService implements HdManager{ 
	@Resource(name = "daoSupport") 
	private DaoSupport dao; 

	@SuppressWarnings("unchecked")
	
	@Override
	public List<TbHuodong> getHd(PageData pd) throws Exception {
		return (List<TbHuodong>)dao.findForList("TbHdMapping.getHd", pd);
	}
	@Override
	public TbHuodong getHdFromhdid(PageData pd) throws Exception {
		return (TbHuodong)dao.findForObject("TbHdMapping.getHdFromhdid", pd);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<TbHuodong> getHdFromInfo(PageData pd) throws Exception {
		return (List<TbHuodong>)dao.findForList("TbHdMapping.getHdFromInfo", pd);
	}
	
	@Override
	public TbHuodong getHdDateFromhdid(PageData pd) throws Exception {
		return (TbHuodong)dao.findForObject("TbHdMapping.getHdDateFromhdid", pd);
	}


	@Override
	public void updateHuodong(PageData pd) throws Exception {
		dao.update("TbHdMapping.updateHuodong", pd);
		
	}

	@Override
	public void insertHuodong(PageData pd) throws Exception {
		dao.save("TbHdMapping.insertHuodong", pd);
		
	}

	@Override
	public void deleteHuodong(PageData pd) throws Exception {
		dao.delete("TbHdMapping.deleteHuodong", pd);
		
	}


	
}
