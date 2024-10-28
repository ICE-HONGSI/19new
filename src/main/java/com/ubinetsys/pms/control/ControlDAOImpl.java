package com.ubinetsys.pms.control;

import java.util.List;
import java.util.Map;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class ControlDAOImpl implements ControlDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<Map<String, Object>> selectData( String gno) {
		List<Map<String, Object>> list;
		list = sqlSession.selectList("controlSql.selectAll", gno);
		return list;
	}

	@Override
	public List<Map<String, Object>> basic(String gno) {
		List<Map<String, Object>> list;
		list = sqlSession.selectList("controlSql.basic", gno);
		return list;
	}
	
	@Override
	public List<Map<String, Object>> get_upwd(String userId) {
		List<Map<String, Object>> list;
		list = sqlSession.selectList("controlSql.get_upwd", userId);
		return list;
	}
}
