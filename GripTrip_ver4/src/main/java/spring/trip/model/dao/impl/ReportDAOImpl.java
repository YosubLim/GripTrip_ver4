package spring.trip.model.dao.impl;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import spring.trip.model.dao.ReportDAO;

@Repository
public class ReportDAOImpl implements ReportDAO{
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insertReport(String word) throws Exception {
		sqlSession.insert("reportMapper.insertReport", word);
	}

	@Override
	public int updateReport(String word) throws Exception {		
		return sqlSession.update("reportMapper.updateReport", word);
	}

	@Override
	public List selectReport() throws Exception {		
		return sqlSession.selectList("reportMapper.selectReport");
	}
}




