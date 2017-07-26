package spring.trip.model.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import spring.trip.model.dao.ReportDAO;
import spring.trip.model.service.ReportService;

@Service
public class ReportServiceImpl implements ReportService{
	@Autowired
	private ReportDAO reportDAO;

	@Override
	public void saveReport(String word) throws Exception {
		int updateRow=reportDAO.updateReport(word);//0 , 1
		if(updateRow==0) reportDAO.insertReport(word);	
	}

	@Override
	public List selectReport() throws Exception {
		return reportDAO.selectReport();
	}
}
/*
 * int insert( ) 
 * int delete( )
 * int update( )
 */














