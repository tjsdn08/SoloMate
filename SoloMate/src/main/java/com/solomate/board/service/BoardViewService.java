package com.solomate.board.service;

import com.solomate.board.dao.BoardDAO;
import com.solomate.board.vo.BoardVO;
import com.solomate.main.dao.DAO;
import com.solomate.main.service.Service;

public class BoardViewService implements Service {

	private BoardDAO dao=null;
	
	public void setDAO(DAO dao) {
		this.dao=(BoardDAO)dao;
	}

	@Override
	public Object service(Object obj) throws Exception {
	    Object[] arr = (Object[]) obj;

        Long no = (Long) arr[0];
        Long inc = (Long) arr[1];
        String id = (String) arr[2];

        // 조회수 증가
        if(inc == 1) {
            Integer result = dao.increase(no);
            if(result != 1) throw new Exception("조회수 증가 오류");
        }

        // 기존 글 데이터
        BoardVO vo = dao.view(no);

        // 🔥 bookmarked 따로 세팅
        if(id != null) {
            long bookmarked = dao.isBookmarked(no, id);
            vo.setBookmarked(bookmarked);
        }

        return vo;
    }

}
