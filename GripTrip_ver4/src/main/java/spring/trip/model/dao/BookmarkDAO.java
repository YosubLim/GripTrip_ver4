package spring.trip.model.dao;

import java.util.List;

import spring.trip.domain.Bookmark;
import spring.trip.domain.Member;

public interface BookmarkDAO {
	public void insertBookmark(Bookmark bookmark) throws Exception;
	public List<Bookmark> myBookmark(String email) throws Exception;
	public void deleteBookmark(Bookmark bookmark) throws Exception;	
	public void deleteBookmarkByStoryNo(String storyNo) throws Exception;
	public void deleteBookmarkByBookNo(String book_no) throws Exception;
}
