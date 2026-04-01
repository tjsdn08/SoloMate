package com.solomate.folder.dao;

import java.util.ArrayList;
import java.util.List;

import com.solomate.folder.vo.FolderVO;
import com.solomate.food.dao.FoodDAO;
import com.solomate.food.vo.FoodVO;
import com.solomate.main.dao.DAO;
import com.solomate.util.db.DB;
import com.solomate.util.page.PageObject;

public class FolderDAO extends DAO{
	
	// 전체 조회 (폼용) food - writeform updateform
	public List<FolderVO> listAll(String memberId) throws Exception {
	    List<FolderVO> list = new ArrayList<>();

	    con = DB.getConnection();

	    String sql = "SELECT no, name, TO_CHAR(createdAt, 'yyyy-mm-dd') createdAt FROM folder WHERE memberId = ? order by createdAt desc ";

	    pstmt = con.prepareStatement(sql);
	    pstmt.setString(1, "test"); // -> 나중엔 로그인값

	    rs = pstmt.executeQuery();

		if(rs != null) {
		    while(rs.next()) {
		        FolderVO vo = new FolderVO();
		        vo.setNo(rs.getLong("no"));
		        vo.setName(rs.getString("name"));
		        vo.setCreatedAt(rs.getString("createdAt"));
		        list.add(vo);
		    }
		}

	    DB.close(con, pstmt, rs);

	    return list;
	}
	
	// 폴더 상세 보기
	public FolderVO view(Long no) throws Exception {

	    FolderVO folder = null;
	    List<FoodVO> foods = new ArrayList<>();

	    con = DB.getConnection();

	    try {
	        String sql = "select "
	                + "f.no as folderNo, "
	                + "f.name as folderName, "
	                + "TO_CHAR(f.createdAt, 'yyyy-mm-dd') createdAt, "
	                + "fo.no as foodNo, "
	                + "fo.name as foodName, "
	                + "fo.quantity, "
	                + "fo.storageType, "
	                + "TO_CHAR(fo.expiryDate, 'yyyy-mm-dd') expiryDate "
	                + "from folder f "
	                + "left join folder_food ff on f.no = ff.folderNo "
	                + "left join food fo on ff.foodNo = fo.no "
	                + "where f.no = ?";

	        pstmt = con.prepareStatement(sql);
	        pstmt.setLong(1, no);
	        rs = pstmt.executeQuery();

	        while (rs.next()) {

	            // 🔹 folder는 한 번만 생성
	            if (folder == null) {
	                folder = new FolderVO();
	                folder.setNo(rs.getLong("folderNo"));
	                folder.setName(rs.getString("folderName"));
	                folder.setCreatedAt(rs.getString("createdAt"));
	            }

	            // 🔹 food가 존재할 때만 생성
	            Long foodNo = rs.getLong("foodNo");
	            if (!rs.wasNull()) {
	                FoodVO food = new FoodVO();
	                food.setNo(foodNo);
	                food.setName(rs.getString("foodName"));
	                food.setQuantity(rs.getInt("quantity"));
	                food.setStorageType(rs.getString("storageType"));
	                food.setExpiryDate(rs.getString("expiryDate"));
	                food.setdDay(FoodDAO.getDday(rs.getString("expiryDate"))); // dDay 계산

	                foods.add(food);
	            }
	        }

	        if (folder != null) {
	            folder.setFoods(foods);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	        throw e;
	    } finally {
	        if (rs != null) rs.close();
	        if (pstmt != null) pstmt.close();
	    }

	    return folder;
	}
	
	// 폴더 목록 보기
	public List<FolderVO> list(PageObject pageObject) throws Exception {
		List<FolderVO> list = new ArrayList<>();
		
		con = DB.getConnection();
		
		String sql = "SELECT no, name, TO_CHAR(createdAt, 'yyyy-mm-dd') createdAt FROM folder WHERE memberId = ? order by createdAt desc ";
		
		sql = "SELECT rownum rnum, no, name, createdAt "
				+ " FROM(" + sql + ")";
		sql = "SELECT rnum, no, name, createdAt "
				+ " FROM(" + sql + ") where rnum between ? and ?";
		
		// 4. 
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, pageObject.getAccepter()); // -> 나중엔 로그인값!!!!!!!
		pstmt.setLong(2, pageObject.getStartRow());
		pstmt.setLong(3, pageObject.getEndRow());
		
		rs = pstmt.executeQuery();
		
		if(rs != null) {
			while(rs.next()) {
				FolderVO vo = new FolderVO();
				vo.setNo(rs.getLong("no"));
				vo.setName(rs.getString("name"));
				vo.setCreatedAt(rs.getString("createdAt"));
				list.add(vo);
			}
		}
		
		DB.close(con, pstmt, rs);
		
		return list;
	}
	
	// 1-1. 폴더 목록 보기에서 글의 개수
	public Long getTotalRow(PageObject pageObject) throws Exception{
		
		Long totalRow = 0L;
		
		con = DB.getConnection();
		
		String sql = "select count(*) from folder where memberId = ? ";
		
		// 검색 처리를 한다. -> list()의 검색 처리와 같다. -> 반복이 된다. 메서드를 만든다.
		// sql += search(pageObject);
		
		// 4. 실행 객체 & 데이터 세팅
		pstmt = con.prepareStatement(sql);
		// 하드코딩 !!!!!!!!
		pstmt.setString(1, pageObject.getAccepter());
		
		// - 검색 처리를 하면 데이터 세팅이 필요하다. ?가 생긴다.
		// 순서 번호의 변수 선언해서 사용한다.
		// int idx = 1;
		// 검색 데이터 세팅을 한다. - ?가 생길 수도 있다.
		// idx = searchDataSet(pstmt, idx, pageObject); // pstmt 데이터 메서드 안에서 변경하면 밖에서 변경된 상태 : 참조형 변수 - 주소 전달
		
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
	
	// 폴더 상세 보기
	
	
	
	// 폴더 등록
	public Integer write(FolderVO vo) throws Exception {
		Integer result = 0;
		
		con = DB.getConnection();
		
		String sql = "insert into folder(no, memberId, name, createdAt, updatedAt) values(folder_seq.nextval, ?, ?, sysdate, sysdate)";
		
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, vo.getMemberId());
		pstmt.setString(2, vo.getName());
		
		result = pstmt.executeUpdate();
		
		DB.close(con, pstmt);
		
		return result;
		
	}
	

}
