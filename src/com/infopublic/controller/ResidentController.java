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
import com.infopublic.entity.TbResident;
import com.infopublic.entity.Users;
import com.infopublic.entity.MuyunRes;
import com.infopublic.service.GuideManager;
import com.infopublic.service.LogManager;
import com.infopublic.service.ResidentManager;
import com.infopublic.service.UsersManager;
import com.infopublic.service.MuyunResManager;
import com.infopublic.util.Const;
import com.infopublic.util.FileInputread;
import com.infopublic.util.Jurisdiction;
import com.infopublic.util.PageData;
import com.infopublic.util.Tools;


/**
 * 村民信息
 * @author yxy
 *
 */
@Controller
@RequestMapping(value="/resident")    
public class ResidentController extends BaseController {
	
	@Resource(name="usersService")
	private UsersManager usersService;
	@Resource(name="ResidentService")
	private ResidentManager ResidentService;
	@Resource(name="logService")
	private LogManager logService;
	@Resource(name="MuyunResService")
	private MuyunResManager MuyunResService;

	
	/**
	 * 村民信息列表界面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/residentlist")
	public ModelAndView guidelist() throws Exception{
		
		ModelAndView mv = this.getModelAndView();
		
		PageData pd = new PageData();
		
		List<Map<String, String>> group_Map = MuyunResService.getCount_All_types(pd);
		mv.addObject("groupmap", group_Map);
		
		pd=this.getPageData();
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); // 读取系统名称
		      
		pd.put("allnumber", MuyunResService.getCount_Res(pd));
		pd.put("mannumber", MuyunResService.getCount_bySex("男"));
		pd.put("womannumber", MuyunResService.getCount_bySex("女"));
		pd.put("unknownsex", MuyunResService.getCount_Res(pd)-MuyunResService.getCount_bySex("男")-MuyunResService.getCount_bySex("女"));
		
		
		
		String tip = pd.getString("tip");
		if (!"".equals(tip) && tip != null) {// 搜索结果
			pd.put("begin", 0);
			pd.put("length", Integer.parseInt(pd.getString("length")));
			
			//String searchInput=pd.getString("searchInput");
			//pd.put("searchInput", searchInput);

			List<MuyunRes> MuyunRes = MuyunResService.get_res_bySearch(pd); // 根据搜索结果展示
			mv.addObject("resident", MuyunRes);
			mv.addObject("firstfeednum", Tools.firstnum(MuyunRes));
			pd.put("searchtip", tip); // 传递搜索的内容作为参数判断是跳转到搜索页面
			mv.addObject("pd", pd);
			mv.setViewName("resident/residentlist");
			
		} else { 
			
			pd.put("begin", 0);
			pd.put("length", Integer.parseInt(Tools.GetValueByKey(
					Const.ALLPAGE, "residentfirstshow"))); // 读取分页长度

			List<MuyunRes> MuyunRes= MuyunResService.getAll_res(pd);// 展示全部
			mv.addObject("resident", MuyunRes);
			mv.addObject("firstfeednum", Tools.firstnum(MuyunRes));
			mv.addObject("pd", pd);
			mv.setViewName("resident/residentlist");
			
		}
		
		return mv;
		
	}


	/**
	 * 下拉加载
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/showresidentmore")
	@ResponseBody
	public Object showresidentmore() throws Exception{
		
		Map<String,String> map=new HashMap<String, String>();
		PageData pd = new PageData();
		pd = this.getPageData();
		
		int length=Integer.parseInt(pd.getString("length"));  //原始条数
		int tip=Integer.parseInt(pd.getString("tip")); //每次下拉  多展示2条     limit tip*length,2  
		
		pd.put("begin",((tip-1)*2+length));
		pd.put("length",2);
		
		List<MuyunRes> resident;
		
		if(!"".equals(pd.getString("searchtip")) && pd.getString("searchtip")!=null){ //不为空 说明是搜索下拉
			pd.put("searchInput", pd.getString("searchtip"));
			resident=MuyunResService.get_res_bySearch(pd);  //根据关键字模糊查询
		}else{
			resident=MuyunResService.getAll_res(pd);;  
		}
		
		if(resident.isEmpty()){//数据为空
			map.put("stop", "stop");
		}else{
		for(int i=1;i<=resident.size();i++){  
			if(resident.get(i-1)!=null){
			map.put("pid"+i, resident.get(i-1).getPid()+"");
			map.put("name"+i, resident.get(i-1).getName());
			map.put("phone1"+i, resident.get(i-1).getPhone1());
			map.put("grouptype"+i, resident.get(i-1).getgrouptype());
			
			if(i==resident.size()){
				map.put("success",i+"");  //集合数据都不为空
			}
			}else{
				map.put("success",(i-1)+"");  //集合有几个不为NULL的数据
				break;
			}	
		}
		
		}
		return map;
	}
	

	/**
	 * 展示内容
	 * @return
	 * @throws Exception
	 * @author zc
	 */
	@RequestMapping(value="/showrescontent")
	public ModelAndView showrescontent() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); //读取系统名称
		String pid=pd.getString("pid");
		
		MuyunRes resident=MuyunResService.get_res_byPid(pid);
		mv.addObject("resident",resident);
		mv.setViewName("resident/residentcontent");
		mv.addObject("pd",pd);
		return mv;	
	}
	
}
