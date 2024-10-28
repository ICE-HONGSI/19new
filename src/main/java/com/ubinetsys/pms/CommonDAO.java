package com.ubinetsys.pms;

import java.util.List;
import java.util.Map;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("commonDao")
public class CommonDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	@SuppressWarnings("unchecked")
	public String getTitle(Map param) {
		// TODO Auto-generated method stub
		String result = sqlSession.selectOne("commonSql.selectTitle", param);
		return result;
	}

	public List<Map<String, Object>> selectList() {
		// TODO Auto-generated method stub
		List<Map<String, Object>> result = sqlSession.selectList("commonSql.selectAll", null);
		return result;
	}

}
