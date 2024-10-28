
package com.ubinetsys.pms.oper_pcs;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.ubinetsys.pms.report.AbstractDAO;;

@Repository("pcsDAO")
public class PcsDAO extends AbstractDAO{
	
	public List<Map<String, Object>> getPcsData(Map<String, Object> map)throws Exception{
		List<Map<String,Object>> selectList = (List<Map<String,Object>>)selectList("pcsSql.pcsTableData",map);
		return selectList;
	}
	
	public List<Map<String, Object>> pcsBoxData(Map<String, Object> map)throws Exception{
		List<Map<String,Object>> selectList = (List<Map<String,Object>>)selectList("pcsSql.pcsBoxData",map);
		return selectList;
	}

}
