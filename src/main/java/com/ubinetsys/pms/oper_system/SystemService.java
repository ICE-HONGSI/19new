package com.ubinetsys.pms.oper_system;

import java.util.List;
import java.util.Map;

public interface SystemService {

	public List<Map<String, Object>> selectSysInfo(Map<String, Object> map);
}
