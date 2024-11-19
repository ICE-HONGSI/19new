package com.ubinetsys.pms.login;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class LoginController {

	@Autowired
	private LoginBO loginBO;

	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);

	@RequestMapping("/")
	public String login(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		String page = autoLogin(request, response, session);
		return page;
	}


	String autoLogin(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		boolean autologin = false;

		Cookie cookie_userid = null;
		Cookie cookie_pwd = null;
		Cookie cookie_autologin = null;

		Cookie[] cookies = request.getCookies();
		String userid = null, passwd = null;

		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("userid")) {
					userid = cookie.getValue();
					cookie_userid = cookie;
				}
				else if (cookie.getName().equals("pwd")) {
					passwd = cookie.getValue();
					cookie_pwd = cookie;
				}
				else if (cookie.getName().equals("autologin")) {
					if(cookie.getValue().isEmpty()) break;
					else if(cookie.getValue().equals("1")) {
						cookie_autologin = cookie;
						autologin = true;
					}
				}
			}
		}

		if(autologin) {
			User userinfo = loginBO.findByUserIdAndPassword(userid, passwd);
			if(userinfo != null) {

				//쿠키 유효기간 수정
				int expiretime = 60 * 60 * 24 * 30;
				cookie_userid.setMaxAge(expiretime);
				cookie_pwd.setMaxAge(expiretime);
				cookie_autologin.setMaxAge(expiretime);
				response.addCookie(cookie_userid);
				response.addCookie(cookie_pwd);
				response.addCookie(cookie_autologin);

				session.setAttribute("userLoginInfo", userinfo);
				logger.info("autologin : main page");
				return "redirect:/main";
			}
		}
		logger.info("autologin : login page");
		return "login";
	}

	@RequestMapping("logout")
	public String logout(HttpSession session, HttpServletResponse response) {
		session.invalidate();

		//delete autologin cookie
		Cookie cookie_pwd = new Cookie("pwd", null);
		Cookie cookie_autologin= new Cookie("autologin", null);
		cookie_pwd.setMaxAge(0);
		cookie_autologin.setMaxAge(0);
		response.addCookie(cookie_autologin);
		response.addCookie(cookie_pwd);

		return "redirect:/";
	}

	@ResponseBody
	@RequestMapping(value = "loginProcess", method = RequestMethod.POST)
	public ModelAndView loginProcess(@RequestParam("Uuid") String userid, @RequestParam("Upwd") String passwd,
									 HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {

		logger.info("===> Start loginProcess1");

		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/");
		if (userid == null || passwd == null)
			return mav;

		passwd = testMD5(passwd);

		User userinfo = loginBO.findByUserIdAndPassword(userid, passwd);
		if (userinfo == null) {
			logger.info("===> Login fail");
			mav.addObject("msg", "f");
		} else {
			logger.info("===> Login" + userinfo.getGname() + userinfo.getUlevel());
			session.setAttribute("userLoginInfo", userinfo);
			mav.addObject("msg", "s");

			int mode = 0;
			if(request.getParameter("saveId") != null) mode = 1;
			if(request.getParameter("saveBoth") != null) mode = 2;
			setLoginCookie(response, mode, userid, passwd);
		}
		return mav;

	}

	public void setLoginCookie(HttpServletResponse response,  int mode, String userid, String pwd) {
		int expiretime = 60 * 60 * 24 * 30;

		logger.info("mode : " + mode);
		Cookie cookie_id = new Cookie("userid", userid);
		cookie_id.setMaxAge(expiretime);
		response.addCookie(cookie_id);

		Cookie cookie_pwd = new Cookie("pwd", pwd);
		Cookie cookie_autologin = new Cookie("autologin", "1");
		if(mode == 2) {
			cookie_autologin.setMaxAge(expiretime);
			cookie_pwd.setMaxAge(expiretime);
		}
		else {
			cookie_autologin.setMaxAge(0);
			cookie_pwd.setMaxAge(0);
		}
		response.addCookie(cookie_autologin);
		response.addCookie(cookie_pwd);
	}

	public String testMD5(String str) {
		String MD5 = "";
		try {

			MessageDigest md = MessageDigest.getInstance("MD5");
			md.update(str.getBytes());
			byte byteData[] = md.digest();
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < byteData.length; i++)
				sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
			MD5 = sb.toString();

		} catch (NoSuchAlgorithmException e) {

			e.printStackTrace();
			MD5 = null;
		}
		return MD5;
	}
}