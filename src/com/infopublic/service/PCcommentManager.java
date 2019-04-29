package com.infopublic.service;

import java.util.List;

import com.infopublic.entity.TbFeedback;
import com.infopublic.entity.TbGroup;
import com.infopublic.entity.TbPartycircle;
import com.infopublic.entity.TbPccomment;
import com.infopublic.util.PageData;

/**
 * 暮云圈评论接口类
 * @author yxy
 *
 */
public interface PCcommentManager {
	
	/**
	 * 根据暮云圈ID查找评论信息
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<TbPccomment> getPccomment(PageData pd)throws Exception;
	
	
	/**
	 * 根据暮云圈评论ID查找单条评论信息
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public TbPccomment getSensitiveBycoid(PageData pd)throws Exception;
	
	/**
	 * 增加评论信息
	 * @param pd
	 */
	public void addPccomment(PageData pd)throws Exception ;
	
	/**
	 * 根据暮云圈ID和评论人ID删除评论
	 * @param pd
	 */
	public void delPccomment(PageData pd)throws Exception ;
		

	

}
