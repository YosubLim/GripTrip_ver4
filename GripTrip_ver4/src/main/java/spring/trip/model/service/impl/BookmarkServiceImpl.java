package spring.trip.model.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import spring.trip.domain.Bookmark;
import spring.trip.domain.Member;
import spring.trip.model.dao.BookDAO;
import spring.trip.model.dao.BookmarkDAO;
import spring.trip.model.service.BookmarkService;

@Service
public class BookmarkServiceImpl implements BookmarkService{
	@Autowired
	private BookmarkDAO bookmarkDAO;
	
	@Override
	public void insertBookmark(Bookmark bookmark) throws Exception {
		bookmarkDAO.insertBookmark(bookmark);
	}

/*	@Override
	public List<Bookmark> getBookmarks(String email) throws Exception {
		return bookmarkDAO.getBookmarks(email);
	}*/
	
	@Override
	public List<Bookmark> myBookmark(String email) throws Exception {
		return bookmarkDAO.myBookmark(email);
	}

	@Override
	public void deleteBookmark(Bookmark bookmark) throws Exception {
		bookmarkDAO.deleteBookmark(bookmark);
	}

	@Override
	public void deleteBookmarkByStoryNo(String storyNo) throws Exception {
		bookmarkDAO.deleteBookmarkByStoryNo(storyNo);
	}

	@Override
	public void deleteBookmarkByBookNo(String book_no) throws Exception {
		bookmarkDAO.deleteBookmarkByBookNo(book_no);
	}
}
