package com.solomate.recipesbookmark.dao;

import java.util.ArrayList;
import java.util.List;

import com.solomate.main.dao.DAO;
import com.solomate.recipesbookmark.vo.RecipesBookmarkVO;
import com.solomate.util.db.DB;
import com.solomate.util.page.PageObject;

public class RecipesBookmarkDAO extends DAO {

	// 1. 북마크 리스트 조회 (로그인한 본인의 것만)
	public List<RecipesBookmarkVO> list(PageObject pageObject, String id) throws Exception {
		List<RecipesBookmarkVO> list = new ArrayList<>();

		con = DB.getConnection();

		String sql = "select r.recipes_no, r.recipes_title, r.name, "
				   + " TO_CHAR(r.recipes_writeDate, 'yyyy-mm-dd') recipes_writeDate "
				   + " from recipes r, recipes_bookmark rb "
				   + " where (r.recipes_no = rb.recipes_no) and (rb.id = ?) "
				   + " order by rb.recipes_no desc";

		sql = "select rownum rnum, recipes_no, recipes_title, name, recipes_writeDate "
			+ " from (" + sql + ")";
		sql = "select rnum, recipes_no, recipes_title, name, recipes_writeDate "
			+ " from (" + sql + ") where rnum between ? and ?";

		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setLong(2, pageObject.getStartRow());
		pstmt.setLong(3, pageObject.getEndRow());

		rs = pstmt.executeQuery();

		if (rs != null) {
			while (rs.next()) {
				RecipesBookmarkVO vo = new RecipesBookmarkVO();
				vo.setRecipes_no(rs.getLong("recipes_no"));
				vo.setRecipes_title(rs.getString("recipes_title"));
				vo.setName(rs.getString("name"));
				vo.setRecipes_writeDate(rs.getString("recipes_writeDate"));
				list.add(vo);
			}
		}
		DB.close(con, pstmt, rs);
		return list;
	}

	public Long getTotalRow(PageObject pageObject, String id) throws Exception {
		Long totalRow = 0L;
		con = DB.getConnection();
		String sql = "select count(*) from recipes_bookmark where id = ?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, id);
		rs = pstmt.executeQuery();

		if (rs != null && rs.next()) {
			totalRow = rs.getLong(1);
		}
		DB.close(con, pstmt, rs);
		return totalRow;
	}

	public Integer write(RecipesBookmarkVO vo) throws Exception {
		Integer result = 0;
		con = DB.getConnection();
		String sql = "insert into recipes_bookmark(recipes_no, id) values(?, ?)";
		pstmt = con.prepareStatement(sql);
		pstmt.setLong(1, vo.getRecipes_no());
		pstmt.setString(2, vo.getId());
		result = pstmt.executeUpdate();
		DB.close(con, pstmt);
		return result;
	}

	public Integer delete(RecipesBookmarkVO vo) throws Exception {
		Integer result = 0;
		con = DB.getConnection();
		String sql = "delete from recipes_bookmark where recipes_no = ? and id = ?";
		pstmt = con.prepareStatement(sql);
		pstmt.setLong(1, vo.getRecipes_no());
		pstmt.setString(2, vo.getId());
		result = pstmt.executeUpdate();
		DB.close(con, pstmt);
		return result;
	}
}