package com.infopublic.util;

import java.io.BufferedReader;  
import java.io.InputStream;  
import java.io.InputStreamReader;  
import java.io.OutputStream;  
import java.net.ConnectException;  
import java.net.URL;  
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.io.File;

import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.methods.multipart.FilePart;
import org.apache.commons.httpclient.methods.multipart.MultipartRequestEntity;
import org.apache.commons.httpclient.methods.multipart.Part;
import org.apache.http.HttpStatus;

import com.alibaba.druid.support.json.JSONParser;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import javax.net.ssl.HttpsURLConnection;  
import javax.net.ssl.SSLContext;  
import javax.net.ssl.SSLSocketFactory;  
import javax.net.ssl.TrustManager;

import net.sf.json.JSONArray;
import net.sf.json.JSONException;
import net.sf.json.JSONObject;

import org.slf4j.Logger;  
import org.slf4j.LoggerFactory;  

import com.infopublic.weixin.pojo.AccessToken;

public class WeixinUtil {
	private static Logger log = LoggerFactory.getLogger(WeixinUtil.class);  
	/** 
	 * 发起https请求并获取结果 
	 *  
	 * @param requestUrl 请求地址 
	 * @param requestMethod 请求方式（GET、POST） 
	 * @param outputStr 提交的数据 
	 * @return JSONObject(通过JSONObject.get(key)的方式获取json对象的属性值) 
	 */  
	public static JSONObject httpRequest(String requestUrl, String requestMethod, String outputStr) {  
		JSONObject jsonObject = null;  
		StringBuffer buffer = new StringBuffer();  
		try {  
			// 创建SSLContext对象，并使用我们指定的信任管理器初始化  
			TrustManager[] tm = { new MyX509TrustManager() };  
			SSLContext sslContext = SSLContext.getInstance("SSL", "SunJSSE");  
			sslContext.init(null, tm, new java.security.SecureRandom());  
			// 从上述SSLContext对象中得到SSLSocketFactory对象  
			SSLSocketFactory ssf = sslContext.getSocketFactory();  

			URL url = new URL(requestUrl);  
			HttpsURLConnection httpUrlConn = (HttpsURLConnection) url.openConnection();  
			httpUrlConn.setSSLSocketFactory(ssf);  

			httpUrlConn.setDoOutput(true);  
			httpUrlConn.setDoInput(true);  
			httpUrlConn.setUseCaches(false);  
			// 设置请求方式（GET/POST）  
			httpUrlConn.setRequestMethod(requestMethod);  

			if ("GET".equalsIgnoreCase(requestMethod))  
				httpUrlConn.connect();  

			// 当有数据需要提交时  
			if (null != outputStr) {  
				OutputStream outputStream = httpUrlConn.getOutputStream();  
				// 注意编码格式，防止中文乱码  
				outputStream.write(outputStr.getBytes("UTF-8"));  
				outputStream.close();  
			}  

			// 将返回的输入流转换成字符串  
			InputStream inputStream = httpUrlConn.getInputStream();  
			InputStreamReader inputStreamReader = new InputStreamReader(inputStream, "utf-8");  
			BufferedReader bufferedReader = new BufferedReader(inputStreamReader);  

			String str = null;  
			while ((str = bufferedReader.readLine()) != null) {  
				buffer.append(str);  
			}  
			bufferedReader.close();  
			inputStreamReader.close();  
			// 释放资源  
			inputStream.close();  
			inputStream = null;  
			httpUrlConn.disconnect();  
			jsonObject = JSONObject.fromObject(buffer.toString());  
		} catch (ConnectException ce) {  
			log.error("Weixin server connection timed out.");  
		} catch (Exception e) {  
			log.error("https request error:{}", e);  
		}  
		return jsonObject;  
	}  
	public static final String GET_TOKEN_URL = "https://api.weixin.qq.com/cgi-bin/token";// 获取access
	public static final String UPLOAD_IMAGE_URL = "https://api.weixin.qq.com/cgi-bin/media/upload";// 上传多媒体文件
	public static final String UPLOAD_CONTENTIMG_URL = "https://api.weixin.qq.com/cgi-bin/media/uploadimg";// 上传图文消息内容图片
	public static final String UPLOAD_TEXTIMG_URL = "https://api.weixin.qq.com/cgi-bin/media/uploadnews";// 上传图文素材
	public static final String SEND = "https://api.weixin.qq.com/cgi-bin/message/mass/send";// 群发
	
