package com.ubinetsys.pms.control;

import java.util.List;
import java.util.Map;

public interface ControlBO {
	public List<Map<String, Object>> selectData(String gno);
	public List<Map<String, Object>> basic(String gno);
	public List<Map<String, Object>> get_upwd(String userId);
}