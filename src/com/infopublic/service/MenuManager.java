package com.infopublic.service;

import java.util.List;

import com.infopublic.entity.Menu;
import com.infopublic.util.PageData;


/**说明：MenuService 菜单处理接口
 */
public interface MenuManager {

	/**
	 * @param parentId
	 * @return
	 * @throws Exception
	 */
	public List<Menu> listSubMenuByParentId(String parentId)throws Exception;
	
	/**
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData getMenuById(PageData pd) throws Exception;
	
	
	/**
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findMaxId(PageData pd) throws Exception;
	
	/**
	 * @param mid
	 * @return
	 * @throws Exception
	 */
	public List<Menu> listAllMenu(String mid) throws Exception;
	
}
