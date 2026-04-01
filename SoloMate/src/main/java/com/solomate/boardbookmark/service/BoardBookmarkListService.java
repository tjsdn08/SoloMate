package com.solomate.boardbookmark.service;


import com.solomate.boardbookmark.dao.BoardBookmarkDAO;
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
	    Object[] objs = (Object[]) obj;
	    PageObject pageObject = (PageObject) objs[0];
	    String id = (String) objs[1];

	    // 1. 전체 데이터 개수를 가져와서 pageObject에 넣는다. (이게 빠지면 번호가 마이너스 됨)
	    pageObject.setTotalRow(dao.getTotalRow(pageObject, id));

	    // 2. 리스트 데이터 가져오기
	    return dao.list(pageObject, id);
	}

}
