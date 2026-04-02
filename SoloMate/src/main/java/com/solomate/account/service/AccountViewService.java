package com.solomate.account.service;

import com.solomate.account.dao.AccountDAO;
import com.solomate.main.dao.DAO;
import com.solomate.main.service.Service;

public class AccountViewService implements Service{

	private AccountDAO dao;
	
	@Override
	public void setDAO(DAO dao) {
		this.dao=(AccountDAO) dao;
		
	}

	@Override
	public Object service(Object obj) throws Exception {
		Long no=(Long) obj;
		return dao.view(no);
	}


}
