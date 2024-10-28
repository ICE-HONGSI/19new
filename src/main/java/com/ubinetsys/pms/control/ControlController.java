package com.ubinetsys.pms.control;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ubinetsys.pms.login.User;

@Controller
public class ControlController {

	@Autowired
	private ControlBO ControlBO;
	private static final Logger logger = LoggerFactory.getLogger(ControlController.class);

	@RequestMapping(value = "control_url.do", method = RequestMethod.POST)
	public ModelAndView ajax(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		User userinfo = (User) session.getAttribute("userLoginInfo");
		String userId = userinfo.getUuid();
		List<Map<String, Object>> list3 = ControlBO.get_upwd(userId);
		ModelAndView mav = new ModelAndView();

		mav.setViewName("redirect:/control");

		if (list3.get(0).get("UPwd").equals(request.getParameter("password"))) 
		mav.addObject("result", "s");											
		else																	
		mav.addObject("result", "f");	
			
		
		return mav;
	}

	/* return control */
	@RequestMapping(value = "/control", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView home(HttpSession session, Locale locale, Model model) {
		User userinfo = (User) session.getAttribute("userLoginInfo");
		String gno = userinfo.getLocNo();
		String userId = userinfo.getUuid();
		ModelAndView mv = new ModelAndView("control");
		List<Map<String, Object>> list = ControlBO.selectData(gno);
		List<Map<String, Object>> list2 = ControlBO.basic(gno);
		List<Map<String, Object>> list3 = ControlBO.get_upwd(userId);
		mv.addObject("list", list);
		mv.addObject("basic", list2);
		mv.addObject("get_upwd", list3);
		mv.addObject("UPwd", list3.get(0).get("UPwd").toString());

		model.addAttribute("UPwd", list3.get(0).get("UPwd").toString());
		return mv;
	}

	/* return control_manualMode */
	@RequestMapping(value = "/control_manualMode")
	public String Control_manualMode() {
		return "control_manualMode";
	}

	/* return control_autoMode */
	@RequestMapping(value = "/control_autoMode")
	public String Control_autoMode() {
		return "control_autoMode";
	}

	@RequestMapping(value = "/control_run")
	public ModelAndView control_stop(HttpSession session, Locale locale, Model model) {
		User userinfo = (User) session.getAttribute("userLoginInfo");
		String gno = userinfo.getLocNo();
		ModelAndView mv = new ModelAndView("control_run");
		List<Map<String, Object>> list = ControlBO.selectData(gno);
		List<Map<String, Object>> list2 = ControlBO.basic(gno);
		mv.addObject("list", list);
		mv.addObject("basic", list2);
		return mv;
	}

	@RequestMapping(value = "/control_stop")
	public String Control_runMode() {
		return "control_stop";
	}

	@RequestMapping(value = "/control_operationSetting")
	public ModelAndView control_operationSetting(HttpSession session, Locale locale, Model model) {
		User userinfo = (User) session.getAttribute("userLoginInfo");
		String gno = userinfo.getLocNo();
		ModelAndView mv = new ModelAndView("control_operationSetting");
		return mv;
	}

	@RequestMapping(value = "/control_engineer")
	public ModelAndView control_engineer(HttpSession session, Locale locale, Model model) {
		User userinfo = (User) session.getAttribute("userLoginInfo");
		String gno = userinfo.getLocNo();
		ModelAndView mv = new ModelAndView("control_engineer");
		return mv;
	}

}