package com.ubinetsys.pms.service;

import java.util.List;
import java.util.Map;

public interface CommonService {
	public String getTitle(Map param) throws Exception;

	public List<Map<String, Object>> selectList();
}
