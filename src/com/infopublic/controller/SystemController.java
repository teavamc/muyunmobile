package com.infopublic.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.infopublic.entity.Page;
import com.infopublic.service.LogManager;
import com.infopublic.service.SystemManager;
import com.infopublic.util.AppUtil;
import com.infopublic.util.Const;
import com.infopublic.util.FileUtil;
import com.infopublic.util.PageData;
import com.infopublic.util.PathUtil;


/** 
 * 类名称：SystemController
 * @version
 */
@Controller
@RequestMapping(value="/system")
public class SystemController extends BaseController {
	
	@Resource(name="logService")
	private LogManager logService;
	@Resource(name="systemService")
	private SystemManager systemService;
	/**
	 * 去系统初始化界面
	 * @return ModelAndView
	 */
	@RequestMapping(value="/setInit")
	public ModelAndView toAssignRole(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("system/init_set");
		mv.addObject("pd", pd);
		return mv;
	}
	/**
	 * 去基础设置界面
	 * @return ModelAndView
	 */
	@RequestMapping(value="/toBaseset")
	public ModelAndView toBaseset() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		List<PageData> data = systemService.listBaseAttributes("");
		for(PageData item:data){
			String valueid = item.get("valueid").toString();
			switch (valueid) {
			case "服务器公网IP地址":
				pd.put("ip", item.get("valuename").toString());
				break;
			case "服务器短信号码":
				pd.put("phone", item.get("valuename").toString());
				break;
			case "系统名称":
				pd.put("systemname", item.get("valuename").toString());
				break;
			case "系统所有者":
				pd.put("owner", item.get("valuename").toString());
				break;
			case "紧急播出单短信":
				pd.put("urgentmsg", item.get("valuename").toString());
				break;
			case "终端通讯数量":
				pd.put("ternumber", item.get("valuename").toString());
				break;
			case "终端通讯访问端口":
				pd.put("port", item.get("valuename").toString());
				break;

			default:
				break;
			}
		}
		mv.setViewName("system/base_set");
		mv.addObject("pd", pd);
		return mv;
	}
	/**
	 * 系统初始化
	 */
	@RequestMapping(value="/initSystem")
	@ResponseBody
	public Object initSystem() throws Exception{
		Map<String,String> map = new HashMap<String,String>();
		PageData pd = new PageData();
		pd = this.getPageData();
		systemService.initDataBase("");//初始化数据库
		FileUtil.delFilePath(PathUtil.getClasspath() + Const.FILEPATH);//删除文件
		map.put("result", "success");
		return AppUtil.returnObject(pd, map);
	}
	/**
	 * 保存设置
	 */
	@RequestMapping(value="/saveEdit")
	@ResponseBody
	public Object saveEdit() throws Exception{
		Map<String,String> map = new HashMap<String,String>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String name = pd.get("name").toString();
		switch (name) {
		case "ip":
			pd.put("valueid", "服务器公网IP地址");
			break;
		case "phone":
			pd.put("valueid", "服务器短信号码");
			break;
		case "systemname":
			pd.put("valueid", "系统名称");
			break;
		case "owner":
			pd.put("valueid", "系统所有者");
			break;
		case "urgentmsg":
			pd.put("valueid", "紧急播出单短信");
			break;
		case "ternumber":
			pd.put("valueid", "终端通讯数量");
			break;
		case "port":
			pd.put("valueid", "终端通讯访问端口");
			break;
		default:
			pd.put("valueid", "");
			break;
		}
		pd.put("valuename", pd.get("content").toString());
		systemService.saveAttri(pd);;
		FileUtil.delFilePath(PathUtil.getClasspath() + Const.FILEPATH);//删除文件
		map.put("result", "success");
		return AppUtil.returnObject(pd, map);
	}
	
	
}
