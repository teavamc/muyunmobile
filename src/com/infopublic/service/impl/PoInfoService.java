package com.infopublic.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.infopublic.dao.DaoSupport;
import com.infopublic.entity.Page;
import com.infopublic.entity.PoInfo;
import com.infopublic.service.PoInfoManager;
import com.infopublic.util.PageData;

@Service("poinfoService")
public class PoInfoService implements PoInfoManager{
	@Resource(name = "daoSupport")
	private DaoSupport dao;
	@SuppressWarnings("unchecked")
	
    //这里的querry是查找

	@Override //查找所有的类型
	public List<PoInfo> querryAllBytype(String type) throws Exception {
		return (List<PoInfo>) dao.findForList("PoInfoMapper.querryAllBytype", type);
		
	}

	@SuppressWarnings("unchecked")
	@Override //所有标题
	public List<PoInfo> querryAllBytitle(String title) throws Exception {
		
		return (List<PoInfo>) dao.findForList("PoInfoMapper.querryAllBytitle", title);
	}

	@SuppressWarnings("unchecked")
	@Override //所有是否可用
	public List<PoInfo> querryAllByRemark(String remark) throws Exception {
		return (List<PoInfo>) dao.findForList("PoInfoMapper.querryAllByRemark", remark);
	}

	@Override //所有id
	public PoInfo querryById(String poinid) throws Exception {
		// TODO Auto-generated method stub
		return (PoInfo) dao.findForObject("PoInfoMapper.querryById", poinid);
	}


	@Override //删除id
	public void deletePoInfoById(String poinid) throws Exception {
		// TODO Auto-generated method stub
		dao.delete("PoInfoMapper.deletePoInfoById", poinid);
	}

	@Override //编辑通知
	public void editPoInfo(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		dao.update("PoInfoMapper.editPoInfo", pd);
		
	}

	@Override //插入通知
	public void insertPoInfo(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		dao.save("PoInfoMapper.insertPoInfo", pd);
	}

	@SuppressWarnings("unchecked") //查询所有
	public List<PoInfo> querryAll(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PoInfo>) dao.findForList("PoInfoMapper.listAllPoInfo", page);
	}

	@SuppressWarnings("unchecked") //查询所有通知页面
	@Override
	public List<PoInfo> showallinfo(PageData pd) throws Exception {
		return (List<PoInfo>)dao.findForList("PoInfoMapper.listAllPoInfoforpage", pd);
	}

	@Override //根据类别查询所有通知的个数
	public int totalallinfo(String type) throws Exception {
		return (int) dao.findForObject("PoInfoMapper.totalallinfo", type);
	}

	@SuppressWarnings("unchecked")
	@Override //通过标题模糊查询id列表
	public List<PoInfo> showallinfofromsearch(PageData pd) throws Exception {
		return (List<PoInfo>)dao.findForList("PoInfoMapper.listSearchPoInfoforpage", pd);
	}

	@Override //根据类别查询所有通知
	public int totalSearchPoInfoforpage(String content) throws Exception {
		return (int) dao.findForObject("PoInfoMapper.totalSearchPoInfoforpage", content);
	}
	
}
