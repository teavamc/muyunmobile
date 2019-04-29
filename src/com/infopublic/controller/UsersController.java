package com.infopublic.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.session.Session;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.infopublic.entity.Users;
import com.infopublic.service.LogManager;
import com.infopublic.service.MenuManager;
import com.infopublic.service.PartymemberManager;
import com.infopublic.service.RoleManager;
import com.infopublic.service.UsersManager;
import com.infopublic.util.AppUtil;
import com.infopublic.util.Const;
import com.infopublic.util.Jurisdiction;
import com.infopublic.util.PageData;
import com.infopublic.util.Tools;


/** 
 * 用户区
 * 类名称：UsersController
 * @version
 */
@Controller
@RequestMapping(value="/users")
public class UsersController extends BaseController {
	
	@Resource(name="usersService")
	private UsersManager usersService;
	@Resource(name="roleService")
	private RoleManager roleService;
	@Resource(name="menuService")
	private MenuManager menuService;
	@Resource(name="logService")
	private LogManager logService;
	@Resource(name="partymemberService")
	private PartymemberManager partymemberService;
	
	/**
	 *  个人中心
	 */
	@RequestMapping(value="/showuserinfo") 
	@ResponseBody
	public ModelAndView userinfo() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); //读取系统名称
		pd.put("uid", Jurisdiction.getUserid());
		Users user = usersService.findByUserid(pd);
		mv.addObject("headimg",user.getHeadimg());
		mv.addObject("user",user);
		mv.addObject("pd", pd);
		mv.setViewName("user/userinfo");
		return mv;
	}
	
	
	/**去修改用户信息界面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/edituser")
	public ModelAndView editUser() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); //读取系统名称
		pd.put("uid", Jurisdiction.getUserid());
		Users user = usersService.findByUserid(pd);						//根据ID读取
		mv.setViewName("user/edituserinfo");
		mv.addObject("user", user);
		mv.addObject("pd", pd);
		return mv;
	}
	/**
	 * 修改用户个人信息
	 */
	@RequestMapping(value="/editU")
	@ResponseBody
	public Object editU() throws Exception{
		Map<String,String> map = new HashMap<String,String>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String usex=pd.getString("usersex");
		String userid=pd.getString("userid");
		String phone=pd.getString("uphone");
		String isparty="党员".equals(pd.getString("isparty"))? "1" : "0";
		pd.put("isparty", isparty);
		pd.put("usex", usex);
		pd.put("phone", phone);
		//System.out.println(usex+"");
		if(!("".equals(userid))){
		System.out.println("进入修改");
		usersService.editUserInfofromuid(pd);	//执行修改
		map.put("result","success");
		}
		else{
		map.put("result","error");
		}
		return AppUtil.returnObject(pd, map);
	}

	/**
	 * 换绑手机
	 */
	@RequestMapping(value="/changphone")
	@ResponseBody
	public Object changuidphone() throws Exception{
		Map<String,String> map = new HashMap<String,String>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String loginid = pd.getString("loginid");  //登录名
		String password = pd.getString("password");  //密码
		String phonenumber = pd.getString("loginid");  //手机号
		//System.out.println(loginid+""+password+""+phonenumber+"");
		String uid=Jurisdiction.getUserid();
		pd.put("uid",uid);
		pd.put("loginid", loginid);
		String pwd =new SimpleHash("SHA-1",loginid, password).toString();
		pd.put("password",pwd);
		pd.put("phone", phonenumber);
		try {
		Session session = Jurisdiction.getSession();
		Users user = (Users)session.getAttribute(Const.SESSION_USER);	//读取session中的用户信息
		if(user.getIsparty()!=0){ //是党员
		partymemberService.changephone(pd);//根据uid 修改党员表中电话号码
		usersService.changephone(pd);//根据uid 修改用户表 登录名 密码 手机号
		map.put("result", "success");
		}else{
			map.put("result", "error");
		}
			} catch (Exception e) {//不做操作 
		}
		return map;
	}
	
	/**
	 * 去换绑页面
	 * @return ModelAndView
	 */
	@RequestMapping(value="/pwdedit")
	public ModelAndView goEditPassword() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); //读取系统名称
		try {
			Session session = Jurisdiction.getSession();
			Users user = (Users)session.getAttribute(Const.SESSION_USER);	//读取session中的用户信息
			mv.setViewName("user/pwd");
			mv.addObject("pd", pd);
			mv.addObject("msg", "editPassword");
			mv.addObject("user", user);
		} catch (Exception e) {
			mv.setViewName("index/mainindex");
		}	
		return mv;
	}
	
//	//判断密码正确性
//	@RequestMapping(value="/edijudge")
//	@ResponseBody
//	public Object edijudge() throws Exception{
//		Map<String,String> map = new HashMap<String,String>();
//		PageData pd = new PageData();
//		pd = this.getPageData();
//		String loginid=pd.getString("loginid");
//		String password=pd.getString("password");
//		String pwd=new SimpleHash("SHA-1",loginid, password).toString();//密码加密
//		Users user = new Users();
//		pd.put("username", loginid);
//		pd.put("password", pwd);
//		user = usersService.getUserByNameAndPwd(pd);
//		if(user!=null){
//		map.put("result","success");
//		}
//		else{
//		map.put("result","pwderror");
//		}
//		return map;
//	}
//	
//	/**
//	 * 修改用户密码
//	 */
//	@RequestMapping(value="/editPassword")
//	@ResponseBody
//	public Object editPassword() throws Exception{
//		Map<String,String> map = new HashMap<String,String>();
//		PageData pd = new PageData();
//		pd = this.getPageData();
//		pd.put("password", new SimpleHash("SHA-1",Jurisdiction.getLoginid(), pd.getString("newpassword")).toString());
//		pd.put("userid", Jurisdiction.getUserid());
//		if(!Jurisdiction.getUserid().equals("")){
//		usersService.editPwd(pd);
//		map.put("result","success");
//		}
//		else{
//			map.put("result","edpwderror");
//		}
//		return map;
//	}

	
	
	
	
}
