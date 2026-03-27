package com.solomate.shopping.service;

import com.solomate.main.dao.DAO;
import com.solomate.main.service.Service;
import com.solomate.shopping.dao.ShoppingDAO;
import com.solomate.shopping.vo.ShoppingVO;

public class ShoppingViewService implements Service {

	private ShoppingDAO dao = null;

	@Override
	public void setDAO(DAO dao) {
		this.dao = (ShoppingDAO) dao;
		System.out.println("🔥 ShoppingViewService.setDAO() - dao 주입됨 : " + this.dao);
	}

	@Override
	public ShoppingVO service(Object obj) throws Exception {
		Long shoppingId = (Long) obj;
		return dao.view(shoppingId);
	}
}