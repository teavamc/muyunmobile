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


/**
 * 指南
 * @author yxy
 *
 */
@Controller
@RequestMapping(value="/guide")    
public class GuideController extends BaseController {
	
	@Resource(name="usersService")
	private UsersManager usersService;
	@Resource(name="GuideService")
	private GuideManager GuideService;
	@Resource(name="logService")
	private LogManager logService;
	
	//展示政策与公告
		@RequestMapping(value="/showguide")
		public ModelAndView showguide() throws Exception{
			ModelAndView mv = this.getModelAndView();
			PageData pd = new PageData();
			pd = this.getPageData();
			pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); // 读取系统名称
			pd.put("pagelength", Integer.parseInt(Tools.GetValueByKey(Const.ALLPAGE, "guidePageSet"))); // 读取政策与公告分页长度

			// 公告列表
			List<TbGuide> showguide = GuideService.getGuideFromGreadtotalbyremark(1); 
			this.getdata(showguide);  //取  数据
			for (int i = showguide.size() - 1; i >= 0; i--) {// 对发布事件的发布条数截取  截取最近5条
				TbGuide tbguide = showguide.get(i); //查询多少行  size就是多少
				if (i >= 4)
					showguide.remove(tbguide);
			}
			mv.addObject("showguide", showguide); //分了页面啊，第一个页面是公告不，所以这里就是把查询公告的list存1
			mv.setViewName("guide/showguide");
			mv.addObject("pd", pd);
			return mv;
		}

	/**
	 * 指南列表界面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/guidelist")
	@ResponseBody 
	public ModelAndView guidelist() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd=this.getPageData();
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); // 读取系统名称
		pd.put("pagelength", Integer.parseInt(Tools.GetValueByKey(Const.ALLPAGE, "guidePageSet")));
		
		int remark = Integer.parseInt(pd.getString("remark")); //取 数据是否有效
		String begin = pd.getString("begin"); // 取起始
		int length = Integer.parseInt(pd.getString("length")); // 取长度
		String tip = pd.getString("tip");
		
		pd.put("remark", remark); //是1还是0
		pd.put("begin", Integer.parseInt(begin)); // 分页开始时的数据条目
		pd.put("length", length); // 每页显示的固定数据条目
		
		List<TbGuide> getguide = GuideService.getGuideFromGreadtotal(pd);// 展示全部
		this.getdata(getguide);
		this.gettitle(getguide);
		
		int totalnum = GuideService.totalallbyremark(remark); // 查询到所有相关类型的页数	
		pd.put("one", Integer.parseInt(begin) / length + 1); // 第一页
		pd.put("total", totalnum / length + 1); // 总页面
		
		mv.addObject("pd", pd);
		mv.addObject("getguide", getguide);
		mv.setViewName("guide/guidelist");
		
		return mv;
	}
	
	/**
	 * 下拉加载指南
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/showguidemore")
	@ResponseBody
	public Object showguidemore() throws Exception{
		Map<String,String> map=new HashMap<String, String>();
		PageData pd = new PageData();
		pd = this.getPageData();
		int length=Integer.parseInt(pd.getString("length"));  //原始条数
		int tip=Integer.parseInt(pd.getString("tip")); //每次下拉  多展示2条     limit tip*length,2  
		pd.put("begin",((tip-1)*2+length));
		pd.put("length",2);
		List<TbGuide> guide;
		if(!"".equals(pd.getString("searchtip")) && pd.getString("searchtip")!=null){ //不为空 说明是搜索下拉
			pd.put("searchInput", pd.getString("searchtip"));
			guide=GuideService.getGuideFromTitleOrType(pd);  //根据名称或类型模糊查询
		}else{
		    guide=GuideService.getGuideFromGreadtotal(pd);  
		}
		this.gettitle(guide);
		if(guide.isEmpty()){//数据为空
			map.put("stop", "stop");
		}else{
		for(int i=1;i<=guide.size();i++){  
			if(guide.get(i-1)!=null){
			map.put("guid"+i, guide.get(i-1).getGuid()+"");
			map.put("gutype"+i, guide.get(i-1).getGutype());
			map.put("pushdate"+i, guide.get(i-1).getPushdate());
			map.put("guname"+i, guide.get(i-1).getGuname()+"");
			if(i==guide.size()){
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
	 * 展示指南内容
	 * @return
	 * @throws Exception
	 * @author yxy
	 */
	@RequestMapping(value="/showallguide")
	public ModelAndView showallguide() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); //读取系统名称
		TbGuide guide=GuideService.getGuideFromguid(pd);
		pd.put("greadtotal", guide.getGreadtotal()+1);
		GuideService.updatereadtotal(pd);//将浏览次数加1
		guide.setPushdate(guide.getPushdate().substring(0, 19));
		guide.setGreadtotal(guide.getGreadtotal()+1);
		List<String> url=FileInputread.getURL(guide.getGupic());
		mv.addObject("url",url);
		pd.put("urlnum", url.size());
		mv.addObject("guide",guide);
		mv.setViewName("guide/guideshowcontent");
		mv.addObject("pd",pd);
		return mv;	
	}
	
	/**
	 * 图片展示
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping(value="/showguideimage")
	public void showguideimage(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String url=request.getParameter("url");
		System.out.println(url);
		if(!"".equals(url) && url!=null){
		url = url.substring(1, url.length()-1);   //注意：这里要去掉前后的   ' 号 
		System.out.println(url);
		FileInputread.Imageshow(request,response,url);	  //输出图片
		}
	}


	
	//对时间进行截取 
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<TbGuide> getdata(List tbself){
		for(int i=0;i<tbself.size();i++){
			for(int j=0;j<tbself.get(i).toString().length();j++){
				((TbGuide) tbself.get(i)).setPushdate( ((TbGuide) tbself.get(i)).getPushdate().substring(0, 19));
			}
		}
		return tbself;	
	}
	
	
	
	//对题目进行截取 去掉时分秒
			@SuppressWarnings({ "unchecked", "rawtypes" })
			public List<TbGuide> gettitle(List tbself){
				for(int i=0;i<tbself.size();i++){
					for(int j=0;j<tbself.get(i).toString().length();j++){
						((TbGuide) tbself.get(i)).setPushdate( ((TbGuide) tbself.get(i)).getPushdate().substring(0, 10));
						if(((TbGuide) tbself.get(i)).getGuname().length()>10){
						((TbGuide) tbself.get(i)).setGuname( ((TbGuide) tbself.get(i)).getGuname().substring(0, 10)+"..");
						}else{
							break;
						}
					}
				}
				return tbself;	
			}
}
