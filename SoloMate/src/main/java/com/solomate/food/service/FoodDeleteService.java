package com.solomate.food.service;

import com.solomate.food.dao.FoodDAO;
import com.solomate.main.dao.DAO;
import com.solomate.main.service.Service;

public class FoodDeleteService implements Service{
	
	private FoodDAO dao;

	@Override
	public void setDAO(DAO dao) {
		// TODO Auto-generated method stub
		this.dao = (FoodDAO) dao;
		
	}

	@Override
	public Object service(Object obj) throws Exception {
		// TODO Auto-generated method stub
		Long no = (Long) obj;
		return dao.delete(no);
	}

}
