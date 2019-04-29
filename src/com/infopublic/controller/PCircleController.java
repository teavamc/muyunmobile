package com.infopublic.controller;


import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
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

import com.infopublic.entity.TbPartycircle;
import com.infopublic.entity.TbPccomment;
import com.infopublic.entity.TbPcpraise;
import com.infopublic.entity.TbSencollect;
import com.infopublic.entity.TbXiaocun;
import com.infopublic.entity.TbYuqing;
import com.infopublic.entity.Users;
import com.infopublic.service.LogManager;
import com.infopublic.service.PCcommentManager;
import com.infopublic.service.PCircleManager;
import com.infopublic.service.PCpraiseManager;
import com.infopublic.service.SenCollectManager;
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
 * 暮云圈
 * @author yxy
 *
 */
@Controller
@RequestMapping(value="/pcircle")    
public class PCircleController extends BaseController {
	
	@Resource(name="usersService")
	private UsersManager usersService;
	@Resource(name="PCpraiseService")
	private PCpraiseManager PCpraiseService;
	@Resource(name="PCcommentService")
	private PCcommentManager PCcommentService;
	@Resource(name="PCircleService")
	private PCircleManager PCircleService;
	@Resource(name="SenCollectService")
	private SenCollectManager SenCollectService;
	@Resource(name="logService")
	private LogManager logService;

	/**
	 * 展示暮云圈
	 * @return
	 * @throws Exception
	 * @author yxy
	 */
	
