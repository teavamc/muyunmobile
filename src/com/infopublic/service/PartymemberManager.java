package com.infopublic.service;

import java.util.List;

import com.infopublic.entity.TbPartymember;
import com.infopublic.util.PageData;

/**党员接口类 
 */
public interface PartymemberManager {
	
	/**根据党员身份证得到党员信息
	 * @throws Exception
	 */
	public TbPartymember getpartyinfofromidcard(String idcard)throws Exception;
	
	/**根据党员用户账号 uid得到党员信息
	 * @throws Exception
	 */
	public TbPartymember getpartymemberfromuid(String uid)throws Exception;
	
	/**根据姓名获得党员编号pid
	 */
	public String getpidbypname(String pname)throws Exception;
	
	/**验证党员身份,根据身份证
	 */
	public String yanzhengpartymember(String idcard)throws Exception;
	/**根据userid取出党员身份证
	 */
	public String getpartymemberidcard(String uid)throws Exception;
	
	/**修改党员用户账号
	 */
	public void edituid(PageData pd)throws Exception;
	
	/**修改电话号码  换绑
	 */
	public void changephone(PageData pd)throws Exception;
	
	
	
}
