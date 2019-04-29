package com.infopublic.service.impl;


import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.infopublic.dao.DaoSupport;
import com.infopublic.entity.Users;
import com.infopublic.util.PageData;
import com.infopublic.service.UsersManager;


/** 
 * 系统管理用户
 */
@Service("usersService")
public class UsersService implements UsersManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**登录判断
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	@Override
	public Users getUserByNameAndPwd(PageData pd)throws Exception{
		Users user =(Users)dao.findForObject("UsersMapper.getUserByNameAndPwd", pd);
		return user;
	}
	/**登陆名是否存在判断
	 * @param loginid
	 * @return
	 * @throws Exception
	 */
	@Override
	public String checkLoginid(String loginid)throws Exception{
		return (String)dao.findForObject("UsersMapper.getUseridByLoginid", loginid);
	}
	
	
	@Override
	public String checkOpenid(String wcid) throws Exception {
		return (String)dao.findForObject("UsersMapper.getUseridByopenid", wcid);
	}
	
	/**用户注册
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void insertUser(PageData pd)throws Exception{
		dao.save("UsersMapper.insertUser", pd);
	}
	/**通过useid获取数据
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	@Override
	public Users findByUserid(PageData pd)throws Exception{
		return (Users)dao.findForObject("UsersMapper.findByUserid", pd);
	}

	/**修改用户
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void editU(PageData pd)throws Exception{
		dao.update("UsersMapper.editUserInfo", pd);
	}
	/**修改用户密码
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void editPwd(PageData pd) throws Exception {
		dao.update("UsersMapper.editUserPwd", pd);
	}


	/**修改用户账号可用状态
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void editIsenabled(PageData pd) throws Exception {
		dao.update("UsersMapper.editIsenabled", pd);
	}


	@Override
	public void editisparty(PageData pd) throws Exception {
		dao.update("UsersMapper.editisparty", pd);
	}
	@Override
	public Users findByOpenid(String wcid) throws Exception {
		return (Users)dao.findForObject("UsersMapper.findByOpenid", wcid);
	}
	@Override
	public String getloginidByopenid(String wcid) throws Exception {
		return (String) dao.findForObject("UsersMapper.getloginidByopenid", wcid);
	}
	@Override
	public void editUserInfofromuid(PageData pd) throws Exception {
		dao.update("UsersMapper.editUserInfofromuid", pd);
		
	}
	@Override
	public void changephone(PageData pd) throws Exception {
		dao.update("UsersMapper.changephone", pd);
		
	}
	
}
