package com.infopublic.controller;


import java.io.IOException;
import java.io.PrintWriter;
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

import com.infopublic.entity.TbXiaocun;
import com.infopublic.entity.TbYuqing;
import com.infopublic.entity.Users;
import com.infopublic.service.LogManager;
import com.infopublic.service.UsersManager;
import com.infopublic.service.XiaoCunManager;
import com.infopublic.service.YuQingManager;
import com.infopublic.util.Const;
import com.infopublic.util.DateUtil;
import com.infopublic.util.FileDownload;
import com.infopublic.util.FileInputread;
import com.infopublic.util.Jurisdiction;
import com.infopublic.util.PageData;
import com.infopublic.util.Tools;


/**
 * 小村家事
 * @author yxy
 *
 */
@Controller
@RequestMapping(value="/xiaocun")    
public class XiaoCunController extends BaseController {
	
	@Resource(name="usersService")
	private UsersManager usersService;
	@Resource(name="XiaoCunService")
	private XiaoCunManager XiaoCunService;
	@Resource(name="logService")
	private LogManager logService;
	


	/**
	 * 展示小村家事
	 * @return
	 * @throws Exception
	 * @author yxy
	 */
	@RequestMapping(value="/showallxiaocun")
	public ModelAndView showallxiaocun() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Session session=Jurisdiction.getSession();
		Users user=(Users) session.getAttribute(Const.SESSION_USER);
		String edit=pd.getString("edit");
		if("toedit".equals(edit) && user.getIsparty()==1){//党员编辑进入
			pd.put("edit", "toedit");
			pd.put("isparty", 1);
		}
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); //读取系统名称 
		pd.put("begin", 0);
		pd.put("length", Integer.parseInt(Tools.GetValueByKey(Const.ALLPAGE, "yuqingfirstshow"))); //舆情首次展示条数
		List<TbXiaocun> xiaocun;
		String tip=pd.getString("tip");
		if(!"".equals(tip) && tip!=null && "my".equals(tip)){  //展示个人文章
			String adduid=pd.getString("adduid");	
			pd.put("adduid", adduid);
			xiaocun=XiaoCunService.getMyXiaocun(pd);
			pd.put("myxiaocun", "myxiaocun");
		}else{
			xiaocun=XiaoCunService.getXiaocun(pd);
		}
		this.getdataandtitle(xiaocun);
		this.getheadimg(xiaocun);
		mv.addObject("firstfeednum",Tools.firstnum(xiaocun));  
		mv.addObject("xiaocun",xiaocun);
		pd.put("myuid", user.getUid());
		mv.setViewName("xiaocun/showallxiaocun");
		mv.addObject("pd",pd);
		return mv;	
	}
	
	
	
	/**
	 * 下拉加载小村家事
	 * @throws Exception
	 */
	@RequestMapping(value="/showxiaocunmore")
	@ResponseBody
	public Object showxiaocunmore() throws Exception{
		Map<String,String> map=new HashMap<String, String>();
		PageData pd = new PageData();
		pd = this.getPageData();
		int length=Integer.parseInt(pd.getString("length"));  //原始条数
		int tip=Integer.parseInt(pd.getString("tip")); //每次下拉  多展示2条     limit tip*length,2  
		pd.put("begin",((tip-1)*2+length));
		pd.put("length",2);
		List<TbXiaocun> xiaocun;
		String my=pd.getString("my");
		if(!"".equals(my) && my!=null && "myxiaocun".equals(my)){  //展示我的文章
			String adduid=pd.getString("adduid");
			pd.put("adduid", adduid);
			xiaocun=XiaoCunService.getMyXiaocun(pd);
		}else{
			xiaocun=XiaoCunService.getXiaocun(pd);
		}
		this.getdataandtitle(xiaocun);
		this.getheadimg(xiaocun);
		if(xiaocun.isEmpty()){//数据为空
			map.put("stop", "stop");
		}else{
		for(int i=1;i<=xiaocun.size();i++){  
			if(xiaocun.get(i-1)!=null){
			map.put("jsid"+i, xiaocun.get(i-1).getJsid()+"");
			map.put("adduid"+i, xiaocun.get(i-1).getAdduid()+"");
			map.put("adduname"+i, xiaocun.get(i-1).getAdduname());
			map.put("adddate"+i, xiaocun.get(i-1).getAdddate());
			map.put("title"+i, xiaocun.get(i-1).getTitle());
			map.put("content"+i, xiaocun.get(i-1).getContent());
			map.put("headimg"+i, xiaocun.get(i-1).getHeadimg());
			if(i==xiaocun.size()){
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
	@RequestMapping(value="/xiaocunshowcontent")
	public ModelAndView xiaocunshowcontent() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd=this.getPageData();
		//String jsid=pd.getString("jsid");
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); //读取系统名称
		TbXiaocun xiaocun=XiaoCunService.getXiaocunFromjsid(pd);
		pd.put("uid", xiaocun.getAdduid());
		Users user = usersService.findByUserid(pd);
		xiaocun.setHeadimg(user.getHeadimg());
		xiaocun.setAdddate(xiaocun.getAdddate().substring(0, 19));
		mv.addObject("pd",pd);
		mv.addObject("xiaocun",xiaocun);
		mv.setViewName("xiaocun/xiaocunshowcontent");
		return mv;
	}
	
	

	/**
	 * 新增界面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/xiaocuninsert")
	public ModelAndView xiaocuninsert() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd=this.getPageData();
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); //读取系统名称
		mv.addObject("pd",pd);
		mv.setViewName("xiaocun/xiaocuninsert");
		return mv;
	}
	
	/**
	 * 新增小村家事
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/insertXiaocun")
	@ResponseBody
	public Object insertXiaocun() throws Exception{
		Map<String,String> map=new HashMap<String,String>();
		PageData pd = new PageData();
		pd=this.getPageData();
		//pd.put("title", title);
		//pd.put("type", type);
		//pd.put("content", content);
		pd.put("adduid", Jurisdiction.getUserid()); 
		pd.put("adduname", Jurisdiction.getUsername()); 
		pd.put("sdfhh", DateUtil.getsdfhh());
		TbXiaocun xiaocun=XiaoCunService.getXiaocunDateFromjsid(pd); //若有数据则说明近期已经提交过
		if("".equals(xiaocun)||xiaocun==null){
			String adddate=DateUtil.getTime();
			pd.put("adddate", adddate);
			XiaoCunService.insertXiaocun(pd);
			map.put("result", "success");
		}else{
			map.put("result", "error"); //近期不能再次提交   以1小时为间隔
		}
		
		return map;
	}
	
	/**
	 * 删除小村家事
	 */
	@RequestMapping(value="/deleteXiaocun")
	@ResponseBody
	public Object deleteXiaocun() throws Exception{
		Map<String,String> map=new HashMap<String,String>();
		PageData pd = new PageData();
		pd=this.getPageData();
		XiaoCunService.deletexiaocun(pd);
		map.put("result", "success");
		return map;
		}




//	/**
//	 * 头像       待定
//	 * @return
//	 * @throws IOException 
//	 */
//	@RequestMapping(value="/showxiaocunheadimage")
//	public void showxiaocunheadimage(HttpServletRequest request,HttpServletResponse response) throws Exception{
//		String uid=request.getParameter("uid");
//		//System.out.println("用户id"+uid);
//		uid=uid.substring(1,uid.length()-1);
//		PageData pd=new PageData();
//		pd.put("uid", uid);
//		Users user =usersService.findByUserid(pd);
//		if(user!=null){
//		if(!"".equals(user.getHeadimg()) && user.getHeadimg()!=null){
//		System.out.println("用户头像："+user.getHeadimg());
//		PrintWriter out=response.getWriter();	  //输出图片
//		response.setContentType("text/html;charset=UTF-8");
//		out.println("<img class=\"weui-media-box__thumb\" style=\"border-radius:200px;\"  src=\""+user.getHeadimg()+"\">");
//		out.flush();
//		out.close();
//		}
//		}
//	}

	
	
	/**
	 * 新增成功界面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/xiaocuninsertsuccess")
	public ModelAndView xiaocuninsertsuccess() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd=this.getPageData();
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); //读取系统名称
		mv.addObject("pd",pd);
		mv.setViewName("xiaocun/xiaocunsuccess");
		return mv;
	}

	/**
	 * 得到头像
	 * @param tbself
	 * @return
	 * @throws Exception
	 */
	public List<TbXiaocun> getheadimg(List<TbXiaocun> tbself) throws Exception{
		for (TbXiaocun tbXiaocun : tbself) {
		Integer uid=tbXiaocun.getAdduid();
		PageData pd=new PageData();
		pd.put("uid", uid);
		Users user = usersService.findByUserid(pd);
		tbXiaocun.setHeadimg(user.getHeadimg());
		}
		return tbself;	
		}		

	
	//对时间和标题进行截取 
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<TbXiaocun> getdataandtitle(List tbself){
		for(int i=0;i<tbself.size();i++){
			for(int j=0;j<tbself.get(i).toString().length();j++){
				if(((TbXiaocun) tbself.get(i)).getTitle().length()>20){
				((TbXiaocun) tbself.get(i)).setTitle( ((TbXiaocun) tbself.get(i)).getTitle().substring(0, 20)+"...");
				}
				((TbXiaocun) tbself.get(i)).setAdddate( ((TbXiaocun) tbself.get(i)).getAdddate().substring(0, 19));
			}
		}
		return tbself;	
	}
	
	
	
}
