package com.solomate.shopping.service;

import com.solomate.main.dao.DAO;
import com.solomate.main.service.Service;
import com.solomate.shopping.dao.ShoppingDAO;

public class ShoppingDeleteService implements Service {

	private ShoppingDAO dao;

	@Override
	public void setDAO(DAO dao) {
		this.dao = (ShoppingDAO) dao;
	}

	@Override
	public Integer service(Object obj) throws Exception {
		Long shoppingId = (Long) obj;
		return dao.delete(shoppingId);
	}
}