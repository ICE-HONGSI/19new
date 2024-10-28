package com.ubinetsys.pms.trend;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TrendBOImpl implements TrendBO {

	@Autowired
	private TrendDAO TrendDAO;

	@Override
	public List<Map<String, Object>> selectDay(Map<String, Object> map, String date, String gno) throws Exception {
		return TrendDAO.selectDay(map, date, gno);
	}

	@Override
	public List<Map<String, Object>> selectMonth(Map<String, Object> map, String date, String gno) throws Exception {
		return TrendDAO.selectMonth(map, date, gno);
	}
}
