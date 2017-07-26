package spring.trip.model.dao.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import spring.trip.domain.Book;
import spring.trip.model.dao.BookDAO;

@Repository
public class BookDAOImpl implements BookDAO{
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insertWriteBook(Book book) throws Exception {	
		sqlSession.insert("bookMapper.insertwriteBook", book);
	}

	@Override
	public String selectByNoForDate(int book_no) throws Exception {	
		return sqlSession.selectOne("bookMapper.selectByNoForDate", book_no);
	}

	@Override
	public List<Book> getOtherBookList(String email) throws Exception {		
		return sqlSession.selectList("bookMapper.getOtherBookList",email);
	}

	@Override
	public void updateHit(int book_no) throws Exception {
		sqlSession.update("bookMapper.updateHit", book_no);
	}

	@Override
	public void updateBook(Book book) throws Exception {	
		sqlSession.update("bookMapper.updateBook", book);
	}

	@Override
	public void deleteBook(int book_no) throws Exception {
		sqlSession.delete("bookMapper.deleteBook", book_no);
	}

	@Override
	public Book getBookByBookNo(int book_no) throws Exception {
		return sqlSession.selectOne("bookMapper.getBookByBookNo", book_no);
	}

	@Override
	public String getNickName(int book_no) throws Exception {
		return sqlSession.selectOne("bookMapper.getNickName", book_no);
	}
	
	@Override
	   public List<Book> getMyBookList(String email) throws Exception {
	      return sqlSession.selectList("bookMapper.getMyBookList", email);
	   }

	@Override
	public List<Book> getAllBookList() throws Exception {
		return sqlSession.selectList("bookMapper.getAllBookList");
	}

	@Override
	public void updateBookmark(int book_no) throws Exception {
		sqlSession.update("bookMapper.updateBookmark", book_no);	
	}

	@Override
	public void deleteBookmark(int book_no) throws Exception {
		sqlSession.update("bookMapper.deleteBookmark", book_no);
	}

	@Override
	public String getEmailByBookNo(int book_no) throws Exception {
		return sqlSession.selectOne("bookMapper.getEmailByBookNo", book_no);
	}

	@Override
	public void deleteBookByEmail(String email) throws Exception {
		sqlSession.delete("bookMapper.deleteBookByEmail", email);
	}

	@Override
	public List<Book> searchBook(String keyword) throws Exception {
		return sqlSession.selectList("bookMapper.searchBook", keyword);
	}

	@Override
	public List<Book> searchBookByTitle(String keyword) throws Exception {
		return sqlSession.selectList("bookMapper.searchBookByTitle", keyword);
	}

	@Override
	public List<Book> searchBookByContent(String keyword) throws Exception {
		return sqlSession.selectList("bookMapper.searchBookByContent", keyword);
	}

	@Override
	public List<Book> searchBookByLocation(String keyword) throws Exception {
		return sqlSession.selectList("bookMapper.searchBookByLocation", keyword);
	}

	@Override
	public int getStoryCountOfBook(int book_no) throws Exception {
		return sqlSession.selectOne("storyMapper.getStoryCountOfBook", book_no);
	}

	@Override
	public List<Book> getAllBookListOrderByHit() throws Exception {
		return sqlSession.selectList("bookMapper.getAllBookListOrderByHit");
	}

	@Override
	public List<Book> searchBookOrderByHit(String keyword) throws Exception {
		return sqlSession.selectList("bookMapper.searchBookOrderByHit", keyword);
	}

	@Override
	public List<Book> searchBookByTitleOrderByHit(String keyword) throws Exception {
		return sqlSession.selectList("bookMapper.searchBookByTitleOrderByHit", keyword);
	}

	@Override
	public List<Book> searchBookByContentOrderByHit(String keyword) throws Exception {
		return sqlSession.selectList("bookMapper.searchBookByContentOrderByHit", keyword);
	}

	@Override
	public List<Book> searchBookByLocationOrderByHit(String keyword) throws Exception {
		return sqlSession.selectList("bookMapper.searchBookByLocationOrderByHit", keyword);
	}

	@Override
	public void upBookmarkCount(int book_no) throws Exception {
		sqlSession.update("bookMapper.upBookmarkCount", book_no);
	}

	@Override
	public void downBookmarkCount(int book_no) throws Exception {
		sqlSession.update("bookMapper.downBookmarkCount", book_no);
	}

	@Override
	public List<Book> getAllBookListOrderByBookmark() throws Exception {
		return sqlSession.selectList("bookMapper.getAllBookListOrderByBookmark");
	}

	@Override
	public List<Book> searchBookOrderByBookmark(String keyword) throws Exception {
		return sqlSession.selectList("bookMapper.searchBookOrderByBookmark",keyword);
	}

	@Override
	public List<Book> searchBookByTitleOrderByBookmark(String keyword) throws Exception {
		return sqlSession.selectList("bookMapper.searchBookByTitleOrderByBookmark",keyword);
	}

	@Override
	public List<Book> searchBookByContentOrderByBookmark(String keyword) throws Exception {
		return sqlSession.selectList("bookMapper.searchBookByContentOrderByBookmark",keyword);
	}

	@Override
	public List<Book> searchBookByLocationOrderByBookmark(String keyword) throws Exception {
		return sqlSession.selectList("bookMapper.searchBookByLocationOrderByBookmark",keyword);
	}
}
