package com.solomate.food.vo;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.List;


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
	private List<String> folders;   // 조회용
	private List<Long> folderNos; // 등록/수정 용
    // 추가
    private String dday;
    private long diffDays;

    public void calculateDday() {
        LocalDate today = LocalDate.now();

        // String → LocalDate 변환
        LocalDate expiry = LocalDate.parse(this.expiryDate);

        this.diffDays = ChronoUnit.DAYS.between(today, expiry);

        if (diffDays > 0) this.dday = "D-" + diffDays;
        else if (diffDays == 0) this.dday = "D-Day";
        else this.dday = "D+" + Math.abs(diffDays);
    }
	
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
	public List<String> getFolders() {
		return folders;
	}
	public void setFolders(List<String> folders) {
		this.folders = folders;
	}
	
	
	public List<Long> getFolderNos() {
		return folderNos;
	}
	public void setFolderNos(List<Long> folderNos) {
		this.folderNos = folderNos;
	}

	public String getDday() {
		return dday;
	}

	public void setDday(String dday) {
		this.dday = dday;
	}

	public long getDiffDays() {
		return diffDays;
	}

	public void setDiffDays(long diffDays) {
		this.diffDays = diffDays;
	}

	@Override
	public String toString() {
		return "FoodVO [no=" + no + ", memberId=" + memberId + ", name=" + name + ", quantity=" + quantity
				+ ", storageType=" + storageType + ", expiryDate=" + expiryDate + ", memo=" + memo + ", createdAt="
				+ createdAt + ", updatedAt=" + updatedAt + ", dDay=" + dDay + ", folders=" + folders + ", folderNos="
				+ folderNos + ", dday=" + dday + ", diffDays=" + diffDays + "]";
	}

	

	
	

}
