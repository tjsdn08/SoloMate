package com.solomate.food.service;

import com.solomate.food.dao.FoodDAO;
import com.solomate.food.vo.FoodVO;
import com.solomate.main.dao.DAO;
import com.solomate.main.service.Service;

public class FoodWriteService implements Service{

	private FoodDAO dao = null;
	
	@Override
	public void setDAO(DAO dao) {
		// TODO Auto-generated method stub
		this.dao = (FoodDAO) dao;
		
	}

	@Override
	public Object service(Object obj) throws Exception {
		// TODO Auto-generated method stub
		return dao.write((FoodVO) obj);
	}

}
