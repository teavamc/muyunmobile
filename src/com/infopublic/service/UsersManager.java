package com.infopublic.service;

import java.util.List;

import com.infopublic.entity.Page;
import com.infopublic.entity.Users;
import com.infopublic.util.PageData;


/** 用户接口类
 */
public interface UsersManager {
	
	/**登录判断
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public Users getUserByNameAndPwd(PageData pd)throws Exception;
	
	
	
	/**登陆名是否存在判断
	 * @param String
	 * @return String
	 * @throws Exception
	 */
	public String checkLoginid(String loginid)throws Exception;
	
	
	/**openid是否存在判断
	 * @param String
	 * @return String
	 * @throws Exception
	 */
	public String checkOpenid(String wcid)throws Exception;   
	
	/**判断党员是否登陆 没登陆则过滤
	 * @param String
	 * @return String
	 * @throws Exception
	 */
	public String getloginidByopenid(String wcid)throws Exception;  
	
	
	/**通过useid获取数据
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public Users findByUserid(PageData pd)throws Exception;
	
	/**通过openid获取数据
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public Users findByOpenid(String wcid)throws Exception;

	
	/**用户换绑  根据uid
	 * @param pd
	 * @throws Exception
	 */
	public void changephone(PageData pd)throws Exception;
	
	/**修改用户   根据wcid
	 * @param pd
	 * @throws Exception
	 */
	public void editU(PageData pd)throws Exception;
	
	
	/**修改用户 根据uid
	 * @param pd
	 * @throws Exception
	 */
	public void editUserInfofromuid(PageData pd)throws Exception;
	/**修改用户密码
	 * @param pd
	 * @throws Exception
	 */
	public void editPwd(PageData pd)throws Exception;

	/**修改用户账号可用状态
	 * @param pd
	 * @throws Exception
	 */
	public void editIsenabled(PageData pd)throws Exception;
	/**修改用户是否党员
	 * @param pd
	 * @throws Exception
	 */
	public void editisparty(PageData pd)throws Exception;
	
	/**添加用户
	 * @param pd
	 * @throws Exception
	 */
	public void insertUser(PageData pd)throws Exception;


	
}
