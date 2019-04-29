package com.infopublic.service;

import java.util.List;
import java.util.Map;

import com.infopublic.entity.MuyunRes;
import com.infopublic.util.PageData;

public interface MuyunResManager {
	
public List<MuyunRes> getAll_res(PageData pd)throws Exception;
	
public List<MuyunRes> getAll_res_byGroup(PageData pd)throws Exception;
	
public List<MuyunRes> get_res_bySearch(PageData pd)throws Exception;

public MuyunRes get_res_byPid(String pid)throws Exception; 

public int getCount_byGroup(String grouptype)throws Exception; 

public int getCount_bySex(String sex)throws Exception; 

public int getCount_Res(PageData pd)throws Exception; 

public List<Map<String,String>>  getCount_All_types(PageData pd)throws Exception;


}
