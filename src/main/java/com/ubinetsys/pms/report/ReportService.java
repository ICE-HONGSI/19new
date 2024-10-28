package com.ubinetsys.pms.report;

import java.util.List;
import java.util.Map;

public interface ReportService {
	List<Map<String, Object>> getMonthData(Map<String, Object> map) throws Exception;

	List<Map<String, Object>> getDateData(Map<String, Object> map) throws Exception;

	List<Map<String, Object>> getDateSum(Map<String, Object> map) throws Exception;

	List<Map<String, Object>> getMoneyData(Map<String, Object> map) throws Exception;
	
	int updatedata(String smp,String rec,String pv_multi,String ess_multi,String gno) throws Exception;
}