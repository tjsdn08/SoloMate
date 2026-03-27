package com.solomate.board.service;

import com.solomate.board.dao.BoardDAO;
import com.solomate.board.vo.BoardVO;
import com.solomate.main.dao.DAO;
import com.solomate.main.service.Service;

public class BoardWriteService implements Service {

	private BoardDAO dao=null;
	
	public void setDAO(DAO dao) {
		this.dao=(BoardDAO)dao;
		
	}

	@Override
	public Object service(Object obj) throws Exception {
		return dao.write((BoardVO) obj);
	}

}
