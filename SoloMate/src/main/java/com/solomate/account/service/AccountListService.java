package com.solomate.account.service;

import com.solomate.board.dao.BoardDAO;
import com.solomate.main.dao.DAO;
import com.solomate.main.service.Service;
import com.solomate.util.page.PageObject;

public class AccountListService implements Service{

	private BoardDAO dao=null;
	
	public void setDAO(DAO dao) {
		this.dao=(BoardDAO) dao;
	}

	@Override
	public Object service(Object obj) throws Exception {
		PageObject pageObject=(PageObject) obj;
		pageObject.setTotalRow(dao.getTotalRow(pageObject));
		return dao.list(pageObject);
	}

}
