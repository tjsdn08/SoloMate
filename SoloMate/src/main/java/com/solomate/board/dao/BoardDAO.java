package com.solomate.board.dao;

import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;

import com.solomate.board.vo.BoardVO;
import com.solomate.main.dao.DAO;
import com.solomate.util.db.DB;
import com.solomate.util.page.PageObject;

public class BoardDAO extends DAO{
	
	// 리스트
	public List<BoardVO> list(PageObject pageObject) throws Exception {
		List<BoardVO> list=new ArrayList<>();
		con=DB.getConnection();
		String sql = "select b.no, b.title, b.writer, "
		        + " to_char(b.writeDate, 'yyyy-mm-dd') writeDate, "
		        + " b.hit, NVL(count(m.bookmarkNo),0) bookmark "
		        + " from board b "
		        + " left join bookmark m on b.no = m.boardNo ";
		sql += search(pageObject);
		sql += " group by b.no, b.title, b.writer, b.writeDate, b.hit ";
		sql += " order by b.no desc";
		sql = "select rownum rnum, no, title, writer, writeDate, hit, bookmark " 
			+ " from(" + sql + ")";
		sql = "select rnum, no, title, writer, writeDate, hit, bookmark "
			+ " from(" + sql + ") where rnum between ? and ?";
		pstmt = con.prepareStatement(sql);
		int idx = 1;
		idx = searchDataSet(pstmt, idx, pageObject);
		pstmt.setLong(idx++, pageObject.getStartRow());
		pstmt.setLong(idx++, pageObject.getEndRow());
		rs = pstmt.executeQuery();
		if(rs != null) {
			while(rs.next()) { 
				BoardVO vo = new BoardVO();
				vo.setNo(rs.getLong("no"));
				vo.setTitle(rs.getString("title"));
				vo.setWriter(rs.getString("writer"));
				vo.setWriteDate(rs.getString("writeDate"));
				vo.setHit(rs.getLong("hit"));
				vo.setBookmark(rs.getLong("bookmark"));
				list.add(vo);
			} // while() 끝
		} // if의 끝
		DB.close(con, pstmt, rs);
		return list;
	} // list()의 끝
	
	// 글 개수
	public Long getTotalRow(PageObject pageObject) throws Exception{
		Long totalRow = 0L;
		con = DB.getConnection();
		String sql = "select count(*) from board ";
		sql += search(pageObject);
		pstmt = con.prepareStatement(sql);
		int idx = 1;
		idx = searchDataSet(pstmt, idx, pageObject); // pstmt 데이터 변경
		rs = pstmt.executeQuery();
		if(rs != null && rs.next()) {
			totalRow = rs.getLong(1);
		} // if의 끝
		DB.close(con, pstmt, rs);
		return totalRow;
	} // getTotalRow()의 끝
	
	// 검색
	public String search(PageObject pageObject) {
		String sql = "";
		String key = pageObject.getKey();
		String word = pageObject.getWord();
		if(word != null && word.length() != 0) {
			sql = " where 1=0 ";
			if(key.indexOf("t") >= 0)
				sql += " or title like ? ";
			if(key.indexOf("c") >= 0)
				sql += " or content like ? ";
			if(key.indexOf("w") >= 0)
				sql += " or writer like ? ";
		}
		return sql;
	} // search()의 끝
	
	// 검색어 세팅
	public Integer searchDataSet(PreparedStatement pstmt, int idx, PageObject pageObject)
	 throws Exception{
		String key = pageObject.getKey();
		String word = pageObject.getWord();
		if(word != null && word.length() != 0) {
			if(key.indexOf("t") >= 0)
				pstmt.setString(idx++, "%" + word + "%");
			if(key.indexOf("c") >= 0)
				pstmt.setString(idx++, "%" + word + "%");
			if(key.indexOf("w") >= 0)
				pstmt.setString(idx++, "%" + word + "%");
		}
		return idx;
	} // searchDataSet()의 끝
	
	// 조회수 증가
	public Integer increase(Long no) throws Exception{
		Integer result = 0;
		con = DB.getConnection();
		String sql = "update board set hit = hit + 1 where no = ?";
		pstmt = con.prepareStatement(sql);
		pstmt.setLong(1, no);
		result = pstmt.executeUpdate();
		DB.close(con, pstmt);
		return result;
	} // increase()의 끝
	
	// 글보기
	public BoardVO view(Long no) throws Exception {
		BoardVO vo=null;
		con=DB.getConnection();
		String sql = "select b.no, b.title, b.content, b.writer, "
		        + " to_char(b.writeDate, 'yyyy-mm-dd') writeDate, "
		        + " b.hit, NVL(count(m.bookmarkNo),0) bookmark "
		        + " from board b "
		        + " left join bookmark m on b.no = m.boardNo "
		        + " where b.no = ? "
		        + " group by b.no, b.title, b.content, b.writer, b.writeDate, b.hit";		
		pstmt = con.prepareStatement(sql);
		pstmt.setLong(1, no);
		rs = pstmt.executeQuery();
		if(rs != null && rs.next()) {
			vo = new BoardVO();
			vo.setNo(rs.getLong("no"));
			vo.setTitle(rs.getString("title"));
			vo.setContent(rs.getString("content"));
			vo.setWriter(rs.getString("writer"));
			vo.setWriteDate(rs.getString("writeDate"));
			vo.setHit(rs.getLong("hit"));
			vo.setBookmark(rs.getLong("bookmark"));
		} // if 의 끝
		DB.close(con, pstmt, rs);
		return vo;
	} // view()의 끝
	
	public long isBookmarked(Long boardNo, String id) throws Exception {
	    long result = 0;

	    con = DB.getConnection();
	    String sql = "select count(*) from bookmark where boardNo = ? and id = ?";

	    pstmt = con.prepareStatement(sql);
	    pstmt.setLong(1, boardNo);
	    pstmt.setString(2, id);

	    rs = pstmt.executeQuery();

	    if(rs.next()) result = rs.getLong(1);

	    DB.close(con, pstmt, rs);
	    return result; // 0 or 1
	} // isBookmarked()의 끝
	
	// 글쓰기
	public Integer write(BoardVO vo) throws Exception {
		Integer result=0;
		con = DB.getConnection();
		String sql = "insert into board(no, category, title, content, writer) values(board_seq.nextval,?,?,?,?)";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, vo.getCategory());
		pstmt.setString(2, vo.getTitle());
		pstmt.setString(3, vo.getContent());
		pstmt.setString(4, vo.getWriter());
		result = pstmt.executeUpdate();
		DB.close(con, pstmt);
		return result;
	} // write()의 끝
	
	// 글등록
	public Integer update(BoardVO vo) throws Exception {
		Integer result=0;
		con=DB.getConnection();
		String sql="update board set title = ?, content = ? "
				+ " where no = ? and writer=? ";
		pstmt=con.prepareStatement(sql);
		pstmt.setString(1, vo.getTitle());
		pstmt.setString(2, vo.getContent());
		pstmt.setLong(3, vo.getNo());
		pstmt.setString(4, vo.getWriter());
		result = pstmt.executeUpdate();
		DB.close(con, pstmt);
		return result;
	} // update()의 끝
	
	// 글삭제
	public Integer delete(BoardVO vo) throws Exception {
		Integer result=0;
		con=DB.getConnection();
		String sql="delete from board where no=? and writer=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setLong(1, vo.getNo());
		pstmt.setString(2, vo.getWriter());
		result=pstmt.executeUpdate();
		DB.close(con, pstmt);
		return result;
	} // delete()의 끝
	
}
