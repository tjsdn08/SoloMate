package com.solomate.recipes.dao;

import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;

import com.solomate.main.dao.DAO;
import com.solomate.recipes.vo.RecipesVO;
import com.solomate.util.db.DB;
import com.solomate.util.page.PageObject;

public class RecipesDAO extends DAO{

	public List<RecipesVO> list(PageObject pageObject) throws Exception {
	    List<RecipesVO> list = new ArrayList<>();
	    
	    con = DB.getConnection();

	    String sql = "select r.recipes_no, r.recipes_title, r.food, r.description, "
	               + " r.recipes_time, r.recipes_level, "
	               + " (select count(*) from recipes_bookmark rb where rb.recipes_no = r.recipes_no) recipes_bookmark "
	               + " from recipes r ";

	    sql += search(pageObject);
	    sql += " order by r.recipes_no desc";

	    sql = "select rownum rnum, recipes_no, recipes_title, food, description, "
	        + " recipes_time, recipes_level, recipes_bookmark " 
	        + " from (" + sql + ")";
	    
	    sql = "select rnum, recipes_no, recipes_title, food, description, "
	        + " recipes_time, recipes_level, recipes_bookmark "
	        + " from (" + sql + ") where rnum between ? and ?";

	    pstmt = con.prepareStatement(sql);
	    int idx = 1;
	    idx = searchDataSet(pstmt, idx, pageObject);
	    pstmt.setLong(idx++, pageObject.getStartRow());
	    pstmt.setLong(idx++, pageObject.getEndRow());

	    rs = pstmt.executeQuery();

	    if (rs != null) {
	        while (rs.next()) {
	            RecipesVO vo = new RecipesVO();
	            vo.setRecipes_no(rs.getLong("recipes_no"));
	            vo.setRecipes_title(rs.getString("recipes_title"));
	            vo.setFood(rs.getString("food"));
	            vo.setDescription(rs.getString("description"));
	            vo.setRecipes_time(rs.getInt("recipes_time"));
	            vo.setRecipes_level(rs.getString("recipes_level"));
	            
	            vo.setRecipes_bookmark(rs.getLong("recipes_bookmark"));

	            list.add(vo);
	        }
	    }
	    DB.close(con, pstmt, rs);
	    return list;
	}
	

	public String search(PageObject pageObject) {
	    String sql = "";
	    String key = pageObject.getKey();
	    String word = pageObject.getWord();
	    
	    if(word != null && word.length() != 0) {
	        sql = " where ( 1=0 "; // 검색 조건 시작
	        if(key.indexOf("t") >= 0) sql += " or recipes_title like ? ";
	        if(key.indexOf("c") >= 0) sql += " or recipes_content like ? ";
	        // 핵심 재료 검색 추가
	        if(key.indexOf("f") >= 0) sql += " or food like ? "; 
	        sql += " ) ";
	    }
	    return sql;
	}

	public Integer searchDataSet(PreparedStatement pstmt, int idx, PageObject pageObject) throws Exception {
	    String key = pageObject.getKey();
	    String word = pageObject.getWord();
	    
	    if(word != null && word.length() != 0) {
	        if(key.indexOf("t") >= 0) pstmt.setString(idx++, "%" + word + "%");
	        if(key.indexOf("c") >= 0) pstmt.setString(idx++, "%" + word + "%");
	        if(key.indexOf("f") >= 0) pstmt.setString(idx++, "%" + word + "%"); // 재료 세팅 추가
	    }
	    return idx;
	}
	
	public Long getTotalRow(PageObject pageObject) throws Exception {
	    Long totalRow = 0L;
	        con = DB.getConnection();
	        String sql = "select count(*) from recipes"; 
	        sql += search(pageObject);
	        
	        pstmt = con.prepareStatement(sql);
	        int idx = 1;
	        idx = searchDataSet(pstmt, idx, pageObject);
	        
	        rs = pstmt.executeQuery();
	        if(rs != null && rs.next()) {
	            totalRow = rs.getLong(1);
	        }
	        DB.close(con, pstmt, rs);
	    return totalRow;
	}
	
	
	public RecipesVO view(Long no) throws Exception {
	    RecipesVO vo = null;
        con = DB.getConnection();
        
        String sql = "SELECT r.recipes_no, r.recipes_title, r.id, r.name, r.food, "
                   + " r.description, r.recipes_time, r.recipes_level, r.recipes_img, "
                   + " r.recipes_content, "
                   + " TO_CHAR(r.recipes_writeDate, 'yyyy-mm-dd') recipes_writeDate, " 
                   + " (SELECT COUNT(*) FROM recipes_bookmark rb WHERE rb.recipes_no = r.recipes_no) recipes_bookmark "
                   + " FROM recipes r WHERE r.recipes_no = ?";
        
        pstmt = con.prepareStatement(sql);
        pstmt.setLong(1, no);
        rs = pstmt.executeQuery();
        
        if(rs != null && rs.next()) {
            vo = new RecipesVO();
            vo.setRecipes_no(rs.getLong("recipes_no"));
            vo.setRecipes_title(rs.getString("recipes_title"));
            vo.setId(rs.getString("id"));
            vo.setName(rs.getString("name"));
            vo.setFood(rs.getString("food"));
            vo.setDescription(rs.getString("description"));
            vo.setRecipes_time(rs.getInt("recipes_time"));
            vo.setRecipes_level(rs.getString("recipes_level"));
            vo.setRecipes_img(rs.getString("recipes_img"));
            vo.setRecipes_content(rs.getString("recipes_content"));
            vo.setRecipes_writeDate(rs.getString("recipes_writeDate")); 
            vo.setRecipes_bookmark(rs.getLong("recipes_bookmark"));
        }
        DB.close(con, pstmt, rs);
	    return vo;
	}
}
