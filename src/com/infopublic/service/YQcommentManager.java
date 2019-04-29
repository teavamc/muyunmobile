package com.infopublic.service;

import java.util.List;

import com.infopublic.entity.TbFeedback;
import com.infopublic.entity.TbGroup;
import com.infopublic.entity.TbPartycircle;
import com.infopublic.entity.TbPccomment;
import com.infopublic.entity.TbYqcomment;
import com.infopublic.util.PageData;

/**
 * 舆情评论接口类
 * @author yxy
 *
 */
public interface YQcommentManager {
	
	/**
	 * 根据舆情ID查找评论信息
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<TbYqcomment> getYqcomment(PageData pd)throws Exception;
	
	/**
	 * 根据舆情评论id查找评论具体信息
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public TbYqcomment getYqccontent(PageData pd)throws Exception;
	
	/**
	 * 增加评论信息
	 * @param pd
	 */
	public void addYqcomment(PageData pd)throws Exception ;
	
	/**
	 * 根据舆情ID和评论人ID删除评论
	 * @param pd
	 */
	public void delYqcomment(PageData pd)throws Exception ;
		

	

}
