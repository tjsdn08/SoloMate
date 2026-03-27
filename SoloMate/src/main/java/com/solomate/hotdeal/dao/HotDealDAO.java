package com.solomate.hotdeal.dao;

import java.util.ArrayList;
import java.util.List;

import com.solomate.hotdeal.vo.HotDealVO;
import com.solomate.main.dao.DAO;
import com.solomate.util.db.DB;
import com.solomate.util.page.PageObject;

public class HotDealDAO extends DAO {

	// 1. 핫딜 리스트
	public List<HotDealVO> list(HotDealVO searchVO) throws Exception {

		List<HotDealVO> list = new ArrayList<>();

		PageObject pageObject = searchVO.getPageObject();

		con = DB.getConnection();

		String orderSql = " order by hd.created_at desc ";
		if ("popular".equals(searchVO.getSort())) {
			orderSql = " order by hd.view_count desc, hd.deal_id desc ";
		}

		String sql = ""
				+ " select deal_id, category_name, title, price, original_price, discount_rate, "
				+ "        image_url, shop_name, end_date, view_count, created_at "
				+ " from ( "
				+ "   select rownum rnum, data.* "
				+ "   from ( "
				+ "     select hd.deal_id, c.category_name, hd.title, hd.price, hd.original_price, "
				+ "            hd.discount_rate, hd.image_url, hd.shop_name, "
				+ "            to_char(hd.end_date, 'yyyy-mm-dd') end_date, "
				+ "            hd.view_count, to_char(hd.created_at, 'yyyy-mm-dd') created_at "
				+ "     from hot_deal hd "
				+ "     join hot_deal_category c on hd.category_id = c.category_id "
				+ "     where hd.is_deleted = 'N' "
				+ "       and c.is_deleted = 'N' "
				+ "       and hd.status = 'ACTIVE' "
				+ search(searchVO)
				+ orderSql
				+ "   ) data "
				+ " ) "
				+ " where rnum between ? and ? ";

		pstmt = con.prepareStatement(sql);

		int idx = 1;
		idx = searchDataSet(pstmt, idx, searchVO);

		pstmt.setLong(idx++, pageObject.getStartRow());
		pstmt.setLong(idx++, pageObject.getEndRow());

		rs = pstmt.executeQuery();

		while (rs.next()) {
			HotDealVO vo = new HotDealVO();
			vo.setDealId(rs.getLong("deal_id"));
			vo.setCategoryName(rs.getString("category_name"));
			vo.setTitle(rs.getString("title"));
			vo.setPrice(rs.getLong("price"));
			vo.setOriginalPrice(rs.getLong("original_price"));
			vo.setDiscountRate(rs.getDouble("discount_rate"));
			vo.setImageUrl(rs.getString("image_url"));
			vo.setShopName(rs.getString("shop_name"));
			vo.setEndDate(rs.getString("end_date"));
			vo.setViewCount(rs.getLong("view_count"));
			vo.setCreatedAt(rs.getString("created_at"));
			list.add(vo);
		}

		DB.close(con, pstmt, rs);

		return list;
	}

	// 2. 전체 데이터 개수
	public Long getTotalRow(HotDealVO searchVO) throws Exception {

		Long totalRow = 0L;

		con = DB.getConnection();

		String sql = ""
				+ " select count(*) "
				+ " from hot_deal hd "
				+ " join hot_deal_category c on hd.category_id = c.category_id "
				+ " where hd.is_deleted = 'N' "
				+ "   and c.is_deleted = 'N' "
				+ "   and hd.status = 'ACTIVE' "
				+ search(searchVO);

		pstmt = con.prepareStatement(sql);

		int idx = 1;
		idx = searchDataSet(pstmt, idx, searchVO);

		rs = pstmt.executeQuery();

		if (rs != null && rs.next()) {
			totalRow = rs.getLong(1);
		}

		DB.close(con, pstmt, rs);

		return totalRow;
	}

	// 3. 검색 SQL
	private String search(HotDealVO searchVO) {

		String sql = "";

		if (searchVO.getCategoryId() != null) {
			sql += " and hd.category_id = ? ";
		}

		if (searchVO.getWord() != null && !searchVO.getWord().trim().equals("")) {
			sql += " and hd.title like ? ";
		}

		return sql;
	}

	// 4. 검색 데이터 세팅
	private int searchDataSet(java.sql.PreparedStatement pstmt, int idx, HotDealVO searchVO) throws Exception {

		if (searchVO.getCategoryId() != null) {
			pstmt.setLong(idx++, searchVO.getCategoryId());
		}

		if (searchVO.getWord() != null && !searchVO.getWord().trim().equals("")) {
			pstmt.setString(idx++, "%" + searchVO.getWord() + "%");
		}

		return idx;
	}
}