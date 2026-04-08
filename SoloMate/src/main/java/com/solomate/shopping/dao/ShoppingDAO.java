package com.solomate.shopping.dao;

import java.util.ArrayList;
import java.util.List;

import com.solomate.main.dao.DAO;
import com.solomate.shopping.vo.ShoppingVO;
import com.solomate.util.db.DB;
import com.solomate.util.page.PageObject;

public class ShoppingDAO extends DAO {

	// 1. 장보기 리스트
	public List<ShoppingVO> list(ShoppingVO searchVO) throws Exception {

		List<ShoppingVO> list = new ArrayList<>();

		PageObject pageObject = searchVO.getPageObject();

		con = DB.getConnection();

		String sql = ""
				+ " select shopping_id, item_name, quantity, expected_price, "
				+ "        to_char(plan_date, 'yyyy-mm-dd') plan_date, "
				+ "        status, to_char(created_at, 'yyyy-mm-dd') created_at "
				+ " from ( "
				+ "   select rownum rnum, data.* "
				+ "   from ( "
				+ "     select shopping_id, item_name, quantity, expected_price, "
				+ "            plan_date, status, created_at "
				+ "     from shopping_plan "
				+ "     where is_deleted = 'N' "
				+ "       and member_id = ? "
				+ search(searchVO)
				+ "     order by shopping_id desc "
				+ "   ) data "
				+ " ) "
				+ " where rnum between ? and ? ";

		pstmt = con.prepareStatement(sql);

		int idx = 1;
		pstmt.setString(idx++, searchVO.getMemberId());
		idx = searchDataSet(pstmt, idx, searchVO);
		pstmt.setLong(idx++, pageObject.getStartRow());
		pstmt.setLong(idx++, pageObject.getEndRow());

		rs = pstmt.executeQuery();

		while (rs.next()) {
			ShoppingVO vo = new ShoppingVO();
			vo.setShoppingId(rs.getLong("shopping_id"));
			vo.setItemName(rs.getString("item_name"));
			vo.setQuantity(rs.getInt("quantity"));
			vo.setExpectedPrice(rs.getLong("expected_price"));
			vo.setPlanDate(rs.getString("plan_date"));
			vo.setStatus(rs.getString("status"));
			vo.setCreatedAt(rs.getString("created_at"));
			list.add(vo);
		}

		DB.close(con, pstmt, rs);

		return list;
	}

	// 2. 전체 데이터 개수
	public Long getTotalRow(ShoppingVO searchVO) throws Exception {

		Long totalRow = 0L;

		con = DB.getConnection();

		String sql = ""
				+ " select count(*) "
				+ " from shopping_plan "
				+ " where is_deleted = 'N' "
				+ "   and member_id = ? "
				+ search(searchVO);

		pstmt = con.prepareStatement(sql);

		int idx = 1;
		pstmt.setString(idx++, searchVO.getMemberId());
		idx = searchDataSet(pstmt, idx, searchVO);

		rs = pstmt.executeQuery();

		if (rs != null && rs.next()) {
			totalRow = rs.getLong(1);
		}

		DB.close(con, pstmt, rs);

		return totalRow;
	}

	// 3. 검색 SQL
	private String search(ShoppingVO searchVO) {

		String sql = "";

		if (searchVO.getStatus() != null && !searchVO.getStatus().trim().equals("")) {
			sql += " and status = ? ";
		}

		if (searchVO.getPlanDateSearch() != null && !searchVO.getPlanDateSearch().trim().equals("")) {
			sql += " and to_char(plan_date, 'yyyy-mm-dd') = ? ";
		}

		if (searchVO.getWord() != null && !searchVO.getWord().trim().equals("")) {
			sql += " and item_name like ? ";
		}

		return sql;
	}

	// 4. 검색 데이터 세팅
	private int searchDataSet(java.sql.PreparedStatement pstmt, int idx, ShoppingVO searchVO) throws Exception {

		if (searchVO.getStatus() != null && !searchVO.getStatus().trim().equals("")) {
			pstmt.setString(idx++, searchVO.getStatus());
		}

		if (searchVO.getPlanDateSearch() != null && !searchVO.getPlanDateSearch().trim().equals("")) {
			pstmt.setString(idx++, searchVO.getPlanDateSearch());
		}

		if (searchVO.getWord() != null && !searchVO.getWord().trim().equals("")) {
			pstmt.setString(idx++, "%" + searchVO.getWord() + "%");
		}

		return idx;
	}

