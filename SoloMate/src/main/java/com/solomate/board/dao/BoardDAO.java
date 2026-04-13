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
		// 1. 가장 안쪽의 원본 데이터 추출 쿼리 (조인 및 집계)
		String sql = "select b.no, b.title, b.writer, b.writeDate, b.hit, "
		           + " count(distinct m.bookmarkNo) bookmark, " // 북마크 개수 (중복방지)
		           + " count(distinct r.rno) replyCnt "         // 댓글 개수 (중복방지)
		           + " from board b "
		           + " left join board_bookmark m on b.no = m.boardNo "
		           + " left join board_reply r on b.no = r.no ";

		// 2. 검색 조건 추가 (search 메서드 호출)
		sql += search(pageObject);

		// 3. 그룹화 및 정렬
		sql += " group by b.no, b.title, b.writer, b.writeDate, b.hit ";
		sql += " order by b.no desc";

		// 4. 페이징 처리를 위한 2단계 (rownum 부여)
		sql = "select rownum rnum, no, title, writer, writeDate, hit, bookmark, replyCnt " 
		    + " from (" + sql + ")";

		// 5. 페이징 처리를 위한 3단계 (페이지 범위 필터링 및 날짜 포맷)
		sql = "select rnum, no, title, writer, "
		    + " to_char(writeDate, 'yyyy-mm-dd') writeDate, hit, bookmark, replyCnt "
		    + " from (" + sql + ") where rnum between ? and ?";
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
				vo.setReplyCnt(rs.getInt("replyCnt"));
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
		String sql = "select count(*) from board b";
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
	// 검색 조건을 생성하는 메서드
	public String search(PageObject pageObject) {
	    String sql = " where 1=1 "; // 모든 조건 앞에 1=1을 붙여서 다음에 오는 AND 처리를 쉽게 함

	    // 1. 카테고리 조건 추가 (카테고리가 있을 때만)
	    String category = pageObject.getCategory();
	    if (category != null && !category.equals("")) {
	        // b.category인 이유는 list() 메서드 SQL에서 board 테이블을 'b'로 별칭 주었기 때문
	        sql += " and b.category = ? "; 
	    }

	    // 2. 검색어 조건 추가 (기존 로직 유지 및 b. 추가)
	    String key = pageObject.getKey();
	    String word = pageObject.getWord();
	    if (word != null && word.length() != 0) {
	        sql += " and ( 1=0 ";
	        if (key.indexOf("t") >= 0) sql += " or b.title like ? ";
	        if (key.indexOf("c") >= 0) sql += " or b.content like ? ";
	        if (key.indexOf("w") >= 0) sql += " or b.writer like ? ";
	        sql += " ) ";
	    }
	    return sql;
	}
	
	// 검색어 세팅
	// 검색어 데이터를 세팅하는 메서드
	public Integer searchDataSet(PreparedStatement pstmt, int idx, PageObject pageObject)
	 throws Exception {
	    
	    // 1. 카테고리 데이터 세팅
	    String category = pageObject.getCategory();
	    if (category != null && !category.equals("")) {
	        pstmt.setString(idx++, category);
	    }

	    // 2. 검색어 데이터 세팅 (기존 로직)
	    String key = pageObject.getKey();
	    String word = pageObject.getWord();
	    if (word != null && word.length() != 0) {
	        if (key.indexOf("t") >= 0) pstmt.setString(idx++, "%" + word + "%");
	        if (key.indexOf("c") >= 0) pstmt.setString(idx++, "%" + word + "%");
	        if (key.indexOf("w") >= 0) pstmt.setString(idx++, "%" + word + "%");
	    }
	    return idx;
	}
	
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
		String sql = "select b.no, b.category, b.title, b.content, b.writer, "
		        + " to_char(b.writeDate, 'yyyy-mm-dd') writeDate, "
		        + " b.hit, NVL(count(m.bookmarkNo),0) bookmark "
		        + " from board b "
		        + " left join board_bookmark m on b.no = m.boardNo "
		        + " where b.no = ? "
		        + " group by b.no, b.category, b.title, b.content, b.writer, b.writeDate, b.hit";		
		pstmt = con.prepareStatement(sql);
		pstmt.setLong(1, no);
		rs = pstmt.executeQuery();
		if(rs != null && rs.next()) {
			vo = new BoardVO();
			vo.setNo(rs.getLong("no"));
			vo.setCategory(rs.getString("category"));
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
	    String sql = "select count(*) from board_bookmark where boardNo = ? and id = ?";

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
		String sqlReply = "delete from board_reply where no = ?";
        pstmt = con.prepareStatement(sqlReply);
        pstmt.setLong(1, vo.getNo());
        pstmt.executeUpdate();
        pstmt.close();

        // 2. 북마크 삭제 (board_bookmark)
        String sqlBookmark = "delete from board_bookmark where boardNo = ?";
        pstmt = con.prepareStatement(sqlBookmark);
        pstmt.setLong(1, vo.getNo());
        pstmt.executeUpdate();
        pstmt.close();

        // 3. 게시글 원본 삭제 (board) - 작성자 본인 확인 포함
        // 보내주신 SQL 스타일처럼 변수를 활용해 깔끔하게 작성
        String sqlBoard = "delete from board where no = ? and writer = ?";
        
        pstmt = con.prepareStatement(sqlBoard);
        pstmt.setLong(1, vo.getNo());
        pstmt.setString(2, vo.getWriter());
		result=pstmt.executeUpdate();
		DB.close(con, pstmt);
		return result;
	} // delete()의 끝
	
}
