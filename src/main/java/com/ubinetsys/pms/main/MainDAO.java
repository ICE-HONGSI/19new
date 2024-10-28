package com.ubinetsys.pms.main;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("mainDAO")
public class MainDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;


	public List<Map<String, Object>> selectRunResult(String gno) {
		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("gno", gno);
		List<Map<String, Object>> result = sqlSession.selectList("mainpageSql.selectRunResult", paramMap);
		return result;
	}

	public List<Map<String, Object>> basic(String gno) {
		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("gno", gno);
		List<Map<String, Object>> result = sqlSession.selectList("mainpageSql.basic", paramMap);
		return result;
	}

	public List<Map<String, Object>> chartdata(String gno) {
		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("gno", gno);
		List<Map<String, Object>> result = sqlSession.selectList("mainpageSql.chartdata", paramMap);
		return result;
	}
	
	public List<Map<String, Object>> selectASCResult(String gno) {
		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("gno", gno);
		List<Map<String, Object>> result = sqlSession.selectList("mainpageSql.selectASCResult", paramMap);
		return result;
	}
	
	public List<Map<String, Object>> selectNOWResult(String gno) {
		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("gno", gno);
		List<Map<String, Object>> result = sqlSession.selectList("mainpageSql.selectNOWResult", paramMap);
		return result;
	}
}
