package com.infopublic.service;

import java.util.List;

import com.infopublic.entity.TbGuide;
import com.infopublic.entity.TbResident;
import com.infopublic.util.PageData;

/**
 * 村民信息接口类
 * @author yxy
 *
 */
public interface ResidentManager {
	
	/**
	 * 查询所有村民信息
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<TbResident> getResAll(PageData pd)throws Exception;
	
	/**
	 * 根据关键字（姓名、住址、家庭类别、身份证）查询村民信息
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<TbResident> getResByKey(PageData pd)throws Exception;
	
	/**
	 * 查看具体信息
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public TbResident getResidentFromrid(PageData pd)throws Exception;
	
		
	

}
