package com.infopublic.service.impl;


import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.infopublic.dao.DaoSupport;
import com.infopublic.entity.TbEducation;
import com.infopublic.service.EduManager;
import com.infopublic.util.PageData;

@Service("EduService")
public class EduService implements EduManager{ 
	@Resource(name = "daoSupport") 
	private DaoSupport dao; 

	@SuppressWarnings("unchecked")
	@Override
	public List<TbEducation> getEdu(PageData pd) throws Exception {
		return (List<TbEducation>)dao.findForList("TbEduMapping.getEdu", pd);
	}
	@Override
	public TbEducation getEduFromeid(PageData pd) throws Exception {
		return (TbEducation)dao.findForObject("TbEduMapping.getEduFromeid", pd);
	}
	@Override
	public TbEducation setEduCourread(PageData pd) throws Exception {
		return (TbEducation)dao.findForObject("TbEduMapping.setEduCourread", pd);
	}
	
}
