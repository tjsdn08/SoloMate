package com.solomate.account.dao;

import java.util.ArrayList;
import java.util.List;

import com.solomate.account.vo.AccountVO;
import com.solomate.main.dao.DAO;
import com.solomate.util.db.DB;
import com.solomate.util.page.PageObject;

public class AccountDAO extends DAO{

	public List<AccountVO> list(PageObject pageObject, String id) throws Exception {

	    List<AccountVO> list = new ArrayList<>();

	    con = DB.getConnection();

	    String sql = "select no, type, amount, category, memo, "
	               + " to_char(regDate, 'yyyy-mm-dd') regDate "
	               + " from account "
	               + " where id = ? ";

	    // 페이징
	    sql = "select rownum rnum, no, type, amount, category, memo, regDate "
	        + " from (" + sql + ")";

	    sql = "select rnum, no, type, amount, category, memo, regDate "
	        + " from (" + sql + ") where rnum between ? and ?";

	    pstmt = con.prepareStatement(sql);

	    int idx = 1;

	    // ⭐ 사용자 id 먼저 세팅
	    pstmt.setString(idx++, id);

	    // 페이징
	    pstmt.setLong(idx++, pageObject.getStartRow());
	    pstmt.setLong(idx++, pageObject.getEndRow());

	    rs = pstmt.executeQuery();

	    while(rs.next()) {
	        AccountVO vo = new AccountVO();

	        vo.setNo(rs.getLong("no"));
	        vo.setType(rs.getString("type"));
	        vo.setAmount(rs.getInt("amount"));
	        vo.setCategory(rs.getString("category"));
	        vo.setRegDate(rs.getString("regDate"));

	        list.add(vo);
	    }

	    DB.close(con, pstmt, rs);

	    return list;
	}
	
	// 글 개수
		public Long getTotalRow(PageObject pageObject) throws Exception{
			Long totalRow = 0L;
			con = DB.getConnection();
			String sql = "select count(*) from account a";
			pstmt = con.prepareStatement(sql);
			int idx = 1;
			rs = pstmt.executeQuery();
			if(rs != null && rs.next()) {
				totalRow = rs.getLong(1);
			} // if의 끝
			DB.close(con, pstmt, rs);
			return totalRow;
		} // getTotalRow()의 끝
}
