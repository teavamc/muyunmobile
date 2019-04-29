package com.infopublic.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.shiro.session.Session;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.infopublic.entity.TbFeedback;
import com.infopublic.entity.Users;
import com.infopublic.service.FeedBackManager;
import com.infopublic.service.LogManager;
import com.infopublic.service.UsersManager;
import com.infopublic.util.Const;
import com.infopublic.util.DateUtil;
import com.infopublic.util.Jurisdiction;
import com.infopublic.util.PageData;
import com.infopublic.util.Tools;


/**
 * 投诉咨询
 * @author yxy
 *
 */
@Controller
@RequestMapping(value="/feedback")    
public class FeedBackController extends BaseController {
	
	@Resource(name="usersService")
	private UsersManager usersService;
	@Resource(name="FeedService")
	private FeedBackManager FeedService;
	@Resource(name="logService")
	private LogManager logService;

	
	/**
	 * 选择去向
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/selecttofeed")
	public ModelAndView selecttofeed() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); //读取系统名称
		mv.setViewName("feedback/selecttofeed");
		mv.addObject("pd",pd);
		return mv;
		
	}

	/**
	 * 展示投诉或咨询
	 * @return
	 * @throws Exception
	 * @author yxy
	 */
	@RequestMapping(value="/showallfeed")
	public ModelAndView showjob() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String read=pd.getString("isread");
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); //读取系统名称
		pd.put("fbuid", Jurisdiction.getUserid());  
		pd.put("begin", 0);
		pd.put("length", Integer.parseInt(Tools.GetValueByKey(Const.ALLPAGE, "feedfirstshow")));  //首次展示条数
		pd.put("isread", read);
		List<TbFeedback> feed1=FeedService.getFeebBackFromFtype(pd);
		this.gettitle(feed1);
		mv.addObject("firstfeednum",Tools.firstnum(feed1));
		mv.addObject("feed1",feed1);
		mv.setViewName("feedback/showallfeed");
		mv.addObject("pd",pd);
		return mv;	
	}
	
	
	
	/**
	 * 下拉加载投诉咨询
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/showfeedmore")
	@ResponseBody
	public Object showjobmore() throws Exception{
		Map<String,String> map=new HashMap<String, String>();
		PageData pd = new PageData();
		pd = this.getPageData();
		int length=Integer.parseInt(pd.getString("length"));  //原始条数
		int tip=Integer.parseInt(pd.getString("tip")); //每次下拉  多展示2条     limit tip*length,2  
		pd.put("begin",((tip-1)*2+length));
		pd.put("length",2);
		pd.put("fbuid", Jurisdiction.getUserid());  
		//pd.put("isread", isread);  
		List<TbFeedback> feed=FeedService.getFeebBackFromFtype(pd);  
		this.gettitle(feed);
		if(feed.isEmpty()){//数据为空
			map.put("stop", "stop");
		}else{
		for(int i=1;i<=feed.size();i++){  
			if(feed.get(i-1)!=null){
			map.put("fbid"+i, feed.get(i-1).getFbid()+"");
			map.put("title"+i, feed.get(i-1).getTitle());
			map.put("fbdatetime"+i, feed.get(i-1).getFbdatetime());
			map.put("isread"+i, feed.get(i-1).getIsread()+"");
			map.put("ftype"+i, feed.get(i-1).getFtype()+"");
			if(i==feed.size()){
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
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/feedshowcontent")
	public ModelAndView feedshowcontent() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd=this.getPageData();
		//String fbid=pd.getString("fbid");
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); //读取系统名称
		TbFeedback feed=FeedService.getFeedBackByFbid(pd);
		if("1".equals(feed.getIsread()))
		{
			feed.setDatetime(feed.getDatetime().substring(0, 19));
		}
		feed.setFbdatetime(feed.getFbdatetime().substring(0, 19));
		mv.addObject("feed",feed);
		mv.setViewName("feedback/feedshowcontent");
		return mv;
	}
	
	/**
	 * 修改未回复的投诉咨询
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/updateFeed")
	@ResponseBody
	public Object updateFeed() throws Exception{
		Map<String,String> map=new HashMap<String,String>();
		PageData pd = new PageData();
		pd=this.getPageData();
		if("".equals(FeedService.getFeedBackByFbid(pd)) || FeedService.getFeedBackByFbid(pd)==null){
			map.put("result", "error");
		}
		else if(FeedService.getFeedBackByFbid(pd).getIsread()==0){ //更新时未被回复
			String fbdatetime=DateUtil.getTime();
			pd.put("fbdatetime", fbdatetime);
			FeedService.updateFeed(pd);
			map.put("result", "success");
		}else {
			map.put("result", "error");
		}
		return map;
	}
	
	/**
	 * 删除未回复的投诉咨询
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteFeed")
	@ResponseBody
	public Object deleteFeed() throws Exception{
		Map<String,String> map=new HashMap<String,String>();
		PageData pd = new PageData();
		pd=this.getPageData();
		if((FeedService.getFeedBackByFbid(pd).getIsread())==0){ //删除时未被回复
			//String fbid=pd.getString("fbid");
			FeedService.deleteFeed(pd);
			map.put("result", "success");
		}else{
			map.put("result", "error");
		}
		return map;
	}
	
	/**
	 * 新增界面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/feedinsert")
	public ModelAndView feedinsert() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd=this.getPageData();
		String ftype=pd.getString("ftype");
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); //读取系统名称
		pd.put("ftype", ftype);
		mv.addObject("pd",pd);
		mv.setViewName("feedback/feedinsert");
		return mv;
	}
	
	/**
	 * 新增投诉咨询
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/insertFeed")
	@ResponseBody
	public Object insertFeed() throws Exception{
		Map<String,String> map=new HashMap<String,String>();
		PageData pd = new PageData();
		pd=this.getPageData();
		String fbdatetime=DateUtil.getTime();
		pd.put("fbdatetime", fbdatetime);
		pd.put("fbuid", Jurisdiction.getUserid());  
		TbFeedback feed=FeedService.getFeedBackByFuidAndTitle(pd);
		if("".equals(feed)||feed==null){  //该用户不存在同样的标题
			FeedService.insertFeed(pd);
			map.put("result", "success");
		}else{
			map.put("result", "error");
		}
		
		return map;
	}
	
	/**
	 * 新增成功界面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/feedinsertsuccess")
	public ModelAndView feedinsertsuccess() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd=this.getPageData();
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); //读取系统名称
		mv.addObject("pd",pd);
		mv.setViewName("feedback/feedinsertsuccess");
		return mv;
	}

	
	/**
	 * 管理者编辑 投诉或咨询
	 * @return
	 * @throws Exception
	 * @author yxy
	 */
	@RequestMapping(value="/editallfeed")
	public ModelAndView editallfeed() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String ftype=pd.getString("ftype");
		pd.put("ftype", ftype);
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); //读取系统名称
		pd.put("begin", 0);
		pd.put("length", Integer.parseInt(Tools.GetValueByKey(Const.ALLPAGE, "feedfirstshow")));  //首次展示条数
		pd.put("isread", 0);
			List<TbFeedback> feed1=FeedService.getFeebBackEdit(pd);
		this.gettitle(feed1);
		mv.addObject("firstfeednum",Tools.firstnum(feed1));
		mv.addObject("feed1",feed1);
		mv.setViewName("feedback/editallfeed");
		mv.addObject("pd",pd);
		return mv;	
	}
	
	/**
	 * 管理   下拉加载投诉咨询
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/showfeedmore2")
	@ResponseBody
	public Object showjobmore2() throws Exception{
		Map<String,String> map=new HashMap<String, String>();
		PageData pd = new PageData();
		pd = this.getPageData();
		int length=Integer.parseInt(pd.getString("length"));  //原始条数
		int tip=Integer.parseInt(pd.getString("tip")); //每次下拉  多展示2条     limit tip*length,2  
		pd.put("begin",((tip-1)*2+length));
		pd.put("length",2); 
		pd.put("isread",0); 
		List<TbFeedback> feed=FeedService.getFeebBackEdit(pd);
		this.gettitle(feed);
		if(feed.isEmpty()){//数据为空
			map.put("stop", "stop");
		}else{
		for(int i=1;i<=feed.size();i++){  
			if(feed.get(i-1)!=null){
			map.put("fbid"+i, feed.get(i-1).getFbid()+"");
			map.put("title"+i, feed.get(i-1).getTitle());
			map.put("fbdatetime"+i, feed.get(i-1).getFbdatetime());
			map.put("isread"+i, feed.get(i-1).getIsread()+"");
			map.put("ftype"+i, feed.get(i-1).getFtype()+"");
			if(i==feed.size()){
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
	 * 管理内容  回复页面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/editfeedcontent")
	public ModelAndView editfeedcontent() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd=this.getPageData();
		//String fbid=pd.getString("fbid");
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); //读取系统名称
		TbFeedback feed=FeedService.getFeedBackByFbid(pd);
		mv.addObject("feed",feed);
		mv.setViewName("feedback/editfeedcontent");
		return mv;
	}
	
	/**
	 * 管理内容      回复内容
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/ediupdateFeed")
	@ResponseBody
	public Object ediupdateFeed() throws Exception{
		Map<String,String> map=new HashMap<String,String>();
		PageData pd = new PageData();
		pd=this.getPageData();
		if(FeedService.getFeedBackByFbid(pd).getIsread()==0){ //更新时未被回复
			pd.put("uname", Jurisdiction.getUsername());
			pd.put("uid", Jurisdiction.getUserid());
			pd.put("isread", 1);
			pd.put("datetime", DateUtil.getTime());
			FeedService.updateFeed(pd);
			map.put("result", "success");
		}else{
			map.put("result", "error");
		}
		return map;
	}
		
	//对时间进行截取 
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<TbFeedback> getdata(List tbself){
		for(int i=0;i<tbself.size();i++){
			for(int j=0;j<tbself.get(i).toString().length();j++){
				((TbFeedback) tbself.get(i)).setFbdatetime( ((TbFeedback) tbself.get(i)).getFbdatetime().substring(0, 10));
			}
		}
		return tbself;	
	}
	
	//对题目进行截取 去掉时分秒
			@SuppressWarnings({ "unchecked", "rawtypes" })
			public List<TbFeedback> gettitle(List tbself){
				for(int i=0;i<tbself.size();i++){
					for(int j=0;j<tbself.get(i).toString().length();j++){
						((TbFeedback) tbself.get(i)).setFbdatetime( ((TbFeedback) tbself.get(i)).getFbdatetime().substring(0, 10));
						if(((TbFeedback) tbself.get(i)).getTitle().length()>6){
						((TbFeedback) tbself.get(i)).setTitle( ((TbFeedback) tbself.get(i)).getTitle().substring(0, 6)+"..");
						}else{
							break;
						}
					}
				}
				return tbself;	
			}
	
	
}
