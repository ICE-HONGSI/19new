package com.ubinetsys.pms.main;

import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ubinetsys.pms.main.MainDAO;

@Service("mainService")
public class MainServiceImpl implements MainService {
	@Autowired
	@Resource(name = "mainDAO")
	private MainDAO MainDAO;

	public List<Map<String, Object>> selectRunResult(String gno) {
		List<Map<String, Object>> list = MainDAO.selectRunResult(gno);
		return list;
	}

	@Override
	public List<Map<String, Object>> basic(String gno) {
		List<Map<String, Object>> list = MainDAO.basic(gno);
		return list;
	}

	@Override
	public List<Map<String, Object>> chartdata(String gno) {
		List<Map<String, Object>> list = MainDAO.chartdata(gno);
		return list;
	}
	
	@Override
	public List<Map<String, Object>> selectASCResult(String gno) {
		List<Map<String, Object>> list = MainDAO.selectASCResult(gno);
		return list;
	}
	
	@Override
	public List<Map<String, Object>> selectNOWResult(String gno) {
		List<Map<String, Object>> list = MainDAO.selectNOWResult(gno);
		return list;
	}
}
