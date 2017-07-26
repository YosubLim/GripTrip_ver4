package spring.trip.model.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import spring.trip.domain.Write;
import spring.trip.model.dao.WriteDAO;
import spring.trip.model.service.WriteService;

@Service
public class WriteServiceImpl implements WriteService {

	@Autowired
	private WriteDAO writeDAO;
	
	@Override
	public void insertWrite(Write write) throws Exception {	
		writeDAO.insertWrite(write);
	}

}
