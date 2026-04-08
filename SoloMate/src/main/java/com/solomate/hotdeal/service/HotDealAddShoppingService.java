package com.solomate.hotdeal.service;

import com.solomate.main.dao.DAO;
import com.solomate.main.service.Service;
import com.solomate.shopping.dao.ShoppingDAO;
import com.solomate.shopping.vo.ShoppingVO;

public class HotDealAddShoppingService implements Service {

	private ShoppingDAO dao = null;

	@Override
	public void setDAO(DAO dao) {
		this.dao = (ShoppingDAO) dao;
	}

	@Override
	public Integer service(Object obj) throws Exception {
		ShoppingVO vo = (ShoppingVO) obj;
		return dao.addFromHotDeal(vo);
	}
}