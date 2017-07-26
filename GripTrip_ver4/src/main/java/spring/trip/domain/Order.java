package spring.trip.domain;

public class Order {
	private int orderNo;
	private int quantity;
	private String orderCreateDate;
	private Member member;
	private Book book;
	private int totalPrice;

	public Order() {
		super();
	}

	public Order(int orderNo, int quantity, String orderCreateDate, Member member, Book book, int totalPrice) {
		super();
		this.orderNo = orderNo;
		this.quantity = quantity;
		this.orderCreateDate = orderCreateDate;
		this.member = member;
		this.book = book;
		this.totalPrice = totalPrice;
	}

	public int getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public String getOrderCreateDate() {
		return orderCreateDate;
	}

	public void setOrderCreateDate(String orderCreateDate) {
		this.orderCreateDate = orderCreateDate;
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
	
	public int getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}

	@Override
	public String toString() {
		return "Order [orderNo=" + orderNo + ", quantity=" + quantity + ", orderCreateDate=" + orderCreateDate
				+ ", member=" + member + ", book=" + book + "]";
	}
}