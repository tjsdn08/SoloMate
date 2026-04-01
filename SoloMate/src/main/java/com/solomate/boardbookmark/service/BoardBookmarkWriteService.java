package com.solomate.boardbookmark.service;

import com.solomate.boardbookmark.dao.BoardBookmarkDAO;
import com.solomate.boardbookmark.vo.BoardBookmarkVO;
import com.solomate.main.dao.DAO; // 이 인터페이스 타입이 중요합니다.
import com.solomate.main.service.Service;

public class BoardBookmarkWriteService implements Service {

    private BoardBookmarkDAO dao;

    @Override
    public void setDAO(DAO dao) {
        // [체크] 이 코드가 누락되면 필드인 this.dao는 계속 null입니다.
        this.dao = (BoardBookmarkDAO) dao; 
    }

    @Override
    public Object service(Object obj) throws Exception {
    	Object[] objs = (Object[]) obj; 
        BoardBookmarkVO vo = (BoardBookmarkVO) objs[0];
        
        // 1. 존재 여부 확인 (있으면 1 이상, 없으면 0)
        int check = dao.check(vo);
        System.out.println("중복 체크 결과 (0이면 추가, 1이면 삭제): " + check);
        
        if (check == 0) {
            // 데이터가 없으므로 '추가' 실행
            System.out.println("--- 북마크 추가 실행 ---");
            return dao.write(vo); 
        } else {
            // 데이터가 이미 있으므로 '삭제' 실행
            System.out.println("--- 북마크 삭제 실행 ---");
            return dao.delete(vo); 
        }
    }
}
