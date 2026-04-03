package com.solomate.main.service;

import com.solomate.main.dao.DAO;
import com.solomate.main.dao.MainDAO;

public class MainSummaryService implements Service {

    private MainDAO dao;

    @Override
    public void setDAO(DAO dao) {
        this.dao = (MainDAO) dao;
    }

    // obj : 로그인한 회원 id (String)
    @Override
    public Object service(Object obj) throws Exception {
        String id = (String) obj;

        // 4가지 데이터를 Object[] 배열로 묶어서 반환
        Object[] result = new Object[4];
        result[0] = dao.getRecentRecipeDetail(id);
        result[1] = dao.getRecentBoardBookmark(id);// BoardBookmarkVO
        result[2] = dao.getExpiringFoods(id);// List<FoodVO>
//        result[3] = dao.getPlannedShoppingList(id);// List<ShoppingVO>

        return result;
    }
}