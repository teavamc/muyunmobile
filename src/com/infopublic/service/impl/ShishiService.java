package com.infopublic.service.impl;


import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.infopublic.dao.DaoSupport;
import com.infopublic.entity.TbShishi;
import com.infopublic.service.ShishiManager;
import com.infopublic.util.PageData;

@Service("ShishiService")
public class ShishiService implements ShishiManager{ //用ShiShiService来实现ShiShiManager类
	@Resource(name = "daoSupport") 
	private DaoSupport dao; //获取DaoSupport中的dao类

	@SuppressWarnings("unchecked")
	@Override
	public List<TbShishi> getShishi(PageData pd) throws Exception {
		return (List<TbShishi>)dao.findForList("ShishiMapping.getShishi", pd);
	}
	@Override
	public TbShishi getShishiFromshiid(PageData pd) throws Exception {
		return (TbShishi)dao.findForObject("ShishiMapping.getShishiFromshiid", pd);
	}
	
}
