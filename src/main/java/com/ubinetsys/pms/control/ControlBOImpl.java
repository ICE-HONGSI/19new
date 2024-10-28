package com.ubinetsys.pms.control;

import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ControlBOImpl implements ControlBO {
	@Autowired
	private ControlDAO ControlDAO;

	@Override
	public List<Map<String, Object>> selectData(String gno) {
		List<Map<String, Object>> list = ControlDAO.selectData(gno);
		return list;
	}

	@Override
	public List<Map<String, Object>> basic(String gno) {
		List<Map<String, Object>> list = ControlDAO.basic(gno);
		return list;
	}

	@Override
	public List<Map<String, Object>> get_upwd(String userId) {
		List<Map<String, Object>> list = ControlDAO.get_upwd(userId);
		return list;
	}

}
