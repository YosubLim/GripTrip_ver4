package spring.trip.domain;

public class Write {
	private int write_no;
	private String email;
	private int book_no;
	//
	private Member member;
	private Book book;
	
	public Write(int write_no, String email, int book_no, Member member, Book book) {
		super();
		this.write_no = write_no;
		this.email = email;
		this.book_no = book_no;
		this.member = member;
		this.book = book;
	}

	public Write(int write_no, String email, int book_no) {
		super();
		this.write_no = write_no;
		this.email = email;
		this.book_no = book_no;
	}
	
	public Write() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public int getWrite_no() {
		return write_no;
	}
	public void setWrite_no(int write_no) {
		this.write_no = write_no;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getBook_no() {
		return book_no;
	}
	public void setBook_no(int book_no) {
		this.book_no = book_no;
	}
	
	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	public Book getBook() {
		return book;
	}

	public void setBook(Book book) {
		this.book = book;
	}

	@Override
	public String toString() {
		return "Write [write_no=" + write_no + ", email=" + email + ", book_no=" + book_no + "]";
	}
	
}
