package com.solomate.hotdeal.service;

import com.solomate.hotdeal.dao.HotDealDAO;
import com.solomate.hotdeal.vo.HotDealVO;
import com.solomate.main.dao.DAO;
import com.solomate.main.service.Service;

public class HotDealViewService implements Service {

	private HotDealDAO dao = null;

	@Override
	public void setDAO(DAO dao) {
		this.dao = (HotDealDAO) dao;
	}

	@Override
	public HotDealVO service(Object obj) throws Exception {
		HotDealVO vo = (HotDealVO) obj;
		dao.increase(vo.getDealId());
		return dao.view(vo);
	}
}