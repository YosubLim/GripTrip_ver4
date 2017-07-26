package spring.trip.model.dao.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import spring.trip.domain.Bookmark;
import spring.trip.domain.Member;
import spring.trip.model.dao.BookmarkDAO;

@Repository
public class BookmarkDAOImpl implements BookmarkDAO{
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insertBookmark(Bookmark bookmark) throws Exception {
		sqlSession.insert("bookmarkMapper.insertBookmark", bookmark);
	}

	@Override
	public List<Bookmark> myBookmark(String email) throws Exception {
		return sqlSession.selectList("bookmarkMapper.myBookmark", email);
	}

	@Override
	public void deleteBookmark(Bookmark bookmark) throws Exception {
		sqlSession.delete("bookmarkMapper.deleteBookmark", bookmark);	
	}

	@Override
	public void deleteBookmarkByStoryNo(String storyNo) throws Exception {
		sqlSession.delete("bookmarkMapper.deleteBookmarkByStoryNo", storyNo);
	}

	@Override
	public void deleteBookmarkByBookNo(String book_no) throws Exception {
		sqlSession.delete("bookmarkMapper.deleteBookmarkByBookNo", book_no);
	}
}
