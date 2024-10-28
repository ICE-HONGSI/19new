package com.ubinetsys.pms.oper_bms;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class BmsDAOImpl implements BmsDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<Map<String, Object>> selectBms(Map<String, Object> map, String gno) {
		List<Map<String, Object>> list;
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("gno", gno);

		list = sqlSession.selectList("bmsSql.selectBms", paramMap);
		return list;
	}

	@Override
	public List<Map<String, Object>> selectTray(Map<String, Object> map, String gno, String Rno, String DT) {
		List<Map<String, Object>> list;
		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("gno", gno);
		paramMap.put("Rno", Rno);
		paramMap.put("DT", DT);
		
		list = sqlSession.selectList("bmsSql.selectTray", paramMap);
		return list;
	}

}