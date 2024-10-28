package com.ubinetsys.pms.oper_bms;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BmsBOImpl implements BmsBO {

	@Autowired
	private BmsDAO BmsDAO;

	@Override
	public List<Map<String, Object>> selectBms(Map<String, Object> map, String gno) throws Exception {
		return BmsDAO.selectBms(map, gno);
	}

	@Override
	public List<Map<String, Object>> selectTray(Map<String, Object> map, String gno, String Rno, String DT) throws Exception {
		return BmsDAO.selectTray(map, gno, Rno, DT);
	}
}
