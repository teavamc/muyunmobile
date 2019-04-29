package com.infopublic.service;

import java.util.List;

import com.infopublic.entity.TbFeedback;
import com.infopublic.entity.TbYuqing;
import com.infopublic.util.PageData;

/**
 * 舆情接口类
 * @author yxy
 *
 */
public interface YuQingManager {
	
	/**
	 * 展示舆情
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<TbYuqing> getYuqing(PageData pd)throws Exception;
		
	/**
	 * 根据yqid展示
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public TbYuqing getYuqingFromyqid(PageData pd)throws Exception;
	
	
	/**
	 * 根据搜索结果展示
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<TbYuqing> getYuqingFromInfo(PageData pd)throws Exception;
	
	/**
	 * 判断提交速度 不允许在同一小时内再次提交
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public TbYuqing getYuqingDateFromyqid(PageData pd)throws Exception;
	
	
	/**
	 * 修改舆情信息
	 * @param pd
	 * @throws Exception
	 */
	public void updateYuqing(PageData pd)throws Exception;
	
	/**
	 * 新增信息
	 * @param pd
	 * @throws Exception
	 */
	public void insertYuqing(PageData pd)throws Exception;
	
	/**
	 * 删除信息
	 * @param pd
	 * @throws Exception
	 */
	public void deleteYuqing(PageData pd)throws Exception;
}
