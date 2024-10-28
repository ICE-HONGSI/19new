package com.ubinetsys.pms.trend;

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
 * Handles requests for the application Trend page.
 */
@Controller
public class TrendController {

	@Autowired
	private TrendBO TrendBO;
	private static final Logger logger = LoggerFactory.getLogger(TrendController.class);

	/**
	 * Trend page
	 */
	@RequestMapping(value = "/trend", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView trendFunc(HttpSession session, Map<String, Object> dataMap, Model model,
			HttpServletRequest request) throws Exception {

		User userinfo = (User) session.getAttribute("userLoginInfo");
		String gno = userinfo.getLocNo();

		String date1, date2;
		String dateLabel, dateLabel2;
		List<Map<String, Object>> list, list2;

		if (request.getParameter("date1") == null) {
			if (request.getParameter("date2") == null) {
				date1 = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
				date2 = date1.substring(0, 7);
			} else {
				date2 = request.getParameter("date2");
				date1 = date2 + "-01";
			}
		} else {
			date1 = request.getParameter("date1");
			date2 = date1.substring(0, 7);
		}
		dateLabel = date1.substring(5, 7);
		dateLabel2 = date1.substring(0, 4);
		logger.info("Today :" + date1);

		list = TrendBO.selectDay(dataMap, date1, gno);
		list2 = TrendBO.selectMonth(dataMap, date2, gno);

		ModelAndView mv = new ModelAndView("/trend");
		mv.addObject("list", list);
		mv.addObject("list2", list2);
		mv.addObject("date1", date1);
		mv.addObject("date2", date2);
		mv.addObject("dateLabel", dateLabel);
		mv.addObject("dateLabel2", dateLabel2);
		return mv;

	}
}