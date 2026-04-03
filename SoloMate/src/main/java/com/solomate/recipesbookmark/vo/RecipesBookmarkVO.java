package com.solomate.recipesbookmark.vo;

public class RecipesBookmarkVO {

	// 북마크 식별 정보
	private Long recipes_no;
	private String id;

	// 리스트 출력을 위한 보 (Recipes 테이블과 조인)
	private String recipes_title;
	private String name;
	private String recipes_writeDate;

	// 기본 생성자
	public RecipesBookmarkVO() {}

	// Getter & Setter
	public Long getRecipes_no() {
		return recipes_no;
	}

	public void setRecipes_no(Long recipes_no) {
		this.recipes_no = recipes_no;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getRecipes_title() {
		return recipes_title;
	}

	public void setRecipes_title(String recipes_title) {
		this.recipes_title = recipes_title;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getRecipes_writeDate() {
		return recipes_writeDate;
	}

	public void setRecipes_writeDate(String recipes_writeDate) {
		this.recipes_writeDate = recipes_writeDate;
	}

	// 데이터 확인용 toString
	@Override
	public String toString() {
		return "RecipesBookmarkVO [recipes_no=" + recipes_no + ", id=" + id + ", recipes_title=" + recipes_title
				+ ", name=" + name + ", recipes_writeDate=" + recipes_writeDate + "]";
	}

}