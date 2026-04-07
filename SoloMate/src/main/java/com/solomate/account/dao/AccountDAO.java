package com.solomate.account.dao;

import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;

import com.solomate.account.vo.AccountVO;
import com.solomate.main.dao.DAO;
import com.solomate.util.db.DB;
import com.solomate.util.page.PageObject;

public class AccountDAO extends DAO{

	public List<AccountVO> list(PageObject pageObject, String id) throws Exception {
	    List<AccountVO> list = new ArrayList<>();
	    try {
	        con = DB.getConnection();

	        // 1. 기본 SQL (검색 조건이 붙을 수 있게 마지막에 공백 확인)
	        String sql = "select a.no, a.amount, ac.cname, ac.type, a.title, a.content, a.regDate "
	                   + " from account a, account_category ac "
	                   + " where a.id = ? and a.cno = ac.cno "; // 괄호 제거하고 단순화

	        // 2. 검색 및 카테고리 조건 추가
	        sql += search(pageObject);

	        // 3. 정렬 및 페이징 래퍼
	        String fullSql = "select no, amount, cname, type, title, content, to_char(regDate, 'yyyy-mm-dd') regDate "
	                       + " from (" + sql + " order by a.regDate desc, a.no desc)";

	        fullSql = "select rownum rnum, no, amount, cname, type, title, content, regDate "
	                + " from (" + fullSql + ")";
	        
	        fullSql = "select no, amount, cname, type, title, content, regDate "
	                + " from (" + fullSql + ") where rnum between ? and ?";

	        pstmt = con.prepareStatement(fullSql);
	        
	        int idx = 1;
	        pstmt.setString(idx++, id); // ? 1번: 아이디

	        // [중요] ? 2번부터 카테고리/검색어 세팅
	        idx = searchDataSet(pstmt, idx, pageObject);

	        // 마지막 페이징 ? 세팅
	        pstmt.setLong(idx++, pageObject.getStartRow());
	        pstmt.setLong(idx++, pageObject.getEndRow());

	        rs = pstmt.executeQuery();
	        while(rs.next()) {
	            AccountVO vo = new AccountVO();
	            vo.setNo(rs.getLong("no"));
	            vo.setAmount(rs.getLong("amount"));
	            vo.setCategory(rs.getString("cname")); 
	            vo.setType(rs.getString("type"));      
	            vo.setTitle(rs.getString("title"));  
	            vo.setContent(rs.getString("content"));  
	            vo.setRegDate(rs.getString("regDate")); 
	            list.add(vo);
	        }
	    } finally {
	        DB.close(con, pstmt, rs);
	    }
	    return list;
	}
	
