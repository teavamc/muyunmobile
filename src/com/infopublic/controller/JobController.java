package com.infopublic.controller;

import java.io.File;
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

import com.infopublic.entity.PoInfo;
import com.infopublic.entity.TbGuide;
import com.infopublic.entity.TbJob;
import com.infopublic.entity.Users;
import com.infopublic.service.JobManager;
import com.infopublic.service.LogManager;
import com.infopublic.service.UsersManager;
import com.infopublic.util.Const;
import com.infopublic.util.FileInputread;
import com.infopublic.util.Jurisdiction;
import com.infopublic.util.PageData;
import com.infopublic.util.Tools;

/**
 * 职位
 * 
 * @author yxy
 *
 */
@Controller
@RequestMapping(value = "/jobs")
public class JobController extends BaseController {

	@Resource(name = "usersService")
	private UsersManager usersService;
	@Resource(name = "JobService")
	private JobManager JobService;
	@Resource(name = "logService")
	private LogManager logService;

	//展示政策与公告
		@RequestMapping(value="/showj")
		public ModelAndView showj() throws Exception{
			ModelAndView mv = this.getModelAndView();
			PageData pd = new PageData();
			pd = this.getPageData();
			pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); // 读取系统名称
			pd.put("pagelength", Integer.parseInt(Tools.GetValueByKey(Const.ALLPAGE, "jobPageSet"))); // 读取政策与公告分页长度

			// 公告列表
			List<TbJob> showj = JobService.getjobbyremark(1); //搜索所有公告类型的条目
			this.getdata(showj);  //取  数据
			for (int i = showj.size() - 1; i >= 0; i--) {// 对发布事件的发布条数截取  截取最近5条
				TbJob tbjob = showj.get(i); //查询多少行  size就是多少
				if (i >= 10)
					showj.remove(tbjob);
			}
			mv.addObject("showj", showj); //分了页面啊，第一个页面是公告不，所以这里就是把查询公告的list存1
			mv.setViewName("job/showj");
			mv.addObject("pd", pd);
			return mv;
		}
	
	// 展示职位
	@RequestMapping(value = "/showjobs")
	@ResponseBody 
	public ModelAndView showjobs() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData(); // 新建页面
		pd = this.getPageData(); // 取页面数据
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); // 读取系统名称
		pd.put("pagelength", Integer.parseInt(Tools.GetValueByKey( Const.ALLPAGE, "jobPageSet"))); // 读取招聘条目

		int remark = Integer.parseInt(pd.getString("remark")); //取 数据是否有效
		String begin = pd.getString("begin"); // 取起始
		int length = Integer.parseInt(pd.getString("length")); // 取长度
		String tip = pd.getString("tip");
		
		pd.put("remark", remark); //是1还是0
		pd.put("begin", Integer.parseInt(begin)); // 分页开始时的数据条目
		pd.put("length", length); // 每页显示的固定数据条目

		List<TbJob> joblistall = JobService.getjobbydate(pd);
		this.getdata(joblistall); // 拿到日期
		this.getposition(joblistall); //拿到职位
		
		int totalnum = JobService.totalalljobbyremark(remark); // 查询到所有相关类型的页数
		pd.put("one", Integer.parseInt(begin) / length + 1); // 第一页
		pd.put("total", totalnum / length + 1); // 总页面
			
		mv.addObject("pd", pd);
		mv.addObject("joblistall", joblistall);
		mv.setViewName("job/showjobs");

		return mv;

	}

	// 展示职位（下拉加载）
	@RequestMapping(value = "/showjobmore")
	@ResponseBody
	public Object showjobmore() throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		PageData pd = new PageData(); // 新页面
		pd = this.getPageData();

		int length = Integer.parseInt(pd.getString("length"));
		int tip = Integer.parseInt(pd.getString("tip")); // 每次下拉 多展示2条 limit
															// tip*length,2

		pd.put("begin", ((tip - 1) * 2 + length));
		pd.put("length", 2);
		List<TbJob> tbjob;
		if (!"".equals(pd.getString("searchtip"))
				&& pd.getString("searchtip") != null) { // 不为空 说明是搜索下拉
			pd.put("searchInput", pd.getString("searchtip"));
			tbjob = JobService.getJobByPoOrTit(pd); // 根据名称或类型模糊查询
		} else {
			tbjob = JobService.getjobbydate(pd);
		}
		this.getdata(tbjob);
		if (tbjob.isEmpty()) {// 数据为空
			map.put("stop", "stop");
		} else {
			for (int i = 1; i <= tbjob.size(); i++) {
				if (tbjob.get(i - 1) != null) {
					map.put("jid" + i, tbjob.get(i - 1).getJid() + "");
					map.put("po" + i, tbjob.get(i - 1).getPosition());
					map.put("co" + i, tbjob.get(i - 1).getCompany());
					map.put("num" + i, tbjob.get(i - 1).getNum() + "");
					map.put("endate" + i, tbjob.get(i - 1).getEndate());
					if (i == tbjob.size()) {
						map.put("success", i + ""); // 集合数据都不为空
					}
				} else {
					map.put("success", (i - 1) + ""); // 集合有几个不为NULL的数据
					break;
				}
			}

		}
		return map;
	}

	// 展示职位(具体)
	@RequestMapping(value = "/showcontent")
	public ModelAndView showcontent() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); // 读取系统名称
		String jid = pd.getString("jid");
		TbJob tbjobcontent = JobService.getcontentfromjid(jid);// 根据jid查找求职信息
		
		tbjobcontent.setBedate(tbjobcontent.getBedate().substring(0, 19));
		tbjobcontent.setEndate(tbjobcontent.getEndate().substring(0, 19));
		
		mv.addObject("tbjob", tbjobcontent);
		mv.setViewName("job/showcontent");
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * 取出图片输出
	 * 
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("showimage")
	public void showimage(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String jid = request.getParameter("jid");
		TbJob tbjobcontent = JobService.getcontentfromjid(jid);// 根据jid查找求职信息
		String imageurl = tbjobcontent.getPicurl();
		if (!"".equals(imageurl) && imageurl != null) {
			FileInputread.Imageshow(request,response, imageurl); // 输出图片
		}
	}

	// 对信息时间进行截取 去掉时分秒
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<TbJob> getdata(List tbself) {
		for (int i = 0; i < tbself.size(); i++) {
			for (int j = 0; j < tbself.get(i).toString().length(); j++) {
				((TbJob) tbself.get(i)).setEndate(((TbJob) tbself.get(i))
						.getEndate().substring(0, 19));
			}
		}
		return tbself;
	}
	
	//对题目进行截取 
			@SuppressWarnings({ "unchecked", "rawtypes" })
			public List<TbJob> getposition(List tbself){
				for(int i=0;i<tbself.size();i++){
					for(int j=0;j<tbself.get(i).toString().length();j++){
						if(((TbJob) tbself.get(i)).getPosition().length()>9){
						((TbJob) tbself.get(i)).setPosition( ((TbJob) tbself.get(i)).getPosition().substring(0, 9)+"..");
						}else{
							break;
						}
					}
				}
				return tbself;	
			}

}
