package com.solomate.folder.service;

import java.util.List;

import com.solomate.folder.dao.FolderDAO;
import com.solomate.folder.vo.FolderVO;
import com.solomate.main.dao.DAO;
import com.solomate.main.service.Service;
import com.solomate.util.page.PageObject;

public class FolderListService implements Service{
	
	private FolderDAO dao;

	@Override
	public void setDAO(DAO dao) {
		// TODO Auto-generated method stub
		this.dao = (FolderDAO) dao;
		
	}

	@Override
	public List<FolderVO> service(Object obj) throws Exception {
		// TODO Auto-generated method stub
		PageObject pageObject= (PageObject) obj;
		pageObject.setTotalRow(dao.getTotalRow(pageObject));
		return dao.list(pageObject);
	}

}
