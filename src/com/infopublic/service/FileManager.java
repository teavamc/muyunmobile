package com.infopublic.service;

import java.util.List;

import com.infopublic.entity.TbFileManager;
import com.infopublic.util.PageData;

public interface FileManager {
	
	public List<TbFileManager> getfileformupdate(PageData pd)throws Exception; //查询所有的文件 然后按照时间先后排序 数量取决于前台的开始和结束
	
	public List<TbFileManager> getfileformdownloadnum(PageData pd)throws Exception; // 查询所有的文件 然后按照下载量排序
	
	public List<TbFileManager> getfileformseach(PageData pd)throws Exception; // 模糊查询 然后按照时间排序
	
	public TbFileManager getfilefromfileid(String fileid)throws Exception; //通过id查询文件的详情 这里就返还一个实体类的对象
	
	public int querryfilenumber(int remark)throws Exception; //查所有文件的数量 用于前台的分页

	public void setfiledownnumber(PageData pd)throws Exception; //修改下载量
	
	public void setfilezan(PageData pd)throws Exception; //修改赞数量
	
	public void insertNewFile(PageData pd)throws Exception; //新增文件
	
}
