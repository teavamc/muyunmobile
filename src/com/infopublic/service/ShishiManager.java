package com.infopublic.service;

import java.util.List;

import com.infopublic.entity.TbShishi;
import com.infopublic.util.PageData;

/**
 * 舆情接口类
 * @author zc
 *
 */
public interface ShishiManager {
	
	/**
	 * 展示舆情
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<TbShishi> getShishi(PageData pd)throws Exception;
		
	/**
	 * 根据shiid展示
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public TbShishi getShishiFromshiid(PageData pd)throws Exception;

}
