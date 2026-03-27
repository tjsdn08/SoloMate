package com.solomate.food.vo;

import java.util.List;

import com.solomate.folder.vo.FolderVO;

public class FoodVO {
	
	private long no;
	private String memberId;
	private String name;
	private long quantity;
	private String storageType;
	private String expiryDate;
	private String memo;
	private String createdAt;
	private String updatedAt;
	private String dDay;
	private List<FolderVO> folders;
	public long getNo() {
		return no;
	}
	public void setNo(long no) {
		this.no = no;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public long getQuantity() {
		return quantity;
	}
	public void setQuantity(long quantity) {
		this.quantity = quantity;
	}
	public String getStorageType() {
		return storageType;
	}
	public void setStorageType(String storageType) {
		this.storageType = storageType;
	}
	public String getExpiryDate() {
		return expiryDate;
	}
	public void setExpiryDate(String expiryDate) {
		this.expiryDate = expiryDate;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public String getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}
	public String getUpdatedAt() {
		return updatedAt;
	}
	public void setUpdatedAt(String updatedAt) {
		this.updatedAt = updatedAt;
	}
	public String getdDay() {
		return dDay;
	}
	public void setdDay(String dDay) {
		this.dDay = dDay;
	}
	public List<FolderVO> getFolders() {
		return folders;
	}
	public void setFolders(List<FolderVO> folders) {
		this.folders = folders;
	}
	@Override
	public String toString() {
		return "FoodVO [no=" + no + ", memberId=" + memberId + ", name=" + name + ", quantity=" + quantity
				+ ", storageType=" + storageType + ", expiryDate=" + expiryDate + ", memo=" + memo + ", createdAt="
				+ createdAt + ", updatedAt=" + updatedAt + ", dDay=" + dDay + ", folders=" + folders + "]";
	}
	
	

}
