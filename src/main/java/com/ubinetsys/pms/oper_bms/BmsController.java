package com.ubinetsys.pms.oper_bms;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.ubinetsys.pms.login.User;

/**
 * Handles requests for the application home page.
 */
@Controller
public class BmsController {

	@Autowired
	private BmsBO BmsBO;
//	@Resource(name = "commonService")
//	private CommonService commonService;
	private static final Logger logger = LoggerFactory.getLogger(BmsController.class);


	@RequestMapping(value = "/oper_bmsCall", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView home2(HttpSession session, Map<String, Object> dataMap, Model model) throws Exception {
		User userinfo = (User) session.getAttribute("userLoginInfo");
		String gno = userinfo.getLocNo();

		ModelAndView mv = new ModelAndView("oper_bmsCall");
		List<Map<String, Object>> list = BmsBO.selectBms(dataMap, gno);
		mv.addObject("list", list);

		return mv;
	}

	@RequestMapping(value = "/oper_bmsTray_ajax", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView oper_bmsTray_ajax(HttpSession session, Map<String, Object> dataMap, Model model, HttpServletRequest request) throws Exception {

		User userinfo = (User) session.getAttribute("userLoginInfo");
		String gno = userinfo.getLocNo();

		ModelAndView mv = new ModelAndView("oper_bmsTray_ajax");

		String Tno = request.getParameter("Tno");
		String Rno = request.getParameter("Rnotray");
		String DT = request.getParameter("DTtray");

		logger.info("Rno, gno" + Rno + "," + gno + "," + Tno);
		mv.addObject("Rno", Rno);
		mv.addObject("DT", DT);

		List<Map<String, Object>> tray = BmsBO.selectTray(dataMap, gno, Rno, DT);
		mv.addObject("tray", tray);
		logger.info("Tray===> " + tray);

		return mv;
	}

}
