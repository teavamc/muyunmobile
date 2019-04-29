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
import com.infopublic.entity.TbPartycircle;
import com.infopublic.entity.TbResident;
import com.infopublic.entity.TbSencollect;
import com.infopublic.entity.Users;
import com.infopublic.service.GuideManager;
import com.infopublic.service.LogManager;
import com.infopublic.service.ResidentManager;
import com.infopublic.service.SenCollectManager;
import com.infopublic.service.UsersManager;
import com.infopublic.util.Const;
import com.infopublic.util.DateUtil;
import com.infopublic.util.FileInputread;
import com.infopublic.util.Jurisdiction;
import com.infopublic.util.PageData;
import com.infopublic.util.Tools;


/**
 * 敏感字符管理
 * @author yxy
 *
 */
@Controller
@RequestMapping(value="/sencol")    
public class SenColController extends BaseController {
	
	@Resource(name="usersService")
	private UsersManager usersService;
	@Resource(name="SenCollectService")
	private SenCollectManager SenCollectService;
	@Resource(name="logService")
	private LogManager logService;

	
	/**
	 * 敏感字符列表界面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/sencollist")
	public ModelAndView guidelist() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd=this.getPageData();
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); // 读取系统名称
		Session session=Jurisdiction.getSession();
		Users u = (Users) session.getAttribute(Const.SESSION_USER);
		//System.out.println("***********"+u.toString());
		if(u.getIsparty()==1 && u.getType()==1){   //有权限进入
		String tip = pd.getString("tip");
		if (!"".equals(tip) && tip != null) {// 搜索结果              （暂无完善）
			pd.put("begin", 0);
			pd.put("length", Integer.parseInt(pd.getString("length")));
			List<TbSencollect> sencol = SenCollectService.getAllSenCol(); // 根据搜索结果展示
			mv.addObject("sencol", sencol);
			mv.addObject("firstfeednum", Tools.firstnum(sencol));
			pd.put("searchtip", tip); // 传递搜索的内容作为参数判断是跳转到搜索页面
			mv.addObject("pd", pd);
			mv.setViewName("resident/residentlist");
		} else {
			pd.put("begin", 0);
			pd.put("length", Integer.parseInt(Tools.GetValueByKey(
					Const.ALLPAGE, "residentfirstshow"))); // 读取分页长度
			List<TbSencollect> sencol = SenCollectService.getAllSenCol(); 
			mv.addObject("sencol", sencol);
			mv.addObject("firstfeednum", Tools.firstnum(sencol));
			mv.addObject("pd", pd);
			mv.setViewName("sencolmanage/sencollist");
		}
		}else{   //无权限进入
			mv.addObject("pd", pd);
			mv.setViewName("sencolmanage/nopower");
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
		List<TbSencollect> sencol;
		if(!"".equals(pd.getString("searchtip")) && pd.getString("searchtip")!=null){ //不为空 说明是搜索下拉
			pd.put("searchInput", pd.getString("searchtip"));
			sencol=SenCollectService.getAllSenCol();   //根据关键字模糊查询
		}else{
			sencol=SenCollectService.getAllSenCol(); 
		}
		if(sencol.isEmpty()){//数据为空
			map.put("stop", "stop");
		}else{
		for(int i=1;i<=sencol.size();i++){  
			if(sencol.get(i-1)!=null){
			map.put("rid"+i, sencol.get(i-1).getId()+"");
			map.put("name"+i, sencol.get(i-1).getSencollect());
			if(i==sencol.size()){
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
	 * 新增敏感字符
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/insertsen")
	@ResponseBody
	public Object insertsen() throws Exception{
		Map<String,String> map=new HashMap<String,String>();
		PageData pd = new PageData();
		pd=this.getPageData();
		SenCollectService.addSenCol(pd);
		map.put("result", "success");
		return map;
	}
	
	/**
	 * 删除敏感字符
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/delsen")
	@ResponseBody
	public Object delsen() throws Exception{
		Map<String,String> map=new HashMap<String,String>();
		PageData pd = new PageData();
		pd=this.getPageData();
		SenCollectService.delSenCol(pd);
		map.put("result", "success");
		return map;
	}
	

//	/**
//	 * 展示内容
//	 * @return
//	 * @throws Exception
//	 * @author yxy
//	 */
//	@RequestMapping(value="/showrescontent")
//	public ModelAndView showrescontent() throws Exception{
//		ModelAndView mv = this.getModelAndView();
//		PageData pd = new PageData();
//		pd = this.getPageData();
//		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); //读取系统名称
//		//String rid=pd.getString("rid");
//		TbResident resident=ResidentService.getResidentFromrid(pd);
//		mv.addObject("resident",resident);
//		mv.setViewName("resident/residentcontent");
//		mv.addObject("pd",pd);
//		return mv;	
//	}
	



	

	
	
}
