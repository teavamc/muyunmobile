package com.infopublic.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.session.Session;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.infopublic.entity.TbZhiban;
import com.infopublic.entity.Users;

import com.infopublic.service.LogManager;
import com.infopublic.service.UsersManager;
import com.infopublic.service.ZhibanManager;

import com.infopublic.util.Const;
import com.infopublic.util.DateUtil;
import com.infopublic.util.FileDownload;
import com.infopublic.util.FileInputread;
import com.infopublic.util.Jurisdiction;
import com.infopublic.util.PageData;
import com.infopublic.util.Tools;


/**
 * 在线学习 
 * @author zc
 *
 */

@Controller
@RequestMapping(value="/zhiban")   
public class ZhibanController extends BaseController {  
	
	@Resource(name="usersService")
	private UsersManager usersService;
	@Resource(name="ZhibanService")
	private ZhibanManager ZhibanService;
	@Resource(name="logService")
	private LogManager logService;
	
	private String path=""; 


	/**
	 * 展示所有的党员值班情况活动
	 * @return
	 * @throws Exception
	 * @author zc
	 */
	@RequestMapping(value="/showallzhiban") 
	public ModelAndView showallzhiban() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); // 读取系统名称
			
		pd.put("nowdate", DateUtil.getDay());
		
		if(!"".equals(ZhibanService.getAllZhibannow(DateUtil.getDay()))&&ZhibanService.getAllZhibannow(DateUtil.getDay())!=null){
			TbZhiban getnowzhiban = ZhibanService.getAllZhibannow(DateUtil.getDay());
			mv.addObject("getnowzhiban", getnowzhiban);
			mv.setViewName("zhiban/showallzhiban");
			mv.addObject("pd", pd);
		}else{
			mv.addObject("getnowzhiban", ""); //就设置为空
			mv.setViewName("zhiban/showallzhiban");
			mv.addObject("pd", pd);
		}
		return mv;
	}
	


	/**
	 * 展示具体内容
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/showzbcontent")
	public ModelAndView showzbcontent() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd=this.getPageData();
		
		String zbid = pd.getString("zbid");
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); //读取系统名称
		

		TbZhiban zhiban=ZhibanService.getZbFromzbid(zbid);
		
		List<String> url=FileInputread.getURL(zhiban.getAdddate());
		mv.addObject("url",url);
		pd.put("urlnum", url.size());
		mv.addObject("pd",pd);
		mv.addObject("zhiban",zhiban);
		mv.setViewName("zhiban/showzbcontent");
		
		return mv;
	}
		
}
 