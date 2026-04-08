package com.solomate.shopping.vo;

import com.solomate.util.page.PageObject;

public class ShoppingVO {

	// 기본 데이터
	private Long shoppingId;
	private Long userId;
	private Long dealId;
	private String itemName;
	private Integer quantity;
	private Long expectedPrice;
	private String planDate;
	private String status;
	private String sourceType;
	private String memo;
	private String createdAt;
	private String updatedAt;
	private String isDeleted;
	private String memberId;
	// 연동 핫딜 제목
	private String hotDealTitle;

	// 리스트 검색/페이징용
	private PageObject pageObject;
	private String word;
	private String planDateSearch;

	public Long getShoppingId() {
		return shoppingId;
	}

	public void setShoppingId(Long shoppingId) {
		this.shoppingId = shoppingId;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public Long getDealId() {
		return dealId;
	}

	public void setDealId(Long dealId) {
		this.dealId = dealId;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public Integer getQuantity() {
		return quantity;
	}

	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}

	public Long getExpectedPrice() {
		return expectedPrice;
	}

	public void setExpectedPrice(Long expectedPrice) {
		this.expectedPrice = expectedPrice;
	}

	public String getPlanDate() {
		return planDate;
	}

	public void setPlanDate(String planDate) {
		this.planDate = planDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getSourceType() {
		return sourceType;
	}

	public void setSourceType(String sourceType) {
		this.sourceType = sourceType;
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

	public String getIsDeleted() {
		return isDeleted;
	}

	public void setIsDeleted(String isDeleted) {
		this.isDeleted = isDeleted;
	}

	public String getHotDealTitle() {
		return hotDealTitle;
	}

	public void setHotDealTitle(String hotDealTitle) {
		this.hotDealTitle = hotDealTitle;
	}

	public PageObject getPageObject() {
		return pageObject;
	}

	public void setPageObject(PageObject pageObject) {
		this.pageObject = pageObject;
	}

	public String getWord() {
		return word;
	}

	public void setWord(String word) {
		this.word = word;
	}

	public String getPlanDateSearch() {
		return planDateSearch;
	}

	public void setPlanDateSearch(String planDateSearch) {
		this.planDateSearch = planDateSearch;
	}

	

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	@Override
	public String toString() {
		return "ShoppingVO [shoppingId=" + shoppingId + ", userId=" + userId + ", dealId=" + dealId + ", itemName="
				+ itemName + ", quantity=" + quantity + ", expectedPrice=" + expectedPrice + ", planDate=" + planDate
				+ ", status=" + status + ", sourceType=" + sourceType + ", memo=" + memo + ", createdAt=" + createdAt
				+ ", updatedAt=" + updatedAt + ", isDeleted=" + isDeleted + ", memberId=" + memberId + ", hotDealTitle="
				+ hotDealTitle + ", pageObject=" + pageObject + ", word=" + word + ", planDateSearch=" + planDateSearch
				+ "]";
	}
	
	
}