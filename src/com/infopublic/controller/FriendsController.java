package com.infopublic.controller;


import java.io.IOException;
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

import com.infopublic.entity.TbGuide;
import com.infopublic.entity.TbJob;
import com.infopublic.entity.Users;
import com.infopublic.service.GuideManager;
import com.infopublic.service.LogManager;
import com.infopublic.service.UsersManager;
import com.infopublic.util.Const;
import com.infopublic.util.FileInputread;
import com.infopublic.util.Jurisdiction;
import com.infopublic.util.PageData;
import com.infopublic.util.Tools;


@Controller
@RequestMapping(value="/friends")    
public class FriendsController extends BaseController {
	
	@Resource(name="usersService")
	private UsersManager usersService;

	@Resource(name="logService")
	private LogManager logService;
	
	//展示微信矩阵
	@RequestMapping(value="/juzhen")
	public ModelAndView juzhen() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); // 读取系统名称
		
		mv.setViewName("friends/juzhen");
		mv.addObject("pd", pd);
		return mv;
	}



}
