package com.solomate.food.dao;

import java.sql.PreparedStatement;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;

import com.opensymphony.module.sitemesh.Page;
import com.solomate.food.vo.FoodVO;
import com.solomate.main.dao.DAO;
import com.solomate.util.db.DB;
import com.solomate.util.page.PageObject;


public class FoodDAO extends DAO{
	
	// 1. 식품 목록 보기
	public List<FoodVO> list(PageObject pageObject) throws Exception {
		
		List<FoodVO> list = new ArrayList<>();
		
		con = DB.getConnection();
		
		String sql = "select no, memberId, name, to_char(expiryDate, 'yyyy-mm-dd') expiryDate, quantity, storageType from food"
				+ " where memberId = ? ";
		
		sql += search(pageObject);
		sql += " order by expiryDate ";
		
		System.out.println(sql);
		
		// 순서번호
		sql = "select rownum rnum, no, memberId, name, expiryDate, quantity, storageType from(" + sql + ")";
		// page에 맞는 데이터만 가져온다.
		sql = "select rnum, no, memberId, name, expiryDate, quantity, storageType from(" + sql + ") where rnum between ? and ?";
		
		pstmt = con.prepareStatement(sql);
		
		int idx = 1; //검색 처리
		
		pstmt.setString(idx++, pageObject.getAccepter());
		idx = searchDataSet(pstmt, idx, pageObject); // 검색 처리 
		pstmt.setLong(idx++, pageObject.getStartRow()); // 검색처리시 수정해야댐
		pstmt.setLong(idx++, pageObject.getEndRow()); // 검색처리시 수정해야댐
		
		System.out.println(sql);
		
		rs = pstmt.executeQuery();
		
		if(rs != null) {
			while(rs.next()) {
				FoodVO vo = new FoodVO();
				vo.setNo(rs.getLong("no"));
				vo.setName(rs.getString("name"));
				vo.setExpiryDate(rs.getString("expiryDate"));
				vo.setdDay(FoodDAO.getDday(rs.getString("expiryDate")));  // D-Day 계산
				vo.setQuantity(rs.getLong("quantity"));
				vo.setStorageType(rs.getString("storageType"));
				list.add(vo);
			}
		}
		
		DB.close(con, pstmt, rs);
				
		return list;
	}
	
	// 1-1. 식품 목록 보기에서 글의 개수
	public Long getTotalRow(PageObject pageObject) throws Exception{
		
		Long totalRow = 0L;
		
		con = DB.getConnection();
		
		String sql = "select count(*) from food where memberId = ? ";
		
		// 검색 처리를 한다. -> list()의 검색 처리와 같다. -> 반복이 된다. 메서드를 만든다.
		sql += search(pageObject);
		
		// 4. 실행 객체 & 데이터 세팅
		pstmt = con.prepareStatement(sql);
		
		// - 검색 처리를 하면 데이터 세팅이 필요하다. ?가 생긴다.
		// 순서 번호의 변수 선언해서 사용한다.
		int idx = 1;
		// 하드코딩
		pstmt.setString(idx++, pageObject.getAccepter());
		// 검색 데이터 세팅을 한다. - ?가 생길 수도 있다.
		idx = searchDataSet(pstmt, idx, pageObject); // pstmt 데이터 메서드 안에서 변경하면 밖에서 변경된 상태 : 참조형 변수 - 주소 전달
		
		// 5. 실행 : select :executeQuery() -> rs, insert / update / delete :executeUpdate() -> Integer
		rs = pstmt.executeQuery();
		
		// 6. DB에서 가져온 데이터 채우기
		if(rs != null && rs.next()) {
			// 데이터를 저장한다.
			totalRow = rs.getLong(1);
		} // if의 끝
		
		// 7. DB 닫기
		DB.close(con, pstmt, rs);
		
		return totalRow;
	} // getTotalRow()의 끝	
	
