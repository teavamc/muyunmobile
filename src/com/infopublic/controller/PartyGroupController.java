package com.infopublic.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.session.Session;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.infopublic.entity.TbFileManager;
import com.infopublic.entity.TbGroup;
import com.infopublic.entity.GroupMuyun;
import com.infopublic.entity.TbPartymember;
import com.infopublic.entity.TbResident;
import com.infopublic.entity.Users;
import com.infopublic.service.GroupMuyunManager;
import com.infopublic.service.PartyGroupManager;
import com.infopublic.service.UsersManager;
import com.infopublic.service.impl.GroupMuyunService;
import com.infopublic.util.Const;
import com.infopublic.util.FileInputread;
import com.infopublic.util.Jurisdiction;
import com.infopublic.util.PageData;
import com.infopublic.util.Tools;


/**
 * 党员小组
 * @author yxy
 *
 */
@Controller
@RequestMapping(value="/partygroup")  
public class PartyGroupController extends BaseController {
	
	@Resource(name="usersService")
	private UsersManager usersService;
	@Resource(name="PartyGroupService")
	private PartyGroupManager PartyGroupService;
	@Resource(name="GroupMuyunService")
	private GroupMuyunManager GroupMuyunService;

	// 展示党员小组
		@RequestMapping(value = "/showgroup")
		public ModelAndView showgroup() throws Exception {
			ModelAndView mv = this.getModelAndView();
			PageData pd = new PageData();
			pd = this.getPageData();
			pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); // 读取系统名称
			

			String[] grouptypes = {"新港","白庙咀","排兴垅","曹家塘","长塘","上珠塘","暮云铺","禁山子"}; 
			for(int i=0;i<grouptypes.length;i++){
				String grouptype = grouptypes[i];
				pd.put(grouptypes[i], GroupMuyunService.querrynumberformtypes(grouptype)) ;
			}
			
			
			pd.put("pmnumber", GroupMuyunService.querrynumber(pd));
			pd.put("mannum", GroupMuyunService.querrynumberformsex("男"));
			pd.put("womennum", GroupMuyunService.querrynumberformsex("女"));
			
			mv.addObject("pd", pd);
			mv.setViewName("p_group/choosetype");
			return mv;
		}

	
	
	// 根据类别展示每个小组的人数用于统计
		@RequestMapping(value = "/typecontent")
		public ModelAndView typecontent() throws Exception {
			ModelAndView mv = this.getModelAndView();
			PageData pd = new PageData();
			pd = this.getPageData();
			pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); // 读取系统名称
			
			/*拿到文件列表和分页的过程  开始*/
			String begin = pd.getString("begin"); 
			int length = Integer.parseInt(pd.getString("length")); //从url里面拿到两个键值,扔到后台
			
			String tip = pd.getString("tip");
			String grouptype = pd.getString("type");

			
			pd.put("begin", Integer.parseInt(begin));
			pd.put("length", Integer.parseInt(pd.getString("length")));
			
			pd.put("grouptype", grouptype);
			

			List<GroupMuyun> typelist = GroupMuyunService.getGmuyuntypelist(pd); // 根据类别展示所有的党员list
			
			int totalnum = GroupMuyunService.querrynumberformtype(pd);  //拿到所有的数据总数
			
			
			pd.put("one", Integer.parseInt(begin)/length+1); //第一页
			pd.put("total", totalnum/length+1);              //目标页数
			/*拿到文件列表和分页的过程  结束*/
			
			
			mv.addObject("typelist", typelist);
			mv.addObject("grouptype", grouptype);	
			mv.addObject("pd", pd);
			mv.setViewName("p_group/typecontent");
			return mv;
		}
		
		//展示下载内容的详情
		@RequestMapping(value="/groupinfo")
		public ModelAndView groupinfo() throws Exception{
			ModelAndView mv = this.getModelAndView();
			PageData pd = new PageData();
			pd = this.getPageData();
			
			String pid = pd.getString("pid"); //从url拿到fileid
			
			pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); // 读取系统名称
			GroupMuyun groupcontent = GroupMuyunService.getGmuyunofpid(pid);
			
			mv.addObject("groupcontent",groupcontent);
			
			mv.setViewName("p_group/groupinfo");
			mv.addObject("pd", pd);
			return mv;
		}
	
}
