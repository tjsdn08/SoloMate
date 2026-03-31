package com.solomate.boardbookmark.service;

import java.util.List;

import com.solomate.boardbookmark.dao.BoardBookmarkDAO;
import com.solomate.boardbookmark.vo.BoardBookmarkVO;
import com.solomate.main.dao.DAO;
import com.solomate.main.service.Service;
import com.solomate.util.page.PageObject;

public class BoardBookmarkListService implements Service{

	private BoardBookmarkDAO dao;
	
	@Override
	public void setDAO(DAO dao) {
		// TODO Auto-generated method stub
		this.dao=(BoardBookmarkDAO) dao;
	}

	@Override
	public Object service(Object obj) throws Exception {
		// TODO Auto-generated method stub
		Object[] objs = (Object[]) obj;
		PageObject pageObject = (PageObject) objs[0];
		String id = (String) objs[1];
		List<BoardBookmarkVO> list = dao.list(pageObject, id);
		return list;
	}

}
