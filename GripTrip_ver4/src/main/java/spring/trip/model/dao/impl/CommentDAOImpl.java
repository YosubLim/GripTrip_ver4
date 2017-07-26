package spring.trip.model.dao.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import spring.trip.domain.Comment;
import spring.trip.domain.Story;
import spring.trip.model.dao.CommentDAO;

@Repository
public class CommentDAOImpl implements CommentDAO{
	// field
	@Autowired
	private SqlSession sqlSession;

	@Override
	public int writeComment(Comment vo) {
		return sqlSession.insert("commentMapper.writeComment", vo);
	}

	@Override
	public List<Comment> showAllVisibleCommentsOfStory(Story vo) {
		return sqlSession.selectList("commentMapper.showAllVisibleCommentsOfStory", vo);
	}

	@Override
	public int updateComment(Comment vo) {
		return sqlSession.update("commentMapper.updateComment", vo);
	}

	@Override
	public int removeComment(String commentNo) {
		return sqlSession.delete("commentMapper.removeComment", commentNo);
	}

	@Override
	public int getMaxOrderIdWithSameDepth(Comment vo) {
		System.out.println("RE DAOImpl : " + vo);
		return sqlSession.selectOne("commentMapper.getMaxOrderIdWithSameDepth", vo);
	}

	@Override
	public int writeRecomment(Comment vo) {
		return sqlSession.insert("commentMapper.writeRecomment", vo);
	}

	@Override
	public int countComment(String storyNo) {
		return sqlSession.selectOne("commentMapper.countComment", storyNo);
	}
}
