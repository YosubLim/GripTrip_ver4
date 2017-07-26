package spring.trip.model.service;

import java.util.List;

public interface ReportService {
	public void saveReport(String word)throws Exception;//insert + update
	public List selectReport()throws Exception;
}
