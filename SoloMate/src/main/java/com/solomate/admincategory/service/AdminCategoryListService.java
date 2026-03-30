package com.solomate.admincategory.service;

import com.solomate.admincategory.dao.HotDealCategoryDAO;
import com.solomate.main.dao.DAO;
import com.solomate.main.service.Service;

public class AdminCategoryListService implements Service {

	private HotDealCategoryDAO dao;

	public void setDAO(DAO dao) {
		this.dao = (HotDealCategoryDAO) dao;
	}

	public Object service(Object obj) throws Exception {
		return dao.list();
	}
}
