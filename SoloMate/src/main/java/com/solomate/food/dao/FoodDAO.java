package com.solomate.food.dao;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;

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
		
//		sql += search(pageObject);  검색처리
		sql += " order by expiryDate ";
		
		// 순서번호
		sql = "select rownum rnum, no, memberId, name, expiryDate, quantity, storageType from(" + sql + ")";
		// page에 맞는 데이터만 가져온다.
		sql = "select rnum, no, memberId, name, expiryDate, quantity, storageType from(" + sql + ") where rnum between ? and ?";
		
		pstmt = con.prepareStatement(sql);
		
		int idx = 1; //검색 처리
		
//		idx = searchDataSet(pstmt, idx, pageObject); 검색 처리
		// 아이디 하드코딩함. LoginVO loginvo를 받아야함. 
		pstmt.setString(idx++, "test");
		pstmt.setLong(idx++, pageObject.getStartRow()); // 검색처리시 수정해야댐
		pstmt.setLong(idx++, pageObject.getEndRow()); // 검색처리시 수정해야댐
		
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
//		sql += search(pageObject);
		
		// 4. 실행 객체 & 데이터 세팅
		pstmt = con.prepareStatement(sql);
		// 하드코딩
		pstmt.setString(1, "test");
		
		// - 검색 처리를 하면 데이터 세팅이 필요하다. ?가 생긴다.
		// 순서 번호의 변수 선언해서 사용한다.
//		int idx = 1;
		// 검색 데이터 세팅을 한다. - ?가 생길 수도 있다.
//		idx = searchDataSet(pstmt, idx, pageObject); // pstmt 데이터 메서드 안에서 변경하면 밖에서 변경된 상태 : 참조형 변수 - 주소 전달
		
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

	    con = DB.getConnection();

	    String sql = "SELECT "
	            + " f.no, f.name, TO_CHAR(f.expiryDate, 'yyyy-mm-dd') expiryDate, "
	            + " f.quantity, f.storageType, f.memo, "
	            + " fo.name AS folderName "
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

	        // 폴더는 여러 개일 수 있음 → 리스트에 추가
	        String folderName = rs.getString("folderName");
	        if (folderName != null) {
	            folderList.add(folderName);
	        }
	    }

	    // 폴더 리스트 세팅
	    if (vo != null) {
	        vo.setFolders(folderList);;
	    }

	    DB.close(con, pstmt, rs);

	    return vo;
	}

}
