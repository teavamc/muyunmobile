package com.infopublic.service;

import java.util.List;

import com.infopublic.entity.Page;
import com.infopublic.util.PageData;


/** 系统设置
 */
public interface SystemManager {
	
	
	/**初始化数据库
	 * @return
	 * @throws Exception
	 */
	public String initDataBase(String str) throws Exception;
	/**
	 * 基础信息
	 * @param str
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listBaseAttributes(String str) throws Exception;
	/**
	 * 查询基础信息
	 * @param valueid
	 * @return
	 * @throws Exception
	 */
	public String getBaseAttri(String valueid) throws Exception;
	
	/**
	 * 保存设置
	 * @param pd
	 * @throws Exception
	 */
	public void saveAttri(PageData pd)throws Exception;
	
}
