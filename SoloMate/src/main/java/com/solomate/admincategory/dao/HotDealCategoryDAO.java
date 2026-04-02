package com.solomate.admincategory.dao;

import java.util.ArrayList;
import java.util.List;

import com.solomate.admincategory.vo.HotDealCategoryVO;
import com.solomate.main.dao.DAO;
import com.solomate.util.db.DB;

public class HotDealCategoryDAO extends DAO {

	// 리스트
	public List<HotDealCategoryVO> list() throws Exception {

		List<HotDealCategoryVO> list = new ArrayList<>();

		con = DB.getConnection();

		String sql = ""
				+ " select category_id, category_name, status, "
				+ "        to_char(created_at, 'yyyy-mm-dd') created_at "
				+ " from hot_deal_category "
				+ " where is_deleted = 'N' "
				+ " order by category_id asc ";

		pstmt = con.prepareStatement(sql);
		rs = pstmt.executeQuery();

		while (rs.next()) {
			HotDealCategoryVO vo = new HotDealCategoryVO();
			vo.setCategoryId(rs.getLong("category_id"));
			vo.setCategoryName(rs.getString("category_name"));
			vo.setStatus(rs.getString("status"));
			vo.setCreatedAt(rs.getString("created_at"));
			list.add(vo);
		}

		DB.close(con, pstmt, rs);
		return list;
	}

	// 등록
	public Integer write(HotDealCategoryVO vo) throws Exception {

		Integer result = 0;

		con = DB.getConnection();

		String sql = ""
				+ " insert into hot_deal_category "
				+ " (category_id, category_name, status, created_at, is_deleted) "
				+ " values (seq_hot_category.nextval, ?, ?, sysdate, 'N') ";

		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, vo.getCategoryName());
		pstmt.setString(2, vo.getStatus());

		result = pstmt.executeUpdate();

		DB.close(con, pstmt);
		return result;
	}

	// 수정
	public Integer update(HotDealCategoryVO vo) throws Exception {

		Integer result = 0;

		con = DB.getConnection();

		String sql = ""
				+ " update hot_deal_category "
				+ " set category_name = ?, "
				+ "     status = ?, "
				+ "     updated_at = sysdate "
				+ " where category_id = ? "
				+ "   and is_deleted = 'N' ";

		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, vo.getCategoryName());
		pstmt.setString(2, vo.getStatus());
		pstmt.setLong(3, vo.getCategoryId());

		result = pstmt.executeUpdate();

		DB.close(con, pstmt);
		return result;
	}

	// 삭제 (soft delete)
	public Integer delete(Long categoryId) throws Exception {

		Integer result = 0;

		con = DB.getConnection();

		String sql = ""
				+ " update hot_deal_category "
				+ " set is_deleted = 'Y', updated_at = sysdate "
				+ " where category_id = ? ";

		pstmt = con.prepareStatement(sql);
		pstmt.setLong(1, categoryId);

		result = pstmt.executeUpdate();

		DB.close(con, pstmt);
		return result;
	}

	// 상태 변경
	public Integer changeStatus(HotDealCategoryVO vo) throws Exception {

		Integer result = 0;

		con = DB.getConnection();

		String sql = ""
				+ " update hot_deal_category "
				+ " set status = ?, updated_at = sysdate "
				+ " where category_id = ? "
				+ "   and is_deleted = 'N' ";

		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, vo.getStatus());
		pstmt.setLong(2, vo.getCategoryId());

		result = pstmt.executeUpdate();

		DB.close(con, pstmt);
		return result;
	}
}