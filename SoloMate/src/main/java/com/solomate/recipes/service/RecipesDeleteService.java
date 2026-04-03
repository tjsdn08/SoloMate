package com.solomate.recipes.service;

import com.solomate.main.dao.DAO;
import com.solomate.main.service.Service;
import com.solomate.recipes.dao.RecipesDAO;

public class RecipesDeleteService implements Service {

	private RecipesDAO dao;

	@Override
	public void setDAO(DAO dao) {
		this.dao = (RecipesDAO) dao;
	}

	@Override
	public Integer service(Object obj) throws Exception {
		return dao.delete((Long) obj);
	}
}