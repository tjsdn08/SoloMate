package com.solomate.food.service;

import java.util.List;

import com.solomate.food.dao.FoodDAO;
import com.solomate.food.vo.FoodVO;
import com.solomate.main.dao.DAO;
import com.solomate.main.service.Service;
import com.solomate.util.page.PageObject;

public class FoodListService implements Service{
	
	private FoodDAO dao = null;

	@Override
	public void setDAO(DAO dao) {
		// TODO Auto-generated method stub
		this.dao = (FoodDAO) dao;
	}

	@Override
	public List<FoodVO> service(Object obj) throws Exception {
		// TODO Auto-generated method stub
		PageObject pageObject= (PageObject) obj;
		pageObject.setTotalRow(dao.getTotalRow(pageObject));
		return dao.list(pageObject);
	}

}
