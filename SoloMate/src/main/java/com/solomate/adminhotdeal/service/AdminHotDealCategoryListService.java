package com.solomate.adminhotdeal.service;

import com.solomate.admincategory.dao.HotDealCategoryDAO;
import com.solomate.main.dao.DAO;
import com.solomate.main.service.Service;

public class AdminHotDealCategoryListService implements Service {

	private HotDealCategoryDAO dao;

	@Override
	public void setDAO(DAO dao) {
		this.dao = (HotDealCategoryDAO) dao;
	}

	@Override
	public Object service(Object obj) throws Exception {
		return dao.list();   // 관리자니까 전체 카테고리
	}
}