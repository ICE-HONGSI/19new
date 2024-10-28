package com.ubinetsys.pms.open_event;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class EventService {
	@Autowired
	private EventDAO eventDAO;

	public List<Map<String, Object>> selectEvent(Map<String, Object> map, String dateFrom, String dateTo, String gno)
			throws Exception {
		// TODO Auto-generated method stub
		return eventDAO.selectEvent(map, dateFrom, dateTo, gno);
	}

}