	// 5. 장보기 상세보기
	public ShoppingVO view(Long shoppingId) throws Exception {

		ShoppingVO vo = null;

		con = DB.getConnection();

		String sql = ""
				+ " select sp.shopping_id, sp.member_id, sp.deal_id, sp.item_name, sp.quantity, sp.expected_price, "
				+ "        to_char(sp.plan_date, 'yyyy-mm-dd') plan_date, "
				+ "        sp.status, sp.source_type, sp.memo, "
				+ "        to_char(sp.created_at, 'yyyy-mm-dd') created_at, "
				+ "        to_char(sp.updated_at, 'yyyy-mm-dd') updated_at, "
				+ "        sp.is_deleted, hd.title hot_deal_title "
				+ " from shopping_plan sp "
				+ " left join hot_deal hd on sp.deal_id = hd.deal_id "
				+ " where sp.shopping_id = ? "
				+ "   and sp.is_deleted = 'N' ";

		pstmt = con.prepareStatement(sql);
		pstmt.setLong(1, shoppingId);

		rs = pstmt.executeQuery();

		if (rs != null && rs.next()) {
			vo = new ShoppingVO();
			vo.setShoppingId(rs.getLong("shopping_id"));
			vo.setMemberId(rs.getString("member_id"));

			long dealId = rs.getLong("deal_id");
			if (!rs.wasNull()) {
				vo.setDealId(dealId);
			}

			vo.setItemName(rs.getString("item_name"));
			vo.setQuantity(rs.getInt("quantity"));
			vo.setExpectedPrice(rs.getLong("expected_price"));
			vo.setPlanDate(rs.getString("plan_date"));
			vo.setStatus(rs.getString("status"));
			vo.setSourceType(rs.getString("source_type"));
			vo.setMemo(rs.getString("memo"));
			vo.setCreatedAt(rs.getString("created_at"));
			vo.setUpdatedAt(rs.getString("updated_at"));
			vo.setIsDeleted(rs.getString("is_deleted"));
			vo.setHotDealTitle(rs.getString("hot_deal_title"));
		}

		DB.close(con, pstmt, rs);

		return vo;
	}

	// 6. 장보기 등록
	public Integer write(ShoppingVO vo) throws Exception {

		Integer result = 0;

		con = DB.getConnection();

		String sql = ""
				+ " insert into shopping_plan "
				+ " (shopping_id, member_id, deal_id, item_name, quantity, expected_price, "
				+ "  plan_date, status, source_type, memo, created_at, is_deleted) "
				+ " values "
				+ " (seq_shopping_plan.nextval, ?, ?, ?, ?, ?, "
				+ "  to_date(?, 'yyyy-mm-dd'), 'PLANNED', ?, ?, sysdate, 'N') ";

		pstmt = con.prepareStatement(sql);

		int idx = 1;

		pstmt.setString(idx++, vo.getMemberId());

		if (vo.getDealId() == null) {
			pstmt.setNull(idx++, java.sql.Types.NUMERIC);
		} else {
			pstmt.setLong(idx++, vo.getDealId());
		}

		pstmt.setString(idx++, vo.getItemName());
		pstmt.setInt(idx++, vo.getQuantity());
		pstmt.setLong(idx++, vo.getExpectedPrice());
		pstmt.setString(idx++, vo.getPlanDate());
		pstmt.setString(idx++, vo.getSourceType());
		pstmt.setString(idx++, vo.getMemo());

		result = pstmt.executeUpdate();

		DB.close(con, pstmt);

		return result;
	}

