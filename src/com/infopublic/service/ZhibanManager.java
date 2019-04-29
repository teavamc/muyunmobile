package com.infopublic.service;

import java.util.List;

import com.infopublic.entity.TbZhiban;
import com.infopublic.util.PageData;

/**
 * 党员值班接口类
 * @author zc
 *
 */
public interface ZhibanManager {
	
	/**
	 * 展示活动内容
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<TbZhiban> getAllZhiban(PageData pd)throws Exception;
		
	/**
	 * 根据hdid展示
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public TbZhiban getAllZhibannow(String localdate)throws Exception;
		
	/**
	 * 根据搜索结果展示
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public TbZhiban getZbFromzbid(String zhid)throws Exception;
	
	

}
