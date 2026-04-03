package com.solomate.recipesbookmark.service;

import java.util.List;
import com.solomate.main.dao.DAO;
import com.solomate.main.service.Service;
import com.solomate.recipesbookmark.dao.RecipesBookmarkDAO;
import com.solomate.recipesbookmark.vo.RecipesBookmarkVO;
import com.solomate.util.page.PageObject;

public class RecipesBookmarkListService implements Service {

	private RecipesBookmarkDAO dao;

	// DAO 주입
	@Override
	public void setDAO(DAO dao) {
		this.dao = (RecipesBookmarkDAO) dao;
	}

	@Override
	public List<RecipesBookmarkVO> service(Object obj) throws Exception {
		// 컨트롤러에서 전달한 Object[] {pageObject, id}를 형변환
		Object[] objs = (Object[]) obj;
		PageObject pageObject = (PageObject) objs[0];
		String id = (String) objs[1];
		
		// 1. 전체 데이터 개수 구하기 (페이징 처리를 위해 필수)
		// DAO의 getTotalRow 메서드에 id를 같이 넘겨 본인의 북마크 개수만 가져옵니다.
		pageObject.setTotalRow(dao.getTotalRow(pageObject, id));
		
		// 2. 실제 북마크 리스트 가져오기
		return dao.list(pageObject, id);
	}
}