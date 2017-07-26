package spring.trip.model.dao.impl;


import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import spring.trip.domain.Story;
import spring.trip.model.dao.StoryDAO;

@Repository
public class StoryDAOImpl implements StoryDAO{
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insertStoryInfo(Story story) throws Exception{
		sqlSession.insert("storyMapper.insertStoryInfo", story);
	}
   
	@Override
	public void updateStory(Story story) throws Exception{
		sqlSession.update("storyMapper.updateStory", story);
	}
   
	@Override
	public void deleteStory(String storyNo) throws Exception{
		sqlSession.delete("storyMapper.deleteStory", storyNo);
	}
   
/*	@Override
	public Story showStory(String storyNo) throws Exception{
		return sqlSession.selectOne("storyMapper.showStory", storyNo);
	}*/
   
	@Override
	public void upStoryHit(String storyNo) throws Exception{
		sqlSession.update("storyMapper.upStoryHit", storyNo);
	}

	@Override
	public List<Story> showStoryList(String bookNo) throws Exception {
		return sqlSession.selectList("storyMapper.showStoryList", bookNo);
	}

	@Override
	public void deleteUrl(String storyNo) throws Exception {
		sqlSession.update("storyMapper.deleteUrl", storyNo);
	}

	@Override
	public void updateStoryBookmark(String storyNo) throws Exception {
		sqlSession.update("storyMapper.updateStoryBookmark",storyNo);
	}

	@Override
	public Story getStoryByStoryNo(String storyNo) throws Exception {
		return sqlSession.selectOne("storyMapper.getStoryByStoryNo", storyNo);
	}

	@Override
	public void deleteStoryBookmark(String storyNo) throws Exception {
		sqlSession.update("storyMapper.deleteStoryBookmark", storyNo);
	}

	@Override
	public List<Story> allStoryList() throws Exception {
		return sqlSession.selectList("storyMapper.allStoryList");
	}

	@Override
	public List<Story> otherStoryList(String email) throws Exception {
		return sqlSession.selectList("storyMapper.otherStoryList",email);
	}

	@Override
	public List<Story> searchStory(String keyword) throws Exception {
		return sqlSession.selectList("storyMapper.searchStory", keyword);
	}

	@Override
	public List<Story> searchStoryByTitle(String keyword) throws Exception {
		return sqlSession.selectList("storyMapper.searchStoryByTitle", keyword);
	}

	@Override
	public List<Story> searchStoryByContent(String keyword) throws Exception {
		return sqlSession.selectList("storyMapper.searchStoryByContent", keyword);
	}

	@Override
	public List<Story> searchStoryByLocation(String keyword) throws Exception {
		return sqlSession.selectList("storyMapper.searchStoryByLocation", keyword);
	}

	@Override
	public List<Story> allStoryListByHit() throws Exception {
		return sqlSession.selectList("storyMapper.allStoryListByHit");
	}

	@Override
	public List<Story> searchStoryOrderByHit(String keyword) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("storyMapper.searchStoryOrderByHit", keyword);
	}

	@Override
	public List<Story> searchStoryByTitleOrderByHit(String keyword) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("storyMapper.searchStoryByTitleOrderByHit", keyword);
	}

	@Override
	public List<Story> searchStoryByContentOrderByHit(String keyword) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("storyMapper.searchStoryByContentOrderByHit", keyword);
	}

	@Override
	public List<Story> searchStoryByLocationOrderByHit(String keyword) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("storyMapper.searchStoryByLocationOrderByHit", keyword);
	}

	@Override
	public void upStoryBookmarkCount(int storyNo) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update("storyMapper.upStoryBookmarkCount",storyNo);
	}

	@Override
	public void downStoryBookmarkCount(int storyNo) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update("storyMapper.downStoryBookmarkCount",storyNo);
	}

	@Override
	public List<Story> allStoryListOrderByBookmark() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("storyMapper.allStoryListOrderByBookmark");
	}

	@Override
	public List<Story> searchStoryOrderByBookmark(String keyword) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("storyMapper.searchStoryOrderByBookmark", keyword);
	}

	@Override
	public List<Story> searchStoryByTitleOrderByBookmark(String keyword) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("storyMapper.searchStoryByTitleOrderByBookmark", keyword);
	}

	@Override
	public List<Story> searchStoryByContentOrderByBookmark(String keyword) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("storyMapper.searchStoryByContentOrderByBookmark", keyword);
	}

	@Override
	public List<Story> searchStoryByLocationOrderByBookmark(String keyword) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("storyMapper.searchStoryByLocationOrderByBookmark", keyword);
	}
}