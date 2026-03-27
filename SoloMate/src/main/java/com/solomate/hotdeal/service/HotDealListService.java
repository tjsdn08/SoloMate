package com.solomate.hotdeal.service;

import java.util.List;

import com.solomate.hotdeal.dao.HotDealDAO;
import com.solomate.hotdeal.vo.HotDealVO;
import com.solomate.main.dao.DAO;
import com.solomate.main.service.Service;

public class HotDealListService implements Service {

	private HotDealDAO dao = null;

	@Override
	public void setDAO(DAO dao) {
		this.dao = (HotDealDAO) dao;
	}

	@Override
	public List<HotDealVO> service(Object obj) throws Exception {

		HotDealVO searchVO = (HotDealVO) obj;

		searchVO.getPageObject().setTotalRow(dao.getTotalRow(searchVO));

		return dao.list(searchVO);
	}
}