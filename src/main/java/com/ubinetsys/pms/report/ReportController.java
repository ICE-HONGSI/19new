package com.ubinetsys.pms.report;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.mysql.fabric.xmlrpc.base.Data;
import com.ubinetsys.pms.login.User;

/**
 * Handles requests for the application home page.
 */
@Controller
public class ReportController {
   private static final Logger logger = LoggerFactory.getLogger(ReportController.class);

   @Autowired
   @Resource(name = "reportService")
   private ReportService reportService;
   
   @RequestMapping(value = "/reportUpdate", method = RequestMethod.GET)
      public ModelAndView reportUpdate2(HttpSession session,HttpServletRequest httpServletRequest) throws Exception {
         ModelAndView mv = new ModelAndView();
         mv.setViewName("redirect:/report");
         User userinfo = (User) session.getAttribute("userLoginInfo");
         String gno = userinfo.getLocNo();
         String dataSmp=httpServletRequest.getParameter("smp");
         String dataRec=httpServletRequest.getParameter("rec");
         String dataSun=httpServletRequest.getParameter("sunWeight");
         String dataEss=httpServletRequest.getParameter("ess_multi");
         if(dataSmp==null||dataRec==null||dataSun==null||dataEss==null) {
            //logger.info("NoUpdate" );
         }
         else {
            //logger.info("data :" + dataSmp +"/"+dataRec+"/"+dataSun+"/"+dataEss);
            reportService.updatedata(dataSmp,dataRec,dataSun,dataEss,gno);
         }
         return mv;
      }

   @RequestMapping(value = "/report", method = RequestMethod.GET)
   public ModelAndView reportData(HttpSession session,HttpServletRequest httpServletRequest) throws Exception {

      User userinfo = (User) session.getAttribute("userLoginInfo");
      String gno = userinfo.getLocNo();
      String dataSmp=httpServletRequest.getParameter("smp");
      
      // review.jsp에서 날짜를 보낼 때
      String year = httpServletRequest.getParameter("year");
      String month = httpServletRequest.getParameter("month");

      // review.jsp에서 날짜를 안보낼 때 = 처음에 페이지에 들어왔을 때
      if (year == null) {
         LocalDate currentDate = LocalDate.now();
         year = Integer.toString(currentDate.getYear());
         month =Integer.toString(currentDate.getMonthValue());
      }
      
      String g_number = userinfo.getLocNo();            
      //logger.info("year: " + year + "-" + "month: " + month + ", gnumber: " + g_number);
      
      ModelAndView mv = new ModelAndView();
      mv.setViewName("report");
      mv.addObject("year",year);
      mv.addObject("month", month);
      
      Map<String, Object> map = new HashMap<String, Object>();
      map.put("year", year);
      map.put("month", month);
      map.put("day", 0);
      map.put("g_number", g_number);

      // 수익 계산 기준표
      List<Map<String, Object>> moneyData = reportService.getMoneyData(map);
      float smp = getFloat(moneyData.get(0).get("SMP"));
      float rec = getFloat(moneyData.get(0).get("REC"));
      float pv_multi = getFloat(moneyData.get(0).get("PV_Multiple"));
      float ess_multi = getFloat(moneyData.get(0).get("ESS_Multiple"));//ESS_multiple의 DB테이블상 컬럼 name을 넣어주세요. 일단 임의로 "ESS_Multiple"로 넣어뒀음.
      mv.addObject("smp", smp);
      mv.addObject("rec", rec);
      mv.addObject("pv_multi", pv_multi);
      mv.addObject("ess_multi", ess_multi);
      // 일별데이터
      String sunProfit = ""; // 태양광 수익
      String essProfit = ""; // ESS 수익
      double totProfit = 0; // 월별 총 수익
      String profitStr = "";
      String dResultString = "";
      float checkProfit=0;
      Timestamp startDate=null;
      int calDate=0;
      
      List<Map<String, Object>> dateResult = reportService.getDateData(map);
      Float pvTot;
      Float essOut;
      Float essRcv;
      
      if(dateResult.size()!=0)
      {
    	  startDate=getTime(dateResult.get(0).get("DT"));
    	  mv.addObject("startDate",startDate);
    	  //logger.info("starDate-----"+startDate);
      }
 	// logger.info("~~~~~~~~*date!!!!!!!***"+getCalDate(startDate));
 	  int dateCnt=0;
 	  int startDateInt=getCalDate(startDate);
      for (int i=0; i<dateResult.size(); i++) {
     	 calDate=getCalDate(getTime(dateResult.get(i).get("DT")));
    	 if((dateCnt+startDateInt)!=calDate) {
    		i--;
    		pvTot=(float)0;
    		essOut=(float)0;
    		essRcv=(float)0;	
    	 }
    	 else {
             pvTot = getFloat(dateResult.get(i).get("PV_Total")) > 0 ? getFloat(dateResult.get(i).get("PV_Total")) : 0;
             essOut = getFloat(dateResult.get(i).get("ESS_SumOut")) > 0 ? getFloat(dateResult.get(i).get("ESS_SumOut")) : 0;
             essRcv = getFloat(dateResult.get(i).get("ESS_SumRcv")) > 0 ? getFloat(dateResult.get(i).get("ESS_SumRcv")) : 0;         
    	 }

     		// logger.info("SSame--"+dateCnt+startDateInt+"dddd"+calDate);
 		 dateCnt++;

         //일자별 충전량, 방전량, 발전량
         dResultString += (essOut + "/" + essRcv + "/" + pvTot + "@");
         
         // ess수익과 태양광수익을 string으로 합쳐서 전달
         checkProfit=essRcv * (smp + (rec * ess_multi));
         if(checkProfit>0) {
            essProfit=String.valueOf(checkProfit);
            totProfit += checkProfit;
         }
         else {
            essProfit="0";
            totProfit+=0;
         }
         checkProfit=(pvTot - essOut) * (smp + (pv_multi * rec));
         if(checkProfit>0) {
            sunProfit=String.valueOf(checkProfit);
            totProfit += checkProfit;
         }
         else {
            sunProfit="0";
            totProfit+=0;
         }
         profitStr += (essProfit + "/" + sunProfit +  "@");
      }
      BigDecimal bigDecimal = new BigDecimal(totProfit); //총수익 E 지수표현 없애기
      mv.addObject("startDate",startDate);
      mv.addObject("totProfit", bigDecimal.toString());
      mv.addObject("profitStr", profitStr);
      mv.addObject("dResultStr", dResultString);   
      logger.info("dResultStr"+dResultString);
      return mv;
   }

   Float getFloat(Object data) {
      if(data != null)
         return (Float)data;
      else
         return 0f;
   }   

   Timestamp getTime(Object data) {
	   if(data != null) {
	    	 // logger.info("======Date-----"+data);
			   return (Timestamp)data;
	   }
	   else return null;
   }
   
   int getCalDate(Timestamp data) {
	
	   if(data != null) {
		   Date date = new Date();
		   date.setTime(data.getTime());
		   String formattedDate = new SimpleDateFormat("yyyyMMdd").format(date);
		   String calStrDate = formattedDate.substring(6,8);
		   int calDate = Integer.valueOf(calStrDate);
		   return calDate;
	   }
	   else return 0;
   }
   
   
}