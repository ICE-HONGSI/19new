package com.ubinetsys.pms.oper_system;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ubinetsys.pms.oper_system.SystemDAO;

@Service("SystemService")
public class SystemServiceImpl implements SystemService {

	@Autowired
	@Resource(name = "SystemDAO")
	private SystemDAO SystemDAO;

	@Override
	public List<Map<String, Object>> selectSysInfo(Map<String, Object> map) {
		return SystemDAO.selectSysInfo(map);
	}

}
