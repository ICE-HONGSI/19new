package com.ubinetsys.pms.main;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("mainService")
public interface MainService {
	
	public List<Map<String, Object>> selectRunResult(String gno);

	public List<Map<String, Object>> basic(String gno);

	public List<Map<String, Object>> chartdata(String gno);
	
	public List<Map<String, Object>> selectASCResult(String gno);
	
	public List<Map<String, Object>> selectNOWResult(String gno);
}
