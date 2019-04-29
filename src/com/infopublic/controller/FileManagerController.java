package com.infopublic.controller;

import javax.annotation.Resource;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.io.Serializable;

import org.json.JSONException;
import org.json.JSONObject;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.text.html.HTMLDocument.Iterator;

import org.apache.commons.io.FileUtils;
import org.apache.shiro.session.Session;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.ModelAndView;












import com.infopublic.entity.TbFileManager;
import com.infopublic.entity.Users;
import com.infopublic.service.FileManager;
import com.infopublic.service.UsersManager;
import com.infopublic.service.impl.FileService;
import com.infopublic.util.Const;
import com.infopublic.util.DateUtil;
import com.infopublic.util.FileInputread;
import com.infopublic.util.FileUpload;
import com.infopublic.util.FileDownload;
import com.infopublic.util.Jurisdiction;
import com.infopublic.util.PageData;
import com.infopublic.util.Tools;


@Controller
@RequestMapping(value="/FileManager")    
public class FileManagerController extends BaseController {
	
	@Resource(name="usersService")
	private UsersManager usersService;
	@Resource(name="FileService")
	private FileManager FileService;
	
	//展示下载中心
	@RequestMapping(value="/showfiles")
	public ModelAndView showfiles() throws Exception{
		
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); 
		
		/*拿到文件列表和分页的过程  开始*/
		String begin = pd.getString("begin"); 
		int length = Integer.parseInt(pd.getString("length")); //从url里面拿到两个键值,扔到后台
		
		pd.put("begin", Integer.parseInt(begin)); 
		pd.put("length", length); //再扔到前台
	
		List<TbFileManager> filelistall = FileService.getfileformupdate(pd); //拿到List对象集给前台遍历
		int totalnum = FileService.querryfilenumber(1);  //拿到所有的数据总数
		
		pd.put("one", Integer.parseInt(begin)/length+1); //第一页
		pd.put("total", totalnum/length+1);              //目标页数
		/*拿到文件列表和分页的过程  结束*/
		
		/*拿到用户信息  开始*/
		Session session=Jurisdiction.getSession(); //从Session里面拿
		Users user=(Users) session.getAttribute(Const.SESSION_USER);
		/*拿到用户信息  结束*/
		
		mv.addObject("filelistall",filelistall);
		mv.addObject("user",user);
		mv.setViewName("FileManager/showfiles");
		mv.addObject("pd", pd);
		return mv;
	}
	
	
	@RequestMapping(value = "/fileupload",method=RequestMethod.POST)
    public String fileupload(HttpServletRequest request,
           @RequestParam("file") MultipartFile file) throws Exception {
		
		    //获取当前页面的PageData
			PageData pd = new PageData();
			pd = this.getPageData();
			
	       //如果文件不为空，写入上传路径
	       if(!file.isEmpty()) {
	           
	    	   //上传文件路径
	           String path = request.getServletContext().getRealPath("/UserInputFile/");      
	           //上传文件名
	           String filename = file.getOriginalFilename();
	           //拿到转成Mb的文件大小
	           String filesize = String.valueOf((double)file.getSize()/1048576);
	           
	           
	           File filepath = new File(path,filename);
	         //判断路径是否存在，如果不存在就创建一个
	           if (!filepath.getParentFile().exists()) { 
	               filepath.getParentFile().mkdirs();
	           }
	           
	           pd.put("url", path);
	           pd.put("filename", filename);
	           pd.put("uid", Jurisdiction.getUserid());
	           pd.put("uname", Jurisdiction.getUsername());
	           pd.put("uploaddate", DateUtil.getSdfTimes());
	           pd.put("filesize", filesize.substring(0, 4));
	           FileService.insertNewFile(pd);
	           
	           //将上传文件保存到一个目标文件当中
	           file.transferTo(new File(path + File.separator + filename));
	           
	           return "FileManager/Inputsucceed";
	           
	       } else {
	           return "FileManager/Inputerror";
	       }

    }
	
	//下载文件
	@RequestMapping(value="/filedownload")
    public ResponseEntity<byte[]> filedownload(HttpServletRequest request,
            @RequestParam("filename") String filename,
            Model model)throws Exception {
    	
    	//获取当前页面的PageData
		PageData pd = new PageData();
		pd = this.getPageData();
		String fileid = pd.getString("filename");
		pd.put("filename", fileid);
		FileService.setfiledownnumber(pd);
		
       //下载文件路径
       String path = request.getServletContext().getRealPath("/UserInputFile/");
       File file = new File(path + File.separator + filename);
       HttpHeaders headers = new HttpHeaders();  
       
       //下载显示的文件名，解决中文名称乱码问题  
       String downloadFielName = new String(filename.getBytes("UTF-8"),"iso-8859-1");
       
       //通知浏览器以attachment（下载方式）打开图片
       headers.setContentDispositionFormData("attachment", downloadFielName); 
       
       //application/octet-stream ： 二进制流数据（最常见的文件下载）。
       headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
       return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),    
               headers, HttpStatus.CREATED);  
    }
	
	//展示下载内容的详情
		@RequestMapping(value="/filedownloadcontent")
		public ModelAndView filedoenloadcontent() throws Exception{
			ModelAndView mv = this.getModelAndView();
			PageData pd = new PageData();
			pd = this.getPageData();
			
			String fileid = pd.getString("fileid"); //从url拿到fileid
			
			pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); // 读取系统名称
			TbFileManager fileformfileid = FileService.getfilefromfileid(fileid);
			
			mv.addObject("filecontent",fileformfileid);
			
			mv.setViewName("FileManager/filedownloadcontent");
			mv.addObject("pd", pd);
			return mv;
		}
		
		//上传成功
		@RequestMapping(value="/inputsucceed")
		public ModelAndView inputsucceed() throws Exception{
			ModelAndView mv = this.getModelAndView();
			/*PageData pd = new PageData();
			pd = this.getPageData();
			pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); // 读取系统名称
			
*/			mv.setViewName("FileManager/inputsucceed");
			/*mv.addObject("pd", pd);*/
			return mv;
		}
		//上传失败
		@RequestMapping(value="/inputerror")
		public ModelAndView inputerror() throws Exception{
			ModelAndView mv = this.getModelAndView();
			PageData pd = new PageData();
			pd = this.getPageData();
			pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); // 读取系统名称
			mv.setViewName("FileManager/inputerror");
			mv.addObject("pd", pd);
			return mv;
		}
	

}
