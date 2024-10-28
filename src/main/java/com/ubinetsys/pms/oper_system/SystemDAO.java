package com.ubinetsys.pms.oper_system;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("SystemDAO")
public class SystemDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	public List<Map<String, Object>> selectSysInfo(Map<String, Object> map) {
		List<Map<String, Object>> list = sqlSession.selectList("systemSQL.selectIPandSname", map);
		return list;
	}

}
