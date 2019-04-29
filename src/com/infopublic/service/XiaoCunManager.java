package com.infopublic.service;

import java.util.List;

import com.infopublic.entity.TbFeedback;
import com.infopublic.entity.TbXiaocun;
import com.infopublic.entity.TbYuqing;
import com.infopublic.util.PageData;

/**
 * 小村家事接口类
 * @author yxy
 *
 */
public interface XiaoCunManager {
	
	/**
	 * 展示小村家事
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<TbXiaocun> getXiaocun(PageData pd)throws Exception;
		
	/**
	 * 根据uid展示我的小村家事
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<TbXiaocun> getMyXiaocun(PageData pd) throws Exception;
	
	
	/**
	 * 根据jsid查询小村家事信息
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public TbXiaocun getXiaocunFromjsid(PageData pd)throws Exception;
	
	/**
	 * 判断提交速度 不允许在同一小时内再次提交
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public TbXiaocun getXiaocunDateFromjsid(PageData pd)throws Exception;
	
	
	
	/**
	 * 新增信息
	 * @param pd
	 * @throws Exception
	 */
	public void insertXiaocun(PageData pd)throws Exception;

	
	
	/**
	 * 删除信息
	 * @param pd
	 * @throws Exception
	 */
	public void deletexiaocun(PageData pd)throws Exception;
	
}
