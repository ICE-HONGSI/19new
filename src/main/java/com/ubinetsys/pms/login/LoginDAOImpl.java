package com.ubinetsys.pms.login;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class LoginDAOImpl implements LoginDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	public User findByUserIdAndPassword(String userId, String password) {
		Map<String, String> paramMap = new HashMap<String, String>();
		System.out.println(userId);
		paramMap.put("userId", userId);
		paramMap.put("password", password);
		User user = sqlSession.selectOne("userSql.userLogininfo", paramMap);
		return user;
	}
}