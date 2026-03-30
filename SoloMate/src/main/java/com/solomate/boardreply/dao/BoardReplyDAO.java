package com.solomate.boardreply.dao;

import java.util.ArrayList;
import java.util.List;
import com.solomate.boardreply.vo.BoardReplyVO;
import com.solomate.main.dao.DAO;
import com.solomate.util.db.DB;
import com.solomate.util.page.PageObject;

public class BoardReplyDAO extends DAO {

    // 1. 댓글 리스트 (수정 완료)
    public List<BoardReplyVO> list(PageObject pageObject) throws Exception {
        List<BoardReplyVO> list = new ArrayList<BoardReplyVO>();
        con = DB.getConnection();
        
        // 💡 [수정] b.id -> b.writer 로 변경 (ORA-00904 해결 포인트)
        String sql = "select b.rno, b.no, b.content, b.writer, m.name, "
                   + " to_char(b.writeDate,'yyyy-mm-dd') writeDate "
                   + " from board_reply b, member m "
                   + " where (b.no = ?) and (b.writer = m.id) " // 이 부분의 b.writer 확인
                   + " order by b.rno desc";
                   
        // 페이징 처리를 위한 서브쿼리 (id -> writer 변경 반영)
        String query = "select rownum rnum, rno, no, content, writer, name, writeDate "
                     + " from ( " + sql + " )";
        query = "select rnum, rno, no, content, writer as id, name, writeDate " // RS에서 id로 꺼낼 수 있게 별칭 부여
              + " from ( " + query + " ) "
              + " where rnum between ? and ?";
              
        pstmt = con.prepareStatement(query);
        pstmt.setLong(1, pageObject.getNo());
        pstmt.setLong(2, pageObject.getStartRow());
        pstmt.setLong(3, pageObject.getEndRow());
        
        rs = pstmt.executeQuery();
        if (rs != null) {
            while (rs.next()) {
                BoardReplyVO vo = new BoardReplyVO();
                vo.setRno(rs.getLong("rno"));
                vo.setNo(rs.getLong("no"));
                vo.setContent(rs.getString("content"));
                vo.setId(rs.getString("id")); // 별칭(writer as id) 덕분에 기존 VO 코드 유지 가능
                vo.setName(rs.getString("name"));
                vo.setWriteDate(rs.getString("writeDate"));
                list.add(vo);
            }
        }
        DB.close(con, pstmt, rs);
        return list;
    }

    // 2. 댓글 등록 (기존 코드 유지)
    public Integer write(BoardReplyVO vo) throws Exception {
        Integer result = 0;
        con = DB.getConnection();
        String sql = "insert into board_reply(rno, no, content, writer) "
                   + " values(board_reply_seq.nextval, ?, ?, ?)";
        pstmt = con.prepareStatement(sql);
        pstmt.setLong(1, vo.getNo());
        pstmt.setString(2, vo.getContent());
        pstmt.setString(3, vo.getId());
        result = pstmt.executeUpdate();
        DB.close(con, pstmt);
        return result;
    }

    // 3. 댓글 수정 (기존 코드 유지)
    public Integer update(BoardReplyVO vo) throws Exception {
        Integer result = 0;
        con = DB.getConnection();
        String sql = "update board_reply set content = ? "
                   + " where rno = ? and writer = ?"; 
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, vo.getContent());
        pstmt.setLong(2, vo.getRno());
        pstmt.setString(3, vo.getId());
        result = pstmt.executeUpdate();
        DB.close(con, pstmt);
        return result;
    }

    // 4. 댓글 삭제 (수정 완료)
    public Integer delete(BoardReplyVO vo) throws Exception {
        Integer result = 0;
        con = DB.getConnection();
        // 💡 [수정] id -> writer 로 변경
        String sql = "delete from board_reply where rno = ? and writer = ?";
        pstmt = con.prepareStatement(sql);
        pstmt.setLong(1, vo.getRno());
        pstmt.setString(2, vo.getId());
        result = pstmt.executeUpdate();
        DB.close(con, pstmt);
        return result;
    }

    // 5. 댓글 개수 (기존 코드 유지)
    public Long getTotalRow(PageObject pageObject) throws Exception {
        Long totalRow = 0L;
        con = DB.getConnection();
        String sql = "select count(*) from board_reply where no = ?";
        pstmt = con.prepareStatement(sql);
        pstmt.setLong(1, pageObject.getNo());
        rs = pstmt.executeQuery();
        if (rs != null && rs.next()) {
            totalRow = rs.getLong(1);
        }
        DB.close(con, pstmt, rs);
        return totalRow;
    }
}