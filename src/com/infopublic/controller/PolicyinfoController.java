package com.infopublic.controller;

import java.io.File;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.shiro.session.Session;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.infopublic.entity.PoInfo;
import com.infopublic.entity.TbSelfeval;
import com.infopublic.entity.Users;
import com.infopublic.service.LogManager;
import com.infopublic.service.PoInfoManager;
import com.infopublic.service.UsersManager;
import com.infopublic.util.Const;
import com.infopublic.util.FileUpload;
import com.infopublic.util.Jurisdiction;
import com.infopublic.util.PageData;
import com.infopublic.util.Tools;


/** 
 * 政策与公告
 * 类名称：PolicyinfoController
 * @version
 */
@Controller
@RequestMapping(value="/policyinfo")
public class PolicyinfoController extends BaseController {
	
	@Resource(name="usersService")
	private UsersManager usersService;
	@Resource(name="poinfoService")
	private PoInfoManager poinfoService;
	@Resource(name="logService")
	private LogManager logService;
	
	@RequestMapping(value="/test")
	public ModelAndView showtest() throws Exception{
		ModelAndView mv=new ModelAndView();
		mv.setViewName("user/test1");
		return mv;
		
	}

	//展示政策与公告
	@RequestMapping(value="/showpolicyforuser")
	public ModelAndView showpolicyforuser() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); // 读取系统名称
		pd.put("pagelength", Integer.parseInt(Tools.GetValueByKey(Const.ALLPAGE, "pageNotLoadmore"))); // 读取政策与公告分页长度
		
		// 公告列表
		List<PoInfo> policyinfolist = poinfoService.querryAllBytype("公告"); //搜索所有公告类型的条目
		this.getdata(policyinfolist);  //取  数据
		this.gettitle(policyinfolist); //取 公告 类型的 标题
		for (int i = policyinfolist.size() - 1; i >= 0; i--) {// 对发布事件的发布条数截取  截取最近5条
			PoInfo poinfo = policyinfolist.get(i); //查询多少行  size就是多少
			if (i >= 5)
				policyinfolist.remove(poinfo);
		}
		mv.addObject("policyinfolist1", policyinfolist); //分了页面啊，第一个页面是公告不，所以这里就是把查询公告的list存1
		
		
		// 政策列表 大题同上
		List<PoInfo> policyinfolist2 = poinfoService.querryAllBytype("政策"); //搜索所有政策类型的条目
		this.getdata(policyinfolist2);
		this.gettitle(policyinfolist2);
		for (int i = policyinfolist2.size() - 1; i >= 0; i--) {// 对发布事件的发布条数截取  截取最近5条
			PoInfo poinfo = policyinfolist2.get(i);
			if (i >= 5)
				policyinfolist2.remove(poinfo);
		}
		mv.addObject("policyinfolist2", policyinfolist2);

		mv.setViewName("user/policyinfoforuser");
		mv.addObject("pd", pd);
		return mv;
	}
	
	
	//对信息时间进行截取 去掉时分秒
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<PoInfo> getdata(List tbself){
		for(int i=0;i<tbself.size();i++){
			for(int j=0;j<tbself.get(i).toString().length();j++){
				((PoInfo) tbself.get(i)).setReldate( ((PoInfo) tbself.get(i)).getReldate().substring(0, 10));
			}
		}
		return tbself;	
	}
	
	
	//对题目进行截取 
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<PoInfo> gettitle(List tbself){
		for(int i=0;i<tbself.size();i++){
			for(int j=0;j<tbself.get(i).toString().length();j++){
				if(((PoInfo) tbself.get(i)).getTitle().length()>9){
				((PoInfo) tbself.get(i)).setTitle( ((PoInfo) tbself.get(i)).getTitle().substring(0, 9)+"..");
				}else{
					break;
				}
			}
		}
		return tbself;	
	}
	
	
		
	//展示政策与公告（具体）
	@RequestMapping(value="/policyinfocontent")
	public ModelAndView policyinfocontent() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData(); //新的页面
		pd = this.getPageData(); //获得这个页面的数据
		String poinid = pd.getString("poinid"); //拿到页面id
		PoInfo poinfo=poinfoService.querryById(poinid);  //通过id来查询页面
		poinfo.setReldate(poinfo.getReldate().substring(0, 19));//对发布事件发布时间进行截取 去掉时分秒
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); //读取系统名称
		mv.addObject("pd",pd);
		mv.addObject("poinfo",poinfo);
		mv.setViewName("user/policyinfocontent");
		return mv;	
	}
		

	//展示政策与公告（查看更多）
	@RequestMapping(value="/policyinfolist")
	@ResponseBody 
	public ModelAndView policyinfolist() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData(); //新页面
		
		pd = this.getPageData();  //拿到相应的页面数据 
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); //读取系统名称
		pd.put("pagelength", Integer.parseInt(Tools.GetValueByKey(Const.ALLPAGE, "pageNotLoadmore"))); //读取政策与公告分页长度

		String type = pd.getString("type"); //取 数据类型
		String begin = pd.getString("begin"); //取起始
		int length = Integer.parseInt(pd.getString("length")); //取长度
		String tip = pd.getString("tip"); 

		pd.put("type", type); //数据类别 是政策还是公告
		pd.put("begin", Integer.parseInt(begin)); //分页开始时的数据条目
		pd.put("length", length); //每页显示的固定数据条目

		List<PoInfo> policyinfolistall = poinfoService.showallinfo(pd);
		this.getdata(policyinfolistall); //拿到 
		this.gettitle(policyinfolistall); //拿到标题

		int totalnum=poinfoService.totalallinfo(type);  //查询到所有相关类型的页数
		pd.put("one", Integer.parseInt(begin)/length+1); //第一页
		pd.put("total", totalnum/length+1);              //总页面
		
		mv.addObject("pd",pd);
		mv.addObject("policyinfolistall",policyinfolistall);
		mv.setViewName("user/policyinfolist");

		return mv;	
	}
		
		//搜索
	@RequestMapping(value="/policyinfolistsearch",produces="application/json;charset=UTF-8")
	@ResponseBody 
	public ModelAndView policyinfolistsearch() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData(); //新页面
		pd = this.getPageData(); //取页面数据

		String searchInput = pd.getString("searchInput"); //将页面输入的值 UTF8格式 放入searchInput
		String begin = pd.getString("begin"); //开始分页时的数据序号
		int length = Integer.parseInt(pd.getString("length")); //确定每页显示的数据长度
		String tip = pd.getString("tip"); //

		pd.put("searchInput", searchInput);
		pd.put("begin", Integer.parseInt(begin));
		pd.put("length", length);

		List<PoInfo> policyinfolistsearch = poinfoService.showallinfofromsearch(pd); //通过搜索的标题模糊查询所有结果
		this.getdata(policyinfolistsearch); //拿到这个list的时间
		this.gettitle(policyinfolistsearch); //拿到这个list的标题
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); //读取系统名称
		int totalnum=poinfoService.totalSearchPoInfoforpage(searchInput); //通过标题模糊查询id列表个数,确定数据总数 用来分页
		pd.put("totalnum", totalnum); 
		
		//判断是下一页还是上一页还是开始页
		if(tip=="firstpage"){ //开始页
			pd.put("one", 1);
		}else{
			pd.put("one", Integer.parseInt(begin)/length+1);
		}
		//判断是否有余数，有则总页数加1
		if(totalnum%length!=0){
			pd.put("total", totalnum/length+1);
		}else{
			pd.put("total", totalnum/length);
		}
		mv.addObject("pd",pd);
		mv.addObject("policyinfolistsearch",policyinfolistsearch);
		mv.setViewName("user/policyinfolistsearch");
		return mv;	
	}

}
