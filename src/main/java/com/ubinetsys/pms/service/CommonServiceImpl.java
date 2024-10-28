package com.ubinetsys.pms.service;

import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ubinetsys.pms.CommonDAO;

@Service("commonService")
public class CommonServiceImpl implements CommonService {

	@Autowired
	@Resource(name = "commonDao")
	CommonDAO commonDao;

	@Override
	public String getTitle(Map param) throws Exception {
		String title = commonDao.getTitle(param);
		return title;
	}

	@Override
	public List<Map<String, Object>> selectList() {
		List<Map<String, Object>> list = commonDao.selectList();
		return list;
	}
}
