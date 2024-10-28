package com.ubinetsys.pms.oper;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.ubinetsys.pms.report.AbstractDAO;

@Repository("operDAO")
public class OperDAO extends AbstractDAO {

	public List<Map<String, Object>> getPcsCount(Map<String, Object> map) throws Exception {
		return selectList("pcsSql.pcsCount", map);
	}

}