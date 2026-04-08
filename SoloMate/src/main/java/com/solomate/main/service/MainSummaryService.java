package com.solomate.main.service;

import java.util.List;
import com.solomate.main.dao.DAO;
import com.solomate.main.dao.MainDAO;

public class MainSummaryService implements Service {

    private MainDAO dao;

    @Override
    public void setDAO(DAO dao) {
        this.dao = (MainDAO) dao;
    }

    @Override
    public Object service(Object obj) throws Exception {
        String id = (String) obj;

        // 7개의 데이터를 담을 배열 생성
        Object[] result = new Object[7];
        
        // [0]~[4] 기존 데이터 세팅
        result[0] = dao.getRecentRecipeDetail(id);  // 최근 북마크 레시피
        result[1] = dao.getRecentBoardBookmark(id); // 최근 북마크 꿀팁
        result[2] = dao.getExpiringFoods(id);       // 유통기한 임박 식품 리스트 (D-7)
        // result[3] = dao.getPlannedShoppingList(id); // 장보기 목록 (필요 시 주석 해제)
        result[4] = dao.getTotalExpenseThisMonth(id); // 이번 달 지출 총액
        // 1. 임박 식재료(D-0 ~ D-3) 최대 3개 이름 가져오기
        List<String> urgentIngredients = dao.getUrgentIngredientList(id);
        
        if (urgentIngredients != null && !urgentIngredients.isEmpty()) {
            // [5] 인덱스: 식재료 이름을 "양파, 소고기" 형태의 문자열로 합쳐서 저장
            result[5] = String.join(", ", urgentIngredients);
            
            // [6] 인덱스: 해당 식재료들로 검색된 추천 레시피 리스트 저장
            result[6] = dao.getFridgeRecipes(urgentIngredients);
        }

        return result;
    }
}