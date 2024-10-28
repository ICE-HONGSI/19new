package com.ubinetsys.pms.open_event;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class EventDAO {
	@Autowired
	private SqlSessionTemplate sqlSession;

	public List<Map<String, Object>> selectEvent(Map<String, Object> map, String dateFrom, String dateTo, String gno) {
		// TODO Auto-generated method stub
		List<Map<String, Object>> list;
		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("dateFrom", dateFrom);
		paramMap.put("dateTo", dateTo);
		paramMap.put("gno", gno);
		list = sqlSession.selectList("eventSql.selectEvent", paramMap);
		return list;
	}
}
