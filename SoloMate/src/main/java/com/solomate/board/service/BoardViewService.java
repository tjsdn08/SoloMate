package com.solomate.board.service;

import com.solomate.board.dao.BoardDAO;
import com.solomate.main.dao.DAO;
import com.solomate.main.service.Service;

public class BoardViewService implements Service {

	private BoardDAO dao=null;
	
	public void setDAO(DAO dao) {
		this.dao=(BoardDAO)dao;
	}

	@Override
	public Object service(Object obj) throws Exception {
		Long[] arrs = (Long[]) obj;
		Long no=arrs[0];
		Long inc=arrs[1];
		if(inc == 1) {
			Integer result = dao.increase(no);
			if(result != 1) throw new Exception("글보기 조회수 1 증가 오류: 글 번호가 존재하지 않습니다");
		}
		return dao.view(no);
	}

}
