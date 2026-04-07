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

	        // 1. 기본 SQL 작성 (정렬 기준을 regDate 최신순으로 설정)
	        // 정렬을 위해 서브쿼리 안에서는 to_char 처리 전의 원본 regDate를 사용하거나, 
	        // 전체를 감싸는 쿼리에서 정렬해야 합니다.
	        String sql = "select a.no, a.amount, ac.cname, ac.type, a.title, a.content, a.regDate "
	                + " from account a, account_category ac "
	                + " where (a.id = ?) and (a.cno = ac.cno) ";

	        // 카테고리 필터링 (기존 로직 유지)
	        String category = pageObject.getCategory();
	        if (category != null && !category.equals("")) {
	            if (category.equals("income")) {
	                sql += " and ac.type = 'income' ";
	            } else if (category.equals("expense")) {
	                sql += " and ac.type = 'expense' ";
	            } else {
	                sql += " and ac.cname = ? ";
	            }
	        }

	        // 2. 정렬 및 페이징 처리 
	        // [중요] regDate DESC(최신날짜순), no DESC(같은 날짜면 최신글순)
	        sql = "select no, amount, cname, type, title, content, to_char(regDate, 'yyyy-mm-dd') regDate "
	            + " from (" + sql + " order by a.regDate desc, a.no desc)";

	        // 3. ROWNUM을 이용한 페이징 래퍼
	        sql = "select rownum rnum, no, amount, cname, type, title, content, regDate "
	            + " from (" + sql + ")";
	        
	        sql = "select no, amount, cname, type, title, content, regDate "
	            + " from (" + sql + ") where rnum between ? and ?";

	        pstmt = con.prepareStatement(sql);
	        
	        int idx = 1;
	        pstmt.setString(idx++, id);

	        // 카테고리 파라미터 바인딩
	        if (category != null && !category.equals("") 
	            && !category.equals("income") && !category.equals("expense")) {
	            pstmt.setString(idx++, category);
	        }

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
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw e;
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
	
	// 글 개수
	public Long getTotalRow(PageObject pageObject, String id) throws Exception {
	    Long totalRow = 0L;
	    try {
	        con = DB.getConnection();
	        // 로그인한 아이디(id)의 데이터만 세어야 합니다.
	        String sql = "select count(*) from account where id = ?";
	        
	        // 카테고리 선택 시 개수도 같이 줄어들게 처리
	        String category = pageObject.getCategory();
	        if (category != null && !category.equals("")) {
	            if (category.equals("income")) sql += " and cno in (1,2,3)"; // 예시 cno
	            else if (category.equals("expense")) sql += " and cno in (4,5,6,7,8,9)";
	            else sql += " and cno = (select cno from account_category where cname = ?)";
	        }

	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, id);
	        if (category != null && !category.equals("") && !category.equals("income") && !category.equals("expense")) {
	            pstmt.setString(2, category);
	        }

	        rs = pstmt.executeQuery();
	        if (rs.next()) totalRow = rs.getLong(1);
	    } finally {
	        DB.close(con, pstmt, rs);
	    }
	    return totalRow;
	}
	
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
