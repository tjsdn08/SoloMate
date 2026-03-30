package com.solomate.boardreply.dao;

import java.util.ArrayList;
import java.util.List;

import com.solomate.boardreply.vo.BoardReplyVO;
import com.solomate.main.dao.DAO;
import com.solomate.util.db.DB;
import com.solomate.util.page.PageObject;

public class BoardReplyDAO extends DAO{

	// 댓글 리스트
	public List<BoardReplyVO> list(PageObject pageObject) throws Exception {
		List<BoardReplyVO> list = new ArrayList<BoardReplyVO>();
		
		con=DB.getConnection();
		String sql="select b.rno, b.no, b.content, b.id, m.name, "
				+ " to_char(b.writeDate,'yyyy-mm-dd') writeDate "
				+ " from board_reply b, member m "
				+ " where (no=?) and (b.id=m.id) "
				+ " order by rno desc";
		sql="select rownum rnum, rno, no, content, id, name, writeDate "
				+ " from( "+sql+")";
		sql="select rnum, rno, no, content, id, name, writeDate "
			+ " from( "+sql+" ) "
			+ " where rnum between ? and ?";
		pstmt=con.prepareStatement(sql);
		pstmt.setLong(1, pageObject.getNo());
		pstmt.setLong(2, pageObject.getStartRow());
		pstmt.setLong(3, pageObject.getEndRow());
		rs=pstmt.executeQuery();
		if(rs!=null) {
			while(rs.next()) {
				BoardReplyVO vo = new BoardReplyVO(); 
				vo.setRno(rs.getLong("rno"));
				vo.setNo(rs.getLong("no"));
				vo.setContent(rs.getString("content"));
				vo.setId(rs.getString("id"));
				vo.setName(rs.getString("name"));
				vo.setWriteDate(rs.getString("writeDate"));
				list.add(vo);
			} // while의 끝
		} // if의 끝
		DB.close(con, pstmt, rs);
		
		return list;
	} // list()의 끝
	
	// 댓글 개수
	public Long getTotalRow(PageObject pageObject) throws Exception{
		Long totalRow = 0L;
		con = DB.getConnection();
		String sql = "select count(*) from board_reply where no = ?";
		pstmt = con.prepareStatement(sql);
		pstmt.setLong(1, pageObject.getNo());
		rs = pstmt.executeQuery();
		if(rs != null && rs.next()) {
			totalRow = rs.getLong(1);
		} // if의 끝
		DB.close(con, pstmt, rs);
		return totalRow;
	} // getTotalRow()의 끝
	
	// 댓글 등록
	public Integer write(BoardReplyVO vo) throws Exception {
		Integer result = 0;
		con=DB.getConnection();
		String sql="insert into board_reply(rno, no, content, id) "
				+ " values(board_reply_seq.nextval,?,?,?)";
		pstmt=con.prepareStatement(sql);
		pstmt.setLong(1, vo.getNo());
		pstmt.setString(2, vo.getContent());
		pstmt.setString(3, vo.getId());
		result=pstmt.executeUpdate();
		DB.close(con, pstmt);
		return result;
	}
	
	// 댓글 수정
	public Integer update(BoardReplyVO vo) throws Exception {
		Integer result = 0;
		con=DB.getConnection();
		String sql="update board_reply content=? "
				+ " where rno=? and id=?";
		pstmt=con.prepareStatement(sql);
		pstmt.setString(1, vo.getContent());
		pstmt.setLong(2, vo.getRno());
		pstmt.setString(3, vo.getId());
		result=pstmt.executeUpdate();
		DB.close(con, pstmt);
		return result;
	}
	
	// 댓글 삭제
	public Integer delete(BoardReplyVO vo) throws Exception {
		Integer result = 0;
		con=DB.getConnection();
		String sql="delete from board_reply "
				+ " where rno=? and id=?";
		pstmt=con.prepareStatement(sql);
		pstmt.setLong(1, vo.getRno());
		pstmt.setString(2, vo.getId());
		result=pstmt.executeUpdate();
		DB.close(con, pstmt);
		return result;
	} // delete()의 끝
	
}
