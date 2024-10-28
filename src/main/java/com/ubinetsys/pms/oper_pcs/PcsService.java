
package com.ubinetsys.pms.oper_pcs;

import java.util.List;
import java.util.Map;


public interface PcsService {
	
	List<Map<String, Object>> getPcsData(Map<String, Object> map) throws Exception;
	List<Map<String, Object>> pcsBoxData(Map<String, Object> map) throws Exception;

}
