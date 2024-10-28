package com.ubinetsys.pms.oper_system;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.ubinetsys.pms.login.User;


@Controller
public class SystemInfoController {
	
	@Autowired
	@Resource(name = "SystemService")
	private SystemService SystemService;

	
	@RequestMapping(value = "/oper_systemInfo", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView oper_systemInfo(HttpSession session, Model model, HttpServletRequest request) {

		ModelAndView mv = new ModelAndView();
		Map<String, Object> map = new HashMap<String, Object>();
		mv.setViewName("oper_systemInfo");
		User userInfo = (User) session.getAttribute("userLoginInfo");
		String gno = userInfo.getLocNo();
		map.put("gno", gno);

		try {
		List<Map<String, Object>> list = SystemService.selectSysInfo(map);


		String Sname = (String) list.get(0).get("Sname");
		int bms_cnt = (Integer) list.get(0).get("BMS_Cnt");
		int dpm_cnt = (Integer) list.get(0).get("DPM_Cnt");
		int pcs_cnt = (Integer) list.get(0).get("PCS_Cnt");
		int emu_cnt = (Integer) list.get(0).get("EMU_Cnt");
		
		for(int i=0; i<bms_cnt; i++)
			request.setAttribute("BMS_IP" + Integer.toString(i+1), (String) list.get(0).get("BMS_IP" + Integer.toString(i+1)));
		
		for(int i=0; i<dpm_cnt; i++)
			request.setAttribute("DPM_IP" + Integer.toString(i+1), (String) list.get(0).get("DPM_IP" + Integer.toString(i+1)));
		
		request.setAttribute("PCS_IP", (String) list.get(0).get("PCS_IP"));
		request.setAttribute("EMU_IP", (String) list.get(0).get("EMU_IP"));
	
		request.setAttribute("bms_cnt", bms_cnt);
		request.setAttribute("dpm_cnt", dpm_cnt);
		request.setAttribute("pcs_cnt", pcs_cnt);
		request.setAttribute("emu_cnt", emu_cnt);
		request.setAttribute("Sname", Sname);
		
		request.setAttribute("data", "success");

		} catch (Exception e) {
			System.out.println(e);
			request.setAttribute("data", "error");
		}

		
		return mv;
	}
}
