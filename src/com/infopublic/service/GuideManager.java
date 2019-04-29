package com.infopublic.service;

import java.util.List;

import com.infopublic.entity.TbGuide;
import com.infopublic.entity.TbJob;
import com.infopublic.util.PageData;


public interface GuideManager {
	
	/**
	 * 根据浏览次数和发布时间的降序展示指南列表
	 */
	public List<TbGuide> getGuideFromGreadtotal(PageData pd)throws Exception;
	
	/**
	 * 根据浏览次数和发布时间的降序展示有效指南列表
	 */
	public List<TbGuide> getGuideFromGreadtotalbyremark(int Remark)throws Exception;
	
	/**
	 * 所有有效指南列表
	 */
	public List<TbGuide> getGuidebyremark(int remark)throws Exception;//根据公告是否有效查询
	
	
	/**
	 * 有效指南列表数量
	 */
	public int totalallbyremark(int remark) throws Exception; //根据是否有效查询职位数量
		
	/**
	 * 根据 标题 或 类别 模糊查询指南
	 */
	public List<TbGuide> getGuideFromTitleOrType(PageData pd)throws Exception;

	/**
	 * 根据ID查询指南具体内容
	 */
	public TbGuide getGuideFromguid(PageData pd)throws Exception;


	/**
	 * 修改浏览次数
	 */
	public void updatereadtotal(PageData pd)throws Exception;
	
	
	

}
