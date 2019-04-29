package com.infopublic.service;

import java.util.List;

import com.infopublic.entity.TbSencollect;
import com.infopublic.util.PageData;

/**
 * 敏感字符集合接口类
 * @author yxy
 *
 */
public interface SenCollectManager {
	
	/**
	 * 查询全部敏感字符集
	 * @return
	 */
	public List<TbSencollect> getAllSenCol() throws  Exception;
	
	/**
	 * 新增敏感字符
	 */
	public void addSenCol(PageData pd)throws  Exception;
	
	/**
	 * 删除敏感字符
	 */
	public void delSenCol(PageData pd)throws  Exception;
}
