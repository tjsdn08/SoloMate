package com.solomate.boardbookmark.vo;

public class BoardBookmarkVO {

	private long bookmarkNo;
	private long boardNo;
	private String id;
	private String regDate;
	public long getBookmarkNo() {
		return bookmarkNo;
	}
	public void setBookmarkNo(long bookmarkNo) {
		this.bookmarkNo = bookmarkNo;
	}
	public long getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(long boardNo) {
		this.boardNo = boardNo;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	@Override
	public String toString() {
		return "BoardBookmarkVO [bookmarkNo=" + bookmarkNo + ", boardNo=" + boardNo + ", id=" + id + ", regDate="
				+ regDate + "]";
	}
	
	
}
