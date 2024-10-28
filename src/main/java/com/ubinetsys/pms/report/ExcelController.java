package com.ubinetsys.pms.report;

import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.ubinetsys.pms.login.User;
import com.ubinetsys.pms.report.ReportService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class ExcelController {

	private static final Logger logger = LoggerFactory.getLogger(ExcelController.class);

	@Autowired
	@Resource(name = "reportService")
	private ReportService reportService;

	@RequestMapping(value = "/excel", method = RequestMethod.GET)
	public ModelAndView excelExport(HttpSession session, HttpServletRequest httpServletRequest) throws Exception {
		logger.info("==> excelExport page");

		ModelAndView mv = new ModelAndView();
		mv.setViewName("report_excel");

		String year = httpServletRequest.getParameter("year");
		String month = httpServletRequest.getParameter("month");
		String sdate = httpServletRequest.getParameter("sdate");

		logger.info("excel sdate" + sdate);
		User userinfo = (User) session.getAttribute("userLoginInfo");
		String g_number = userinfo.getLocNo();

		// 일일 데이터
		mv.addObject("year", year);
		mv.addObject("month", month);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("year", year);
		map.put("month", month);
		map.put("g_number", g_number);

		List<Map<String, Object>> dateResult = reportService.getDateData(map);
		logger.info("dateResult: " + dateResult);
		mv.addObject("dateResult", dateResult);

		// 수익 계산 기준표
		List<Map<String, Object>> moneyData = reportService.getMoneyData(map);
		float smp = getFloat(moneyData.get(0).get("SMP"));
		float rec = getFloat(moneyData.get(0).get("REC"));
		float pv_multi = getFloat(moneyData.get(0).get("PV_Multiple"));
		float ess_multi = getFloat(moneyData.get(0).get("ESS_Multiple"));// ESS_multiple의 DB테이블상 컬럼 name을 넣어주세요. 일단 임의로
																			// "ESS_Multiple"로 넣어뒀음.

		// 일일 수익 계산
		float sunProfit = 0; // 태양광 수익
		float essProfit = 0; // ESS 수익
		float checkProfit = 0;
		String[] profitArr = new String[31];
		int[] monthDays = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };

		int monthIndex = Integer.parseInt(month);

		String[] power = new String[monthDays[monthIndex - 1]];
		String[] charge = new String[monthDays[monthIndex - 1]];
		String[] discharge = new String[monthDays[monthIndex - 1]];

		logger.info("dateResult=" + dateResult.size());

		// 데이터 없는 부분 0으로 만들어 넘겨주기
		if (dateResult.size() == 0) {
			for (int i = 0; i < monthDays[monthIndex - 1]; i++) {
				power[i] = "0";
				charge[i] = "0";
				discharge[i] = "0";
				profitArr[i] = "0";
			}

			// System.out.println(power);
		} else {
			int j = 0;
			int checkDT = 0;
			for (int i = 0; i < monthDays[monthIndex - 1]; i++) {
				power[i] = "0";
				charge[i] = "0";
				discharge[i] = "0";
				profitArr[i] = "0";
				if (j < dateResult.size()) {
					checkDT = Integer.valueOf(dateResult.get(j).get("DT").toString().substring(8, 10)) - 1;
					// System.out.println(checkDT);

					if (checkDT == i) {

						Float pvTot = getFloat(dateResult.get(j).get("PV_Total"));
						Float essOut = getFloat(dateResult.get(j).get("ESS_SumOut"));
						Float essRcv = getFloat(dateResult.get(j).get("ESS_SumRcv"));

						// ess수익과 태양광수익을 string으로 합쳐서 전달
						checkProfit = essRcv * (smp + (rec * ess_multi));
						if (checkProfit > 0) {
							essProfit = checkProfit;
						} else {
							essProfit = 0;
						}
						checkProfit = (pvTot - essOut) * (smp + (pv_multi * rec));
						if (checkProfit > 0) {
							sunProfit = checkProfit;
						} else {
							sunProfit = 0;
						}

						power[i] = String.valueOf(pvTot);
						charge[i] = String.valueOf(essOut);
						discharge[i] = String.valueOf(essRcv);
						profitArr[i] = String.valueOf(formatD(essProfit + sunProfit));
						j++;
					}
				}
			}
		}
		mv.addObject("sdate", sdate);
		mv.addObject("power", power);
		mv.addObject("charge", charge);
		mv.addObject("discharge", discharge);
		mv.addObject("profitArr", profitArr);

		return mv;
	}

	Float getFloat(Object data) {
		if (data != null)
			return (Float) data;
		else
			return 0f;
	}

	DecimalFormat df = new DecimalFormat("###,###");

	public String formatD(double number) {
		return df.format(number);
	}
}