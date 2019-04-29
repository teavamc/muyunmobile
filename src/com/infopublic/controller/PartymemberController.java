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

import com.infopublic.entity.TbPartymember;
import com.infopublic.entity.Users;
import com.infopublic.service.PartymemberManager;
import com.infopublic.service.UsersManager;
import com.infopublic.util.AppUtil;
import com.infopublic.util.Const;
import com.infopublic.util.Jurisdiction;
import com.infopublic.util.PageData;
import com.infopublic.util.Tools;

/**
 * 验证党员模块
 * @author yxy
 *
 */
@Controller
@RequestMapping("/partymember")   
public class PartymemberController extends BaseController{
	@Resource(name="partymemberService")
	private PartymemberManager partymemberService;
	@Resource(name="usersService")
	private UsersManager usersService;
	
	// 验证党员身份(第一步)
	@RequestMapping(value = "/checkpatrymember", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Object yanzhengpatrymember() throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String result = "";
		String pidcard = pd.getString("pidcard").toString();
		if (null != pidcard && !("".equals(pidcard))) {
			String pname = partymemberService.yanzhengpartymember(pidcard);
			if (pname != null && !("".equals(pname))) {
				Integer uid=((TbPartymember)partymemberService.getpartyinfofromidcard(pidcard)).getUid();
				if(uid ==null || "".equals(uid)){
				Session session = Jurisdiction.getSession();
				result = pname;
				session.setAttribute(Const.SESSION_partymembername, pname); // 将党员姓名存入session
				session.setAttribute(Const.SESSION_partymemberpidcard, pidcard); // 将党员身份证存入session
				}else{
					result="uidisuse";  //党员已被验证
				}
			} else {
				result = "partymembererror";
			}
		} else {
			result = "nullerror";
		}
		map.put("result", result);
		return AppUtil.returnObject(new PageData(), map);
	}
	
	// 党员账号绑定第三步(修改用户属性)
	@RequestMapping(value = "/binduser", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Object binduser() throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String result = "";
		String code = pd.getString("code");  //验证码
		String openid = pd.getString("openid");  //微信唯一凭证
		String loginid = pd.getString("phonenumber");  //登录名
		String pname = pd.getString("pname");  //姓名
		String password = pd.getString("password");  //密码
		String pidcard = pd.getString("pidcard");  //身份证号码
		String phonenumber = pd.getString("phonenumber");  //手机号
		// 进行修改
		String passwd = new SimpleHash("SHA-1", loginid, password).toString(); // 密码加密
		pd.put("wcid", openid);
		pd.put("loginid", loginid);
		pd.put("uname", pname);
		pd.put("password", passwd);
		pd.put("idcard", pidcard);
		pd.put("isparty", 1);
		pd.put("phone", phonenumber);
		String judgeloginid = usersService.checkLoginid(loginid);   //根据登录名查找是否存在该登录名
		
		if(code==null || "".equals(code) ){
			result="nocode"; //验证码为空
		}
		else{
			Session session=Jurisdiction.getSession();
			String truecode=(String) session.getAttribute(Const.SESSION_SECURITY_CODE);
			if(truecode.equalsIgnoreCase(code)&&Tools.notEmpty(truecode)){ 
				if (Tools.isEmpty(judgeloginid)) { // 用户名没被使用
					String uid=usersService.checkOpenid(openid);//根据wcid找到该用户uid
					pd.put("uid",uid);
					usersService.editUserInfofromuid(pd);// 根据uid修改用户
					partymemberService.edituid(pd); // 根据idcard修改党员表中的用户账号uid属性，电话号码属性，wcid属性
					result = "success";
				} else {
					result = "nameerror";
				}
			}
			else{
				result = "codeerror";  //验证码错误
			}
		}
		map.put("result", result);
		return AppUtil.returnObject(new PageData(), map);
	}
	
	// 进入验证党员身份页面
	@RequestMapping(value = "/yanzhengpartymem")
	public ModelAndView yanzhengpartymem() {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); // 读取系统名称
		mv.setViewName("register/yanzhengpartymem");
		mv.addObject("pd", pd);
		return mv;
	}

	// 进入绑定党员账号页面（第二步界面）
	@RequestMapping(value = "/yanzhengpartymem2")
	public ModelAndView yanzhengpartymem2() {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); // 读取系统名称
		Session session = Jurisdiction.getSession();
		String pname = (String) session.getAttribute(Const.SESSION_partymembername); // 取出党员姓名
		pd.put("pname", pname);
		mv.setViewName("register/yanzhengpartymem2");
		mv.addObject("pd", pd);
		return mv;
	}
	
	
	
	// 进入绑定党员账号页面（第三步界面）
		@RequestMapping(value = "/yanzhengpartymem3")
		public ModelAndView yanzhengpartymem3() {
			ModelAndView mv = this.getModelAndView();
			PageData pd = new PageData();
			pd = this.getPageData();
			String phone=pd.getString("phone");
			pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); // 读取系统名称
			Session session = Jurisdiction.getSession();
			String pname = (String) session.getAttribute(Const.SESSION_partymembername); // 取出党员姓名
			String pidcard = (String) session.getAttribute(Const.SESSION_partymemberpidcard); // 取出党员身份证
			String openid = (String) session.getAttribute(Const.SESSION_openid); // 取出openid
			if("".equals(openid)){   //session失效跳转  再次获取
				mv.setViewName("mainindex");
			}
			else{
			pd.put("phonenumber", phone);
			pd.put("pname", pname);
			pd.put("pidcard", pidcard);
			pd.put("openid", openid);
			mv.setViewName("register/yanzhengpartymem3");
			mv.addObject("pd", pd);
			}
			return mv;
		}

	// 绑定成功，进入绑定成功界面
	@RequestMapping("yanzhengsuccess")
	public ModelAndView yanzhengsuccess() {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); // 读取系统名称
		mv.setViewName("register/yanzhengsuccess");
		mv.addObject("pd", pd);
		return mv;
	}

	// 访问党员专区
	@RequestMapping("partyzhuanqu")
	public ModelAndView partyzhuanqu() {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); // 读取系统名称
		String registerurl = "http://"+Tools.GetValueByKey(Const.CONFIG, "url")+"qyWeChat/qiyelogin3";
		try {
			Session session = Jurisdiction.getSession();
			Users user = (Users) session.getAttribute(Const.SESSION_USER); // 读取session中的用户信息(单独用户信息)
			if (user != null && user.getIsparty()==1) {
				TbPartymember partyinfo=partymemberService.getpartymemberfromuid(user.getUid().toString());//根据uid拿到党员信息存入Session
				session.setAttribute(Const.SESSION_PARTYINFO, partyinfo);
				mv.setViewName("index/partymain");
				mv.addObject("user", user);
			} else {
				mv.setViewName("redirect:"+registerurl);// session失效后跳转
			}
		} catch (Exception e) {
			mv.setViewName("redirect:"+registerurl);
		}
		mv.addObject("pd", pd);
		return mv;
	}
	
	
		/**
		 * 村事管理
		 * @return
		 */
		@RequestMapping("selecttomanage")
		public ModelAndView selecttomanage() {
			ModelAndView mv = this.getModelAndView();
			PageData pd = new PageData();
			pd = this.getPageData();
			pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); // 读取系统名称
			mv.setViewName("management/selecttomanage");
			return mv;
		}

	
}
