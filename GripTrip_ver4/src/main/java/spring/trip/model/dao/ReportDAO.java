package spring.trip.model.dao;

import java.util.List;

public interface ReportDAO {
	public void insertReport(String word)throws Exception;
	public int updateReport(String word)throws Exception;
	public List selectReport()throws Exception;
}
