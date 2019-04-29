package com.infopublic.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.infopublic.entity.TbPartymember;
import com.infopublic.entity.TbSelfeval;
import com.infopublic.service.PartymemberManager;
import com.infopublic.service.SelfevalManager;
import com.infopublic.service.UsersManager;
import com.infopublic.util.AppUtil;
import com.infopublic.util.Const;
import com.infopublic.util.DateUtil;
import com.infopublic.util.Jurisdiction;
import com.infopublic.util.PageData;
import com.infopublic.util.Tools;

@Controller
@RequestMapping("/selfeval")   
public class SelfevalController extends BaseController{
	@Resource(name="partymemberService")
	private PartymemberManager partymemberService;
	@Resource(name="usersService")
	private UsersManager usersService;
	@Resource(name="selfevalService")
	private SelfevalManager selfevalService;
	
	/**
	 * **党员自评互评
	 * @throws Exception 
	 */
	@RequestMapping("assessmentmain")
	public ModelAndView assessmentmain() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); // 读取系统名称
		pd.put("pagelength", Tools.GetValueByKey(Const.ALLPAGE, "pageNotLoadmore")); //读取分页长度
		String ass=pd.getString("ass");
		if("ass2".equals(ass)){  //判断导航条起始位置
			mv.addObject("judgeass", 1);  //第二条
		}else if("ass3".equals(ass)){
			mv.addObject("judgeass", 2); //第三条
		}else{
			mv.addObject("judgeass", 0);
		}
		int begin1 = this.prezero(pd.getString("begin1"));
		int begin2 = this.prezero(pd.getString("begin2"));
		int begin3 = this.prezero(pd.getString("begin3"));
		int length = Integer.parseInt(pd.getString("pagelength"));
		pd.put("begin1", begin1);
		pd.put("begin2", begin2);
		pd.put("begin3", begin3);	
		pd.put("length", length);
		String uid=Jurisdiction.getUserid();
		TbPartymember tbmember=partymemberService.getpartymemberfromuid(uid);     //根据账号uid查找党员信息               
		pd.put("uid",uid);//根据测评人员编号uid,自身党员编号pid查找自评互评信息
		pd.put("pid",tbmember.getPid());

		//自评
		int totalnum1=selfevalService.totalall1(pd);
		pd.put("one1", begin1/length+1);
		if(totalnum1%length!=0){//判断是否有余数，有则总页数加1
			pd.put("total1", totalnum1/length+1);
		}else{
			if(totalnum1==0){pd.put("total1", 1);}
			else{pd.put("total1", totalnum1/length);}
		}
		List<TbSelfeval> tbself=selfevalService.getassessfromuid(pd);
		this.gettitleanddate(tbself);
		mv.addObject("tbself", tbself);
		//我评
		int totalnum2=selfevalService.totalall2(pd);
		pd.put("one2", begin2/length+1);
		if(totalnum2%length!=0){//判断是否有余数，有则总页数加1
			pd.put("total2", totalnum2/length+1);
		}else{
			if(totalnum2==0){pd.put("total2", 1);}
			else{pd.put("total2", totalnum2/length);}
		}
		List<TbSelfeval> tbself1=selfevalService.getassessfromuidtohim(pd);
		this.gettitleanddate(tbself1);
		mv.addObject("tbself1", tbself1);
		//他评
		int totalnum3=selfevalService.totalall3(pd);
		pd.put("one3", begin3/length+1);
		if(totalnum3%length!=0){//判断是否有余数，有则总页数加1
			pd.put("total3", totalnum3/length+1);
		}else{
			if(totalnum3==0){pd.put("total3", 1);}
			else{pd.put("total3", totalnum3/length);}
		}
		List<TbSelfeval> tbself2=selfevalService.getassessfromuidtome(pd);
		this.gettitleanddate(tbself2);
		mv.addObject("tbself2", tbself2);
		
		mv.addObject("pd",pd);
		mv.setViewName("selfeval/assessmain");
		return mv;
	}
	
		
		/**
		 * 查看测评信息（细节）
		 * @return
		 * @throws Exception
		 */
		@RequestMapping("showassess")   //未完成  12.10
		public ModelAndView showassess() throws Exception{
			ModelAndView mv =new ModelAndView();
			PageData pd=this.getPageData();
			String sfid=pd.getString("sfid");
			String type=pd.getString("type");
			pd.put("type", type);
			pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); // 读取系统名称
			TbSelfeval selfeval=selfevalService.getassfromsfid(sfid);
			selfeval.setSdate(selfeval.getSdate().substring(0, 19));
			mv.addObject("pd",pd);
			mv.addObject("selfeval",selfeval);
			mv.setViewName("selfeval/showassess");
			return mv;
			
		}
	
	
	/**
	 * 进入新增测评信息界面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("insertassess")
	public ModelAndView insertassess() throws Exception{
		 ModelAndView mv=new ModelAndView();
		 PageData pd=this.getPageData();
		 pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); // 读取系统名称
		 pd.put("uid", Jurisdiction.getUserid());
		 //根据uid查找党员资料
		 String uid=pd.getString("uid");
		 TbPartymember tbmember=partymemberService.getpartymemberfromuid(uid);
	//	 Users user = usersService.findByUserid(pd);
	//	 pd.put("username", value)
		 mv.addObject("pd",pd);
		 mv.addObject("tbmember",tbmember);
		 mv.setViewName("selfeval/insertassess");
		return mv;
		 
	}
	
	/**
	 * 新增测评
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("assinsert")
	@ResponseBody
	public Object assinsert() throws Exception{
		 Map<String,String> map=new HashMap<String,String>();
		 PageData pd=this.getPageData();
		 String pname=pd.getString("pname");
		 //根据党员名获取党员pid
		 String pid=partymemberService.getpidbypname(pname);
		 if(pid!=null){  //新增测评
			 String ptitle=pd.getString("ptitle");
			 String pstate=pd.getString("pstate");
			 String pscore=pd.getString("pscore");
			 String sdate=DateUtil.getTime();
			 //获取测评人uid  uname
			 pd.put("uname", Jurisdiction.getUsername());
			 pd.put("uid", Jurisdiction.getUserid());
			 pd.put("pid", pid);
			 pd.put("title", ptitle);
			 pd.put("state", pstate);
			 pd.put("score", pscore);
			 pd.put("sdate", sdate);
			 selfevalService.insertsel(pd);
			 map.put("result", "success");
		 }
		 else{
			 map.put("result", "errorname");  //党员不存在
		 }
		return AppUtil.returnObject(pd, map);
		 
	}
	
	/**
	 * 修改测评
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("updateass")
	@ResponseBody
	public Object updateass() throws Exception{
		 Map<String,String> map=new HashMap<String,String>();
		 PageData pd=this.getPageData();
//			 String title=pd.getString("title");
//			 String state=pd.getString("state");
//			 String score=pd.getString("score");
			 String sdate=DateUtil.getTime();
			 pd.put("sdate", sdate);
			 selfevalService.updateselfromselfid(pd);
			 map.put("result", "success");
		return AppUtil.returnObject(pd, map);
		 
	}
	
	/**
	 * 删除测评
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("deleteass")
	@ResponseBody
	public Object deleteass() throws Exception{
		 Map<String,String> map=new HashMap<String,String>();
		 PageData pd=this.getPageData();
		 String sfid=pd.getString("sfid");
		 selfevalService.deleteselfromselfid(sfid);
		 map.put("result", "success");
	     return AppUtil.returnObject(pd, map);
		 
	}
	
	public static void main(String[] args) {
		String date=DateUtil.getTime();
		System.out.println(date);
	}
	
	//空值取值
		public int prezero(String begin){
			if("".equals(begin)||begin==null){
				begin=0+"";
			}
			return Integer.parseInt(begin);
		}

		//对标题及时间进行截取 时间截取为yyyy-mm-dd
			@SuppressWarnings({ "unchecked", "rawtypes" })
			public List<TbSelfeval> gettitleanddate(List tbself){
				for(int i=0;i<tbself.size();i++){
					for(int j=0;j<tbself.get(i).toString().length();j++){
						((TbSelfeval) tbself.get(i)).setSdate( ((TbSelfeval) tbself.get(i)).getSdate().substring(0, 10));
						if(((TbSelfeval) tbself.get(i)).getTitle().length()>5){
						((TbSelfeval) tbself.get(i)).setTitle( ((TbSelfeval) tbself.get(i)).getTitle().substring(0, 5)+"..");
						}else{
							break;
						}
					}
				}
				return tbself;	
			}
	
}
