package com.solomate.boardreply.service;

import com.solomate.boardreply.dao.BoardReplyDAO;
import com.solomate.boardreply.vo.BoardReplyVO;
import com.solomate.main.dao.DAO;
import com.solomate.main.service.Service;

public class BoardReplyUpdateService implements Service{

	private BoardReplyDAO dao;
	
	@Override
	public void setDAO(DAO dao) {
		// TODO Auto-generated method stub
		this.dao=(BoardReplyDAO) dao;
	}

	@Override
	public Object service(Object obj) throws Exception {
		// TODO Auto-generated method stub
		return dao.update((BoardReplyVO) obj);
	}

}
