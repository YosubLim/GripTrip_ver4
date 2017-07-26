package spring.trip.model.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import spring.trip.domain.Comment;
import spring.trip.domain.Story;
import spring.trip.model.dao.CommentDAO;
import spring.trip.model.service.CommentService;

@Service
public class CommentServiceImpl implements CommentService{
	// field
	@Autowired
	private CommentDAO commentDAO;

	@Override
	public int writeComment(Comment vo) {
		return commentDAO.writeComment(vo);
	}

	@Override
	public List<Comment> showAllVisibleCommentsOfStory(Story vo) {
		return commentDAO.showAllVisibleCommentsOfStory(vo);
	}

	@Override
	public int updateComment(Comment vo) {
		return commentDAO.updateComment(vo);
	}

	@Override
	public int removeComment(String commentNo) {
		return commentDAO.removeComment(commentNo);
	}

	@Override
	public int getMaxOrderIdWithSameDepth(Comment vo) {
		return commentDAO.getMaxOrderIdWithSameDepth(vo);
	}

	@Override
	public int writeRecomment(Comment vo) {
		return commentDAO.writeRecomment(vo);
	}

	@Override
	public int countComment(String storyNo) {
		return commentDAO.countComment(storyNo);
	}
}
