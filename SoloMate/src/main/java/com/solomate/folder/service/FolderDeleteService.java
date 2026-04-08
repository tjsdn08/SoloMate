package com.solomate.folder.service;

import com.solomate.folder.dao.FolderDAO;
import com.solomate.main.dao.DAO;
import com.solomate.main.service.Service;

public class FolderDeleteService implements Service{
	
	private FolderDAO dao;

	@Override
	public void setDAO(DAO dao) {
		// TODO Auto-generated method stub
		this.dao = (FolderDAO) dao;
		
	}

	@Override
	public Object service(Object obj) throws Exception {
		// TODO Auto-generated method stub
		return dao.delete((Long) obj);
	}

}
