package com.solomate.boardreply.vo;

public class BoardReplyVO {

	private long rno;
	private long no;
	private String content;
	private String id;
	private String name;
	private int sameId;
	private String writeDate;
	public long getRno() {
		return rno;
	}
	public void setRno(long rno) {
		this.rno = rno;
	}
	public long getNo() {
		return no;
	}
	public void setNo(long no) {
		this.no = no;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getSameId() {
		return sameId;
	}
	public void setSameId(int sameId) {
		this.sameId = sameId;
	}
	public String getWriteDate() {
		return writeDate;
	}
	public void setWriteDate(String writeDate) {
		this.writeDate = writeDate;
	}
	@Override
	public String toString() {
		return "BoardReplyVO [rno=" + rno + ", no=" + no + ", content=" + content + ", id=" + id + ", name=" + name
				+ ", sameId=" + sameId + ", writeDate=" + writeDate + "]";
	}
	
	
	
}
