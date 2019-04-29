package com.infopublic.controller;


import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.shiro.session.Session;

import org.dom4j.Document;   
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;   
import org.dom4j.Element;   
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.infopublic.util.AppUtil;
import com.infopublic.util.Const;
import com.infopublic.util.Jurisdiction;
import com.infopublic.util.PageData;
import com.infopublic.util.Tools;

@Controller
public class sendsmsController extends BaseController{
	
	
	@RequestMapping(value="/sendmessage")
	@ResponseBody
	public Object sendmessage() throws Exception{
		Map<String,String> map = new HashMap<String,String>();
		String Url = Tools.GetValueByKey(Const.CONFIG, "urlmessage");
		PageData pd = new PageData();
		pd = this.getPageData();
		String phonenumber=pd.getString("phonenumber");
		String result="";
		HttpClient client = new HttpClient(); 
		PostMethod method = new PostMethod(Url);

		client.getParams().setContentCharset("utf-8");
		method.setRequestHeader("ContentType","application/x-www-form-urlencoded;charset=utf-8");

		int mobile_code = (int)((Math.random()*9+1)*100000);

	    String content = new String("您的验证码是：" + mobile_code + "。请不要把验证码泄露给其他人。");

		NameValuePair[] data = {
			    new NameValuePair("account", Tools.GetValueByKey(Const.CONFIG, "namemessage")), //查看用户名是登录用户中心->验证码短信->产品总览->APIID
			  //  new NameValuePair("password", "77b24c8ad698e4522dbd8b0559f47532"),  //查看密码请登录用户中心->验证码短信->产品总览->APIKEY
			    new NameValuePair("password", com.infopublic.util.StringUtil.MD5Encode(Tools.GetValueByKey(Const.CONFIG, "pwdmessage"))),
			    new NameValuePair("mobile", phonenumber), 
			    new NameValuePair("content", content),
		};
		method.setRequestBody(data);

		try {
			client.executeMethod(method);
			
			String SubmitResult =method.getResponseBodyAsString();

			//System.out.println(SubmitResult);

			Document doc = DocumentHelper.parseText(SubmitResult);
			Element root = doc.getRootElement();

			String code = root.elementText("code");
			String msg = root.elementText("msg");
			String smsid = root.elementText("smsid");

			System.out.println(code);
			System.out.println(msg);
			System.out.println(smsid);

			 if("2".equals(code)){
				System.out.println("发送成功");
				System.out.println(mobile_code);
				result=mobile_code+"";
				//将验证码存入Session
				Session session=Jurisdiction.getSession();
				session.setAttribute(Const.SESSION_phone_CODE, result);
			}
			 else{
				 result="messagecode";
			 }

		} catch (HttpException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (DocumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		map.put("result", result);
		return AppUtil.returnObject(new PageData(), map);
	}
	
	/**
	 * 手机验证码判断
	 */
	@RequestMapping(value="/judgecode")
	@ResponseBody
	public Object judgecode(){
		Map<String,String> map=new HashMap<String,String>();
		PageData pd=this.getPageData();
		Object code=Jurisdiction.getSession().getAttribute(Const.SESSION_phone_CODE);
		if(code==null){
			map.put("error", "success");
		}else{
		String thiscode=code.toString();
		//System.out.println("code为："+thiscode);
		String phoneyanzheng=pd.getString("phoneyanzheng");
		//System.out.println("phoneyanzheng为："+phoneyanzheng);
		if(thiscode.equals(phoneyanzheng)){ //验证码正确
			map.put("result", "success");
			//System.out.println("验证正确");
			Jurisdiction.getSession().removeAttribute(Const.SESSION_phone_CODE);//验证码换值
		}else{
			map.put("error", "success");
		}
		}
		return map;
	}
	
	

		
	}
