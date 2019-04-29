package com.infopublic.util;

import java.util.Map;

import org.codehaus.jackson.map.util.JSONPObject;

/** 接口参数校验
 */
public class AppUtil  {
	
	protected static Logger logger = Logger.getLogger(AppUtil.class);

	
	/**
	 * @param pd
	 * @param map
	 * @return
	 */
	public static Object returnObject(PageData pd, Map map){
		if(pd.containsKey("callback")){
			String callback = pd.get("callback").toString();
			return new JSONPObject(callback, map);
		}else{
			return map;
		}
	}
}
