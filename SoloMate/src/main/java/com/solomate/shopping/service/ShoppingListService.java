package com.solomate.shopping.service;

import java.util.List;

import com.solomate.main.dao.DAO;
import com.solomate.main.service.Service;
import com.solomate.shopping.dao.ShoppingDAO;
import com.solomate.shopping.vo.ShoppingVO;

public class ShoppingListService implements Service {

	private ShoppingDAO dao = null;

	@Override
	public void setDAO(DAO dao) {
		this.dao = (ShoppingDAO) dao;
		System.out.println("🔥 ShoppingListService.setDAO() - dao 주입됨 : " + this.dao);
	}

	@Override
	public List<ShoppingVO> service(Object obj) throws Exception {

		ShoppingVO searchVO = (ShoppingVO) obj;

		searchVO.getPageObject().setTotalRow(dao.getTotalRow(searchVO));

		return dao.list(searchVO);
	}
}