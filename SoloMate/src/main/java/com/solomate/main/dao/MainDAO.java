package com.solomate.main.dao;

import java.util.ArrayList;
import java.util.List;

import com.solomate.account.vo.AccountVO;
import com.solomate.boardbookmark.vo.BoardBookmarkVO;
import com.solomate.food.dao.FoodDAO;
import com.solomate.food.vo.FoodVO;
import com.solomate.hotdeal.vo.HotDealVO;
import com.solomate.recipes.vo.RecipesVO;
import com.solomate.util.db.DB;

public class MainDAO extends DAO {


	public RecipesVO getRecentRecipeDetail(String id) throws Exception {
	    RecipesVO vo = null;
	    con = DB.getConnection();

	    // recipes_bookmark(rb)와 recipes(r)을 조인하여 레시피 상세 정보와 이미지를 가져옴
	    // rb.ROWID DESC 를 사용하여 가장 마지막에 Insert 된 행을 가져옴
	    String sql = " SELECT recipes_no, recipes_title, recipes_img, description "
	            + " FROM (SELECT r.recipes_no, r.recipes_title, r.recipes_img, r.description "
	            + " FROM recipes_bookmark rb JOIN recipes r ON rb.recipes_no = r.recipes_no "
	            + " WHERE rb.id = ? ORDER BY rb.ROWID DESC) WHERE ROWNUM = 1 "; 

	    pstmt = con.prepareStatement(sql);
	    pstmt.setString(1, id);
	    rs = pstmt.executeQuery();

	    if (rs != null && rs.next()) {
	        vo = new RecipesVO();
	        vo.setRecipes_no(rs.getLong("recipes_no"));
	        vo.setRecipes_title(rs.getString("recipes_title"));
	        vo.setRecipes_img(rs.getString("recipes_img"));
	        vo.setDescription(rs.getString("description")); 
	    }

	    DB.close(con, pstmt, rs);
	    return vo;
	}


    public BoardBookmarkVO getRecentBoardBookmark(String id) throws Exception {
        BoardBookmarkVO vo = null;
        con = DB.getConnection();

        String sql = " SELECT bookmarkNo, boardNo, title, writer "
                   + " FROM ( "
                   + "   SELECT m.bookmarkNo, m.boardNo, b.title, b.writer "
                   + "   FROM board_bookmark m, board b "
                   + "   WHERE m.boardNo = b.no "
                   + "     AND m.id = ? "
                   + "   ORDER BY m.bookmarkNo DESC "
                   + " ) WHERE ROWNUM = 1 ";

        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, id);
        rs = pstmt.executeQuery();

        if (rs != null && rs.next()) {
            vo = new BoardBookmarkVO();
            vo.setBookmarkNo(rs.getLong("bookmarkNo"));
            vo.setBoardNo(rs.getLong("boardNo"));
            vo.setTitle(rs.getString("title"));
            vo.setWriter(rs.getString("writer"));
        }

