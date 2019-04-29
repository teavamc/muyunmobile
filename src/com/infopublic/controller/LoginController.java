package com.infopublic.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.infopublic.controller.BaseController;
import com.infopublic.service.LogManager;
import com.infopublic.service.MenuManager;
import com.infopublic.service.RoleManager;
import com.infopublic.service.SystemManager;
import com.infopublic.entity.Menu;
import com.infopublic.entity.Users;
import com.infopublic.service.UsersManager;
import com.infopublic.util.AppUtil;
import com.infopublic.util.Const;
import com.infopublic.util.DateUtil;
import com.infopublic.util.Jurisdiction;
import com.infopublic.util.PageData;
import com.infopublic.util.RightsHelper;
import com.infopublic.util.Tools;

@Controller
public class LoginController extends BaseController {

	@Resource(name="usersService")
	private UsersManager usersService;
	@Resource(name="menuService")
	private MenuManager menuService;
	@Resource(name="roleService")
	private RoleManager roleService;
	@Resource(name="logService")
	private LogManager logService;
	@Resource(name="systemService")
	private SystemManager systemService;

	
	/**访问村级新闻
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/mainindex")
	public ModelAndView main_index() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		
		/*Session session=Jurisdiction.getSession();
		String userid = session.getAttribute(Const.SESSION_USERID).toString();		
		*/
		/*mv.addObject("userid",userid);*/
		
