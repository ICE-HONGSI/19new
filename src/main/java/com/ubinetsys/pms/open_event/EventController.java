package com.ubinetsys.pms.open_event;

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
public class EventController {

	@Autowired
	private EventService eventService;
	private static final Logger logger = LoggerFactory.getLogger(EventController.class);

	@RequestMapping(value = "/oper_event_ajax", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView oper_event_ajax(HttpSession session, Map<String, Object> dataMap, Model model, HttpServletRequest request) throws Exception
	{
		ModelAndView mv = new ModelAndView();
		String dateFrom = request.getParameter("dateFrom");
		String dateTo = request.getParameter("dateTo");
		User userinfo = (User) session.getAttribute("userLoginInfo");
		String gno = userinfo.getLocNo();

		List<Map<String, Object>> list = eventService.selectEvent(dataMap, dateFrom, dateTo, gno);
		model.addAttribute("list", list);
		logger.info("list:" + list);
		return mv;
	}
	
	@RequestMapping(value = "/oper_event_excel", method = RequestMethod.GET)
	public ModelAndView oper_event_excel(HttpSession session, Map<String, Object> dataMap, Model model,HttpServletRequest request) throws Exception
	{
		ModelAndView mv = new ModelAndView("oper_event_excel");
		String dateFrom = request.getParameter("dateFrom");
		String dateTo = request.getParameter("dateTo");
		User userinfo = (User) session.getAttribute("userLoginInfo");
		String gno = userinfo.getLocNo();
		logger.info("EXCEL!!!");

		List<Map<String, Object>> list = eventService.selectEvent(dataMap, dateFrom, dateTo, gno);
		model.addAttribute("list", list);
		logger.info("list:" + list);
		return mv;
	}

	@RequestMapping(value = "/oper_eventList", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView oper_eventList(HttpSession session, Map<String, Object> dataMap, Model model, HttpServletRequest request) throws Exception
	{
		ModelAndView mv = new ModelAndView("oper_eventList");
		return mv;
	}
}
