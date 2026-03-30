package com.solomate.adminhotdeal.service;

import com.solomate.hotdeal.dao.HotDealDAO;
import com.solomate.main.dao.DAO;
import com.solomate.main.service.Service;

public class AdminHotDealDeleteService implements Service {

	private HotDealDAO dao = null;

	@Override
	public void setDAO(DAO dao) {
		this.dao = (HotDealDAO) dao;
	}

	@Override
	public Integer service(Object obj) throws Exception {
		Long dealId = (Long) obj;
		return dao.delete(dealId);
	}
}