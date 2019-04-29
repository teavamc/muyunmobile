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

import com.infopublic.entity.TbEducation;
import com.infopublic.entity.TbEducomment;
import com.infopublic.entity.TbYqcomment;
import com.infopublic.entity.TbYuqing;
import com.infopublic.entity.Users;
import com.infopublic.service.LogManager;
import com.infopublic.service.UsersManager;
import com.infopublic.service.EducommentManager;
import com.infopublic.service.EduManager;
import com.infopublic.service.YQcommentManager;
import com.infopublic.util.Const;
import com.infopublic.util.DateUtil;
import com.infopublic.util.FileDownload;
import com.infopublic.util.FileInputread;
import com.infopublic.util.Jurisdiction;
import com.infopublic.util.PageData;
import com.infopublic.util.Tools;


/**
 * 在线学习 
 */

@Controller
@RequestMapping(value="/edu")   
public class EduController extends BaseController {  
	
	@Resource(name="usersService")
	private UsersManager usersService;
	@Resource(name="EduService")
	private EduManager EduService;
	@Resource(name="logService")
	private LogManager logService;
	@Resource(name="EducommentService")
	private EducommentManager EducommentService;
	

	@RequestMapping(value="/showalledu") 
	public ModelAndView showalledu() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); // 读取系统名称
		pd.put("begin", 0);
		pd.put("length", Integer.parseInt(Tools.GetValueByKey(Const.ALLPAGE,"edufirstshow"))); // 首次展示条数
		List<TbEducation> edu = EduService.getEdu(pd);
		this.getdata(edu);
		mv.addObject("firstfeednum", Tools.firstnum(edu));
		mv.addObject("edu", edu);
		mv.setViewName("edu/showalledu");
		mv.addObject("pd", pd);
		return mv;
	}
	
	
	
	/**
	 * 下拉加载
	 */
	
	@RequestMapping(value="/showedumore") 
	@ResponseBody
	public Object showedumore() throws Exception{
		Map<String,String> map=new HashMap<String, String>();
		PageData pd = new PageData();
		pd = this.getPageData();
		int length=Integer.parseInt(pd.getString("length"));  //原始条数
		int tip=Integer.parseInt(pd.getString("tip")); //每次下拉  多展示2条     limit tip*length,2  
		
		pd.put("begin",((tip-1)*2+length));
		pd.put("length",2);
		
		List<TbEducation> edu=EduService.getEdu(pd);
		this.getdata(edu);
		
		if(edu.isEmpty()){//数据为空
			map.put("stop", "stop");
		}else{
		for(int i=1;i<=edu.size();i++){  
			if(edu.get(i-1)!=null){
			map.put("eid"+i, edu.get(i-1).getEid()+"");
			map.put("courtit"+i, edu.get(i-1).getCourtit());
			map.put("adddate"+i, edu.get(i-1).getAdddate());
			map.put("courass"+i, edu.get(i-1).getCourass());
			map.put("courpic"+i, edu.get(i-1).getCourpic());
			map.put("courread"+i, edu.get(i-1).getCourread());
			map.put("coursum"+i, edu.get(i-1).getCoursum()+"");
			if(i==edu.size()){
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
	 * 展示具体内容
	 */
	
	@RequestMapping(value="/showeducontent")
	public ModelAndView showeducontent() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd=this.getPageData();
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); //读取系统名称
		
		TbEducation edu=EduService.getEduFromeid(pd);
		
		Integer readnum=Integer.parseInt(edu.getCourread())+1;
		pd.put("courread", readnum);
		
		EduService.setEduCourread(pd);
		
		Session session=Jurisdiction.getSession();
		Users user=(Users) session.getAttribute(Const.SESSION_USER);
		
		List<TbEducomment> educomment = EducommentService.getEducomment(pd);
		for (TbEducomment tbeducomment : educomment) {
			if(tbeducomment.getUid() == user.getUid()){
				tbeducomment.setIsusercom((short) 1);
			}
		}
		
		edu.setEducomment(educomment);
		edu.setAdddate(edu.getAdddate().substring(0, 19));
		
		mv.addObject("pd",pd);
		mv.addObject("user",user);
		mv.addObject("edu",edu);
		mv.setViewName("edu/showeducontent");
		
		return mv;
	}
	

	
	//对信息时间进行截取 去掉时分秒
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<TbEducation> getdata(List tbself){
		for(int i=0;i<tbself.size();i++){
			for(int j=0;j<tbself.get(i).toString().length();j++){
				((TbEducation) tbself.get(i)).setAdddate( ((TbEducation) tbself.get(i)).getAdddate().substring(0, 10));
			}
		}
		return tbself;	
	}
	
	/**
	 * 新增评论
	 * @throws Exception
	 */
	@RequestMapping("addeducomment")
	@ResponseBody
	public Object addeducomment() throws Exception{
		Map<String,String> map=new HashMap<String,String>();
		PageData pd=new PageData();
		pd=this.getPageData();
		String cdate=pd.getString("datetime");
		System.out.println("日期"+cdate);
		pd.put("datetime", cdate);
		EducommentService.addEducomment(pd);
		map.put("result", "success");
		return map;
	}
	
	/**
	 * 删除评论
	 * @throws Exception
	 */
	@RequestMapping("deleteeducomment")
	@ResponseBody
	public Object deleteeducomment() throws Exception{
		Map<String,String> map=new HashMap<String,String>();
		PageData pd=new PageData();
		pd=this.getPageData();
		EducommentService.delEducomment(pd);
		map.put("result", "success");
		return map;
	}
	
	/**
	 * 展示具体的评论内容
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("showycomment")
	public ModelAndView showycomment() throws Exception{
		ModelAndView mv=new ModelAndView();
		PageData pd=new PageData();
		pd=this.getPageData();
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); //读取系统名称
		TbEducomment educomment = EducommentService.getComment(pd);
		mv.addObject("educomment",educomment);
		mv.addObject("pd", pd);
		mv.setViewName("edu/showeducomment");
		return mv;
		
	}
}
 