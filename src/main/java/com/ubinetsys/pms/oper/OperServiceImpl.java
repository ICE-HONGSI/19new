package com.ubinetsys.pms.oper;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import com.ubinetsys.pms.oper.OperDAO;

@Service("operService")
public class OperServiceImpl implements OperService {

	@Resource(name = "operDAO")
	private OperDAO operDAO;

	@Override
	public List<Map<String, Object>> getPcsCount(Map<String, Object> map) throws Exception {
		return operDAO.getPcsCount(map);
	}

}