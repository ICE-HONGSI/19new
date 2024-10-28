package com.ubinetsys.pms.oper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.ubinetsys.pms.oper.OperService;
import com.ubinetsys.pms.login.User;

@Controller
public class OperController {

	@Autowired
	@Resource(name = "operService")
	private OperService operService;

	@RequestMapping(value = "/oper", method = RequestMethod.GET)
	public ModelAndView pcsMenu(HttpSession session) throws Exception 
	{
		ModelAndView mv = new ModelAndView();
		mv.setViewName("oper");
		Map<String, Object> map = new HashMap<String, Object>();
		User userInfo = (User) session.getAttribute("userLoginInfo");
		String g_number = userInfo.getLocNo();
		//String g_number="5"; //tbl_pcs_lsis 테이블때문에 임시설정
		map.put("g_number", g_number);

		List<Map<String, Object>> pcsCount = operService.getPcsCount(map);
		// mv.addObject("pcsCount", pcsCount);

		String pcsString = "";
		for (int i = 0; i < pcsCount.size(); i++) {
			pcsString += pcsCount.get(i).get("Pno");
			pcsString += "/";
		}
		mv.addObject("pcsCountStr", pcsString);
		return mv;

	}
}