	//검색 조건을 검색하는 메서드
	public String search(PageObject pageObject) {
		String sql = " and 1=1 ";
		
		// 1. 보관방법 조건 추가 key를 검색에서 안쓰기 때문에 보관방법=key 로 쓸게영
		String key = pageObject.getKey();
		if(key != null && key != "") {
			if (key.indexOf("냉동") >= 0) sql += " and storageType = ? ";
			if (key.indexOf("냉장") >= 0) sql += " and storageType = ? ";
			if (key.indexOf("실온") >= 0) sql += " and storageType = ? ";
		}
		
		// 2. 검색어 조건 추가
		String word = pageObject.getWord();
		if(word != null && word.length() != 0) {
			sql += " and name like ? ";
		}
		System.out.println(sql);
		return sql;
	}
	
	// 검색어 데이터 세팅 메서드 
	public Integer searchDataSet(PreparedStatement pstmt, int idx, PageObject pageObject) 
	 throws Exception {
		
		// 1. 보관방법 epdlxj tpxld
		String key = pageObject.getKey();
		if(key != null && !key.equals("")) {
			System.out.println("나오세요");
			pstmt.setString(idx++, key);
			System.out.println("나와야해" + key);
		}
		
		// 2. 검색어 데이터 세팅 
		String word = pageObject.getWord();
		if(word != null && word.length() != 0) {
			System.out.println("나와요");
			pstmt.setString(idx++, "%" + word + "%");
		}
		
		return idx;
	}
	
	
	// .D-Day 를 반환하는 메서드
	public static String getDday(String dateStr) {
	    try {
	        LocalDate targetDate = LocalDate.parse(dateStr);
	        LocalDate today = LocalDate.now();

	        long diff = ChronoUnit.DAYS.between(today, targetDate);

	        return (diff >= 0) ? "D-" + diff : "D+" + Math.abs(diff);

	    } catch (Exception e) {
	        return "잘못된 날짜 형식";
	    }
	}
	
	// 2. 식품 상세 보기 (폴더 포함)
	public FoodVO view(Long no) throws Exception {

	    FoodVO vo = null;

	    List<String> folderList = new ArrayList<>();
	    List<Long> folderNos = new ArrayList<>(); // ⭐ 추가

	    con = DB.getConnection();

	    String sql = "SELECT "
	            + " f.no, f.name, TO_CHAR(f.expiryDate, 'yyyy-mm-dd') expiryDate, "
	            + " f.quantity, f.storageType, f.memo, "
	            + " fo.name AS folderName, "
	            + " fo.no AS folderNo "   // ⭐ 추가
	            + "FROM food f "
	            + "LEFT JOIN folder_food ff ON f.no = ff.foodNo "
	            + "LEFT JOIN folder fo ON ff.folderNo = fo.no "
	            + "WHERE f.no = ?";

	    pstmt = con.prepareStatement(sql);
	    pstmt.setLong(1, no);

	    rs = pstmt.executeQuery();

	    while (rs.next()) {

	        // 최초 1번만 FoodVO 생성
	        if (vo == null) {
	            vo = new FoodVO();
	            vo.setNo(rs.getLong("no"));
	            vo.setName(rs.getString("name"));
	            vo.setExpiryDate(rs.getString("expiryDate"));
	            vo.setQuantity(rs.getLong("quantity"));
	            vo.setStorageType(rs.getString("storageType"));
	            vo.setMemo(rs.getString("memo"));
	        }

	        // ⭐ 폴더 이름
	        String folderName = rs.getString("folderName");
	        if (folderName != null) {
	            folderList.add(folderName);
	        }

	        // ⭐ 폴더 번호 (핵심)
	        long folderNo = rs.getLong("folderNo");
	        if (!rs.wasNull()) {
	            folderNos.add(folderNo);
	        }
	    }

	    // ⭐ 세팅
	    if (vo != null) {
	        vo.setFolders(folderList);     // 이름 (출력용)
	        vo.setFolderNos(folderNos);   // 번호 (체크용)
	    }

	    DB.close(con, pstmt, rs);

	    return vo;
	}
	// 3. 식품 추가 + 폴더 매핑
	public Integer write(FoodVO vo) throws Exception {

	    Integer result = 0;

	    con = DB.getConnection();

	    // 1. 시퀀스 먼저 조회
	    String seqSql = "SELECT food_seq.NEXTVAL FROM dual";
	    pstmt = con.prepareStatement(seqSql);
	    rs = pstmt.executeQuery();
	    
	    long foodNo = 0;
	    if (rs.next()) {
	    	foodNo = rs.getLong(1);
	    }

        // 1️. 식품 등록
	    String sql = "INSERT INTO food (no, memberId, name, quantity, storageType, expiryDate, memo) "
	            + "VALUES (?, ?, ?, ?, ?, TO_DATE(?, 'yyyy-mm-dd'), ?)";

	    pstmt = con.prepareStatement(sql);

	    pstmt.setLong(1, foodNo);

        pstmt.setString(2, vo.getMemberId());
        pstmt.setString(3, vo.getName());
        pstmt.setLong(4, vo.getQuantity());
        pstmt.setString(5, vo.getStorageType());
        pstmt.setString(6, vo.getExpiryDate());
        pstmt.setString(7, vo.getMemo());

        result = pstmt.executeUpdate();


        // 2️. 폴더 매핑 (여러 개 가능)
        if (vo.getFolderNos() != null) {

            String mapSql = "INSERT INTO folder_food (no, folderNo, foodNo) "
                          + "VALUES (folder_food_seq.NEXTVAL, ?, ?)";

            pstmt = con.prepareStatement(mapSql);

            for (Long folderNo : vo.getFolderNos()) {
                pstmt.setLong(1, folderNo);
                pstmt.setLong(2, foodNo);
                pstmt.executeUpdate();
            }
        }

        DB.close(con, pstmt, rs);

	    return result;
	}
	
