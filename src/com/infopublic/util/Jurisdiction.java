package com.infopublic.util;

import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;

import com.infopublic.entity.Menu;

/**
 * 权限处理
*/
public class Jurisdiction {

	/**
	 * 访问权限及初始化按钮权限(控制按钮的显示 增删改查)
	 * @param menuUrl  菜单路径
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static boolean hasJurisdiction(String menuUrl){
		//判断是否拥有当前点击菜单的权限（内部过滤,防止通过url进入跳过菜单权限）
		/**
		 * 根据点击的菜单的xxx.do去菜单中的URL去匹配，当匹配到了此菜单，判断是否有此菜单的权限，没有的话跳转到404页面
		 * 根据按钮权限，授权按钮(当前点的菜单和角色中各按钮的权限匹对)
		 */
		String loginid = getLoginid();	//获取当前登录者登录名
		Session session = getSession();
		List<Menu> menuList = (List<Menu>)session.getAttribute(loginid + Const.SESSION_allmenuList); //获取菜单列表
		return readMenu(menuList,menuUrl,session,loginid);
	}
	
	/**校验菜单权限并初始按钮权限用于页面按钮显示与否(递归处理)
	 * @param menuList:传入的总菜单(设置菜单时，.do前面的不要重复)
	 * @param menuUrl:访问地址
	 * @return
	 */
	public static boolean readMenu(List<Menu> menuList,String menuUrl,Session session,String loginid){
		for(int i=0;i<menuList.size();i++){
			if(menuList.get(i).getMurl().split(".do")[0].equals(menuUrl.split(".do")[0])){ //访问地址与菜单地址循环匹配，如何匹配到就进一步验证，如果没匹配到就不处理(可能是接口链接或其它链接)
				if(!menuList.get(i).isHasMenu()){				//判断有无此菜单权限
					return false;  //没有					
				}
			}else{
				if(!readMenu(menuList.get(i).getSubMenu(),menuUrl,session,loginid)){//继续排查其子菜单
					return false;
				}
			}
		}
		return true;
	}
	
	
	/**获取当前登录的用户名
	 * @return
	 */
	public static String getUsername(){
		return getSession().getAttribute(Const.SESSION_USERNAME).toString();
	}
	/**获取当前登录的登陆名
	 * @return
	 */
	public static String getLoginid(){
		return getSession().getAttribute(Const.SESSION_LOGINID).toString();
	}
	/**获取当前登录的用户编号
	 * @return
	 */
	public static String getUserid(){
		return getSession().getAttribute(Const.SESSION_USERID).toString();
	}
	/**获取当前登录的用户角色
	 * @return
	 */
	public static String getUserRid(){
		return getSession().getAttribute(getLoginid() +Const.SESSION_USERROLEID).toString();
	}
//	/**获取当前登录的用户的所属区域编号
//	 * @return
//	 */
//	public static String getUserAid(){
//		User user =(User)getSession().getAttribute(Const.SESSION_USER);
//		return user.getAid();
//	}

	
	/**shiro管理的session
	 * @return
	 */
	public static Session getSession(){
		return SecurityUtils.getSubject().getSession();
	}


}
