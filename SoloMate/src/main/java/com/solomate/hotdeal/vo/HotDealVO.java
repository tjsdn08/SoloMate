package com.solomate.hotdeal.vo;

import com.solomate.util.page.PageObject;

public class HotDealVO {

	private Long dealId;
	private Long categoryId;
	private String categoryName;
	private String title;
	private Long price;
	private Long originalPrice;
	private Double discountRate;
	private String imageUrl;
	private String imageName;
	private String thumbName;
	private String shopName;
	private String sellerName;
	private String dealUrl;
	private String description;
	private String endDate;
	private Long viewCount;
	private String status;
	private String createdAt;
	private String updatedAt;
	private String isDeleted;

	private PageObject pageObject;
	private String word;
	private String sort;
	private String addedToShopping;
	public Long getDealId() {
		return dealId;
	}
	public void setDealId(Long dealId) {
		this.dealId = dealId;
	}
	public Long getCategoryId() {
		return categoryId;
	}
	public void setCategoryId(Long categoryId) {
		this.categoryId = categoryId;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Long getPrice() {
		return price;
	}
	public void setPrice(Long price) {
		this.price = price;
	}
	public Long getOriginalPrice() {
		return originalPrice;
	}
	public void setOriginalPrice(Long originalPrice) {
		this.originalPrice = originalPrice;
	}
	public Double getDiscountRate() {
		return discountRate;
	}
	public void setDiscountRate(Double discountRate) {
		this.discountRate = discountRate;
	}
	public String getImageUrl() {
		return imageUrl;
	}
	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}
	public String getImageName() {
		return imageName;
	}
	public void setImageName(String imageName) {
		this.imageName = imageName;
	}
	public String getThumbName() {
		return thumbName;
	}
	public void setThumbName(String thumbName) {
		this.thumbName = thumbName;
	}
	public String getShopName() {
		return shopName;
	}
	public void setShopName(String shopName) {
		this.shopName = shopName;
	}
	public String getSellerName() {
		return sellerName;
	}
	public void setSellerName(String sellerName) {
		this.sellerName = sellerName;
	}
	public String getDealUrl() {
		return dealUrl;
	}
	public void setDealUrl(String dealUrl) {
		this.dealUrl = dealUrl;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public Long getViewCount() {
		return viewCount;
	}
	public void setViewCount(Long viewCount) {
		this.viewCount = viewCount;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
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
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	public String getAddedToShopping() {
		return addedToShopping;
	}
	public void setAddedToShopping(String addedToShopping) {
		this.addedToShopping = addedToShopping;
	}
	@Override
	public String toString() {
		return "HotDealVO [dealId=" + dealId + ", categoryId=" + categoryId + ", categoryName=" + categoryName
				+ ", title=" + title + ", price=" + price + ", originalPrice=" + originalPrice + ", discountRate="
				+ discountRate + ", imageUrl=" + imageUrl + ", imageName=" + imageName + ", thumbName=" + thumbName
				+ ", shopName=" + shopName + ", sellerName=" + sellerName + ", dealUrl=" + dealUrl + ", description="
				+ description + ", endDate=" + endDate + ", viewCount=" + viewCount + ", status=" + status
				+ ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + ", isDeleted=" + isDeleted + ", pageObject="
				+ pageObject + ", word=" + word + ", sort=" + sort + ", addedToShopping=" + addedToShopping + "]";
	}
}