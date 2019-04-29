package com.infopublic.service;

import java.util.List;

import com.infopublic.entity.TbFeedback;
import com.infopublic.entity.TbGroup;
import com.infopublic.entity.TbPartycircle;
import com.infopublic.entity.TbPcpraise;
import com.infopublic.util.PageData;

/**
 * 暮云圈点赞接口类
 * @author yxy
 *
 */
public interface PCpraiseManager {
	
	/**
	 * 查询所有点赞人
	 */
	public List<TbPcpraise> getpraiseUname(PageData pd)throws Exception;
	
	/**
	 * 增加点赞信息
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public void addPcpraise(PageData pd)throws Exception;
	
	/**
	 * 根据暮云圈ID和点赞人ID删除点赞信息
	 */
	public void delPcpraise(PageData pd) throws Exception;
	
	/**
	 * 根据暮云圈id获取点赞总数
	 */
	public String getPraiseTotle(PageData pd)throws Exception;
	

}
