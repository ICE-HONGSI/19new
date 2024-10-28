package com.ubinetsys.pms.trend;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class TrendDAOImpl implements TrendDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<Map<String, Object>> selectDay(Map<String, Object> map, String date, String gno) {
		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("date", date);
		paramMap.put("gno", gno);
		List<Map<String, Object>> list;
		list = sqlSession.selectList("trendSql.selectDay", paramMap);
		return list;
	}

	@Override
	public List<Map<String, Object>> selectMonth(Map<String, Object> map, String date, String gno) {
		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("date", date);
		paramMap.put("gno", gno);
		List<Map<String, Object>> list;
		list = sqlSession.selectList("trendSql.selectMonth", paramMap);
		return list;
	}
}