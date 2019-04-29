package com.infopublic.controller;

//系统支持类
import javax.annotation.Resource;

import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.session.Session;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

//数据流处理类
import java.io.BufferedReader;  //缓冲读取字符，将字节流封装成BufferedReader对象，然后用readLine()方法逐行读取，然后返回
import java.io.IOException;  //抛出异常
import java.io.InputStream; //字节输入流
import java.io.InputStreamReader;  //创建一个使用指定的字符集的输入流
import java.io.Reader;
import java.net.URL;
import java.nio.charset.Charset;
import org.json.JSONException;
import org.json.JSONObject;
import java.io.PrintWriter;
import java.net.URLConnection;

//Jackson转换
import org.codehaus.jackson.type.TypeReference;
import org.codehaus.jackson.map.ObjectMapper;

//实体类
import com.infopublic.entity.Api360News;

//业务层
import com.infopublic.service.LogManager;
import com.infopublic.service.MenuManager;
import com.infopublic.service.PartymemberManager;


//系统工具类
import com.infopublic.util.AppUtil;
import com.infopublic.util.Const;
import com.infopublic.util.Jurisdiction;
import com.infopublic.util.PageData;
import com.infopublic.util.Tools;






//Java工具类
import java.util.HashMap;
import java.util.List;
import java.util.Map;




/** 
 * 360新闻Api接口调用
 * 类名称：NewsApiController
 */


//示例类
@Controller
@RequestMapping(value="/news360")
public class NewsApiController extends BaseController {
	
	@Resource(name="menuService")
	private MenuManager menuService;
	@Resource(name="logService")
	private LogManager logService;
	@Resource(name="partymemberService")
	private PartymemberManager partymemberService;
	
	
	/*@RequestMapping(value="/shownews")
	@ResponseBody
	public ModelAndView news360searchapi() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData(); // 取页面数据
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); // 读取系统名称

		//发送请求到360的Api
		String searchname = "长沙";
		String url = "http://api01.bitspaceman.com:8000/news/qihoo?apikey=c4mH8pM9wrtPEfxFR2SgLDKp2zLGN3v1Z2rgzK2zyE6dMt6XgcCO5C9ZoCqOpVvg"
					+"&kw="+searchname
					+"&site=qq.com";
		
		//拿到JSON对象
		JSONObject news = getRequestFromUrl(url);; 
		String jsonnews = news.toString();

		ObjectMapper Newsmapper = new ObjectMapper();
		List<Api360News> NewsAll = Newsmapper.readValue(jsonnews,new TypeReference<List<Api360News>>() { }); //把jsonnews转换成List对象
		
		mv.addObject("NewsAll", NewsAll); //分了页面啊，第一个页面是公告不，所以这里就是把查询公告的list存1
		mv.setViewName("news360/shownews");
		mv.addObject("pd", pd);		
		
		return mv;
	}*/
	
//主方法 测试用
	public static void main(String[] args) throws IOException, JSONException {
			// 请求示例 url 默认请求参数已经做URL编码
			String searchname = "长沙";
			String url = "http://api01.bitspaceman.com:8000/news/qihoo?apikey=c4mH8pM9wrtPEfxFR2SgLDKp2zLGN3v1Z2rgzK2zyE6dMt6XgcCO5C9ZoCqOpVvg&kw="+searchname+"&site=qq.com";
			JSONObject json = getRequestFromUrl(url);; 
			String jsonnews = json.toString();
			
			//ObjectMapper Newsmapper = new ObjectMapper();
			//List<Api360News> NewsAll = Newsmapper.readValue(jsonnews,new TypeReference<List<Api360News>>() { }); //把jsonnews转换成List对象
			
			System.out.println(jsonnews);
		}

	//方法1，readAll，读所有数据
	private static String readAll(Reader rd) throws IOException {
		StringBuilder sb = new StringBuilder(); //新建StringBuilder对象sb
		int cp; //用来判断读取状态
		//每个字节读取rd对象，若读到最后就会返回-1，来判断是否文件读完
		while ((cp = rd.read()) != -1) {
			sb.append((char) cp);  //若读完了，把数据都添加进StringBuilder对象sb里面
		}
	return sb.toString(); //返回String格式的sb对象
	}

	//方法2，postRequestFromUrl，发请求给url，参数url和body，该方法的返回值类型是JSONObject
	public static JSONObject postRequestFromUrl(String url, String body) throws IOException, JSONException {
		
		URL realUrl = new URL(url);//新建URL对象realUrl，参数url定义在main方法
		URLConnection conn = realUrl.openConnection();  //调用openConnection赋值给URLConnection对象conn
		conn.setDoOutput(true); //设置是否从httpUrlConnection读入，默认情况下是true; 
		conn.setDoInput(true); //设置是否向httpUrlConnection输出，因为这个是post请求，参数要放在http正文内，因此需要设为true, 默认情况下是false;   
		
		PrintWriter out = new PrintWriter(conn.getOutputStream()); //把PringWriter对象会将字符串转换成字符编码数组再输出,getOutputStream按字节形式输出
		out.print(body); //输出正文
		out.flush(); //用完Builder后，刷新缓存区，避免溢出

		InputStream instream = conn.getInputStream(); //读取url连接对象conn的数据并存instream

		//异常控制
		try {
				//BufferedReader对象，从字符输入流中读取文本，缓冲各个字符，从而实现字符、数组和行的高效读取。
				//InputStreamReader对象，第一参数是InputStream in 输入流, 第二个是CharsetDecoder dec 编码格式)
				BufferedReader rd = new BufferedReader(new InputStreamReader(instream, Charset.forName("UTF-8")));
				//拿第一个方法的返回值然后存jsonText
				String jsonText = readAll(rd);
				//再转存json格式
				JSONObject json = new JSONObject(jsonText);
				return json; //返回json数据
			} finally {
				//关闭instream数据流
				instream.close();
		}
	}

	//方法3，接收url的请求，返回类型是JSON数据，大致同上
	public static JSONObject getRequestFromUrl(String url) throws IOException, JSONException {
		URL realUrl = new URL(url); //新建参数为url的URL对象realUrl
		URLConnection conn = realUrl.openConnection();
		InputStream instream = conn.getInputStream(); //同上
		try {
				
				BufferedReader rd = new BufferedReader(new InputStreamReader(instream, Charset.forName("UTF-8")));
				String jsonText = readAll(rd);
				JSONObject json = new JSONObject(jsonText);
				return json;
			} finally {
				instream.close();
		}
	}


}