package com.ubinetsys.pms.trend;

import java.util.List;
import java.util.Map;

public interface TrendDAO {
	public List<Map<String, Object>> selectDay(Map<String, Object> map, String date, String gno);

	public List<Map<String, Object>> selectMonth(Map<String, Object> map, String date, String gno);
}