	/**
	 * 群发
	 * @param filepath 本地绝对地址
	 * @return String 上传成功返回图片链接，错误返回"error"
	 */
	public static String Send(List<String> openidlist,String infotitle,String infocontent,String infotype,List<String> filenames,String media_id,String accessToken){
		System.out.println(accessToken);
		String uploadurl = String.format("%s?access_token=%s", SEND, accessToken);
//		String infos = "";
		
		Map<String,Object> map = new HashMap<String, Object>();
		if(media_id.equals("")){
			String content = "主题："+infotitle.trim();
			if(!infocontent.equals(""))
				content +="\n内容："+infocontent.trim();
			if(infotype.equals("file")){
				content +="\n文件：";
				for(String name:filenames)
					content +=name.trim()+"\n";
				String url = Tools.GetValueByKey(Const.CONFIG, "url");
				content+="链接：http://"+url+"filenotice/listReceive.do\n"; 
				content+="可前往网页平台下载查看"; 
			}
			map.put("touser", JSONArray.fromObject( openidlist ));
			map.put("msgtype", "text");
			Map<String,Object> textmap = new HashMap<String, Object>();
			textmap.put("content", content);
			map.put("text", textmap);
		}else{
			map.put("touser", JSONArray.fromObject( openidlist ));
			map.put("msgtype", "mpnews");
			Map<String,Object> textmap = new HashMap<String, Object>();
			textmap.put("media_id", media_id);
			map.put("mpnews", textmap);
		}
		//群发消息   返回{ "errcode":0, "errmsg":"send job submission success", "msg_id":34182,  "msg_data_id": 206227730 }
		System.out.print(JSONObject.fromObject(map).toString());
		JSONObject result = httpRequest(uploadurl, "POST", JSONObject.fromObject(map).toString());
		if(result.get("errcode").toString().equals("0")){
			return "success";
		}
		return result.get("errcode").toString();
	}
	/**
	 * 上传图文素材
	 * @param thumb_media_id 缩略图id
	 * @return String 上传成功返回media_id，错误返回"error"
	 */
	public static String uploadTextImg(String news,String accessToken){
		System.out.println(accessToken);
		String uploadurl = String.format("%s?access_token=%s", UPLOAD_TEXTIMG_URL, accessToken);
		
		//群发消息   返回{ "type":"news", "media_id":"CsEf3ldqkAYJAU6EJeIkStVDSvffUJ54vqbThMgplD-VJXXof6ctX5fI6-aYyUiQ", "created_at":1391857799 }
				JSONObject result = httpRequest(uploadurl, "POST", news);
				if(result.get("errcode")==null){
					return result.get("media_id").toString();
				}
		return "error";
	}
	/**
	 * 将图文内容转换成内容字符串
	 * @param @param imgurls 内容中的图片链接
	 * @param @param title 内容标题
	 * @param @param content 内容文字
	 * @return String 转换后的content
	 */
	public static String parseContent(List<String> imgurls,String thumb_media_id,String author,String title,String content){
		String newscontent = "<h5>&nbsp;&nbsp;&nbsp;&nbsp;"+content+"</h5><br>";
		for(String url:imgurls){
			newscontent = newscontent+"<img src='"+url+"'  alt='' />";
		}
		Map<String,Object> articlesmap = new HashMap<String, Object>();
		List<Map> listmap = new ArrayList<Map>();
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("thumb_media_id", thumb_media_id);
		map.put("author", author);
		map.put("title", title);
		map.put("content_source_url", "");
		map.put("content", newscontent);
		map.put("digest", content);
		map.put("show_cover_pic", 1);
		listmap.add(map);
		articlesmap.put("articles", listmap);
//		String news = "{'articles': [ {"+
//                "'thumb_media_id':'"+thumb_media_id+"',"+
//                "'author':'"+author+"',"+
//                "'title':'"+title+"',"+
//                "'content_source_url':'',"+
//                "'content':'"+newscontent+"',"+
//                "'show_cover_pic':1 }]}";
		return JSONObject.fromObject(articlesmap).toString();
	}
	/**
	 * 上传图文消息内部图片
	 * @param filepath 本地绝对地址
	 * @return String 上传成功返回图片链接，错误返回"error"
	 */
	public static String uploadContentImg(String filepath,String accessToken){
		System.out.println(accessToken);
			File file = new File(filepath); // 获取本地文件
			String uploadurl = String.format("%s?access_token=%s", UPLOAD_CONTENTIMG_URL, accessToken);
			JsonObject json = uploadimage(uploadurl, accessToken,  file);// 上传文件
			if (json.get("errcode") == null)// {"errcode":40004,"errmsg":"invalid media type"}
			{ // 上传成功  {"url":"Url"}
				return json.get("url").getAsString();
			}
			return "error";
	}
	/**
	 * 向微信公众号上传图片素材
	 * @param filepath 本地绝对地址
	 * @return String 上传成功返回素材编号media_id，错误返回"error"
	 */
	public static String uploadImage(String filepath,String accessToken){
			System.out.println(accessToken);
			File file = new File(filepath); // 获取本地文件
			String uploadurl = String.format("%s?access_token=%s&type=%s", UPLOAD_IMAGE_URL,
					accessToken, "image");
			JsonObject json = uploadimage(uploadurl, accessToken,  file);// 上传文件
			if (json.get("errcode") == null)// {"errcode":40004,"errmsg":"invalid media type"}
			{ // 上传成功  {"type":"TYPE","media_id":"MEDIA_ID","created_at":123456789}
				return json.get("media_id").getAsString();
			}
			return "error";
	}
	
