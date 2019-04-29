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

import com.infopublic.entity.TbHuodong;
import com.infopublic.entity.TbXiaocun;
import com.infopublic.entity.TbYuqing;
import com.infopublic.entity.Users;
import com.infopublic.service.LogManager;
import com.infopublic.service.UsersManager;
import com.infopublic.service.HdManager;
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
@RequestMapping(value="/hd")   
public class HdController extends BaseController {  
	
	@Resource(name="usersService")
	private UsersManager usersService;
	@Resource(name="HdService")
	private HdManager HdService;
	@Resource(name="logService")
	private LogManager logService;
	
	private String path=""; 


	/**
	 * 党员活动
	 * @return
	 * @throws Exception
	 * @author zc
	 */
	@RequestMapping(value="/showallhd") 
	public ModelAndView showallhd() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); // 读取系统名称
		pd.put("begin", 0);
		pd.put("length", Integer.parseInt(Tools.GetValueByKey(Const.ALLPAGE,"hdfirstshow"))); // 实时政事首次展示条数
		List<TbHuodong> hd = HdService.getHd(pd);
		this.getdataandcon(hd);
		mv.addObject("firstfeednum", Tools.firstnum(hd));
		mv.addObject("hd", hd);
		mv.setViewName("hd/showallhd");
		mv.addObject("pd", pd);
		return mv;
	}
	
	
	
	/**
	 * 党员下拉加载
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping(value="/showhdmore") 
	@ResponseBody
	public Object showhdmore() throws Exception{
		Map<String,String> map=new HashMap<String, String>();
		PageData pd = new PageData();
		pd = this.getPageData();
		int length=Integer.parseInt(pd.getString("length"));  //原始条数
		int tip=Integer.parseInt(pd.getString("tip")); //每次下拉  多展示2条     limit tip*length,2  
		pd.put("begin",((tip-1)*2+length));
		pd.put("length",2);
		
		List<TbHuodong> hd=HdService.getHd(pd);
		this.getdataandcon(hd);
		
		if(hd.isEmpty()){//数据为空
			map.put("stop", "stop");
		}else{
		for(int i=1;i<=hd.size();i++){  
			if(hd.get(i-1)!=null){
			map.put("hdid"+i, hd.get(i-1).getHdid()+"");
			map.put("hdtitle"+i, hd.get(i-1).getHdtitle());
			map.put("hdtype"+i, hd.get(i-1).getHdtype());
			map.put("hdloc"+i, hd.get(i-1).getHdloc());
			map.put("hdnum"+i, hd.get(i-1).getHdnum());
			map.put("hdbtime"+i, hd.get(i-1).getHdbtime());
			map.put("hdetime"+i, hd.get(i-1).getHdetime());
			map.put("hdpic"+i, hd.get(i-1).getHdpic());
			map.put("hdsum"+i, hd.get(i-1).getHdsum());
			map.put("hdadddate"+i, hd.get(i-1).getHdadddate());
			map.put("uid"+i, hd.get(i-1).getUid());
			if(i==hd.size()){
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
	
	private void getdataandcon(List<TbHuodong> hd) {
		// TODO Auto-generated method stub
		
	}

	/**
	 * 展示具体内容
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/showhdcontent")
	public ModelAndView showhdcontent() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd=this.getPageData();
		
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); //读取系统名称
		
		TbHuodong hd=HdService.getHdFromhdid(pd);
		
		List<String> url=FileInputread.getURL(hd.getHdadddate());
		mv.addObject("url",url);
		pd.put("urlnum", url.size());
		mv.addObject("pd",pd);
		mv.addObject("hd",hd);
		mv.setViewName("hd/showhdcontent");
		
		return mv;
	}
	
	/**
	 * 新增活党员活动的页面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/hdinsert")
	public ModelAndView hdinsert() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd=this.getPageData();
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); //读取系统名称
		mv.addObject("pd",pd);
		mv.setViewName("hd/hdinsert");
		return mv;
	}
	
	/**
	 * 新增党员活动
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/insertHuodong")
	@ResponseBody
	public Object insertHuodong(HttpServletResponse response) throws Exception{
		
		Map<String,String> map=new HashMap<String,String>();
		PageData pd = new PageData();
		pd=this.getPageData();
		
		//pd.put("title", title);
		//pd.put("type", type);
		//pd.put("content", content);
		
		pd.put("uid", Jurisdiction.getUserid()); 
		pd.put("sdfhh", DateUtil.getsdfhh());
		
		TbHuodong huodong =HdService.getHdDateFromhdid(pd); //若有数据则说明近期已经提交过
		if("".equals(huodong)||huodong==null){
			String hdadddate=DateUtil.getTime();
			pd.put("hdadddate", hdadddate);
			HdService.insertHuodong(pd);
			map.put("result", "success");
		}else{
			map.put("result", "error"); //近期不能再次提交   以1小时为间隔
		}
		
		return map;
	}
	
	/**
	 * 删除党员活动
	 */
	@RequestMapping(value="/deleteHuodong")
	@ResponseBody
	public Object deleteHuodong() throws Exception{
		Map<String,String> map=new HashMap<String,String>();
		PageData pd = new PageData();
		pd=this.getPageData();
		HdService.deleteHuodong(pd);
		map.put("result", "success");
		return map;
		}
	
	/**
	 * 新增成功界面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/hdinsertsuccess")
	public ModelAndView hdinsertsuccess() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd=this.getPageData();
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); //读取系统名称
		mv.addObject("pd",pd);
		mv.setViewName("hd/hdinsertsuccess");
		return mv;
	}
	
	
	
	//对时间和标题进行截取 
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<TbHuodong> getdataandtitle(List tbself){
		for(int i=0;i<tbself.size();i++){
			for(int j=0;j<tbself.get(i).toString().length();j++){
				if(((TbHuodong) tbself.get(i)).getHdtitle().length()>20){
				((TbHuodong) tbself.get(i)).setHdtitle( ((TbHuodong) tbself.get(i)).getHdtitle().substring(0, 20)+"...");
				}
				((TbHuodong) tbself.get(i)).setHdadddate( ((TbHuodong) tbself.get(i)).getHdadddate().substring(0, 19));
			}
		}
		return tbself;	
	}
	
	
}
 