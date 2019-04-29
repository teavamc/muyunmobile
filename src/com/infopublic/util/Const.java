package com.infopublic.util;

import org.springframework.context.ApplicationContext;
/**
 * 项目名称：
*/
public class Const {
	public static final String SESSION_openid = "openid";//openid
	public static final String SESSION_partymembername = "partymembername";//党员姓名
	public static final String SESSION_partymemberpidcard = "partymemberpidcard";//党员身份证
	public static final String SESSION_partylogin = "false";//党员是否登陆进入
	public static final String SESSION_SECURITY_CODE = "sessionSecCode";//验证码
	public static final String SESSION_phone_CODE = "phonecode";//手机验证码
	public static final String SESSION_USER = "sessionUser";			//session用的用户
	public static final String SESSION_PARTYINFO = "PARTYINFO";			//session用的党员信息
	public static final String SESSION_MENU_RIGHTS = "sessionMenuRights";
//	public static final String sSESSION_ROLE_RIGHTS = "sessionRoleRights";
	public static final String SESSION_menuList = "menuList";			//当前菜单
	public static final String SESSION_allmenuList = "allmenuList";		//全部菜单
	public static final String SESSION_nousermenuList = "nousermenuList";//未登录时的菜单		
	public static final String SESSION_USERID = "USERID";				//用户对象
	public static final String SESSION_USERNAME = "USERNAME";			//用户名
	public static final String SESSION_LOGINID = "LOGINID";			//登陆名
	public static final String SESSION_USERROLEID = "USERROLEID";			//用户角色
	public static final String SESSION_USERAREALIST = "USERAREALIST";			//用户所管理的所有下属区域列表(用户管理用)
	public static final String SESSION_MAPAREALIST = "MAPAREALIST";			//用户所管理的区域及所有下属区域列表(经纬度信息管理用)
	public static final String LOGIN = "/login_toLogin.do";				//登录地址
	public static final String mainindex = "/mainindex.do";				//首页地址
	public static final String partymain = "/selecttogo.do";				//党员首页地址
	public static final String SYSNAME = "admin/config/SYSNAME.txt";	//系统名称路径
	
	
	public static final String FILEPATHIMG = "image/uploadImgs/";	//图片上传路径  磁盘相对路径 原图路径(目前使用)
	public static final String FILEPATHIMGRED = "image/uploadImgsRed/";	//图片上传压缩路径  磁盘相对路径(目前使用)
	
	
	public static final String ALLPAGE	= "admin/config/allpage.properties";	//分页、等属性配置路径

	public static final String CONFIG = "admin/config/config.properties";	//短信猫配置路径
	public static final String FILEPATH = "uploadFiles/";	//文件路径

	//忽略Session进入       不对匹配该值的访问路径拦截（正则）
	public static final String NO_INTERCEPTOR_PATH = ".*/((login)|(logout)|(code)|(app)|(weixin)|(static)|(websocket)|(qyWeChat)|(register)|(sendmessage)|(judgecode)|(mainindexfunction)|(news360)|(renshe)|(FileManager)).*";	
	//权限校验  Session失效跳转到”村级新闻“
	public static final String NO_INTERCEPTOR_PATH1 = ".*/((mainindex)|(xiaocun)|(users)|(policyinfo)|(pcircle)|(edu)|(friends)|(bianming)|(jobs)|(feedback)|(yuqing)|(guide)).*";	
	//权限校验  Session失效跳转到“党员专区”
	public static final String NO_INTERCEPTOR_PATH3 = ".*/((partymember)|(selecttogo)|(selfeval)|(partygroup)|(resident)|(shishi)|(hd)|(zhiban)|(sencol)).*";
	
	
	public static ApplicationContext WEB_APP_CONTEXT = null; //该值会在web容器启动时由WebAppContextListener初始化

		
		public static final String[] LOGTYPE=new String[]{"登陆日志","操作日志"};
		

}
