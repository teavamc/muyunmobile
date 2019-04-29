package com.infopublic.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.Scanner;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.marker.weixin.DefaultSession;
import org.marker.weixin.HandleMessageAdapter;
import org.marker.weixin.msg.Msg4Event;
import org.marker.weixin.msg.Msg4Image;
import org.marker.weixin.msg.Msg4Text;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.infopublic.util.Const;
import com.infopublic.util.SignUtil;
import com.infopublic.util.Tools;

/**
 * 
 * 类名称：WeixinController.java
 * 类描述： 微信公共平台开发 
 * 作者单位： 
 * 联系方式：
 * @version 1.0
 */
@Controller
@RequestMapping(value="/weixin")
public class WeixinController extends BaseController{


	/**
	 * 接口验证,总入口
	 * @param out
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/index")
	public void index(
			HttpServletRequest request,
			HttpServletResponse response
			) throws Exception{     
		logBefore(logger, "微信接口");
		// 微信加密签名  
		String signature = request.getParameter("signature");  
		// 时间戳  
		String timestamp = request.getParameter("timestamp");  
		// 随机数  
		String nonce = request.getParameter("nonce");  
		// 随机字符串  
		String echostr = request.getParameter("echostr");  
		if(null != signature && null != timestamp && null != nonce && null != echostr){/* 接口验证  */
			logBefore(logger, "shenfenyanzheng");
			PrintWriter out = response.getWriter();  
			// 通过检验signature对请求进行校验，若校验成功则原样返回echostr，表示接入成功，否则接入失败  
			if (SignUtil.checkSignature(signature, timestamp, nonce)) {  
				out.print(echostr);  
			}  
			out.close();  
			out = null; 
		}else{/* 消息处理  */
			logBefore(logger, "进入消息处理");
			response.reset();
			sendMsg(request,response);
		}
	}

	/**
	 * 处理微信服务器发过来的各种消息，包括：文本、图片、地理位置、音乐等等 
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	public void sendMsg(HttpServletRequest request, HttpServletResponse response) throws Exception{ 

		InputStream is = request.getInputStream(); 
		response.reset();  
		OutputStream os = response.getOutputStream(); 

		
      

		final DefaultSession session = DefaultSession.newInstance(); 
		session.addOnHandleMessageListener(new HandleMessageAdapter(){ 

			/**
			 * 事件
			 */
			 @Override
			 public void onEventMsg(Msg4Event msg) {
				 /** msg.getEvent()
				  * unsubscribe：取消关注 ; subscribe：关注
				  */
				 if("subscribe".equals(msg.getEvent())){
					 returnMSg(msg,null,"关注");
				 }
			 }

			 /**
			  * 收到的文本消息
			  */
			 @Override 
			 public void onTextMsg(Msg4Text msg) { 
				 returnMSg(null,msg,msg.getContent().trim());
			 }

			 @Override
			 public void onImageMsg(Msg4Image msg) {
				 // TODO Auto-generated method stub
				 super.onImageMsg(msg);
			 }


			 @Override
			 public void onErrorMsg(int errorCode) {
				 // TODO Auto-generated method stub
				 super.onErrorMsg(errorCode);
			 }

			 /**
			  * 返回消息
			  * @param emsg
			  * @param tmsg
			  * @param getmsg
			  */
			 public void returnMSg(Msg4Event emsg, Msg4Text tmsg, String getmsg){
				 //        		 PageData msgpd;
				 //                 PageData pd = new PageData();
				 String toUserName,fromUserName,createTime;
				 if(null == emsg){
					 toUserName = tmsg.getToUserName();
					 fromUserName = tmsg.getFromUserName();
					 createTime = tmsg.getCreateTime();
				 }else{
					 toUserName = emsg.getToUserName();
					 fromUserName = emsg.getFromUserName();
					 createTime = emsg.getCreateTime();
				 }
				 if(getmsg.matches("[\\s\\S]*")){ //匹配任意字符串
					 Msg4Text rmsg = new Msg4Text(); 
					 rmsg.setFromUserName(toUserName); 
					 rmsg.setToUserName(fromUserName); 
//					 String registerurl = "http://120.77.207.42/partymember";
					 String registerurl = "http://"+Tools.GetValueByKey(Const.CONFIG, "url")+"/mainindex";
					 StringBuffer buffer = new StringBuffer();
						buffer.append("欢迎关注~").append("\n\n");	
						buffer.append("<a href='"+registerurl+"'>点击这里进入暮云新村服务大厅</a>").append("\n\n");
					//	buffer.append("回复“注册”可获得党政建设信息系统登录链接").append("\n");
					rmsg.setContent(buffer.toString());
					session.callback(rmsg); 
				 }
				
				 
			
			 }
		}); 

		/*必须调用这两个方法   如果不调用close方法，将会出现响应数据串到其它Servlet中。*/ 
		session.process(is, os);	//处理微信消息  
		session.close();			//关闭Session 
	} 
	
	



	//读取文件
	public String readTxtFile(String filePath) {
		try {
			String encoding = "utf-8";
			File file = new File(filePath);
			if (file.isFile() && file.exists()) { // 判断文件是否存在
				InputStreamReader read = new InputStreamReader(
						new FileInputStream(file), encoding);// 考虑到编码格式
				BufferedReader bufferedReader = new BufferedReader(read);
				String lineTxt = null;
				while ((lineTxt = bufferedReader.readLine()) != null) {
					//System.out.println(lineTxt);
					return lineTxt;
				}
				read.close();
			} else {
				System.out.println("找不到指定的文件");
			}
		} catch (Exception e) {
			System.out.println("读取文件内容出错");
			e.printStackTrace();
		}
		return "";
	}
}
