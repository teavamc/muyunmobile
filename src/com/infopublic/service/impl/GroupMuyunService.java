package com.infopublic.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.infopublic.dao.DaoSupport;
import com.infopublic.util.PageData;

import java.util.List;

import com.infopublic.entity.GroupMuyun;
import com.infopublic.service.GroupMuyunManager;


@Service("GroupMuyunService")
public class GroupMuyunService implements GroupMuyunManager {
	
	@Resource(name = "daoSupport") 
	private DaoSupport dao; 

	@SuppressWarnings("unchecked")
	@Override
	public List<GroupMuyun> getGmuyuntypelist(PageData pd) throws Exception {
		return (List<GroupMuyun>)dao.findForList("GroupMuyunMapping.getGmuyuntypelist", pd);
	}

	@Override
	public GroupMuyun getGmuyunofpid(String pid) throws Exception {
		return (GroupMuyun)dao.findForObject("GroupMuyunMapping.getGmuyunofpid", pid);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<GroupMuyun> getGmuyunlistformseach(PageData pd) throws Exception {
		return (List<GroupMuyun>)dao.findForList("GroupMuyunMapping.getGmuyuntypelist", pd);
	}
	
	@Override
	public int querrynumberformtype(PageData pd) throws Exception {
		return (int)dao.findForObject("GroupMuyunMapping.querrynumberformtype", pd);
	}
	
	@Override
	public int querrynumberformtypes(String grouptype) throws Exception {
		return (int)dao.findForObject("GroupMuyunMapping.querrynumberformtypes", grouptype);
	}
	
	@Override
	public int querrynumberformsex(String sex) throws Exception {
		return (int)dao.findForObject("GroupMuyunMapping.querrynumberformsex", sex);
	}
	
	@Override
	public int querrynumber(PageData pd) throws Exception {
		return (int)dao.findForObject("GroupMuyunMapping.querrynumber", pd);
	}
	

}