	// 4. 식품 수정
	public Integer update(FoodVO vo) throws Exception {

	    Integer result = 0;

	    con = DB.getConnection();

	    try {

	        // 1. food 테이블 수정
	        String sql = "UPDATE food SET "
	                + "name = ?, "
	                + "quantity = ?, "
	                + "storageType = ?, "
	                + "expiryDate = TO_DATE(?, 'yyyy-mm-dd'), "
	                + "memo = ?, "
	                + "updatedAt = SYSDATE "
	                + "WHERE no = ?";

	        pstmt = con.prepareStatement(sql);

	        pstmt.setString(1, vo.getName());
	        pstmt.setLong(2, vo.getQuantity());
	        pstmt.setString(3, vo.getStorageType());
	        pstmt.setString(4, vo.getExpiryDate());
	        pstmt.setString(5, vo.getMemo());
	        pstmt.setLong(6, vo.getNo());

	        result = pstmt.executeUpdate();

	        // 2. 기존 폴더 매핑 삭제
	        String deleteSql = "DELETE FROM folder_food WHERE foodNo = ?";
	        pstmt = con.prepareStatement(deleteSql);
	        pstmt.setLong(1, vo.getNo());
	        pstmt.executeUpdate();

	        // 3. 폴더 재등록
	        if (vo.getFolderNos() != null && !vo.getFolderNos().isEmpty()) {

	            String insertSql = "INSERT INTO folder_food (no, folderNo, foodNo) "
	                    + "VALUES (folder_food_seq.NEXTVAL, ?, ?)";

	            pstmt = con.prepareStatement(insertSql);

	            for (Long folderNo : vo.getFolderNos()) {
	                pstmt.setLong(1, folderNo);
	                pstmt.setLong(2, vo.getNo());
	                pstmt.executeUpdate();
	            }
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	        throw e;
	    } finally {
	        DB.close(con, pstmt);
	    }

	    return result;
	}
	
	// 5. 식품 삭제
	public Integer delete(Long no) throws Exception {

	    Integer result = 0;

	    con = DB.getConnection();

	    try {

	        // 1. 폴더 매핑 삭제
	        String mapSql = "DELETE FROM folder_food WHERE foodNo = ?";
	        pstmt = con.prepareStatement(mapSql);
	        pstmt.setLong(1, no);
	        pstmt.executeUpdate();

	        // 2. 식품 삭제
	        String sql = "DELETE FROM food WHERE no = ?";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setLong(1, no);

	        result = pstmt.executeUpdate();

	    } catch (Exception e) {
	        e.printStackTrace();
	        throw e;
	    } finally {
	        DB.close(con, pstmt);
	    }

	    return result;
	}

}
