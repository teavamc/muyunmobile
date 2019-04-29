package com.infopublic.service;

import java.util.List;

import com.infopublic.entity.TbFeedback;
import com.infopublic.entity.TbGroup;
import com.infopublic.entity.TbPartycircle;
import com.infopublic.entity.TbPccomment;
import com.infopublic.entity.TbEducomment;
import com.infopublic.util.PageData;


public interface EducommentManager {
	
	/**
	 * 根据舆情ID查找评论信息

	 */
	public List<TbEducomment> getEducomment(PageData pd)throws Exception;
	
	/**
	 * 根据舆情评论id查找评论具体信息

	 */
	public TbEducomment getComment(PageData pd)throws Exception;
	
	/**
	 * 增加评论信息
	 * @param pd
	 */
	public void addEducomment(PageData pd)throws Exception ;
	
	/**
	 * 根据舆情ID和评论人ID删除评论
	 * @param pd
	 */
	public void delEducomment(PageData pd)throws Exception ;
		

	

}
