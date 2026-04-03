package com.solomate.recipes.service;

import com.solomate.main.dao.DAO; // 부모 DAO 클래스 임포트 확인
import com.solomate.main.service.Service;
import com.solomate.recipes.dao.RecipesDAO;
import com.solomate.recipes.vo.RecipesVO;

public class RecipesWriteService implements Service {

	private RecipesDAO dao;

	@Override
	public void setDAO(DAO dao) {
		this.dao = (RecipesDAO) dao;
	}

	@Override
	public Integer service(Object obj) throws Exception {
		RecipesVO vo = (RecipesVO) obj;
		
		return dao.write(vo);
	}
}