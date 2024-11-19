package com.ubinetsys.pms.login;

public interface LoginDAO {
	public User findByUserIdAndPassword(String userId, String password);
}