	// 7. 장보기 수정
	public Integer update(ShoppingVO vo) throws Exception {

		Integer result = 0;

		con = DB.getConnection();

		String sql = ""
				+ " update shopping_plan "
				+ " set item_name = ?, "
				+ "     quantity = ?, "
				+ "     expected_price = ?, "
				+ "     plan_date = to_date(?, 'yyyy-mm-dd'), "
				+ "     status = ?, "
				+ "     memo = ?, "
				+ "     updated_at = sysdate "
				+ " where shopping_id = ? "
				+ "   and is_deleted = 'N' ";

		pstmt = con.prepareStatement(sql);

		int idx = 1;
		pstmt.setString(idx++, vo.getItemName());
		pstmt.setInt(idx++, vo.getQuantity());
		pstmt.setLong(idx++, vo.getExpectedPrice());
		pstmt.setString(idx++, vo.getPlanDate());
		pstmt.setString(idx++, vo.getStatus());
		pstmt.setString(idx++, vo.getMemo());
		pstmt.setLong(idx++, vo.getShoppingId());

		result = pstmt.executeUpdate();

		DB.close(con, pstmt);

		return result;
	}

	// 8. 장보기 삭제 (soft delete)
	public Integer delete(Long shoppingId) throws Exception {

		Integer result = 0;

		con = DB.getConnection();

		String sql = ""
				+ " update shopping_plan "
				+ " set is_deleted = 'Y', "
				+ "     updated_at = sysdate "
				+ " where shopping_id = ? ";

		pstmt = con.prepareStatement(sql);
		pstmt.setLong(1, shoppingId);

		result = pstmt.executeUpdate();

		DB.close(con, pstmt);

		return result;
	}

	// 9. 구매완료 처리
	public Integer complete(Long shoppingId) throws Exception {

		Integer result = 0;

		con = DB.getConnection();

		String sql = ""
				+ " update shopping_plan "
				+ " set status = 'PURCHASED', "
				+ "     updated_at = sysdate "
				+ " where shopping_id = ? "
				+ "   and is_deleted = 'N' ";

		pstmt = con.prepareStatement(sql);
		pstmt.setLong(1, shoppingId);

		result = pstmt.executeUpdate();

		DB.close(con, pstmt);

		return result;
	}

	// 10. 장보기 취소
	public Integer cancel(Long shoppingId) throws Exception {

		Integer result = 0;

		con = DB.getConnection();

		String sql = ""
				+ " update shopping_plan "
				+ " set status = 'CANCELED', "
				+ "     updated_at = sysdate "
				+ " where shopping_id = ? "
				+ "   and is_deleted = 'N' ";

		pstmt = con.prepareStatement(sql);
		pstmt.setLong(1, shoppingId);

		result = pstmt.executeUpdate();

		DB.close(con, pstmt);

		return result;
	}

	// 11. 핫딜에서 장보기 자동 추가
	public Integer addFromHotDeal(ShoppingVO vo) throws Exception {

		Integer result = 0;

		try {
			con = DB.getConnection();

			String checkSql = ""
					+ " select count(*) "
					+ " from shopping_plan "
					+ " where deal_id = ? "
					+ "   and member_id = ? "
					+ "   and is_deleted = 'N' ";

			pstmt = con.prepareStatement(checkSql);
			pstmt.setLong(1, vo.getDealId());
			pstmt.setString(2, vo.getMemberId());
			rs = pstmt.executeQuery();

			if (rs != null && rs.next() && rs.getInt(1) > 0) {
				DB.close(con, pstmt, rs);
				return 0;
			}

			DB.close(null, pstmt, rs);

			String insertSql = ""
					+ " insert into shopping_plan "
					+ " (shopping_id, member_id, deal_id, item_name, quantity, expected_price, "
					+ "  plan_date, status, source_type, memo, created_at, is_deleted) "
					+ " select seq_shopping_plan.nextval, ?, hd.deal_id, hd.title, 1, hd.price, "
					+ "        sysdate, 'PLANNED', 'HOTDEAL', null, sysdate, 'N' "
					+ " from hot_deal hd "
					+ " where hd.deal_id = ? ";

			pstmt = con.prepareStatement(insertSql);
			pstmt.setString(1, vo.getMemberId());
			pstmt.setLong(2, vo.getDealId());

			result = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			DB.close(con, pstmt, rs);
		}

		return result;
	}
}