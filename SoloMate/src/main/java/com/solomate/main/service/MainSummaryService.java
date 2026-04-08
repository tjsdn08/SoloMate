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

        // 8개의 데이터를 담을 배열로 확장 (기존 7개 + 차트 데이터 1개)
        Object[] result = new Object[8];
        
        result[0] = dao.getRecentRecipeDetail(id);
        result[1] = dao.getRecentBoardBookmark(id);
        result[2] = dao.getExpiringFoods(id);
        // result[3] = dao.getPlannedShoppingList(id); 
        result[4] = dao.getTotalExpenseThisMonth(id);
        result[7] = dao.getMonthlyChartData(id);

        List<String> urgentIngredients = dao.getUrgentIngredientList(id);
        if (urgentIngredients != null && !urgentIngredients.isEmpty()) {
            result[5] = String.join(", ", urgentIngredients);
            result[6] = dao.getFridgeRecipes(urgentIngredients);
        }

        return result;
    }
}