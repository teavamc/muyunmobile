package com.infopublic.service;

import java.util.List;

import com.infopublic.entity.TbHuodong;
import com.infopublic.entity.TbYuqing;
import com.infopublic.util.PageData;

/**
 * 党员活动接口类
 * @author zc
 *
 */
public interface HdManager {
	
	/**
	 * 展示活动内容
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<TbHuodong> getHd(PageData pd)throws Exception;
		
	/**
	 * 根据hdid展示
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public TbHuodong getHdFromhdid(PageData pd)throws Exception;
		
	/**
	 * 根据搜索结果展示
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<TbHuodong> getHdFromInfo(PageData pd)throws Exception;
	
	/**
	 * 判断提交速度 不允许在同一小时内再次提交
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public TbHuodong getHdDateFromhdid(PageData pd)throws Exception;
	
	
	/**
	 * 修改活动消息
	 * @param pd
	 * @throws Exception
	 */
	public void updateHuodong (PageData pd)throws Exception;
	
	/**
	 * 新增活动消息
	 * @param pd
	 * @throws Exception
	 */
	public void insertHuodong (PageData pd)throws Exception;
	
	/**
	 * 删除活动消息
	 * @param pd
	 * @throws Exception
	 */
	public void deleteHuodong (PageData pd)throws Exception;
	

}
