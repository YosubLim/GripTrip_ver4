package spring.trip.model.service.impl;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import spring.trip.domain.Book;
import spring.trip.model.dao.BookDAO;
import spring.trip.model.service.BookService;

@Service
public class BookServiceImpl implements BookService{

	@Autowired
	private BookDAO bookDAO;

	@Override
	public void insertWriteBook(Book book) throws Exception {		
		bookDAO.insertWriteBook(book);
		String book_create_date = bookDAO.selectByNoForDate(book.getBook_no());
		book.setBook_create_date(book_create_date);
	}

	@Override
	public List<Book> getOtherBookList(String email) throws Exception {		
		return bookDAO.getOtherBookList(email);
	}

	@Override
	public void updateHit(int book_no) throws Exception {		
		bookDAO.updateHit(book_no);
	}

	@Override
	public void updateBook(Book book) throws Exception {	
		bookDAO.updateBook(book);
	}

	@Override
	public void deleteBook(int book_no) throws Exception {
		
		bookDAO.deleteBook(book_no);
	}

	@Override
	public void deleteFile(String book_picture_url) throws Exception {
		File file = new File(book_picture_url);
		System.out.println(book_picture_url+" File Delete OK!"+file.delete());
		file.delete();
	}

	@Override
	public Book getBookByBookNo(int book_no) throws Exception {
		return bookDAO.getBookByBookNo(book_no);
	}

	@Override
	public String getNickName(int book_no) throws Exception {
		return bookDAO.getNickName(book_no);
	}

/*	@Override
	public int maxBookNo() throws Exception {
		return bookDAO.maxBookNo();
	}*/
	
	 @Override
	   public List<Book> getMyBookList(String email) throws Exception {
	      return bookDAO.getMyBookList(email);
	   }

	@Override
	public List<Book> getAllBookList() throws Exception {
		return bookDAO.getAllBookList();
	}

	@Override
	public void updateBookmark(int book_no) throws Exception {
		bookDAO.updateBookmark(book_no);
	}

	@Override
	public void deleteBookmark(int book_no) throws Exception {
		bookDAO.deleteBookmark(book_no);
	}

	@Override
	public String getEmailByBookNo(int book_no) throws Exception {
		return bookDAO.getEmailByBookNo(book_no);
	}

	@Override
	public void deleteBookByEmail(String email) throws Exception {
		bookDAO.deleteBookByEmail(email);
	}

	@Override
	public List<Book> searchBook(String keyword) throws Exception {
		return bookDAO.searchBook(keyword);
	}

	@Override
	public List<Book> searchBookByTitle(String keyword) throws Exception {
		return bookDAO.searchBookByTitle(keyword);
	}

	@Override
	public List<Book> searchBookByContent(String keyword) throws Exception {
		return bookDAO.searchBookByContent(keyword);
	}

	@Override
	public List<Book> searchBookByLocation(String keyword) throws Exception {
		return bookDAO.searchBookByLocation(keyword);
	}

	@Override
	public int getStoryCountOfBook(int book_no) throws Exception {
		// TODO Auto-generated method stub
		return bookDAO.getStoryCountOfBook(book_no);
	}

	@Override
	public List<Book> getAllBookListOrderByHit() throws Exception {
		return bookDAO.getAllBookListOrderByHit();
	}

	@Override
	public List<Book> searchBookOrderByHit(String keyword) throws Exception {
		// TODO Auto-generated method stub
		return bookDAO.searchBookOrderByHit(keyword);
	}

	@Override
	public List<Book> searchBookByTitleOrderByHit(String keyword) throws Exception {
		// TODO Auto-generated method stub
		return bookDAO.searchBookByTitleOrderByHit(keyword);
	}

	@Override
	public List<Book> searchBookByContentOrderByHit(String keyword) throws Exception {
		// TODO Auto-generated method stub
		return bookDAO.searchBookByContentOrderByHit(keyword);
	}

	@Override
	public List<Book> searchBookByLocationOrderByHit(String keyword) throws Exception {
		// TODO Auto-generated method stub
		return bookDAO.searchBookByLocationOrderByHit(keyword);
	}

	@Override
	public void upBookmarkCount(int book_no) throws Exception {
		// TODO Auto-generated method stub
		bookDAO.upBookmarkCount(book_no);
	}

	@Override
	public void downBookmarkCount(int book_no) throws Exception {
		// TODO Auto-generated method stub
		bookDAO.downBookmarkCount(book_no);
	}

	@Override
	public List<Book> getAllBookListOrderByBookmark() throws Exception {
		// TODO Auto-generated method stub
		return bookDAO.getAllBookListOrderByBookmark();
	}

	@Override
	public List<Book> searchBookOrderByBookmark(String keyword) throws Exception {
		// TODO Auto-generated method stub
		return bookDAO.searchBookOrderByBookmark(keyword);
	}

	@Override
	public List<Book> searchBookByTitleOrderByBookmark(String keyword) throws Exception {
		// TODO Auto-generated method stub
		return bookDAO.searchBookByTitleOrderByBookmark(keyword);
	}

	@Override
	public List<Book> searchBookByContentOrderByBookmark(String keyword) throws Exception {
		// TODO Auto-generated method stub
		return bookDAO.searchBookByContentOrderByBookmark(keyword);
	}

	@Override
	public List<Book> searchBookByLocationOrderByBookmark(String keyword) throws Exception {
		// TODO Auto-generated method stub
		return bookDAO.searchBookByLocationOrderByBookmark(keyword);
	}
}
