package com.solomate.main.dao;

import java.util.ArrayList;
import java.util.List;

import com.solomate.boardbookmark.vo.BoardBookmarkVO;
import com.solomate.food.dao.FoodDAO;
import com.solomate.food.vo.FoodVO;
import com.solomate.recipes.vo.RecipesVO;
import com.solomate.util.db.DB;

public class MainDAO extends DAO {

	// 기존의 getRecentRecipeBookmark 메서드를 아래와 같이 수정/대체하세요.
	// 이제 반환 타입이 RecipesBookmarkVO가 아니라 RecipesVO입니다.

	public RecipesVO getRecentRecipeDetail(String id) throws Exception {
	    RecipesVO vo = null;
	    con = DB.getConnection();

	    // recipes_bookmark(rb)와 recipes(r)을 조인하여 레시피 상세 정보와 이미지를 가져옵니다.
	    String sql = " SELECT recipes_no, recipes_title, recipes_img, description "
	    		+ " FROM (SELECT r.recipes_no, r.recipes_title, r.recipes_img, r.description "
	    		+ " FROM recipes_bookmark rb JOIN recipes r ON rb.recipes_no = r.recipes_no "
	    		+ " WHERE rb.id = ? ORDER BY rb.recipes_no DESC) WHERE ROWNUM = 1 ";

	    pstmt = con.prepareStatement(sql);
	    pstmt.setString(1, id);
	    rs = pstmt.executeQuery();

	    if (rs != null && rs.next()) {
	        vo = new RecipesVO();
	        vo.setRecipes_no(rs.getLong("recipes_no"));
	        vo.setRecipes_title(rs.getString("recipes_title"));
	        vo.setRecipes_img(rs.getString("recipes_img"));
	        vo.setName(rs.getString("description"));
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

//    // 4. 구매 예정(PLANNED) 장보기 항목 최신 5건
//    // shopping_plan.user_id 는 member.no(Long) 기반이므로 member 테이블과 조인
//    public List<ShoppingVO> getPlannedShoppingList(String memberId) throws Exception {
//        List<ShoppingVO> list = new ArrayList<>();
//        con = DB.getConnection();
//
//        String sql = " SELECT shopping_id, item_name, quantity "
//                + " FROM ( "
//                + "   SELECT sp.shopping_id, sp.item_name, sp.quantity "
//                + "   FROM shopping_plan sp "
//                + "   WHERE sp.user_id = ? "
//                + "     AND sp.status = 'PLANNED' "
//                + "     AND sp.is_deleted = 'N' "
//                + "   ORDER BY sp.shopping_id DESC "
//                + " ) WHERE ROWNUM <= 5 ";
//
//        pstmt = con.prepareStatement(sql);
//        pstmt.setString(1, memberId);
//        rs = pstmt.executeQuery();
//
//        if (rs != null) {
//            while (rs.next()) {
//                ShoppingVO vo = new ShoppingVO();
//                vo.setShoppingId(rs.getLong("shopping_id"));
//                vo.setItemName(rs.getString("item_name"));
//                vo.setQuantity(rs.getInt("quantity"));
//                list.add(vo);
//            }
//        }
//
//        DB.close(con, pstmt, rs);
//        return list;
//    }
}