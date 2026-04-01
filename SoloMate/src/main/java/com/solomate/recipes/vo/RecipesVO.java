package com.solomate.recipes.vo;

public class RecipesVO {

	    private Long recipes_no;
	    private String recipes_title;
	    private String id;
	    private String name;
	    private String food;
	    private String description;
	    private Integer recipes_time;
	    private String recipes_level;
	    private String recipes_img;
	    private String recipes_content;
	    private String recipes_writeDate;
	    private String recipes_updateDate;
	    private Long recipes_bookmark;
	    private int bookmarked;
		public Long getRecipes_no() {
			return recipes_no;
		}
		public void setRecipes_no(Long recipes_no) {
			this.recipes_no = recipes_no;
		}
		public String getRecipes_title() {
			return recipes_title;
		}
		public void setRecipes_title(String recipes_title) {
			this.recipes_title = recipes_title;
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
		public String getFood() {
			return food;
		}
		public void setFood(String food) {
			this.food = food;
		}
		public String getDescription() {
			return description;
		}
		public void setDescription(String description) {
			this.description = description;
		}
		public Integer getRecipes_time() {
			return recipes_time;
		}
		public void setRecipes_time(Integer recipes_time) {
			this.recipes_time = recipes_time;
		}
		public String getRecipes_level() {
			return recipes_level;
		}
		public void setRecipes_level(String recipes_level) {
			this.recipes_level = recipes_level;
		}
		public String getRecipes_img() {
			return recipes_img;
		}
		public void setRecipes_img(String recipes_img) {
			this.recipes_img = recipes_img;
		}
		public String getRecipes_content() {
			return recipes_content;
		}
		public void setRecipes_content(String recipes_content) {
			this.recipes_content = recipes_content;
		}
		public String getRecipes_writeDate() {
			return recipes_writeDate;
		}
		public void setRecipes_writeDate(String recipes_writeDate) {
			this.recipes_writeDate = recipes_writeDate;
		}
		public String getRecipes_updateDate() {
			return recipes_updateDate;
		}
		public void setRecipes_updateDate(String recipes_updateDate) {
			this.recipes_updateDate = recipes_updateDate;
		}
		public Long getRecipes_bookmark() {
			return recipes_bookmark;
		}
		public void setRecipes_bookmark(Long recipes_bookmark) {
			this.recipes_bookmark = recipes_bookmark;
		}
		public int getBookmarked() {
			return bookmarked;
		}
		public void setBookmarked(int bookmarked) {
			this.bookmarked = bookmarked;
		}
		@Override
		public String toString() {
			return "RecipesVO [recipes_no=" + recipes_no + ", recipes_title=" + recipes_title + ", id=" + id + ", name="
					+ name + ", food=" + food + ", description=" + description + ", recipes_time=" + recipes_time
					+ ", recipes_level=" + recipes_level + ", recipes_img=" + recipes_img + ", recipes_content="
					+ recipes_content + ", recipes_writeDate=" + recipes_writeDate + ", recipes_updateDate="
					+ recipes_updateDate + ", recipes_bookmark=" + recipes_bookmark + ", bookmarked=" + bookmarked
					+ "]";
		}
	    
	    

	
}
