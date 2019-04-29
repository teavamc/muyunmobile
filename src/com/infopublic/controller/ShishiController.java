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

import com.infopublic.entity.TbShishi;
import com.infopublic.entity.Users;

import com.infopublic.service.LogManager;
import com.infopublic.service.UsersManager;
import com.infopublic.service.ShishiManager;

import com.infopublic.util.Const;
import com.infopublic.util.DateUtil;
import com.infopublic.util.FileDownload;
import com.infopublic.util.FileInputread;
import com.infopublic.util.Jurisdiction;
import com.infopublic.util.PageData;
import com.infopublic.util.Tools;


/**
 * 实时政事 
 * @author zc
 *
 */

@Controller
@RequestMapping(value="/shishi")   
public class ShishiController extends BaseController {  
	
	@Resource(name="usersService")
	private UsersManager usersService;
	@Resource(name="ShishiService")
	private ShishiManager ShishiService;
	@Resource(name="logService")
	private LogManager logService;
	
	private String path=""; 


	/**
	 * 实时政事
	 * @return
	 * @throws Exception
	 * @author zc
	 */
	@RequestMapping(value="/showallshishi") 
	public ModelAndView showallshishi() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); // 读取系统名称
		pd.put("begin", 0);
		pd.put("length", Integer.parseInt(Tools.GetValueByKey(Const.ALLPAGE,"shishifirstshow"))); // 实时政事首次展示条数
		List<TbShishi> shishi = ShishiService.getShishi(pd);
		this.getdataandcon(shishi);
		mv.addObject("firstfeednum", Tools.firstnum(shishi));
		mv.addObject("shishi", shishi);
		mv.setViewName("shishi/showallshishi");
		mv.addObject("pd", pd);
		return mv;
	}
	
	
	
	/**
	 * 下拉加载实时政事
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping(value="/showshishimore") 
	@ResponseBody
	public Object showshishimore() throws Exception{
		Map<String,String> map=new HashMap<String, String>();
		PageData pd = new PageData();
		pd = this.getPageData();
		int length=Integer.parseInt(pd.getString("length"));  //原始条数
		int tip=Integer.parseInt(pd.getString("tip")); //每次下拉  多展示2条     limit tip*length,2  
		pd.put("begin",((tip-1)*2+length));
		pd.put("length",2);
		List<TbShishi> shishi=ShishiService.getShishi(pd);
		this.getdataandcon(shishi);
		
		if(shishi.isEmpty()){//数据为空
			map.put("stop", "stop");
		}else{
		for(int i=1;i<=shishi.size();i++){  
			if(shishi.get(i-1)!=null){
			map.put("shiid"+i, shishi.get(i-1).getShiid()+"");
			map.put("type"+i, shishi.get(i-1).getType());
			map.put("pic"+i, shishi.get(i-1).getPic());
			map.put("video"+i, shishi.get(i-1).getVideo());
			map.put("adddate"+i, shishi.get(i-1).getAdddate());
			map.put("content"+i, shishi.get(i-1).getContent()+"");
			if(i==shishi.size()){
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
	
	private void getdataandcon(List<TbShishi> shishi) {
		// TODO Auto-generated method stub
		
	}



	/**
	 * 展示实时政事具体内容
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/shishishowcontent")
	public ModelAndView shishishowcontent() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd=this.getPageData();
		
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); //读取系统名称
		TbShishi shishi=ShishiService.getShishiFromshiid(pd);
		shishi.setAdddate(shishi.getAdddate().substring(0, 19));
		
		List<String> url=FileInputread.getURL(shishi.getPic());
		mv.addObject("url",url);
		
		pd.put("urlnum", url.size());
		mv.addObject("pd",pd);
		mv.addObject("shishi",shishi);
		mv.setViewName("shishi/shishishowcontent");
		return mv;
	}
	
	/**
	 * 实时政事图片展示
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping(value="/showshishiimage")
	public void showshishiimage(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String url=request.getParameter("url");
		if(!"".equals(url) && url!=null){
		url = url.substring(1, url.length()-1);   //注意：这里要去掉前后的   ' 号 
		FileInputread.Imageshow(request,response,url);	  //输出图片
		}
	}
	
	/**
	 * 实时政事图片原图下载
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
		String filePath=Const.FILEPATHIMG+bigimg;
		FileDownload.fileDownload(response, filePath, fileName);
	} 
	
}
 