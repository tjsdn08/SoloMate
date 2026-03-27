package com.solomate.boardcategory.vo;

public class BoardCategoryVO {

	private long cno;
	private String cname;
	public long getCno() {
		return cno;
	}
	public void setCno(long cno) {
		this.cno = cno;
	}
	public String getCname() {
		return cname;
	}
	public void setCname(String cname) {
		this.cname = cname;
	}
	@Override
	public String toString() {
		return "BoardCategoryVO [cno=" + cno + ", cname=" + cname + "]";
	}
	
	
	
}
