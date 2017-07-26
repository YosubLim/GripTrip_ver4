package spring.trip.domain;

public class Comment {
	// field
	private int commentNo;
	private String commentContent;
	private String commentCreateDate;
	private String commentIsPublic;
	private int parentCommentNo;
	private String parentCommentEmail;
	private int groupId;
	private int orderId;
	private int depth;
	
	private Member member;
	private Story story;
	
	// constructors
	public Comment(){}
	
	public Comment(int commentNo, String commentContent, String commentCreateDate, String commentIsPublic,
			Member member, Story story) {
		super();
		this.commentNo = commentNo;
		this.commentContent = commentContent;
		this.commentCreateDate = commentCreateDate;
		this.commentIsPublic = commentIsPublic;
		this.member = member;
		this.story = story;
	}	

	public Comment(int commentNo, String commentContent, String commentCreateDate, String commentIsPublic,
			int parentCommentNo, String parentCommentEmail, int groupId, int orderId, int depth, Member member,
			Story story) {
		super();
		this.commentNo = commentNo;
		this.commentContent = commentContent;
		this.commentCreateDate = commentCreateDate;
		this.commentIsPublic = commentIsPublic;
		this.parentCommentNo = parentCommentNo;
		this.parentCommentEmail = parentCommentEmail;
		this.groupId = groupId;
		this.orderId = orderId;
		this.depth = depth;
		this.member = member;
		this.story = story;
	}

	// setters and getters
	public int getCommentNo() {
		return commentNo;
	}

	public void setCommentNo(int commentNo) {
		this.commentNo = commentNo;
	}

	public String getCommentContent() {
		return commentContent;
	}

	public void setCommentContent(String commentContent) {
		this.commentContent = commentContent;
	}

	public String getCommentCreateDate() {
		return commentCreateDate;
	}

	public void setCommentCreateDate(String commentCreateDate) {
		this.commentCreateDate = commentCreateDate;
	}

	public String getCommentIsPublic() {
		return commentIsPublic;
	}

	public void setCommentIsPublic(String commentIsPublic) {
		this.commentIsPublic = commentIsPublic;
	}

	public int getParentCommentNo() {
		return parentCommentNo;
	}

	public void setParentCommentNo(int parentCommentNo) {
		this.parentCommentNo = parentCommentNo;
	}

	public int getGroupId() {
		return groupId;
	}

	public void setGroupId(int groupId) {
		this.groupId = groupId;
	}

	public int getOrderId() {
		return orderId;
	}

	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}

	public int getDepth() {
		return depth;
	}

	public void setDepth(int depth) {
		this.depth = depth;
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	public Story getStory() {
		return story;
	}

	public void setStory(Story story) {
		this.story = story;
	}

	public String getParentCommentEmail() {
		return parentCommentEmail;
	}

	public void setParentCommentEmail(String parentCommentEmail) {
		this.parentCommentEmail = parentCommentEmail;
	}

	@Override
	public String toString() {
		return "Comment [commentNo=" + commentNo + ", commentContent=" + commentContent + ", commentCreateDate="
				+ commentCreateDate + ", commentIsPublic=" + commentIsPublic + ", parentCommentNo=" + parentCommentNo
				+ ", parentCommentEmail=" + parentCommentEmail + ", groupId=" + groupId + ", orderId=" + orderId
				+ ", depth=" + depth + ", member=" + member + ", story=" + story + "]";
	}
}
