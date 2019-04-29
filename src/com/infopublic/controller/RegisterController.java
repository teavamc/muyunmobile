package com.infopublic.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.session.Session;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.infopublic.controller.BaseController;
import com.infopublic.service.LogManager;
import com.infopublic.service.MenuManager;
import com.infopublic.service.UsersManager;
import com.infopublic.util.AppUtil;
import com.infopublic.util.Const;
import com.infopublic.util.Jurisdiction;
import com.infopublic.util.PageData;
import com.infopublic.util.Tools;
import com.infopublic.util.WeixinUtil;
import com.infopublic.weixin.pojo.AccessToken;

@Controller
@RequestMapping(value="/register")
public class RegisterController extends BaseController {

	@Resource(name="usersService")
	private UsersManager usersService;
	@Resource(name="menuService")
	private MenuManager menuService;
	@Resource(name="logService")
	private LogManager logService;
	/**访问注册页
	 * @param request 
	 * @return
	 * @throws Exception
	 */
	
	
		//进入选择注册页面  微信用到
		@RequestMapping(value="/selectlogin")
		public ModelAndView selectlogin(HttpServletRequest request){
			ModelAndView mv = this.getModelAndView();
			PageData pd = new PageData();
			pd = this.getPageData();
			pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); //读取系统名称
			
			/**
			 *  1 第一步：用户同意授权，获取code
			 */
			//首先拿到微信公众号的AppID、AppSecret等参数
			
			//如果用户授权成功则跳转到此url
			String registerurl = "http://"+Tools.GetValueByKey(Const.CONFIG, "url")+"register/getAccessToken";
	
			//用户授权，获取code
			String url = "https://open.weixin.qq.com/connect/oauth2/authorize?"
						+ "appid="+Tools.GetValueByKey(Const.CONFIG, "APP_ID")+""
						+ "&redirect_uri="+registerurl+""
						+ "&response_type=code"
						+ "&scope=snsapi_userinfo"
						+ "&state=1#wechat_redirect";
	
			mv.setViewName("redirect:"+url);	
			mv.addObject("pd",pd);
			return mv; 
		}
	

