package spring.trip.model.dao.impl;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import spring.trip.domain.Write;
import spring.trip.model.dao.WriteDAO;

@Repository
public class WriteDAOImpl implements WriteDAO{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insertWrite(Write write) throws Exception {
		sqlSession.insert("writeMapper.insertWrite", write);
	}

}
