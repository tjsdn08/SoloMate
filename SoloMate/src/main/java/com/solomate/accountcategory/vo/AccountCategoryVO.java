package com.solomate.accountcategory.vo;

public class AccountCategoryVO {

	private long cno;
	private String cname;
	private String type;
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
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	@Override
	public String toString() {
		return "AccountCategoryVO [cno=" + cno + ", cname=" + cname + ", type=" + type + "]";
	}
	
	
}