//	//进入选择注册页面 项目开发测试用到 
//	@RequestMapping(value="/selectlogin")
//	public ModelAndView selectlogin(HttpServletRequest request){
//		ModelAndView mv = this.getModelAndView();
//		PageData pd = new PageData();
//		pd = this.getPageData();
//		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); //读取系统名称
//	mv.setViewName("register/selectlogin");	
//	mv.addObject("pd",pd);
//	return mv; 
//}
	//测试进入注册界面
	@RequestMapping(value="/toregister")
	public ModelAndView toregister(){
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); //读取系统名称
		mv.setViewName("register/register");
		mv.addObject("pd",pd);
		return mv; 
	}
	
	/**
	 * 通过code换取网页授权access_token
	 * @Title: getAccessToken
	 * @param @param request
	 * @param @param response
	 * @param @param model
	 * @param @return
	 * @return String
	 * @throws xinz
	 */
	//微信用到
	@RequestMapping("getAccessToken")
	public ModelAndView getAccessToken(HttpServletRequest request,HttpServletResponse response,Model model) {
		ModelAndView mv = this.getModelAndView();
		//获取到返回的参数
		try {
			//首先拿到微信公众号的AppID、AppSecret等参数
			
			String code = request.getParameter("code");
			//System.out.println("code=="+code);
			String url = null;
			if(code!=null){
				/**
				 *  2 第二步：通过code换取网页授权access_token
				 */
				//用户授权，获取code
				url = "https://api.weixin.qq.com/sns/oauth2/access_token?"
						+ "appid="+Tools.GetValueByKey(Const.CONFIG, "APP_ID")+""
						+ "&secret="+Tools.GetValueByKey(Const.CONFIG, "APPSECRET")+""
						+ "&code="+code+""
						+ "&grant_type=authorization_code";
				//System.out.println("url=="+url);
				String requestMethod = "GET";
				String outputStr = "";
				JSONObject httpRequest = WeixinUtil.httpRequest(url, requestMethod, outputStr);
				
				AccessToken accessToken  = new AccessToken();  
                accessToken.setAccess_token(httpRequest.get("access_token").toString());  
                accessToken.setExpires_in(httpRequest.getInt("expires_in"));  
                accessToken.setOpenid(httpRequest.get("openid").toString());
                accessToken.setScope(httpRequest.get("scope").toString());
                /**
				 *  4 第四步：拉取用户信息(需scope为 snsapi_userinfo)
				 */	                                                                      
				//用户授权，获取code
				String urlUser = "https://api.weixin.qq.com/sns/userinfo?"
						+ "access_token="+accessToken.getAccess_token()+""
						+ "&openid="+accessToken.getOpenid()+""
						+ "&lang=zh_CN";
				//System.out.println("urlUser=="+urlUser);
				
				JSONObject httpUser = WeixinUtil.httpRequest(urlUser, requestMethod, outputStr);
				
				mv.addObject("webchatUser", httpUser);
				mv.addObject("shouquan","shouquan");  //以此判断是否是授权而到的首页界面
				//mv.addObject("weixin","weixin");   //以此判断是微信进入而非企业微信进入
				PageData pd = new PageData();
				pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); //读取系统名称
				mv.addObject("pd",pd);
				mv.setViewName("index/mainindex");
				/**
				 *  5 附：检验授权凭证（access_token）是否有效
				 */
				JSONObject checkAccessToken = WeixinUtil.checkAccessToken(accessToken.getAccess_token(), accessToken.getOpenid());
				if(checkAccessToken.getString("errcode").equals("0")){
					mv.setViewName("index/mainindex");
				}else{
					//如果access_token失效，则再次进行调用，并存储access_token值，access_token有效期为2个小时
					this.selectlogin(request); 
				}
			}
		} catch (Exception e) {
			System.out.println("===拉取用户出错===");
			e.printStackTrace();
		}
		return mv; 
	}
	

	/**注册成功
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/success")
	public ModelAndView success(){
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); //读取系统名称
		mv.setViewName("register/success");
		mv.addObject("pd",pd);
		return mv; 
	}
	
	
	
	
	
	/**请求注册
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/register" )
	@ResponseBody
	public Object register(){

		Map<String,String> map = new HashMap<String,String>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String errInfo = "";
		String loginid = pd.getString("registername");
		String password = pd.getString("password");
		String code = pd.getString("code");
		//微信登陆用到
	//	String openid = pd.getString("openid");
	//	String nickname = pd.getString("nickname");	
	//	String sex = pd.get("sex").toString().equals("1")?"男":( pd.get("sex").toString().equals("2")?"女":"");
		
		//微信登陆用到if(null != username && code!=null&&openid!=null&&!openid.equals("")){
			if(null != loginid && code!=null){
			Session session = Jurisdiction.getSession();
			String sessionCode = (String)session.getAttribute(Const.SESSION_SECURITY_CODE);		//获取session中的验证码
			if(null == code || "".equals(code)){//判断效验码
				errInfo = "nullcode"; 			//效验码为空
			}else{
				pd.put("username", loginid);

				if(Tools.notEmpty(sessionCode) && sessionCode.equalsIgnoreCase(code)){		//判断登录验证码
					String passwd = new SimpleHash("SHA-1", loginid, password).toString();	//密码加密

					pd.put("password", passwd);
					
					//设置其他默认字段
					String userid = this.get32UUID();
					pd.put("userid", userid);
					pd.put("loginid", loginid); //loginid是登录名无法更改，以后修改时只能修改用户名
	//微信登陆用到	pd.put("openid", openid);
	//微信登陆用到	pd.put("webchat", nickname);
	//微信登陆用到	pd.put("usex", sex);
		
						try {
							usersService.insertUser(pd);
						} catch (Exception e) {
							errInfo = "adderror";
							e.printStackTrace();
						}
						session.setAttribute(Const.SESSION_USERID, userid);

					
				}else{
					errInfo = "codeerror";				 	//验证码输入有误
				}

				if(Tools.isEmpty(errInfo)){
					errInfo = "success";					//验证成功
					logBefore(logger, loginid+"register success");
				}
			}
		}else{
			errInfo = "error";	//缺少参数
			logBefore(logger, errInfo+"缺少参数");
		}
		map.put("result", errInfo);
		return AppUtil.returnObject(new PageData(), map);
	}
	/**判断用户名是否存在
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/checkUsername" ,produces="application/json;charset=UTF-8")
	@ResponseBody
	public Object checkUsername()throws Exception{
		Map<String,String> map = new HashMap<String,String>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String result="";
		String username = pd.getString("registername").toString();
		if(null != username && username!=""){
//				pd.put("username", username);
				String userid = usersService.checkLoginid(username);	
				if(userid!=null && !userid.equals("")){
					result ="nameerror";
				}else{
					result ="success";
				}
		}else{
			result ="nullerror";
		}
		
		map.put("result", result);
		return AppUtil.returnObject(new PageData(), map);
	}
	
}

