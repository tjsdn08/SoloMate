package com.solomate.account.service;

import com.solomate.account.dao.AccountDAO;
import com.solomate.main.dao.DAO;
import com.solomate.main.service.Service;

public class AccountDeleteService implements Service{

	private AccountDAO dao;
	
	@Override
	public void setDAO(DAO dao) {
		// TODO Auto-generated method stub
		this.dao=(AccountDAO) dao;
	}

	@Override
	public Object service(Object obj) throws Exception {
		// TODO Auto-generated method stub
		return dao.delete((Long)obj);
	}

}
