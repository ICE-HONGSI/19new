package com.ubinetsys.pms.oper_pcs;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.ubinetsys.pms.login.User;
import com.ubinetsys.pms.oper_pcs.PcsService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class PCSController {

	@Autowired
	@Resource(name = "pcsService")
	private PcsService pcsService;


	@RequestMapping(value = "/oper_pcsCall01", method = RequestMethod.GET)
	public ModelAndView pcsData( HttpSession session,HttpServletRequest httpServletRequest) throws Exception{
		
		ModelAndView mv = new ModelAndView();
		Map<String, Object> map = new HashMap<String, Object>();

		mv.setViewName("oper_pcsCall01");

		User userInfo = (User)session.getAttribute("userLoginInfo");
		String g_number= userInfo.getLocNo();
				
		String p_number=httpServletRequest.getParameter("pno");
		map.put("g_number",g_number);
		map.put("p_number",p_number);
		
		List<Map<String,Object>> pcsData = pcsService.getPcsData(map); //table 데이터들

		mv.addObject("pcsAlarm", pcsData.get(0).get("PCS_Alarm").toString());
		
		mv.addObject("DT",pcsData.get(0).get("DT").toString());		
		mv.addObject("DO", pcsData.get(0).get("DO").toString());
		mv.addObject("DI", pcsData.get(0).get("DI").toString());
		
		
		mv.addObject("currA", pcsData.get(0).get("G_CurrA").toString());
		mv.addObject("currB", pcsData.get(0).get("G_CurrB").toString());
		mv.addObject("currC", pcsData.get(0).get("G_CurrC").toString());
		
		mv.addObject("voltA", pcsData.get(0).get("G_VoltA").toString());
		mv.addObject("voltB", pcsData.get(0).get("G_VoltB").toString());
		mv.addObject("voltC", pcsData.get(0).get("G_VoltC").toString());
		
		mv.addObject("voltR", pcsData.get(0).get("G_VoltR").toString());
		mv.addObject("voltS", pcsData.get(0).get("G_VoltS").toString());
		mv.addObject("voltT", pcsData.get(0).get("G_VoltT").toString());
		
		mv.addObject("dc_voltH", pcsData.get(0).get("DC_VoltH").toString());
		mv.addObject("dc_voltL", pcsData.get(0).get("DC_VoltL").toString());
		mv.addObject("dc_volt", pcsData.get(0).get("DC_Volt").toString());

		mv.addObject("dc_curr", pcsData.get(0).get("DC_Curr").toString());
		mv.addObject("ambient_temp", pcsData.get(0).get("Ambient_Temp").toString());
		mv.addObject("stack_temp", pcsData.get(0).get("Stack_Temp").toString());
		
		mv.addObject("dc_power", pcsData.get(0).get("DC_Power").toString());
		mv.addObject("ac_power", pcsData.get(0).get("AC_Power").toString());
		mv.addObject("r_power", pcsData.get(0).get("R_Power").toString());
		
		mv.addObject("wr", pcsData.get(0).get("WR").toString());
		mv.addObject("dc_hgpower", pcsData.get(0).get("DChgPower").toString());
		mv.addObject("c_hgpower", pcsData.get(0).get("ChgPower").toString());
		
		mv.addObject("trans_temp", pcsData.get(0).get("Trans_Temp").toString());
		mv.addObject("freq", pcsData.get(0).get("Freq").toString());
		mv.addObject("c_mode", pcsData.get(0).get("C_Mode").toString());
		
		mv.addObject("mode", pcsData.get(0).get("MODE").toString());
		mv.addObject("status", pcsData.get(0).get("STATUS").toString());
		mv.addObject("pebb", pcsData.get(0).get("PEBB_FS").toString());
			
		return mv;

	}
}
