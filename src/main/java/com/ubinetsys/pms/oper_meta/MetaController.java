package com.ubinetsys.pms.oper_meta;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller
public class MetaController {
	
	private static final Logger logger = LoggerFactory.getLogger(MetaController.class);


	@RequestMapping(value = "/oper_metaCall01", method = RequestMethod.GET)
	public String oper_metaCall01(Locale locale, Model model) {

		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);

		String formattedDate = dateFormat.format(date);

		model.addAttribute("serverTime", formattedDate);

		return "oper_metaCall01";
	}
}
