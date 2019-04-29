package com.infopublic.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.infopublic.dao.DaoSupport;
import com.infopublic.entity.TbFileManager;
import com.infopublic.service.FileManager;
import com.infopublic.util.PageData;


@Service("FileService")
public class FileService implements FileManager {

	@Resource(name = "daoSupport") 
	private DaoSupport dao; 

	@SuppressWarnings("unchecked")
	@Override
	public List<TbFileManager> getfileformupdate(PageData pd) throws Exception {
		return (List<TbFileManager>)dao.findForList("TbFileManagerMapping.getfileformupdate", pd);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<TbFileManager> getfileformdownloadnum(PageData pd) throws Exception {
		return (List<TbFileManager>)dao.findForList("TbFileManagerMapping.getfileformdownloadnum", pd);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<TbFileManager> getfileformseach(PageData pd) throws Exception {
		return (List<TbFileManager>)dao.findForList("TbFileManagerMapping.getfileformseach", pd);
	}

	@Override
	public TbFileManager getfilefromfileid(String fileid) throws Exception {
		return (TbFileManager)dao.findForObject("TbFileManagerMapping.getfilefromfileid", fileid);
	}

	@Override
	public void setfiledownnumber(PageData pd) throws Exception {
		dao.update("TbFileManagerMapping.setfiledownnumber", pd);
	}

	@Override
	public void setfilezan(PageData pd) throws Exception {
		dao.update("TbFileManagerMapping.setfilezan", pd);
	}
	
	@Override
	public int querryfilenumber(int remark) throws Exception {
		return (int)dao.findForObject("TbFileManagerMapping.querryfilenumber", remark);
	}
	
	@Override
	public void insertNewFile(PageData pd) throws Exception {
		dao.update("TbFileManagerMapping.insertNewFile", pd);
	}

}
