package com.infopublic.service;

import java.util.List;

import com.infopublic.entity.TbFeedback;
import com.infopublic.entity.TbGroup;
import com.infopublic.entity.TbPartycircle;
import com.infopublic.util.PageData;

/**
 * 暮云圈接口类
 * @author yxy
 *
 */
public interface PCircleManager {
	
	/**
	 * 展示全部信息
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<TbPartycircle> getCircle(PageData pd)throws Exception;
	
	
	/**
	 * 展示个人全部信息
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<TbPartycircle> getCircleByUid(PageData pd)throws Exception;
	
	
	/**
	 * 根据敏感评论数目由多到少展示全部信息
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<TbPartycircle> getCircleOderBysennum(PageData pd)throws Exception;
	
	/**
	 * 根据pcid查询敏感数目
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public Integer getSenTotalBypcid(PageData pd)throws Exception;
	
	
	/**
	 * 限制用户提交   一小时间隔
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<TbPartycircle> getPcircleDateFromuid(PageData pd)throws Exception;
	
	/**
	 * 新增
	 */
	public void insertPcircle(PageData pd)throws Exception;
	
	/**
	 * 删除
	 */
	public void deletecircle(PageData pd)throws Exception;
	

	/**
	 * 敏感数目修改
	 */
	public void updatesennum(PageData pd)throws Exception;
	
}
