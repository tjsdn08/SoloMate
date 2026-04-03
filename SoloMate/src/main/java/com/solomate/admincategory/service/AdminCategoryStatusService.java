package com.solomate.admincategory.service;

import com.solomate.admincategory.dao.HotDealCategoryDAO;
import com.solomate.admincategory.vo.HotDealCategoryVO;
import com.solomate.main.dao.DAO;
import com.solomate.main.service.Service;

public class AdminCategoryStatusService implements Service {

	private HotDealCategoryDAO dao;

	@Override
	public void setDAO(DAO dao) {
		this.dao = (HotDealCategoryDAO) dao;
	}

	@Override
	public Object service(Object obj) throws Exception {
		return dao.status((HotDealCategoryVO) obj);
	}
}