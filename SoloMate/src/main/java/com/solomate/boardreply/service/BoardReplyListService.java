package com.solomate.boardreply.service;

import com.solomate.boardreply.dao.BoardReplyDAO;
import com.solomate.main.dao.DAO;
import com.solomate.main.service.Service;
import com.solomate.util.page.PageObject;

public class BoardReplyListService implements Service {

	private BoardReplyDAO dao;
	
	@Override
	public void setDAO(DAO dao) {
		// TODO Auto-generated method stub
		this.dao=(BoardReplyDAO) dao;
	}

	@Override
	public Object service(Object obj) throws Exception {
		// TODO Auto-generated method stub
		PageObject pageObject=(PageObject) obj;
		pageObject.setTotalRow(dao.getTotalRow(pageObject));
		return dao.list(pageObject);
	}

	
	
}
