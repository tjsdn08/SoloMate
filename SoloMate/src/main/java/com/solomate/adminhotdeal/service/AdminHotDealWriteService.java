package com.solomate.adminhotdeal.service;

import com.solomate.hotdeal.dao.HotDealDAO;
import com.solomate.hotdeal.vo.HotDealVO;
import com.solomate.main.dao.DAO;
import com.solomate.main.service.Service;

public class AdminHotDealWriteService implements Service {

	private HotDealDAO dao;

	public void setDAO(DAO dao) {
		this.dao = (HotDealDAO) dao;
	}

	public Object service(Object obj) throws Exception {
		return dao.write((HotDealVO) obj);
	}
}