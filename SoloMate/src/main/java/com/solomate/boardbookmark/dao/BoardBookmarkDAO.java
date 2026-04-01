package com.solomate.boardbookmark.dao;

import java.util.ArrayList;
import java.util.List;

import com.solomate.boardbookmark.vo.BoardBookmarkVO;
import com.solomate.main.dao.DAO;
import com.solomate.util.db.DB;
import com.solomate.util.page.PageObject;

public class BoardBookmarkDAO extends DAO{

	// list
	public List<BoardBookmarkVO> list(PageObject pageObject, String id) throws Exception {
		List<BoardBookmarkVO> list = new ArrayList<BoardBookmarkVO>();

		con = DB.getConnection();

		String sql = ""
			+ " SELECT rnum, boardNo, id, regDate, title, writer "
			+ " FROM ( "
			+ "     SELECT rownum rnum, t.* "
			+ "     FROM ( "
			+ "         SELECT m.boardNo, m.id, "
			+ "                TO_CHAR(m.regDate, 'yyyy-mm-dd') regDate, "
			+ "                b.title, b.writer "
			+ "         FROM board_bookmark m, board b "
			+ "         WHERE m.boardNo = b.no "
			+ "         AND m.id = ? "
			+ "         ORDER BY m.bookmarkNo DESC "
			+ "     ) t "
			+ " ) "
			+ " WHERE rnum BETWEEN ? AND ?";

		pstmt = con.prepareStatement(sql);

		int idx = 1;
		pstmt.setString(idx++, id);
		pstmt.setLong(idx++, pageObject.getStartRow());
		pstmt.setLong(idx++, pageObject.getEndRow());

		rs = pstmt.executeQuery();

		if (rs != null) {
			while (rs.next()) {
				BoardBookmarkVO vo = new BoardBookmarkVO();

				vo.setBoardNo(rs.getLong("boardNo"));
				vo.setId(rs.getString("id"));
				vo.setRegDate(rs.getString("regDate"));
				vo.setTitle(rs.getString("title"));
				vo.setWriter(rs.getString("writer"));

				list.add(vo);
			}
		}

		DB.close(con, pstmt, rs);
		return list;
	}
	
	public long getTotalRow(String id) throws Exception {
		long totalRow = 0;

		con = DB.getConnection();

		String sql = "select count(*) from board_bookmark where id = ?";

		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, id);

		rs = pstmt.executeQuery();

		if(rs.next()) totalRow = rs.getLong(1);

		DB.close(con, pstmt, rs);

		return totalRow;
	}
	
	// 이미 북마크가 되어있는지 확인 (결과가 있으면 1, 없으면 0)
	public int check(BoardBookmarkVO vo) throws Exception {
	    int count = 0;
	    try {
	        con = DB.getConnection();
	        String sql = "select count(*) from board_bookmark where boardNo = ? and id = ?";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setLong(1, vo.getBoardNo());
	        pstmt.setString(2, vo.getId());
	        rs = pstmt.executeQuery();
	        if(rs.next()) count = rs.getInt(1);
	    } finally {
	        DB.close(con, pstmt, rs);
	    }
	    return count;
	}
	
	// 북마크 등록
	public int write(BoardBookmarkVO vo) throws Exception {

	    int result = 0;

	    con = DB.getConnection();

	    String sql = ""
	        + " insert into board_bookmark "
	        + " (bookmarkNo, boardNo, id, regdate) "
	        + " values (board_bookmark_seq.nextval, ?, ?, sysdate) ";

	    pstmt = con.prepareStatement(sql);

	    pstmt.setLong(1, vo.getBoardNo());
	    pstmt.setString(2, vo.getId());

	    result = pstmt.executeUpdate();

	    DB.close(con, pstmt);

	    return result;
	}
	
	// 북마크 삭제
	public int delete(BoardBookmarkVO vo) throws Exception {
	    int result = 0;
	    try {
	        con = DB.getConnection();
	        String sql = "delete from board_bookmark where boardNo = ? and id = ?";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setLong(1, vo.getBoardNo());
	        pstmt.setString(2, vo.getId());
	        result = pstmt.executeUpdate();
	    } finally {
	        DB.close(con, pstmt);
	    }
	    return result;
	}
	
}
