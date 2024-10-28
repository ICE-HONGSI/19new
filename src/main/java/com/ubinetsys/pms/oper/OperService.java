package com.ubinetsys.pms.oper;

import java.util.List;
import java.util.Map;

public interface OperService {
	List<Map<String, Object>> getPcsCount(Map<String, Object> map) throws Exception;

}