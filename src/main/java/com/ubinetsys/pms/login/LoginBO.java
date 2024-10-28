package com.ubinetsys.pms.login;

public interface LoginBO {
	public User findByUserIdAndPassword(String userId, String password);
}
