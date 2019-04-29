package com.infopublic.service;

import java.util.List;

import com.infopublic.entity.Page;
import com.infopublic.util.PageData;


/** 日志接口类
 */
public interface LogManager {
	public void saveLog1(String code,String name) throws Exception;
	
	/**通过区域ID列表和时间获取日志信息(分页）
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getLogs(Page page) throws Exception;
	/**
	 * 根据日志编号列表获取信息（不分页）
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getLogsByIds(PageData pd) throws Exception;
	
	/**
	 * 保存日志
	 * @param logtype 操作类别
	 * @param function 功能模块
	 * @param logcontent 操作
	 * @param ip ip地址
	 * @param remark 具体内容
	 * @throws Exception
	 */
	public void saveLog(String logtype,String function,String logcontent,String ip,String remark)throws Exception;
	
}
