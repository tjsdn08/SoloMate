package com.solomate.food.service;

import com.solomate.food.dao.FoodDAO;
import com.solomate.food.vo.FoodVO;
import com.solomate.main.dao.DAO;
import com.solomate.main.service.Service;

public class FoodViewService implements Service{
	
	private FoodDAO dao = null;

	@Override
	public void setDAO(DAO dao) {
		// TODO Auto-generated method stub
		this.dao = (FoodDAO) dao;
	}

	@Override
	public FoodVO service(Object obj) throws Exception {
		// TODO Auto-generated method stub
	    if (obj == null) {
	        throw new Exception("식품 번호가 없습니다.");
	    }
		
		Long no = (Long) obj;
		
		return dao.view(no);
	}

}
