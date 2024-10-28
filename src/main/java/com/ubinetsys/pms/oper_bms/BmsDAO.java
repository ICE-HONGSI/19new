package com.ubinetsys.pms.oper_bms;

import java.util.List;
import java.util.Map;

public interface BmsDAO {
	public List<Map<String, Object>> selectBms(Map<String, Object> map, String gno);
	public List<Map<String, Object>> selectTray(Map<String, Object> map, String gno, String Rno, String DT);
}
