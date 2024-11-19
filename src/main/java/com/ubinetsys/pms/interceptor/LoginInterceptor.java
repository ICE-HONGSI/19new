package com.ubinetsys.pms.interceptor;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.ubinetsys.pms.login.User;

public class LoginInterceptor extends HandlerInterceptorAdapter {
	private static final Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws IOException {
		String uri = request.getRequestURI();

		HttpSession session = request.getSession();

		// login처리를 담당하는 사용자 정보를 담고 있는 객체를 가져옴
		Object obj = session.getAttribute("userLoginInfo");
		if (obj == null) {
			logger.info("==> Interceptor1" + request.getRequestURI());
			if (uri.equals("/pms/") || uri.equals("/pms/loginProcess") || uri.contains("/img/") || uri.contains("/js/")
					|| uri.contains("/css/")) {
				return true;
			}

			logger.info("==> Interceptor2" + request.getRequestURI());
			response.sendRedirect("/pms/");
			return false;
		}
		logger.info("==> Interceptor3" + request.getRequestURI());
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
						   ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		super.postHandle(request, response, handler, modelAndView);
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		super.afterCompletion(request, response, handler, ex);
	}
}