package com.solomate.folder.vo;

import java.util.List;

import com.solomate.food.vo.FoodVO;

public class FolderVO {
	private long no;
	private String memberId;
	private String name;
	private String createdAt;
	private String updatedAt;
	private List<FoodVO> foods;
	
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
	public List<FoodVO> getFoods() {
		return foods;
	}
	public void setFoods(List<FoodVO> foods) {
		this.foods = foods;
	}
	@Override
	public String toString() {
		return "FolderVO [no=" + no + ", memberId=" + memberId + ", name=" + name + ", createdAt=" + createdAt
				+ ", updatedAt=" + updatedAt + ", foods=" + foods + "]";
	}
	
	
	

}
