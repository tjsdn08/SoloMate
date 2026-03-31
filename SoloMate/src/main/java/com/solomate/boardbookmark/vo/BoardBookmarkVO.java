package com.solomate.boardbookmark.vo;

public class BoardBookmarkVO {

	private long bookmarkNo;
	private long boardNo;
	private String id;
	private String regDate;
	private String title;
	private String writer;
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
	public String getTitle() {
		return title; 
	}
	public void setTitle(String title) {
		this.title = title; 
	}
	public String getWriter() { 
		return writer; 
	}
	public void setWriter(String writer) {
		this.writer = writer; 
	}
	@Override
	public String toString() {
		return "BoardBookmarkVO [bookmarkNo=" + bookmarkNo + ", boardNo=" + boardNo + ", id=" + id + ", regDate="
				+ regDate + "]";
	}
	
	
}
