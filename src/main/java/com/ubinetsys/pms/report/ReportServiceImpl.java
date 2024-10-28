package com.ubinetsys.pms.report;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import com.ubinetsys.pms.report.ReportDAO;

@Service("reportService")
public class ReportServiceImpl implements ReportService {

	@Resource(name = "reportDAO")
	private ReportDAO reportDAO;

	@Override
	public List<Map<String, Object>> getMonthData(Map<String, Object> map) throws Exception {
		return reportDAO.getMonthData(map);
	}

	@Override
	public List<Map<String, Object>> getDateData(Map<String, Object> map) throws Exception {
		return reportDAO.getDateData(map);
	}

	@Override
	public List<Map<String, Object>> getMoneyData(Map<String, Object> map) throws Exception {
		return reportDAO.getMoneyData(map);
	}

	@Override
	public List<Map<String, Object>> getDateSum(Map<String, Object> map) throws Exception {
		return reportDAO.getDateSum(map);
	}


	@Override
	public int updatedata(String smp,String rec,String pv_multi,String ess_multi,String gno) throws Exception{
		return reportDAO.updatedata(smp,rec,pv_multi,ess_multi,gno);
	}

}
