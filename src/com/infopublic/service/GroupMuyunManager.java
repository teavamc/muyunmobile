package com.infopublic.service;

import java.util.List;

import com.infopublic.entity.GroupMuyun;
import com.infopublic.util.PageData;

public interface GroupMuyunManager {
	
public List<GroupMuyun> getGmuyuntypelist(PageData pd)throws Exception;
	
public GroupMuyun getGmuyunofpid(String pid)throws Exception; 

public List<GroupMuyun> getGmuyunlistformseach(PageData pd)throws Exception; 

public int querrynumberformtype(PageData pd)throws Exception; 

public int querrynumberformsex(String sex)throws Exception; 

public int querrynumber(PageData pd)throws Exception; 
	
public int querrynumberformtypes(String grouptype)throws Exception; 
}