		pd = this.getPageData();
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); //读取系统名称
		pd.put("uid", Jurisdiction.getUserid());
		
		//从Session里面拿到 
	    Session session=Jurisdiction.getSession(); //从Session里面拿

	    if((Users)session.getAttribute(Const.SESSION_USER)!=null){
	    	Users user=(Users)session.getAttribute(Const.SESSION_USER);
	    	mv.addObject("user",user);
			mv.addObject("headimg",user.getHeadimg());
			mv.addObject("isparty",user.getIsparty()+"");
	    }else{
	    	Users user = usersService.findByUserid(pd);
	    	mv.addObject("user",user);
			mv.addObject("headimg",user.getHeadimg());
			mv.addObject("isparty",user.getIsparty()+"");
	    }
		
		mv.setViewName("index/mainindex");
		mv.addObject("pd",pd);
		return mv;
	}
	
	
	/**访问党员选择去向
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/selecttogo")
	public ModelAndView selecttogo() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); //读取系统名称
		pd.put("uid", Jurisdiction.getUserid());
		Users user = usersService.findByUserid(pd);
		mv.addObject("user",user);
		mv.addObject("headimg",user.getHeadimg());
		mv.addObject("isparty",user.getIsparty()+"");
		mv.setViewName("index/selectlogin");
		mv.addObject("pd",pd);
	return mv; 
}
	
	/**
	 * 首页注册
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/mainindexfunction")
	@ResponseBody
	public Object mainindexfunction() throws Exception{
		Map<String,String> map=new HashMap<>();
		PageData pd =this.getPageData();
		
		String openid=pd.getString("openid");
		
		String usex="2".equals(pd.getString("sex"))? "女":"男";
		String nickname=pd.getString("nickname");
		String avatar=pd.getString("avatar");
		
		pd.put("wcid",openid.trim());//微信唯一标识
		pd.put("usex", usex);  //性别
		pd.put("headimg", avatar);  //头像
		pd.put("wcname",nickname);   //微信名
		pd.put("uname",nickname);  //姓名（默认）
		//System.out.println(openid+""+sex+""+nickname);
		
		String userid=usersService.checkOpenid(openid);  //判断openid是否已存在（是否已注册）
		Session session=Jurisdiction.getSession();
		if(userid==null){ //不存在 ，自动进行注册  ，并将用户信息放入session
			String regdate=DateUtil.getTime();
			pd.put("regdate", regdate);
			usersService.insertUser(pd);
			Users user=usersService.findByOpenid(openid);
			session.setAttribute(Const.SESSION_openid, openid);			//把用户openid放session中
			session.setAttribute(Const.SESSION_USER, user);			//把用户信息放session中
			session.setAttribute(Const.SESSION_USERID, user.getUid());				//放入用户id到session
			session.setAttribute(Const.SESSION_LOGINID, user.getLoginid());			//把用户登录名放session中
			session.setAttribute(Const.SESSION_USERNAME, user.getUname());			//把用户姓名放session中
			map.put("isparty", user.getIsparty()+"");
			
			//菜单权限
//			String roleRights="";
//			List<Menu> allmenuList = new ArrayList<Menu>();
//			String loginid=user.getLoginid();
//			if(null == session.getAttribute(loginid + Const.SESSION_allmenuList)){	
//				allmenuList = menuService.listAllMenu("0");					//获取所有菜单
//				if(Tools.notEmpty(roleRights)){
//					//目前设置为空（roleRights）
//					allmenuList = this.readMenu(allmenuList, roleRights);		//根据角色权限获取本权限的菜单列表
//				}
//				session.setAttribute(loginid + Const.SESSION_allmenuList, allmenuList);//菜单权限放入session中
//			}else{
//				allmenuList = (List<Menu>)session.getAttribute(loginid + Const.SESSION_allmenuList);
//			}
			
		}
		else{  //存在 ，将用户信息放入session
			Object judge=session.getAttribute(Const.SESSION_partylogin); //判断是否党员登陆
			//System.out.println("judge="+judge);
			if(judge==null){  //登陆Session失效
				Users user=usersService.findByOpenid(openid);
				usersService.editU(pd);//更新用户信息  头像、昵称
				session.setAttribute(Const.SESSION_openid, openid);			//把用户openid放session中
				session.setAttribute(Const.SESSION_USER, user);			//把用户信息放session中
				session.setAttribute(Const.SESSION_USERID, user.getUid());				//放入用户id到session
				session.setAttribute(Const.SESSION_LOGINID, user.getLoginid());			//把用户登录名放session中
				session.setAttribute(Const.SESSION_USERNAME, user.getUname());			//把用户姓名放session中
				map.put("isparty", user.getIsparty()+"");
			}else{
				String judgeparty=judge.toString();
				if("true".equals(judgeparty)){   //党员登陆进入
					try{
				Users user=(Users) session.getAttribute(Const.SESSION_USER);
				session.setAttribute(Const.SESSION_openid, user.getWcid());	//把用户openid放session中
				session.setAttribute(Const.SESSION_USERID, user.getUid());	//放入用户id到session
				session.setAttribute(Const.SESSION_LOGINID, user.getLoginid());	//把用户登录名放session中
				session.setAttribute(Const.SESSION_USERNAME, user.getUname());			//把用户姓名放session中
				map.put("isparty", user.getIsparty()+"");	
					}catch(Exception e){
						session.removeAttribute(Const.SESSION_partylogin);
						map.put("sessionno", "sessionno");
					}
				}	
			//菜单权限
//			String roleRights="";
//			List<Menu> allmenuList = new ArrayList<Menu>();
//			String loginid=user.getLoginid();
//			if(null == session.getAttribute(loginid + Const.SESSION_allmenuList)){	
//				allmenuList = menuService.listAllMenu("0");					//获取所有菜单
//				if(Tools.notEmpty(roleRights)){
//					//目前设置为空（roleRights）
//					allmenuList = this.readMenu(allmenuList, roleRights);		//根据角色权限获取本权限的菜单列表
//				}
//				session.setAttribute(loginid + Const.SESSION_allmenuList, allmenuList);//菜单权限放入session中
//			}else{
//				allmenuList = (List<Menu>)session.getAttribute(loginid + Const.SESSION_allmenuList);
//			}
			}
		}
		return AppUtil.returnObject(pd, map);
		
	}
	
	
	/**根据菜单权限获取本权限的菜单列表(递归处理)
	 * @param menuList：传入的总菜单
	 * @param menuRights：权限字符串
	 * @return
	 */
	public List<Menu> readMenu(List<Menu> menuList,String menuRights){
		for(int i=0;i<menuList.size();i++){
			menuList.get(i).setHasMenu(RightsHelper.testRights(menuRights, menuList.get(i).getMid()));
			this.readMenu(menuList.get(i).getSubMenu(), menuRights);					//是：继续排查其子菜单
		}
		return menuList;
	}
	

	/**访问登录页
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/login_toLogin")
	public ModelAndView toLogin()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); //读取系统名称
//		pd.put("SYSNAME", systemService.getBaseAttri("系统名称")); //读取系统名称
		pd.put("SYSOWNER", systemService.getBaseAttri("系统所有者")); 
		pd.put("time", "code.do?t="+new Date().getTime());
		mv.setViewName("index/login");
		mv.addObject("pd",pd);
		return mv;
	}
	
	/**请求登录，验证用户
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/login_login" ,produces="application/json;charset=UTF-8")
	@ResponseBody
	public Object login()throws Exception{
		System.out.println("开始登陆");
		Map<String,String> map = new HashMap<String,String>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String errInfo = "";
		String KEYDATA[] = pd.getString("KEYDATA").replaceAll("infopublic", "").split(",info,");
		if(null != KEYDATA && KEYDATA.length == 3){
			Session session = Jurisdiction.getSession();
			String sessionCode = (String)session.getAttribute(Const.SESSION_SECURITY_CODE);		//获取session中的验证码
			String code = KEYDATA[2];
			if(null == code || "".equals(code)){//判断效验码
				errInfo = "nullcode"; 			//效验码为空
			}else{
				String username = KEYDATA[0];	//登录过来的登录名
				String password  = KEYDATA[1];	//登录过来的密码
				pd.put("loginid", username);
				Users user = new Users();
				if(Tools.notEmpty(sessionCode) && sessionCode.equalsIgnoreCase(code)){//判断登录验证码
					
					String passwd = new SimpleHash("SHA-1", username, password).toString();	//密码加密
					//String passwd2 = MD5.md5(username+ password).toString();	//密码加密		
					pd.put("password", passwd);
					user = usersService.getUserByNameAndPwd(pd);	//根据登录名和密码去读取用户信息
					if(user != null){
						//System.out.println(user.getIsuse());
//						if(user.getIsuse().equals("0")){
						session.removeAttribute(Const.SESSION_SECURITY_CODE);	//清除登录验证码的session
						//shiro加入身份验证
						Subject subject = SecurityUtils.getSubject(); 
					    UsernamePasswordToken token = new UsernamePasswordToken(username, password); 
					    try { 
					        subject.login(token); 
					    } catch (AuthenticationException e) { 
					    	errInfo = "身份验证失败！";
					    }
//						}
//						else{
//							errInfo="loginderror";  //已经在其他设备登陆
//						}
					}else{
						errInfo = "usererror"; 				//用户名或密码有误
					}
				}else{
					errInfo = "codeerror";				 	//验证码输入有误
				}
				if(Tools.isEmpty(errInfo)){
					errInfo = "success";					//验证成功
					//党员点击登陆进入  设置session
					session.setAttribute(Const.SESSION_partylogin, "true");
					session.setAttribute(Const.SESSION_USER, user);  //将登陆信息放入session
					session.setAttribute(Const.SESSION_USERID, user.getUid());				//放入用户id到session
					session.setAttribute(Const.SESSION_LOGINID, user.getLoginid());			//把用户登录名放session中
					session.setAttribute(Const.SESSION_USERNAME, user.getUname());			//把用户姓名放session中
					
				}
			}
		}else{
			errInfo = "error";	//缺少参数
		}
		map.put("result", errInfo);
		return AppUtil.returnObject(new PageData(), map);
	}

	/**
	 * 用户注销
	 * @param session
	 * @return
	 */
	@RequestMapping(value="/logout")
	public ModelAndView logout(){
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		Session session = Jurisdiction.getSession();	//以下清除session缓存
		session.removeAttribute(Const.SESSION_USER);
		session.removeAttribute(Const.SESSION_LOGINID);
		session.removeAttribute(Const.SESSION_partylogin);
		session.removeAttribute("changeMenu");
		//shiro销毁登录
		Subject subject = SecurityUtils.getSubject(); 
		subject.logout();
		pd = this.getPageData();
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); //读取系统名称
		pd.put("time", "code.do?t="+new Date().getTime());
		mv.setViewName("index/login");
		mv.addObject("pd",pd);
		return mv;
	}
	

	
}
