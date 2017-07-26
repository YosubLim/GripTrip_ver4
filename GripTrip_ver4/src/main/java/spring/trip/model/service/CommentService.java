package spring.trip.model.service;

import java.util.List;

import spring.trip.domain.Comment;
import spring.trip.domain.Story;

public interface CommentService {
	public int writeComment(Comment vo);
	public List<Comment> showAllVisibleCommentsOfStory(Story vo);
	public int updateComment(Comment vo);
	public int removeComment(String commentNo);
	public int getMaxOrderIdWithSameDepth(Comment vo);
	public int writeRecomment(Comment vo);
	public int countComment(String storyNo);
}
