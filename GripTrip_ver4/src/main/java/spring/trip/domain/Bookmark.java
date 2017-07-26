package spring.trip.domain;

public class Bookmark {
	private int bookmarkNo;
	private Member member;
	private int bookNo;
	private int storyNo;
	
	public Bookmark() {
	}

	public Bookmark(int bookmarkNo, Member member, int bookNo, int storyNo) {
		super();
		this.bookmarkNo = bookmarkNo;
		this.member = member;
		this.bookNo = bookNo;
		this.storyNo = storyNo;
	}

	public Bookmark(int bookNo, int storyNo) {
		super();
		this.bookNo = bookNo;
		this.storyNo = storyNo;
	}

	public Bookmark(Member member, int bookNo, int storyNo) {
		super();
		this.member = member;
		this.bookNo = bookNo;
		this.storyNo = storyNo;
	}

	public int getBookmarkNo() {
		return bookmarkNo;
	}

	public void setBookmarkNo(int bookmarkNo) {
		this.bookmarkNo = bookmarkNo;
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	public int getBookNo() {
		return bookNo;
	}

	public void setBookNo(int bookNo) {
		this.bookNo = bookNo;
	}

	public int getStoryNo() {
		return storyNo;
	}

	public void setStoryNo(int storyNo) {
		this.storyNo = storyNo;
	}

	@Override
	public String toString() {
		return "Bookmark [bookmarkNo=" + bookmarkNo + ", member=" + member + ", bookNo=" + bookNo + ", storyNo="
				+ storyNo + "]";
	}

	
}