	public List<AccountVO> getMonthlyStats(String id, String dateStr) throws Exception {
	    List<AccountVO> list = new ArrayList<>();
	    try {
	        con = DB.getConnection();
	        String sql = "";
	        
	        if (dateStr != null && !dateStr.equals("")) {
	            // [핵심] 특정 달 선택 시: 카테고리별 지출 합계
	            sql = "SELECT ac.cname as category, ac.type, SUM(a.amount) as total "
	                + " FROM account a, account_category ac "
	                + " WHERE a.id = ? AND a.cno = ac.cno AND TO_CHAR(regDate, 'YYYY-MM') = ? "
	                + " GROUP BY ac.cname, ac.type " // 카테고리명으로 그룹화
	                + " ORDER BY total DESC";
	        } else {
	            // 달 미선택 시: 전체 월별 합계 (기존 유지)
	            sql = "SELECT TO_CHAR(regDate, 'YYYY-MM') as target_date, ac.type, SUM(a.amount) as total "
	                + " FROM account a, account_category ac "
	                + " WHERE a.id = ? AND a.cno = ac.cno "
	                + " GROUP BY TO_CHAR(regDate, 'YYYY-MM'), ac.type "
	                + " ORDER BY target_date ASC";
	        }

	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, id);
	        if (dateStr != null && !dateStr.equals("")) pstmt.setString(2, dateStr);
	        
	        rs = pstmt.executeQuery();
	        while(rs.next()) {
	            AccountVO vo = new AccountVO();
	            if (dateStr != null && !dateStr.equals("")) {
	                vo.setCategory(rs.getString("category")); // 카테고리명 저장
	            } else {
	                vo.setRegDate(rs.getString("target_date")); // 월 정보 저장
	            }
	            vo.setType(rs.getString("type"));
	            vo.setAmount(rs.getLong("total"));
	            list.add(vo);
	        }
	    } finally {
	        DB.close(con, pstmt, rs);
	    }
	    return list;
	}
	
	// 4. 전체 데이터 개수 (카테고리/검색 반영)
	public Long getTotalRow(PageObject pageObject, String id) throws Exception {
	    Long totalRow = 0L;
	    try {
	        con = DB.getConnection();
	        // count 시에도 카테고리 테이블 조인이 필요함
	        String sql = "select count(*) from account a, account_category ac "
	                   + " where a.id = ? and a.cno = ac.cno ";
	        
	        sql += search(pageObject); // 위에서 만든 search() 재사용

	        pstmt = con.prepareStatement(sql);
	        int idx = 1;
	        pstmt.setString(idx++, id);
	        idx = searchDataSet(pstmt, idx, pageObject); // 파라미터 세팅 재사용

	        rs = pstmt.executeQuery();
	        if (rs.next()) totalRow = rs.getLong(1);
	    } finally {
	        DB.close(con, pstmt, rs);
	    }
	    return totalRow;
	}
	
	// 2. 검색 및 카테고리 SQL 생성
	public String search(PageObject pageObject) {
	    String sql = ""; 
	    String category = pageObject.getCategory();
	    String word = pageObject.getWord();
	    String key = pageObject.getKey();

	    // 1. 카테고리 조건
	    if (category != null && !category.equals("")) {
	        // '전체 수입' 선택 시 -> type이 income인 것들
	        if (category.equals("income")) {
	            sql += " and ac.type = 'income' ";
	        } 
	        // '전체 지출' 선택 시 -> type이 expense인 것들
	        else if (category.equals("expense")) {
	            sql += " and ac.type = 'expense' ";
	        } 
	        // '식비', '월급', '기타(수입)' 등 구체적인 이름 선택 시 -> cname과 비교
	        else {
	            sql += " and ac.cname = ? ";
	        }
	    }

	    // 2. 검색어 조건
	    if (word != null && !word.equals("")) {
	        sql += " and ( 1=0 ";
	        if (key.indexOf("t") >= 0) sql += " or a.title like ? ";
	        if (key.indexOf("c") >= 0) sql += " or a.content like ? ";
	        sql += " ) ";
	    }
	    return sql;
	}
		
	// 3. 파라미터 세팅 (여기가 가장 중요합니다!)
	public Integer searchDataSet(PreparedStatement pstmt, int idx, PageObject pageObject) throws Exception {
	    String category = pageObject.getCategory();
	    String word = pageObject.getWord();
	    String key = pageObject.getKey();

	    // [수정 포인트] 
	    // category가 "income"이나 "expense"일 때는 SQL문에 직접 'income'이라고 박아넣었으므로
	    // pstmt.setString을 할 필요가 없습니다. 
	    // 그 외의 구체적인 카테고리 이름일 때만 ?를 채워줘야 합니다.
	    if (category != null && !category.equals("")) {
	        if (!category.equals("income") && !category.equals("expense")) {
	            pstmt.setString(idx++, category);
	        }
	    }

	    // 검색어 세팅
	    if (word != null && !word.equals("")) {
	        if (key.indexOf("t") >= 0) pstmt.setString(idx++, "%" + word + "%");
	        if (key.indexOf("c") >= 0) pstmt.setString(idx++, "%" + word + "%");
	    }
	    return idx;
	}
	
		public AccountVO view(Long no) throws Exception {
		    AccountVO vo = null;
		    con = DB.getConnection();
		    
		    // 1. SQL에 a.cno를 반드시 포함시켜야 합니다!
		    String sql = "select a.no, a.amount, ac.cname, ac.type, a.title, a.content, a.cno, " // a.cno 추가
		               + " to_char(a.regDate, 'yyyy-mm-dd') regDate "
		               + " from account a, account_category ac "
		               + " where (a.no = ?) and (a.cno = ac.cno)";
		               
		    pstmt = con.prepareStatement(sql);
		    pstmt.setLong(1, no);
		    rs = pstmt.executeQuery();
		    
		    if(rs != null && rs.next()) {
		        vo = new AccountVO();
		        vo.setNo(rs.getLong("no"));
		        
		        // ⭐ 이 줄이 있어야 JSP에서 ${vo.cno == 4} 같은 비교가 가능해집니다!
		        vo.setCno(rs.getLong("cno")); 
		        
		        vo.setAmount(rs.getLong("amount"));
		        vo.setCategory(rs.getString("cname"));
		        vo.setType(rs.getString("type"));
		        vo.setTitle(rs.getString("title"));
		        vo.setContent(rs.getString("content"));
		        vo.setRegDate(rs.getString("regDate"));
		    }
		    
		    DB.close(con, pstmt, rs);
		    return vo;
		}
		
		// 가계부 내역 등록
		public Integer write(AccountVO vo) throws Exception {
		    Integer result = 0;
		    con = DB.getConnection();
		    
		    // SQL 수정: regDate 컬럼을 추가하고 sysdate 대신 물음표(?)를 사용합니다.
		    String sql = "insert into account(no, id, cno, title, content, amount, regDate) "
		               + " values(account_seq.nextval, ?, ?, ?, ?, ?, ?)";
		    
		    pstmt = con.prepareStatement(sql);
		    
		    pstmt.setString(1, vo.getId());
		    pstmt.setLong(2, vo.getCno());
		    pstmt.setString(3, vo.getTitle());
		    pstmt.setString(4, vo.getContent());
		    pstmt.setLong(5, vo.getAmount());
		    pstmt.setString(6, vo.getRegDate()); // 6번 물음표: 사용자가 선택한 날짜 ("2026-03-20" 형태)
		    
		    result = pstmt.executeUpdate();
		    
		    DB.close(con, pstmt);
		    return result;
		}
		
		public Integer update(AccountVO vo) throws Exception {
		    Integer result = 0;
		    con = DB.getConnection();
		    
		    // SQL: 선택한 번호(no)의 데이터들을 수정함
		    String sql = "update account set title = ?, content = ?, amount = ?, cno = ?, regDate = ? "
		               + " where no = ?";
		               
		    pstmt = con.prepareStatement(sql);
		    pstmt.setString(1, vo.getTitle());
		    pstmt.setString(2, vo.getContent());
		    pstmt.setLong(3, vo.getAmount());
		    pstmt.setLong(4, vo.getCno());
		    pstmt.setString(5, vo.getRegDate());
		    pstmt.setLong(6, vo.getNo()); // WHERE 절의 번호
		    
		    result = pstmt.executeUpdate();
		    
		    DB.close(con, pstmt);
		    return result;
		}
		
		// 삭제 처리 메서드
	    public int delete(Long no) throws Exception {
	        int result = 0;
	        con = null;
	        PreparedStatement pstmt = null;

	        try {
	            // 1. 드라이버 확인 및 연결
	            con = DB.getConnection();
	            
	            // 2. SQL 작성
	            String sql = "DELETE FROM account WHERE no = ?";
	            
	            // 3. 상태 서비스 및 데이터 세팅
	            pstmt = con.prepareStatement(sql);
	            pstmt.setLong(1, no);
	            
	            // 4. 실행
	            result = pstmt.executeUpdate();
	            
	            // 5. 결과 표시
	            if (result == 1) {
	                System.out.println("AccountDAO.delete() - 삭제 성공!");
	            } else {
	                System.out.println("AccountDAO.delete() - 삭제 실패 (번호가 없을 수 있음)");
	            }

	        } catch (Exception e) {
	            e.printStackTrace();
	            throw new Exception("가계부 삭제 중 DB 오류 발생");
	        } finally {
	            // 6. 닫기
	            DB.close(con, pstmt);
	        }

	        return result;
	    }
		
}
