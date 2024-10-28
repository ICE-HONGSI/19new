
package com.ubinetsys.pms.oper_pcs;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import com.ubinetsys.pms.oper_pcs.PcsDAO;

@Service("pcsService")
public class PcsServiceImpl implements PcsService {

	@Resource(name="pcsDAO")
	private PcsDAO pcsDAO;
	
	@Override
	public List<Map<String, Object>> getPcsData(Map<String, Object> map) throws Exception {
		return pcsDAO.getPcsData(map);
	}

	@Override
	public List<Map<String, Object>> pcsBoxData(Map<String, Object> map) throws Exception {
		return pcsDAO.pcsBoxData(map);
	}
	

}
