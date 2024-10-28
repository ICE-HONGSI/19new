package com.ubinetsys.pms.oper_bms;

import java.util.List;
import java.util.Map;

public interface BmsBO {
	public List<Map<String, Object>> selectBms(Map<String, Object> map, String gno) throws Exception;
	
	public List<Map<String, Object>> selectTray(Map<String, Object> map, String gno, String Rno, String DT) throws Exception;
}
