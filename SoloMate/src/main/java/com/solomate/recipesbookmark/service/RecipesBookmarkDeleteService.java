package com.solomate.recipesbookmark.service;

import com.solomate.main.dao.DAO;
import com.solomate.main.service.Service;
import com.solomate.recipesbookmark.dao.RecipesBookmarkDAO;
import com.solomate.recipesbookmark.vo.RecipesBookmarkVO;

public class RecipesBookmarkDeleteService implements Service {

	private RecipesBookmarkDAO dao;

	@Override
	public void setDAO(DAO dao) {
		this.dao = (RecipesBookmarkDAO) dao;
	}

	@Override
	public Integer service(Object obj) throws Exception {
		// RecipesBookmarkVO 객체를 전달받아 DAO 호출
		return dao.delete((RecipesBookmarkVO) obj);
	}
}