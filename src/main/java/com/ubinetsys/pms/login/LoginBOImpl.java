package com.ubinetsys.pms.login;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoginBOImpl implements LoginBO {

	@Autowired
	private LoginDAO loginDAO;

	public User findByUserIdAndPassword(String userId, String password) {
		return loginDAO.findByUserIdAndPassword(userId, password);
	}

}
