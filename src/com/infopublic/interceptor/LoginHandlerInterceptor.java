package com.infopublic.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import com.infopublic.entity.Users;
import com.infopublic.util.Const;
import com.infopublic.util.Jurisdiction;
import com.infopublic.util.Tools;
/**
 * 
* 类名称：登录过滤，权限验证
* 类描述： 
 */
public class LoginHandlerInterceptor extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		// TODO Auto-generated method stub
		String path = request.getServletPath();
		if(path.matches(Const.NO_INTERCEPTOR_PATH)){//忽略Session进入,不对匹配该值的访问路径拦截
			return true;
		}else if(path.matches(Const.NO_INTERCEPTOR_PATH1)){ //权限校验  Session失效跳转到”村级新闻“（服务大厅）
			Users user = (Users)Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
			if(user!=null){
//				path = path.substring(1, path.length());
//				boolean b = Jurisdiction.hasJurisdiction(path); //访问权限校验
//				if(!b){
//					response.sendRedirect(request.getContextPath() + Const.mainindex);
//				}
//				return b;
				return true;   //忽略权限校验
			}else{
				//String judegeInter=request.getParameter("judgeInter");
				//System.out.println("**********judegeInter*********"+judegeInter);
				String registerurl="http://"+Tools.GetValueByKey(Const.CONFIG, "url")+"register/selectlogin";
//				if("weixin".equals(judegeInter)){//微信公众号进入
//					registerurl= "http://"+Tools.GetValueByKey(Const.CONFIG, "url")+"register/selectlogin";
//				}else{//企业号进入
//					registerurl = "http://"+Tools.GetValueByKey(Const.CONFIG, "url")+"qyWeChat/qiyelogin";
//				}
				
				response.sendRedirect(registerurl);//Session失效跳转
				return false;				
			}
		}else if(path.matches(Const.NO_INTERCEPTOR_PATH3)){ //权限校验  Session失效跳转到”党员专区“
			Users user = (Users)Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
			if(user!=null){
				return true;   
			}else{
				//String judegeInter=request.getParameter("judgeInter");
				//System.out.println("**********judegeInter*********"+judegeInter);
				String registerurl="http://"+Tools.GetValueByKey(Const.CONFIG, "url")+"register/selectlogin";
//				if("weixin".equals(judegeInter)){//微信公众号进入
//					registerurl= "http://"+Tools.GetValueByKey(Const.CONFIG, "url")+"register/selectlogin";
//				}else{//企业号进入
//					registerurl = "http://"+Tools.GetValueByKey(Const.CONFIG, "url")+"qyWeChat/qiyelogin3";
//				}
				response.sendRedirect(registerurl);//Session失效跳转
				return false;		
			}
		}else{return false;}
	}
		
		
}
