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

import com.infopublic.entity.TbYqcomment;
import com.infopublic.entity.TbYuqing;
import com.infopublic.entity.Users;
import com.infopublic.service.LogManager;
import com.infopublic.service.UsersManager;
import com.infopublic.service.YQcommentManager;
import com.infopublic.service.YuQingManager;
import com.infopublic.util.Const;
import com.infopublic.util.DateUtil;
import com.infopublic.util.FileDownload;
import com.infopublic.util.FileInputread;
import com.infopublic.util.Jurisdiction;
import com.infopublic.util.PageData;
import com.infopublic.util.Tools;


/**
 * 舆情上报 
 * @author yxy
 *
 */
@Controller
@RequestMapping(value="/yuqing")    
public class YuQingController extends BaseController {
	
	@Resource(name="usersService")
	private UsersManager usersService;
	@Resource(name="YuQingService")
	private YuQingManager YuQingService;
	@Resource(name="logService")
	private LogManager logService;
	@Resource(name="YQcommentService")
	private YQcommentManager YQcommentService;
	
	
	private String path=""; 


	/**
	 * 展示舆情
	 * @return
	 * @throws Exception
	 * @author yxy
	 */
	@RequestMapping(value="/showallyuqing")
	public ModelAndView showallyuqing() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); // 读取系统名称
		pd.put("begin", 0);
		pd.put("length", Integer.parseInt(Tools.GetValueByKey(Const.ALLPAGE,"yuqingfirstshow"))); // 舆情首次展示条数
		Session session=Jurisdiction.getSession();
		Users user=(Users) session.getAttribute(Const.SESSION_USER);
		List<TbYuqing> yuqing;
		String edit=pd.getString("edit");
		
		String searchinfo=pd.getString("searchinfo");//搜索结果
		
		if(!"".equals(searchinfo) && searchinfo!=null ){ 
			
			if("".equals(edit) || edit==null){//普通用户进入
				pd.put("remark", 1);
				yuqing= YuQingService.getYuqingFromInfo(pd);
			}
			//else if("toremark".equals(edit) && user.getIsparty()==1){ //党员进入 审核舆情
			//	pd.put("remark", 0);
			//	yuqing= YuQingService.getYuqingFromInfo(pd);
			//}
			else if("toedit".equals(edit) && user.getIsparty()==1){//党员进入编辑舆情
				pd.put("remark", 1);
				yuqing= YuQingService.getYuqingFromInfo(pd);
				pd.put("edit", "toedit"); //
				pd.put("isparty", "1");
			}else{//非党员用户  非法进入
				pd.put("remark", 1);
				yuqing= YuQingService.getYuqingFromInfo(pd);
			}
		}
		
		else{
		if("".equals(edit) || edit==null){//普通用户进入
			pd.put("remark", 1);
			yuqing= YuQingService.getYuqing(pd);
		}
		//else if("toremark".equals(edit) && user.getIsparty()==1){ //党员进入 审核舆情
		//	pd.put("remark", 0);
		//	yuqing= YuQingService.getYuqing(pd);
		//}
		else if("toedit".equals(edit) && user.getIsparty()==1){//党员进入编辑舆情
			pd.put("remark", 1);
			yuqing= YuQingService.getYuqing(pd);
			pd.put("edit", "toedit"); //
			pd.put("isparty", "1");
		}else{//非党员用户  非法进入
			pd.put("remark", 1);
			yuqing= YuQingService.getYuqing(pd);
		}
		
		}
		
		this.getdataandcon(yuqing);
		mv.addObject("firstfeednum", Tools.firstnum(yuqing));
		mv.addObject("yuqing", yuqing);
		mv.setViewName("yuqing/showallyuqing");
		mv.addObject("pd", pd);
		return mv;
	}
	
	
	
	/**
	 * 下拉加载投诉咨询
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/showyuqingmore")
	@ResponseBody
	public Object showyuqingmore() throws Exception{
		Map<String,String> map=new HashMap<String, String>();
		PageData pd = new PageData();
		pd = this.getPageData();
		int length=Integer.parseInt(pd.getString("length"));  //原始条数
		int tip=Integer.parseInt(pd.getString("tip")); //每次下拉  多展示2条     limit tip*length,2  
		pd.put("begin",((tip-1)*2+length));
		pd.put("length",2);
		Session session=Jurisdiction.getSession();
		Users user=(Users) session.getAttribute(Const.SESSION_USER);
		List<TbYuqing> yuqing;
		String edit=pd.getString("edit");  //党员管理编辑操作
		
		String searchinfo=pd.getString("searchinfo");//搜索结果
		if(!"".equals(searchinfo) && searchinfo!=null ){ 
			
			if("".equals(edit) || edit==null){//普通用户进入
				pd.put("remark", 1);
				yuqing= YuQingService.getYuqingFromInfo(pd);
			}
			//else if("toremark".equals(edit) && user.getIsparty()==1){ //党员进入 审核舆情
			//	pd.put("remark", 0);
			//	yuqing= YuQingService.getYuqingFromInfo(pd);
			//}
			else if("toedit".equals(edit) && user.getIsparty()==1){//党员进入编辑舆情
				pd.put("remark", 1);
				yuqing= YuQingService.getYuqingFromInfo(pd);
				pd.put("shouquan", "shouquan"); //
			}else{//非党员用户  非法进入
				pd.put("remark", 1);
				yuqing= YuQingService.getYuqingFromInfo(pd);
			}
		}
		
		else{
		if("".equals(edit) || edit==null){//普通用户进入
			pd.put("remark", 1);
			yuqing= YuQingService.getYuqing(pd);
		}
		//else if("toremark".equals(edit) && user.getIsparty()==1){ //党员进入 审核舆情
		//	pd.put("remark", 0);
		//	yuqing= YuQingService.getYuqing(pd);
		//}
		else if("toedit".equals(edit) && user.getIsparty()==1){//党员进入编辑舆情
			pd.put("remark", 1);
			yuqing= YuQingService.getYuqing(pd);
			pd.put("shouquan", "shouquan"); //
		}else{//非党员用户  非法进入
			pd.put("remark", 1);
			yuqing= YuQingService.getYuqing(pd);
		}
		
		}
		this.getdataandcon(yuqing);
		
		if(yuqing.isEmpty()){//数据为空
			map.put("stop", "stop");
		}else{
		for(int i=1;i<=yuqing.size();i++){  
			if(yuqing.get(i-1)!=null){
			map.put("yqid"+i, yuqing.get(i-1).getYqid()+"");
			map.put("yqtype"+i, yuqing.get(i-1).getYqtype());
			map.put("adddate"+i, yuqing.get(i-1).getAdddate());
			map.put("content"+i, yuqing.get(i-1).getContent()+"");
			if(i==yuqing.size()){
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
	@RequestMapping(value="/yuqingshowcontent")
	public ModelAndView yuqingshowcontent() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd=this.getPageData();
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); //读取系统名称
		//String yqid=pd.getString("yqid");
		
		String edit=pd.getString("edit");//
		Session session=Jurisdiction.getSession();
		Users user=(Users) session.getAttribute(Const.SESSION_USER);
		List<TbYqcomment> yqcomment=YQcommentService.getYqcomment(pd);
		TbYuqing yuqing=YuQingService.getYuqingFromyqid(pd);
		
		for (TbYqcomment tbYqcomment : yqcomment) {
			if(tbYqcomment.getUid()==user.getUid()){
				tbYqcomment.setIsusercom((short) 1);
			}
		}
		
		yuqing.setYqcomment(yqcomment);
		yuqing.setAdddate(yuqing.getAdddate().substring(0, 19));
		List<String> url=FileInputread.getURL(yuqing.getUploadimage());
		mv.addObject("user",user);
		mv.addObject("url",url);
		pd.put("urlnum", url.size());
		mv.addObject("yuqing",yuqing);
		if("toedit".equals(edit) && user.getIsparty()==1){//党员进入编辑舆情
			pd.put("edit", "toedit"); 
			pd.put("isparty", 1); 
			mv.addObject("pd",pd);
			mv.setViewName("management/manageyuqingcontent");
		}else{
		mv.addObject("pd",pd);
		mv.setViewName("yuqing/yuqingshowcontent");
		}
		return mv;
	}
	
	/**
	 * 新增评论
	 * @throws Exception
	 */
	@RequestMapping("addyqcomment")
	@ResponseBody
	public Object addyqcomment() throws Exception{
		Map<String,String> map=new HashMap<String,String>();
		PageData pd=new PageData();
		pd=this.getPageData();
		String cdate=pd.getString("datetime");
		System.out.println("日期"+cdate);
		pd.put("datetime", cdate);
		YQcommentService.addYqcomment(pd);
		map.put("result", "success");
		return map;
	}
	
	/**
	 * 删除评论
	 * @throws Exception
	 */
	@RequestMapping("deleteyqcomment")
	@ResponseBody
	public Object deleteyqcomment() throws Exception{
		Map<String,String> map=new HashMap<String,String>();
		PageData pd=new PageData();
		pd=this.getPageData();
		YQcommentService.delYqcomment(pd);
		map.put("result", "success");
		return map;
	}
	
	/**
	 * 展示具体的评论内容
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("showyqccontent")
	public ModelAndView showyqccontent() throws Exception{
		ModelAndView mv=new ModelAndView();
		PageData pd=new PageData();
		pd=this.getPageData();
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); //读取系统名称
		TbYqcomment yqcon=YQcommentService.getYqccontent(pd);
		mv.addObject("yqcon",yqcon);
		mv.addObject("pd", pd);
		mv.setViewName("yuqing/showyqccontent");
		return mv;
		
		
	}
	

	/**
	 * 新增界面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/yuqinginsert")
	public ModelAndView yuqinginsert() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd=this.getPageData();
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); //读取系统名称
		mv.addObject("pd",pd);
		mv.setViewName("yuqing/yuqinginsert");
		return mv;
	}
	
	/**
	 * 新增舆情
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/insertYuqing")
	@ResponseBody
	public Object insertYuqing(HttpServletResponse response) throws Exception{
		Map<String,String> map=new HashMap<String,String>();
		PageData pd = new PageData();
		pd=this.getPageData();
		if(pd.getString("tip")!=null && "haveNoImg".equals(pd.getString("tip"))){
			path="";   //判断是否提交了图片
		}
		pd.put("uploadimage", path);
		//pd.put("yqtype", yqtype);
		//pd.put("content", content);
		pd.put("adduid", Jurisdiction.getUserid()); 
		pd.put("adduname", Jurisdiction.getUsername()); 
		pd.put("sdfhh", DateUtil.getsdfhh());
		TbYuqing yuqing=YuQingService.getYuqingDateFromyqid(pd); //若有数据则说明近期已经提交过
		if("".equals(yuqing)||yuqing==null){
			String adddate=DateUtil.getTime();
			pd.put("adddate", adddate);
			YuQingService.insertYuqing(pd);
			map.put("result", "success");
		}else{
			map.put("result", "error"); //近期不能再次提交   以1小时为间隔
		}
		
		return map;
	}
	
	/**
	 * 审核舆情  （赞无需审核）
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/yuqingtoremark")
	@ResponseBody
	public Object yuqingtoremark() throws Exception{
		Map<String,String> map=new HashMap<String,String>();
		PageData pd = new PageData();
		pd=this.getPageData();
		pd.put("remark", 1);
		YuQingService.updateYuqing(pd);
		map.put("result", "success");
		return map;
		}
	
	/**
	 * 删除舆情
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/yuqingdel")
	@ResponseBody
	public Object yuqingdel() throws Exception{
		Map<String,String> map=new HashMap<String,String>();
		PageData pd = new PageData();
		pd=this.getPageData();
		YuQingService.deleteYuqing(pd);
		map.put("result", "success");
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
		System.out.println(num);
		if("0".equals(num)){
			//System.out.println("没去掉前"+path);
			path="";   //若是第一张图片，则将path初值赋"";
		}
		pd.put("adduid", Jurisdiction.getUserid()); 
		pd.put("sdfhh", DateUtil.getsdfhh());
		TbYuqing yuqing=YuQingService.getYuqingDateFromyqid(pd); //若有数据则说明近期已经提交过
		//System.out.println("---------");
		synchronized (this) {	//由于ajks的异步传输，这里存在并发性
		if("".equals(yuqing)||yuqing==null){
			//System.out.println(num);
			String uploadimg=pd.getString("newBase64");
			path=this.path+FileInputread.uploadimgsave(uploadimg,request)+" ";//以空格分隔多个图片路径
			int length=path.split(" ").length;
			//System.out.println("空格分隔后的path"+path);
			map.put("result", "success");
			map.put("num", length+"");   //传回个数 ，判断是否全部上传完毕
			//System.out.println("path个数"+length);
		}else{
			map.put("result", "error"); //近期不能再次提交   以1小时为间隔
		}
		}
		return map;
	}
	
	/**
	 * 图片展示
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping(value="/showyuqingimage")
	public void showyuqingimage(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String url=request.getParameter("url");
		//System.out.println(url);
		if(!"".equals(url) && url!=null){
		url = url.substring(1, url.length()-1);   //注意：这里要去掉前后的   ' 号 
		//System.out.println(url);
		FileInputread.Imageshow(request,response,url);	  //输出图片
		}
		
		
		
	}
	
	/**
	 * 图片原图下载
	 * @param request
	 * @param response
	 */
	@RequestMapping("downloadimg")
	public void downloadimg(HttpServletRequest request,HttpServletResponse response){
		String smallimg=request.getParameter("url"); //得到压缩后的图片路径
		String fileName=request.getParameter("tip"); //得到图片的编号方便用户看到文件名   'img1'  此时还没有文件后缀名
		String bigimg=smallimg.substring(smallimg.lastIndexOf("/")+1, smallimg.length()-1); //得到存放路径下的图片名
		String lasturl=bigimg.substring(bigimg.lastIndexOf("."),bigimg.length());//获取图片名的后缀名
		fileName=fileName.substring(1,fileName.length()-1)+lasturl; //此时已经是完整返回文件名
		//System.out.println(fileName);
		String filePath=Const.FILEPATHIMG+bigimg;
		FileDownload.fileDownload(response, filePath, fileName);
	} 
	

	
	
	/**
	 * 新增成功界面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/yuqinginsertsuccess")
	public ModelAndView yuqinginsertsuccess() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd=this.getPageData();
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); //读取系统名称
		mv.addObject("pd",pd);
		mv.setViewName("yuqing/yuqingsuccess");
		return mv;
	}



	
	//对时间和内容进行截取 
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<TbYuqing> getdataandcon(List tbself){
		for(int i=0;i<tbself.size();i++){
			for(int j=0;j<tbself.get(i).toString().length();j++){
				if(((TbYuqing) tbself.get(i)).getContent().length()>50){
				((TbYuqing) tbself.get(i)).setContent( ((TbYuqing) tbself.get(i)).getContent().substring(0, 50)+"...");
				}
				((TbYuqing) tbself.get(i)).setAdddate( ((TbYuqing) tbself.get(i)).getAdddate().substring(0, 19));
			}
		}
		return tbself;	
	}
	
	
	
}
