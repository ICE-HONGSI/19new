package com.ubinetsys.pms.report;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("reportDAO")
public class ReportDAO extends AbstractDAO {
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public List<Map<String, Object>> getMonthData(Map<String, Object> map) throws Exception {
		List<Map<String, Object>> selectList = (List<Map<String, Object>>) selectList("reportSql.reportMonth", map);
		return selectList;
	}

	public List<Map<String, Object>> getDateData(Map<String, Object> map) throws Exception {
		List<Map<String, Object>> selectList = (List<Map<String, Object>>) selectList("reportSql.reportDate", map);
		return selectList;
	}

	public List<Map<String, Object>> getDateSum(Map<String, Object> map) throws Exception {
		List<Map<String, Object>> selectList = (List<Map<String, Object>>) selectList("reportSql.sumDate", map);
		return selectList;
	}

	public List<Map<String, Object>> getMoneyData(Map<String, Object> map) throws Exception {
		List<Map<String, Object>> selectList = (List<Map<String, Object>>) selectList("reportSql.getMoneyData", map);
		return selectList;
	}
	
	public int updatedata(String smp,String rec, String pv_multi,String ess_multi, String gno) throws Exception {
		Map<String, String> param = new HashMap<String, String>();
		param.put("smp", smp);
		param.put("rec", rec);
		param.put("pv_multi", pv_multi);
		param.put("ess_multi", ess_multi);
		param.put("gno", gno);
		return sqlSession.update("updateData",param);
	}
}