        DB.close(con, pstmt, rs);
        return vo;
    }

    public List<FoodVO> getExpiringFoods(String memberId) throws Exception {
        List<FoodVO> list = new ArrayList<>();
        con = DB.getConnection();

        String sql = " SELECT no, name, TO_CHAR(expiryDate, 'yyyy-mm-dd') expiryDate "
                   + " FROM ( "
                   + "   SELECT no, name, expiryDate "
                   + "   FROM food "
                   + "   WHERE memberId = ? "
                   + "     AND expiryDate >= TRUNC(SYSDATE) "
                   + "     AND expiryDate - TRUNC(SYSDATE) <= 7 "
                   + "   ORDER BY no DESC "
                   + " ) WHERE ROWNUM <= 5 ";

        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, memberId);
        rs = pstmt.executeQuery();

        if (rs != null) {
            while (rs.next()) {
                FoodVO vo = new FoodVO();
                vo.setNo(rs.getLong("no"));
                vo.setName(rs.getString("name"));
                vo.setExpiryDate(rs.getString("expiryDate"));
                vo.setdDay(FoodDAO.getDday(rs.getString("expiryDate"))); // 기존 static 메서드 재사용
                list.add(vo);
            }
        }

        DB.close(con, pstmt, rs);
        return list;
    }

    
    
 //  이번 달 지출 총액 가져오기
    public long getTotalExpenseThisMonth(String id) throws Exception {
        long totalExpense = 0;
        con = DB.getConnection();

        // account(a)와 account_category(ac)를 조인하여 'expense'(지출)만 필터링
        // regDate를 기준으로 이번 달 데이터만 합산(SUM)합니다.
        String sql = " SELECT NVL(SUM(a.amount), 0) "
                   + " FROM account a, account_category ac "
                   + " WHERE a.id = ? "
                   + "   AND a.cno = ac.cno "
                   + "   AND ac.type = 'expense' "
                   + "   AND TO_CHAR(a.regDate, 'YYYY-MM') = TO_CHAR(SYSDATE, 'YYYY-MM') ";

        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, id);
        rs = pstmt.executeQuery();

        if (rs != null && rs.next()) {
            // SUM의 결과값이므로 첫 번째 컬럼(1)을 가져옵니다. 
            // 금액이 클 수 있어서 long 타입
            totalExpense = rs.getLong(1); 
        }

        DB.close(con, pstmt, rs);
        return totalExpense;
    }
    
    //  메인 페이지용 상위 추천 핫딜 3개 가져오기 (할인율 높은 순)
    // 핫딜은 로그인 여부와 상관없이 보여주므로 파라미터(id)가 필요 없습니다.
    public List<HotDealVO> getTopHotDeals() throws Exception {
        List<HotDealVO> list = new ArrayList<>();
        con = DB.getConnection();

        // 할인율(discount_rate) 기준 내림차순 정렬 후 상위 3개(ROWNUM <= 3)만 추출
        String sql = " SELECT deal_id, title, price, discount_rate "
                   + " FROM ( "
                   + "    SELECT hd.deal_id, hd.title, hd.price, hd.discount_rate "
                   + "    FROM hot_deal hd "
                   + "    JOIN hot_deal_category c ON hd.category_id = c.category_id "
                   + "    WHERE hd.is_deleted = 'N' "
                   + "      AND c.is_deleted = 'N' "
                   + "      AND c.status = 'ACTIVE' "
                   + "      AND hd.status = 'ACTIVE' "
                   + "    ORDER BY hd.discount_rate DESC "
                   + " ) WHERE ROWNUM <= 3 ";

        pstmt = con.prepareStatement(sql);
        rs = pstmt.executeQuery();

        if (rs != null) {
            while (rs.next()) {
                HotDealVO vo = new HotDealVO();
                vo.setDealId(rs.getLong("deal_id"));
                // HotDealVO에 정의된 필드명에 맞게 세팅합니다.
                // (JSP에서 deal.hotdealNo 대신 deal.dealId를 사용하셔야 합니다!)
                vo.setTitle(rs.getString("title"));
                vo.setPrice(rs.getLong("price"));
                vo.setDiscountRate(rs.getDouble("discount_rate"));
                list.add(vo);
            }
        }

        DB.close(con, pstmt, rs);
        return list;
    }
    
    
 //  냉장고 파먹기: 유통기한 임박(D-0 ~ D-3) 식재료 상위 3개 이름 가져오기
    public List<String> getUrgentIngredientList(String memberId) throws Exception {
        List<String> ingredientList = new ArrayList<>();
        con = DB.getConnection();

        // 유통기한이 짧은 순으로 정렬하여 최대 3개까지만 추출
        String sql = " SELECT name FROM ( "
                   + "    SELECT name FROM food "
                   + "    WHERE memberId = ? "
                   + "      AND expiryDate >= TRUNC(SYSDATE) "
                   + "      AND expiryDate - TRUNC(SYSDATE) <= 3 "
                   + "    ORDER BY expiryDate ASC "
                   + " ) WHERE ROWNUM <= 3 ";

        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, memberId);
        rs = pstmt.executeQuery();

        while (rs != null && rs.next()) {
            ingredientList.add(rs.getString("name"));
        }

        DB.close(con, pstmt, rs);
        return ingredientList;
    }

    //  냉장고 파먹기: 식재료 리스트를 이용해 레시피 통합 검색 (제목, 설명, 재료 포함 여부)
    public List<RecipesVO> getFridgeRecipes(List<String> ingredients) throws Exception {
        List<RecipesVO> list = new ArrayList<>();
        // 식재료가 없으면 빈 리스트 반환
        if (ingredients == null || ingredients.isEmpty()) return list; 

        con = DB.getConnection();

        // StringBuilder를 이용해 식재료 개수만큼 동적으로 SQL(OR 조건)을 생성합니다.
        StringBuilder sql = new StringBuilder();
        sql.append(" SELECT recipes_no, recipes_title, recipes_img, description ");
        sql.append(" FROM ( ");
        sql.append("    SELECT recipes_no, recipes_title, recipes_img, description ");
        sql.append("    FROM recipes ");
        sql.append("    WHERE ");

        // 식재료 1개당 제목, 설명, 재료 3곳을 검사하는 쿼리를 덧붙임
        for (int i = 0; i < ingredients.size(); i++) {
            if (i > 0) sql.append(" OR ");
            sql.append(" (recipes_title LIKE ? OR description LIKE ? OR food LIKE ?) ");
        }

        sql.append("    ORDER BY DBMS_RANDOM.VALUE "); // 겹치지 않게 매번 랜덤 정렬
        sql.append(" ) WHERE ROWNUM <= 3 "); // 최종 추천 레시피도 3개만 추출

        pstmt = con.prepareStatement(sql.toString());

        // 동적 쿼리에 맞춰 데이터(?) 세팅
        int idx = 1;
        for (String ingredient : ingredients) {
            String query = "%" + ingredient + "%"; // 포함 검색을 위한 와일드카드
            pstmt.setString(idx++, query); // recipes_title 검사용
            pstmt.setString(idx++, query); // description 검사용
            pstmt.setString(idx++, query); // food 검사용
        }

        rs = pstmt.executeQuery();

        while (rs.next()) {
            RecipesVO vo = new RecipesVO();
            vo.setRecipes_no(rs.getLong("recipes_no"));
            vo.setRecipes_title(rs.getString("recipes_title"));
            vo.setRecipes_img(rs.getString("recipes_img"));
            vo.setDescription(rs.getString("description")); // RecipesDAO의 컬럼명과 맞춤
            list.add(vo);
        }

        DB.close(con, pstmt, rs);
        return list;
    }
    
    

    // MainDAO 클래스 내부에 추가
    public List<AccountVO> getMonthlyChartData(String id) throws Exception {
        List<AccountVO> list = new ArrayList<>();
        con = DB.getConnection();

        // 이번 달(SYSDATE 기준)의 카테고리별 수입/지출 합계를 구하는 쿼리
        String sql = " SELECT ac.cname as category, ac.type, SUM(a.amount) as total "
                   + " FROM account a, account_category ac "
                   + " WHERE a.id = ? AND a.cno = ac.cno "
                   + "   AND TO_CHAR(a.regDate, 'YYYY-MM') = TO_CHAR(SYSDATE, 'YYYY-MM') "
                   + " GROUP BY ac.cname, ac.type "
                   + " ORDER BY total DESC ";

        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, id);
        rs = pstmt.executeQuery();

        while (rs != null && rs.next()) {
            AccountVO vo = new AccountVO();
            vo.setCategory(rs.getString("category"));
            vo.setType(rs.getString("type"));
            vo.setAmount(rs.getLong("total"));
            list.add(vo);
        }

        DB.close(con, pstmt, rs);
        return list;
    }
    
    
    
}