	/**
	 * 上传多媒体文件
	 * @param url 访问url
	 * @param access_token
	 * @param type  文件类型
	 * @param file 文件对象
	 * @return 
	 */
	@SuppressWarnings("finally")
	private static JsonObject uploadimage(String url, String access_token, File file)
	{
		org.apache.commons.httpclient.HttpClient client = new org.apache.commons.httpclient.HttpClient();
		PostMethod post = new PostMethod(url);
		post.setRequestHeader(
				"User-Agent",
				"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:30.0) Gecko/20100101 Firefox/30.0");
		post.setRequestHeader("Host", "file.api.weixin.qq.com");
		post.setRequestHeader("Connection", "Keep-Alive");
		post.setRequestHeader("Cache-Control", "no-cache");
		JsonObject json = null;
		try
		{
			if (file != null && file.exists())
			{
				FilePart filepart = new FilePart("media", file, "image/*",
						"UTF-8");
				Part[] parts = new Part[] { filepart };
				MultipartRequestEntity entity = new MultipartRequestEntity(
						parts,

						post.getParams());
				post.setRequestEntity(entity);
				int status = client.executeMethod(post);
				if (status == HttpStatus.SC_OK)
				{
					String responseContent = post.getResponseBodyAsString();
					JsonParser jsonparer = new JsonParser();// 初始化解析json格式的对象
					json = jsonparer.parse(responseContent).getAsJsonObject();
				}
			}
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			return json;
		}
	}
	/**
	 * 检验授权凭证（access_token）是否有效
	 * @Title: checkAccessToken
	 * @param @param access_token 网页授权接口调用凭证,注意：此access_token与基础支持的access_token不同 
	 * @param @param openid 用户的唯一标识 
	 * @return JSONObject   返回消息实体
	 */
	public static JSONObject checkAccessToken(String access_token,String openid){
		String requestMethod = "GET";
		String outputStr = "";	
		String url = "https://api.weixin.qq.com/sns/auth?"
				+ "access_token="+access_token+""
				+ "&openid="+openid+"";
		JSONObject httpmsg = WeixinUtil.httpRequest(url, requestMethod, outputStr);
		System.out.println("拉取用户信息返回消息=="+httpmsg);

		return httpmsg;
	}

	// 获取access_token的接口地址（GET） 限200（次/天）  
	public final static String access_token_url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=APPID&secret=APPSECRET";  
	/** 
	 * 获取access_token 
	 * @param appid 凭证 
	 * @param appsecret 密钥 
	 * @return 
	 */  
	public static AccessToken getAccessToken() {  
		AccessToken accessToken = null;  

		String requestUrl = access_token_url.replace("APPID", Tools.GetValueByKey(Const.CONFIG, "APP_ID")).replace("APPSECRET", Tools.GetValueByKey(Const.CONFIG, "APPSECRET"));  
		JSONObject jsonObject = httpRequest(requestUrl, "GET", null);  
		// 如果请求成功  
		if (null != jsonObject) {  
			try {  
				accessToken = new AccessToken();  
				accessToken.setAccess_token(jsonObject.getString("access_token"));  
				accessToken.setExpires_in(jsonObject.getInt("expires_in"));  
			} catch (JSONException e) {  
				accessToken = null;  
				// 获取token失败  
				log.error("获取token失败 errcode:{} errmsg:{}", jsonObject.getInt("errcode"), jsonObject.getString("errmsg"));  
			}  
		}  
		return accessToken;  
	}  
	
	
	
	
	/**
	 * 检验授权凭证（access_token）是否有效
	 * @Title: checkAccessToken
	 * @param @param access_token 网页授权接口调用凭证,注意：此access_token与基础支持的access_token不同 
	 * @param @param openid 用户的唯一标识 
	 * @return JSONObject   返回消息实体
	 */
	public static JSONObject qycheckAccessToken(String access_token,String code){
		String requestMethod = "GET";
		String outputStr = "";	
		String url = "https://qyapi.weixin.qq.com/cgi-bin/user/getuserinfo?"
				+ "access_token="+access_token+""
						+ "&code="+code+"";
		JSONObject httpmsg = WeixinUtil.httpRequest(url, requestMethod, outputStr);
		System.out.println("拉取用户信息返回消息=="+httpmsg);

		return httpmsg;
	}




}
