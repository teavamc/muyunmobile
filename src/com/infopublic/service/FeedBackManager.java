package com.infopublic.service;

import java.util.List;

import com.infopublic.entity.TbFeedback;
import com.infopublic.util.PageData;

/**
 * 投诉咨询接口类
 * @author yxy
 *
 */
public interface FeedBackManager {
	
	/**
	 * 根据uid  isread展示我的投诉   咨询
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<TbFeedback> getFeebBackFromFtype(PageData pd)throws Exception;
		
	/**
	 * 根据类别展示我的投诉   咨询
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<TbFeedback> getFeebBackEdit(PageData pd)throws Exception;
	
	/**
	 * 根据 fbid展示
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public TbFeedback getFeedBackByFbid(PageData pd)throws Exception;
	
	/**
	 * 查询某是否存在同样标题
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public TbFeedback getFeedBackByFuidAndTitle(PageData pd)throws Exception;
	
	
	/**
	 * 修改投诉咨询信息
	 * @param pd
	 * @throws Exception
	 */
	public void updateFeed(PageData pd)throws Exception;
	
	/**
	 * 新增信息
	 * @param pd
	 * @throws Exception
	 */
	public void insertFeed(PageData pd)throws Exception;
	
	/**
	 * 根据fbid删除信息
	 * @param pd
	 * @throws Exception
	 */
	public void deleteFeed(PageData pd)throws Exception;
}
