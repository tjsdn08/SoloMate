package com.solomate.folder.service;

import com.solomate.folder.dao.FolderDAO;
import com.solomate.main.dao.DAO;
import com.solomate.main.service.Service;

public class FolderDeleteFoodService implements Service{
	
	private FolderDAO dao;

	@Override
	public void setDAO(DAO dao) {
		// TODO Auto-generated method stub
		this.dao = (FolderDAO) dao;
		
	}

	@Override
	public Object service(Object obj) throws Exception {
		// TODO Auto-generated method stub
		Long[] arr = (Long[]) obj;
		
		Long folderNo = arr[0];
		Long foodNo = arr[1];
		
		return dao.deleteFood(folderNo, foodNo);
	}

}
