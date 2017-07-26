package spring.trip.domain;

import org.springframework.web.multipart.MultipartFile;

public class Book {
	private int book_no;
	private String book_title;
	private String book_create_date;
	private String book_picture_url;
	private String book_is_public;
	private int book_hit;
	private String nick;
	private String bookmark;
	private int price;
	private int storyCount;
	private int bookmark_count;
	
	private MultipartFile uploadFile;
	


	public Book(int book_no, String book_title, String book_create_date, String book_picture_url, String book_is_public,
			int book_hit) {
		super();
		this.book_no = book_no;
		this.book_title = book_title;
		this.book_create_date = book_create_date;
		this.book_picture_url = book_picture_url;
		this.book_is_public = book_is_public;
		this.book_hit = book_hit;
	}
	
	public Book(String book_title, String book_picture_url, String book_is_public) {
		super();
		this.book_title = book_title;
		this.book_picture_url = book_picture_url;
		this.book_is_public = book_is_public;
	}

	public Book() {
		super();
	}
	
	public Book(int book_no, String book_title, String book_create_date, String book_picture_url, String book_is_public,
			int book_hit, String nick, String bookmark, int price, int storyCount, MultipartFile uploadFile) {
		super();
		this.book_no = book_no;
		this.book_title = book_title;
		this.book_create_date = book_create_date;
		this.book_picture_url = book_picture_url;
		this.book_is_public = book_is_public;
		this.book_hit = book_hit;
		this.nick = nick;
		this.bookmark = bookmark;
		this.price = price;
		this.storyCount = storyCount;
		this.uploadFile = uploadFile;
	}

	public int getBook_no() {
		return book_no;
	}
	public void setBook_no(int book_no) {
		this.book_no = book_no;
	}
	public String getBook_title() {
		return book_title;
	}
	public void setBook_title(String book_title) {
		this.book_title = book_title;
	}
	public String getBook_create_date() {
		return book_create_date;
	}
	public void setBook_create_date(String book_create_date) {
		this.book_create_date = book_create_date;
	}
	public String getBook_picture_url() {
		return book_picture_url;
	}
	public void setBook_picture_url(String book_picture_url) {
		this.book_picture_url = book_picture_url;
	}
	public String getBook_is_public() {
		return book_is_public;
	}
	public void setBook_is_public(String book_is_public) {
		this.book_is_public = book_is_public;
	}
	public int getBook_hit() {
		return book_hit;
	}
	public void setBook_hit(int book_hit) {
		this.book_hit = book_hit;
	}
	
	public int getStoryCount() {
		return storyCount;
	}

	public void setStoryCount(int storyCount) {
		this.storyCount = storyCount;
	}
	
	public int getBookmark_count() {
		return bookmark_count;
	}

	public void setBookmark_count(int bookmark_count) {
		this.bookmark_count = bookmark_count;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getBookmark() {
		return bookmark;
	}

	public void setBookmark(String bookmark) {
		this.bookmark = bookmark;
	}

	public String getNick() {
		return nick;
	}

	public void setNick(String nick) {
		this.nick = nick;
	}
	
	public MultipartFile getUploadFile() {
		return uploadFile;
	}

	public void setUploadFile(MultipartFile uploadFile) {
		this.uploadFile = uploadFile;
	}

	@Override
	public String toString() {
		return "Book [book_no=" + book_no + ", book_title=" + book_title + ", book_create_date=" + book_create_date
				+ ", book_picture_url=" + book_picture_url + ", book_is_public=" + book_is_public + ", book_hit="
				+ book_hit + ", nick=" + nick + ", bookmark=" + bookmark + ", price=" + price + ", storyCount="
				+ storyCount + ", uploadFile=" + uploadFile + "]";
	}	
}
