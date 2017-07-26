package spring.trip.model.dao;

import java.util.List;

import spring.trip.domain.Story;

public interface StoryDAO {
	public void insertStoryInfo(Story story) throws Exception;

	public void updateStory(Story story) throws Exception;

	public void deleteStory(String storyNo) throws Exception;

	public void upStoryHit(String storyNo) throws Exception;

	public List<Story> showStoryList(String bookNo) throws Exception;

	public void deleteUrl(String storyNo) throws Exception;

	public void updateStoryBookmark(String storyNo) throws Exception;

	public Story getStoryByStoryNo(String storyNo) throws Exception;

	public void deleteStoryBookmark(String storyNo) throws Exception;

	public List<Story> allStoryList() throws Exception;

	public List<Story> otherStoryList(String email) throws Exception;

	public List<Story> searchStory(String keyword) throws Exception;

	public List<Story> searchStoryByTitle(String keyword) throws Exception;

	public List<Story> searchStoryByContent(String keyword) throws Exception;

	public List<Story> searchStoryByLocation(String keyword) throws Exception;

	public List<Story> allStoryListByHit() throws Exception;

	public List<Story> searchStoryOrderByHit(String keyword) throws Exception;

	public List<Story> searchStoryByTitleOrderByHit(String keyword) throws Exception;

	public List<Story> searchStoryByContentOrderByHit(String keyword) throws Exception;

	public List<Story> searchStoryByLocationOrderByHit(String keyword) throws Exception;

	public void upStoryBookmarkCount(int storyNo) throws Exception;

	public void downStoryBookmarkCount(int storyNo) throws Exception;
	
	public List<Story> allStoryListOrderByBookmark() throws Exception;

	public List<Story> searchStoryOrderByBookmark(String keyword) throws Exception;

	public List<Story> searchStoryByTitleOrderByBookmark(String keyword) throws Exception;

	public List<Story> searchStoryByContentOrderByBookmark(String keyword) throws Exception;

	public List<Story> searchStoryByLocationOrderByBookmark(String keyword) throws Exception;
}