	@RequestMapping(value="/showpcircle")
	public ModelAndView showpcircle() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); //读取系统名称 
		pd.put("begin", 0);
		pd.put("length", Integer.parseInt(Tools.GetValueByKey(Const.ALLPAGE, "pcirclefirstshow"))); //首次展示条数
		Session session=Jurisdiction.getSession();
		Users user=(Users) session.getAttribute(Const.SESSION_USER);
		
		String edit=pd.getString("edit");
		if("edit".equals(edit) && user.getIsparty()==1){ //党员管理者进入修改
			pd.put("edit", "toedit");
		}else if("hotedit".equals(edit) && user.getIsparty()==1){  //党员管理者 查看敏感评论
			pd.put("edit", "toedit");
		}
		
		List<TbPartycircle> pcircle;
		String mytip=pd.getString("mytip");  //以此判断展示全部还是个人的暮云圈
		if(!"".equals(mytip) && mytip!=null && "mytip".equals(mytip)){ //展示个人
			String uid=pd.getString("uid");
			pd.put("uid", uid);
			pcircle=PCircleService.getCircleByUid(pd);//个人暮云圈信息
			mv.addObject("mytip", "mytip");
			mv.addObject("downuid", uid);
		}else if("hotedit".equals(edit) && user.getIsparty()==1){  //党员管理者 查看敏感评论
			pcircle=PCircleService.getCircleOderBysennum(pd);//按敏感评论数目查询暮云圈信息
		}else{
			pcircle=PCircleService.getCircle(pd);//全部暮云圈信息
		}
		
		for (TbPartycircle tbPartycircle : pcircle) {
			if(tbPartycircle.getUid()==user.getUid()){//判断是否是我的暮云圈
				tbPartycircle.setIsmycircle((short) 1);
			}
			List<String> url=FileInputread.getURL(tbPartycircle.getImgurl());//得到空格分隔的路径
			tbPartycircle.setUrl(url);
			pd.put("pcid", tbPartycircle.getPcid());
			List<TbPcpraise> praise=PCpraiseService.getpraiseUname(pd); //点赞全部人名
			int index=1;
			for (TbPcpraise tbPcpraise : praise) { 
				if(tbPcpraise.getUid()==user.getUid()){ //判断用户是否已点赞
					tbPartycircle.setIspr((short) 1);
					tbPartycircle.setPrnum(index);   //以此判断在客户端上点赞的排序
				}
				index++;
			}
			String prtotal=PCpraiseService.getPraiseTotle(pd); //点赞人总数
			List<TbPccomment> comment=PCcommentService.getPccomment(pd); //评论
			int index2=1;
			for (TbPccomment tbPccomment : comment) {
				if(tbPccomment.getUid()==user.getUid()){ //判断用户是否已评论
					tbPartycircle.setIscom((short) 1); //判断用户是否参与评价标志
					tbPartycircle.setComnum(index2); //以此判断在客户端上评论的排序
					tbPccomment.setIsusercom((short) 1); //判断用户评论哪一条的标志    对应前端是否允许删除
				}
				index2++;
			}
			tbPartycircle.setPrtotal(prtotal);
			tbPartycircle.setTbPcpraise(praise);
			tbPartycircle.setTbPccomment(comment);
		}
		this.getheadimg(pcircle);
		mv.addObject("firstfeednum",Tools.firstnum(pcircle));  
		mv.addObject("pcircle",pcircle);
		mv.addObject("userheadimg",user.getHeadimg());
		mv.addObject("user",user);   //把当前用户信息传递过去
		
		//传递敏感字符数组
		List<TbSencollect> allSenCol = SenCollectService.getAllSenCol();
		Integer sencolnum=Tools.firstnum(allSenCol);
		String[] SenList=new String[sencolnum];
		for (int i = 0; i < sencolnum; i++) {
			SenList[i]=allSenCol.get(i).getSencollect();
			System.out.println("字符集合"+i+"为"+SenList[i]);
		}
		mv.addObject("SenList", SenList);
		mv.addObject("sennum", sencolnum);
		
		mv.setViewName("pcircle/showpcircle");
		
		mv.addObject("pd",pd);
		return mv;	
	}
	
	
	
	/**
	 * 下拉加载暮云圈
	 * @throws Exception
	 */
	@RequestMapping(value="/showpcirclemore")
	@ResponseBody
	public Object showpcirclemore() throws Exception{
		Map<String,Object> map=new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		int length=Integer.parseInt(pd.getString("length"));  //原始条数
		int tip=Integer.parseInt(pd.getString("tip")); //每次下拉  多展示2条     limit tip*length,2  
		pd.put("begin",((tip-1)*2+length));
		pd.put("length",2);
		
		List<TbPartycircle> pcircle;
		String mytip=pd.getString("mytip");  //以此判断展示全部还是个人的暮云圈
		if(!"".equals(mytip) && mytip!=null && "mytip".equals(mytip)){ //展示个人
			String downuid=pd.getString("downuid");
			pd.put("uid", downuid);
			pcircle=PCircleService.getCircleByUid(pd);//个人暮云圈信息
		}else{
			pcircle=PCircleService.getCircle(pd);//全部暮云圈信息
		}
		
		Session session=Jurisdiction.getSession();
		Users user=(Users) session.getAttribute(Const.SESSION_USER);
		for (TbPartycircle tbPartycircle : pcircle) {
			if(tbPartycircle.getUid()==user.getUid()){//判断是否是我的暮云圈
				tbPartycircle.setIsmycircle((short) 1);
			}
			List<String> url=FileInputread.getURL(tbPartycircle.getImgurl());//得到空格分隔的路径
			tbPartycircle.setUrl(url);
			pd.put("pcid", tbPartycircle.getPcid());
			List<TbPcpraise> praise=PCpraiseService.getpraiseUname(pd); //点赞全部人名
			int index=1;
			for (TbPcpraise tbPcpraise : praise) { 
				if(tbPcpraise.getUid()==user.getUid()){ //判断用户是否已点赞
					tbPartycircle.setIspr((short) 1);
					tbPartycircle.setPrnum(index);   //以此判断在客户端上点赞的排序
				}
				index++;
			}
			String prtotal=PCpraiseService.getPraiseTotle(pd); //点赞人总数
			List<TbPccomment> comment=PCcommentService.getPccomment(pd); //评论
			int index2=1;
			for (TbPccomment tbPccomment : comment) {
				if(tbPccomment.getUid()==user.getUid()){ //判断用户是否已评论
					tbPartycircle.setIscom((short) 1); //判断用户是否参与评价标志
					tbPartycircle.setComnum(index2); //以此判断在客户端上评论的排序
					tbPccomment.setIsusercom((short) 1); //判断用户评论哪一条的标志    对应前端是否允许删除
				}
				index2++;
			}
			tbPartycircle.setPrtotal(prtotal);
			tbPartycircle.setTbPcpraise(praise);
			tbPartycircle.setTbPccomment(comment);
		}
		this.getheadimg(pcircle);
		if(pcircle.isEmpty()){//数据为空
			map.put("stop", "stop");
		}else{
		for(int i=1;i<=pcircle.size();i++){  
			if(pcircle.get(i-1)!=null){
			map.put("uid"+i, pcircle.get(i-1).getUid());
			map.put("pcid"+i, pcircle.get(i-1).getPcid());
			map.put("headimg"+i, pcircle.get(i-1).getHeadimg());
			map.put("uname"+i, pcircle.get(i-1).getUname());
			map.put("adddate"+i, pcircle.get(i-1).getAdddate());
			map.put("pcontent"+i, pcircle.get(i-1).getPcontent());
			map.put("ismycircle"+i, pcircle.get(i-1).getIsmycircle()); //是否是我的暮云圈  
			map.put("prtotal"+i, pcircle.get(i-1).getPrtotal());
			map.put("praise"+i, pcircle.get(i-1).getTbPcpraise());
			map.put("comment"+i, pcircle.get(i-1).getTbPccomment());
			map.put("prtotal"+i, pcircle.get(i-1).getTbPcpraise().size());//点赞的总数
			map.put("ispr"+i, pcircle.get(i-1).getIspr());
			map.put("prnum"+i, pcircle.get(i-1).getPrnum());
			map.put("iscom"+i, pcircle.get(i-1).getIscom());
			map.put("comnum"+i, pcircle.get(i-1).getComnum());
			map.put("url"+i, pcircle.get(i-1).getUrl());  //图片集合
			map.put("urltotal"+i, pcircle.get(i-1).getUrl().size());//图片总数
			if(i==pcircle.size()){
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
	 * 新增暮云圈信息界面
	 * @return
	 */
	@RequestMapping("pcircleinsert")
	public ModelAndView pcircleinsert(){
		ModelAndView mv=new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String uid=pd.getString("uid");
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); //读取系统名称 
		mv.addObject("uid",uid);
		mv.setViewName("pcircle/pcircleinsert");
		return mv;
		
	}
	
	
	/**
	 * 新增
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/insertPcircle")
	@ResponseBody
	public Object insertPcircle(HttpServletResponse response) throws Exception{
		
		Map<String,String> map=new HashMap<String,String>();
		PageData pd = new PageData();
		pd=this.getPageData();
		
		Session path_session=Jurisdiction.getSession();
		if(pd.getString("tip")!=null && "haveNoImg".equals(pd.getString("tip"))){
			path_session.setAttribute("path", "");
		}
		
		System.out.println("新增"+path_session.getAttribute("path").toString());
		pd.put("imgurl", path_session.getAttribute("path").toString());
		pd.put("sdfhh", DateUtil.getsdfhh());
		
		List<TbPartycircle> pcircle=PCircleService.getPcircleDateFromuid(pd); //若有数据则说明近期已经提交过
		
		if(pcircle.size()==0 || pcircle==null){
			String adddate=DateUtil.getTime();
			pd.put("adddate", adddate);
			PCircleService.insertPcircle(pd);
			map.put("result", "success");
		}else{
			map.put("result", "error"); //近期不能再次提交   以1小时为间隔
		}
		
		return map;
	}
	
	
	/**
	 * 图片上传
	 * 多图上传（此方法 较为复杂）
	 * @author yxy
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/insertimage")
	@ResponseBody
	public Object insertimage(HttpServletRequest request) throws Exception{
		
		Map<String,String> map=new HashMap<String,String>();
		PageData pd = new PageData();
		pd=this.getPageData();
		String num=pd.getString("num");
		//System.out.println(num);
		Session path_session=Jurisdiction.getSession();
		if("0".equals(num)){
			path_session.setAttribute("path", "");
		System.out.println("图片路径：（num=0）"+path_session.getAttribute("path"));
			
		}
		
		pd.put("sdfhh", DateUtil.getsdfhh());
		
		List<TbPartycircle> pcircle=PCircleService.getPcircleDateFromuid(pd); //若有数据则说明近期已经提交过
		//System.out.println("---------这里测试数据个数"+pcircle.size());
		synchronized (this) {	//由于ajks的异步传输，这里存在并发性
			
		if(pcircle.size()==0 || pcircle==null){
			
			//System.out.println(num);
			String uploadimg=pd.getString("newBase64");
			path_session.setAttribute("path", path_session.getAttribute("path")+FileInputread.uploadimgsave(uploadimg,request)+" ");
		System.out.println("图片路径："+path_session.getAttribute("path"));
			int length=((String) path_session.getAttribute("path")).split(" ").length;
		System.out.println(length);
			map.put("result", "success");
			map.put("num", length+"");   //传回个数 ，判断是否全部上传完毕
		}else{
			//System.out.println("进入error");
			map.put("result", "error"); //近期不能再次提交   以1小时为间隔
		}
		}
		return map;
	}
	
	
	
	/**
	 * 多图片展示
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping(value="/showpcircleimage")
	public void showpcircleimage(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String url=request.getParameter("url");
		if(!"".equals(url) && url!=null){
		url = url.substring(1, url.length()-1);   //注意：这里要去掉前后的   ' 号 
		//System.out.println("得到每张图片路径："+url);
		FileInputread.Imageshow(request,response,url);	  //输出图片
		}	
	}
	
	/**
	 * 新增点赞
	 * @throws Exception
	 */
	@RequestMapping("addpraise")
	@ResponseBody
	public Object addpraise() throws Exception{
		Map<String,String> map=new HashMap<String,String>();
		PageData pd=new PageData();
		pd=this.getPageData();
		PCpraiseService.addPcpraise(pd);
		map.put("result", "success");
		return map;
	}
	
	/**
	 * 删除点赞
	 * @throws Exception
	 */
	@RequestMapping("deletepraise")
	@ResponseBody
	public Object deletepraise() throws Exception{
		Map<String,String> map=new HashMap<String,String>();
		PageData pd=new PageData();
		pd=this.getPageData();
		PCpraiseService.delPcpraise(pd);
		map.put("result", "success");
		return map;
	}
	
	
	/**
	 * 新增评论
	 * @throws Exception
	 */
	@RequestMapping("addcomment")
	@ResponseBody
	public Object addcomment() throws Exception{
		Map<String,String> map=new HashMap<String,String>();
		PageData pd=new PageData();
		pd=this.getPageData();
		String cdate=DateUtil.getSdfTimes();
		pd.put("cdate", cdate);
		String issensitive=pd.getString("issensitive");
		if("1".equals(issensitive)){
			Integer pcsennum=PCircleService.getSenTotalBypcid(pd)+1;
			pd.put("pcsennum", pcsennum);
			PCircleService.updatesennum(pd);
		}
		PCcommentService.addPccomment(pd);
		//System.out.println("新增评论序列号："+pd.getString("coid"));
		map.put("result", "success");
		return map;
	}
	
	/**
	 * 删除评论
	 * @throws Exception
	 */
	@RequestMapping("deletecomment")
	@ResponseBody
	public Object deletecomment() throws Exception{
		Map<String,String> map=new HashMap<String,String>();
		PageData pd=new PageData();
		pd=this.getPageData();
		System.out.println("删除评论序列号："+pd.getString("coid"));
		TbPccomment sensitiveBycoid = PCcommentService.getSensitiveBycoid(pd);
		//System.out.println("sensitiveBycoid="+sensitiveBycoid.toString());
		if("1".equals(sensitiveBycoid.getIssensitive())){
			String pcid=sensitiveBycoid.getPcid();
			pd.put("pcid", pcid);
			Integer pcsennum=PCircleService.getSenTotalBypcid(pd)-1;
			System.out.println("敏感删除    减少1   目前为："+pcsennum);
			pd.put("pcsennum", pcsennum);
			PCircleService.updatesennum(pd);
		}
		PCcommentService.delPccomment(pd);
		map.put("result", "success");
		return map;
	}
	
	/**
	 * 删除暮云圈
	 * @throws Exception
	 */
	@RequestMapping("deletecircle")
	@ResponseBody
	public Object deletecircle() throws Exception{
		Map<String,String> map=new HashMap<String,String>();
		PageData pd=new PageData();
		pd=this.getPageData();
		PCircleService.deletecircle(pd);
		map.put("result", "success");
		return map;
	}
	

	/**
	 * 得到头像
	 * @param tbself
	 * @return
	 * @throws Exception
	 */
	public List<TbPartycircle> getheadimg(List<TbPartycircle> tbself) throws Exception{
		for (TbPartycircle tbXiaocun : tbself) {
		Integer uid=tbXiaocun.getUid();
		PageData pd=new PageData();
		pd.put("uid", uid);
		Users user = usersService.findByUserid(pd);
		tbXiaocun.setHeadimg(user.getHeadimg());
		}
		return tbself;	
		}		

	
}
