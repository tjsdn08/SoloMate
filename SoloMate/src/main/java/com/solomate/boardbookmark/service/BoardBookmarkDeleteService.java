package com.solomate.boardbookmark.service;

import com.solomate.boardbookmark.dao.BoardBookmarkDAO;
import com.solomate.boardbookmark.vo.BoardBookmarkVO;
import com.solomate.main.dao.DAO; // 이 인터페이스 타입이 중요합니다.
import com.solomate.main.service.Service;

public class BoardBookmarkDeleteService implements Service {

    private BoardBookmarkDAO dao;

    @Override
    public void setDAO(DAO dao) {
        // Init에서 넣어준 DAO를 필드에 저장해야 합니다.
        this.dao = (BoardBookmarkDAO) dao;
    }

    @Override
    public Object service(Object obj) throws Exception {
        // 여기서 dao를 사용하기 때문에 위 setDAO가 반드시 실행되어야 합니다.
        return dao.delete((BoardBookmarkVO) obj);
    }
}