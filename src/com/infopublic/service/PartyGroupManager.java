package com.infopublic.service;

import java.util.List;

import com.infopublic.entity.TbFeedback;
import com.infopublic.entity.TbGroup;
import com.infopublic.util.PageData;

/**
 * 党小组接口类
 * @author yxy
 *
 */
public interface PartyGroupManager {
	
	/**
	 * 根据gid党小组信息
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public TbGroup getGroupByGid(PageData pd)throws Exception;
		
	/**
	 * 根据uid党小组信息
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public TbGroup getGroupByuid(PageData pd)throws Exception;
	
	

	

}
