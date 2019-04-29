package com.infopublic.service;

import java.util.List;

import com.infopublic.entity.TbEducation;
import com.infopublic.util.PageData;

/**
 * 在线学习接口类
 * @author zc
 *
 */
public interface EduManager {
	
	/**
	 * 展示学习内容
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<TbEducation> getEdu(PageData pd)throws Exception;
		
	/**
	 * 根据eid展示
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public TbEducation getEduFromeid(PageData pd)throws Exception;
	
	/**
	 * 新增courread点击量
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public TbEducation setEduCourread(PageData pd)throws Exception;

}
