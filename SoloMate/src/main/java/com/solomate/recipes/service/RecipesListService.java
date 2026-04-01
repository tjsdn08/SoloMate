package com.solomate.recipes.service;

import com.solomate.main.dao.DAO;
import com.solomate.main.service.Service;
import com.solomate.recipes.dao.RecipesDAO;
import com.solomate.util.page.PageObject;

public class RecipesListService implements Service{

	private RecipesDAO dao=null;
	
	public void setDAO(DAO dao) {
		this.dao=(RecipesDAO) dao;
	}

	@Override
	public Object service(Object obj) throws Exception {
		PageObject pageObject=(PageObject) obj;
		pageObject.setTotalRow(dao.getTotalRow(pageObject));
		return dao.list(pageObject);
	}

}
