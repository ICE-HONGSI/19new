package com.ubinetsys.pms.main;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
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
import com.ubinetsys.pms.service.CommonService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class MainController {
	@Autowired
	@Resource(name = "commonService")
	private CommonService commonService;
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);

	@Autowired
	@Resource(name = "mainService")
	private MainService mainService;

	/**
	 * Main page
	 */
	@ResponseBody
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public ModelAndView home(HttpSession session, Locale locale, Model model) {
		logger.info("==> main page");

		User userinfo = (User) session.getAttribute("userLoginInfo");
		String gno = userinfo.getLocNo();
		ModelAndView mv = new ModelAndView("main");

		return mv;
	}

	@RequestMapping(value = "weatherRecord")
	@ResponseBody
	public String record(HttpSession session, Model model, HttpServletRequest request) {

		String str = request.getParameter("time");
		String log_date = request.getParameter("month").toString() + request.getParameter("date").toString();
		String pathSet = request.getSession().getServletContext()
				.getRealPath("/WEB-INF/views/log_weather/" + log_date + "_logs.txt");
		String msg = "";
		String status = request.getParameter("status");

		switch (request.getParameter("reason")) {
		case "0":
			msg = "쿠키 정보가 없음 [" + status + "] ==> [API 호출]";
			break;
		case "1":
			msg = "Time Out [" + status + "]==> [API 호출]";
			break;
		case "2":
			msg = "새로고침하였으나 정상 데이터 쿠키에 있음 [" + status + "] ==> 저장된 데이터 이용 [API 호출 X]";
			break;
		}

		try {
			File file = new File(pathSet);
			BufferedWriter bufferWriter = new BufferedWriter(new FileWriter(file, true));
			if (file.isFile()) {
				if (file.canWrite()) {
					bufferWriter.write(str + "\n" + msg);
					bufferWriter.newLine();
					bufferWriter.newLine();
					bufferWriter.close();
				}
			}

		} catch (Exception e) {
		}

		return null;

	}

	/** get weather_api call date log */
	@RequestMapping(value = "/wlog", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView log_weather(HttpSession session, Model model, HttpServletRequest request) {
		ModelAndView mv = new ModelAndView("log_weather_print");
		request.setAttribute("d", request.getParameter("d"));

		return mv;
	}

	@RequestMapping(value = "mainRefresh")
	public @ResponseBody HashMap<String, Object> ajax(HttpSession session) {
		HashMap<String, Object> result = new HashMap<String, Object>();

		User userinfo = (User) session.getAttribute("userLoginInfo");
		String gno = userinfo.getLocNo();

		List<Map<String, Object>> RunASCResult = mainService.selectASCResult(gno);
		List<Map<String, Object>> RunNOWResult = mainService.selectNOWResult(gno);
		List<Map<String, Object>> RunResult = mainService.selectRunResult(gno);
		List<Map<String, Object>> chartdata = mainService.chartdata(gno);
		List<Map<String, Object>> basic = mainService.basic(gno);

		result.put("month_asc", RunASCResult);
		result.put("month_now", RunNOWResult);
		result.put("RunResult", RunResult);
		result.put("chartdata", chartdata);
		result.put("BatSize", basic.get(0).get("BatSize").toString());

		int BMS = 0;
		if (RunResult.get(0).get("BMS_Status") != null)
			BMS = (Integer) RunResult.get(0).get("BMS_Status");

		String BMS_Status = "";
		switch (BMS) {
		case 0:
			BMS_Status = "충전중";
			break;
		case 1:
			BMS_Status = "방전중";
			break;
		case 2:
			BMS_Status = "대기중";
			break;
		}

		result.put("BMS_Status", BMS_Status);

		return result;
	}

	/** top page */
	@RequestMapping(value = "/top", method = RequestMethod.GET)
	public String top() {
		return "inc/top";
	}

	/** bottom page */
	@RequestMapping(value = "/bottom", method = RequestMethod.GET)
	public String bottom(Locale locale, Model model) {
		return "inc/bottom";
	}
}
