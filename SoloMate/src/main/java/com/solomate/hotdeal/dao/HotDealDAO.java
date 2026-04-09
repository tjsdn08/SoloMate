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
		if ("endSoon".equals(searchVO.getSort())) {
			orderSql = " order by hd.end_date asc, hd.created_at desc ";
		}

		String sql = ""
				+ " select deal_id, category_name, title, price, original_price, discount_rate, "
				+ "        image_url, shop_name, end_date, view_count, created_at, added_to_shopping "
				+ " from ( "
				+ "   select rownum rnum, data.* "
				+ "   from ( "
				+ "     select hd.deal_id, c.category_name, hd.title, hd.price, hd.original_price, "
				+ "            case "
				+ "              when hd.original_price is null or hd.original_price = 0 then 0 "
				+ "              else round((hd.original_price - hd.price) * 100 / hd.original_price) "
				+ "            end as discount_rate, "
				+ "            hd.image_url, hd.shop_name, "
				+ "            to_char(hd.end_date, 'yyyy-mm-dd') end_date, "
				+ "            hd.view_count, to_char(hd.created_at, 'yyyy-mm-dd') created_at, "
				+ "            case "
				+ "              when exists ( "
				+ "                select 1 "
				+ "                from shopping_plan sp "
				+ "                where sp.deal_id = hd.deal_id "
				+ "                  and sp.is_deleted = 'N' "
				+ "                  and sp.member_id = ? "
				+ "              ) then 'Y' "
				+ "              else 'N' "
				+ "            end as added_to_shopping "
				+ "     from hot_deal hd "
				+ "     join hot_deal_category c on hd.category_id = c.category_id "
				+ "     where hd.is_deleted = 'N' "
				+ "       and c.is_deleted = 'N' "
				+ "       and c.status = 'ACTIVE' "
				+ "       and hd.status = 'ACTIVE' "
				+ search(searchVO)
				+ orderSql
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
			vo.setAddedToShopping(rs.getString("added_to_shopping"));
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
				+ "   and c.status = 'ACTIVE' "
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

	private int searchDataSet(java.sql.PreparedStatement pstmt, int idx, HotDealVO searchVO) throws Exception {

		if (searchVO.getCategoryId() != null) {
			pstmt.setLong(idx++, searchVO.getCategoryId());
		}

		if (searchVO.getWord() != null && !searchVO.getWord().trim().equals("")) {
			pstmt.setString(idx++, "%" + searchVO.getWord() + "%");
		}

		return idx;
	}

	// 3. 조회수 증가
	public Integer increase(Long dealId) throws Exception {

		Integer result = 0;

		con = DB.getConnection();

		String sql = ""
				+ " update hot_deal "
				+ " set view_count = nvl(view_count, 0) + 1 "
				+ " where deal_id = ? "
				+ "   and is_deleted = 'N' ";

		pstmt = con.prepareStatement(sql);
		pstmt.setLong(1, dealId);

		result = pstmt.executeUpdate();

		DB.close(con, pstmt);

		return result;
	}

	// 4. 핫딜 상세보기
	public HotDealVO view(HotDealVO paramVO) throws Exception {

		HotDealVO vo = null;

		con = DB.getConnection();

		String sql = ""
				+ " select hd.deal_id, hd.category_id, c.category_name, hd.title, "
				+ "        hd.price, hd.original_price, "
				+ "        case "
				+ "          when hd.original_price is null or hd.original_price = 0 then 0 "
				+ "          else round((hd.original_price - hd.price) * 100 / hd.original_price) "
				+ "        end as discount_rate, "
				+ "        hd.image_url, hd.shop_name, hd.seller_name, hd.deal_url, hd.description, "
				+ "        to_char(hd.end_date, 'yyyy-mm-dd') end_date, "
				+ "        hd.view_count, hd.status, "
				+ "        to_char(hd.created_at, 'yyyy-mm-dd') created_at, "
				+ "        to_char(hd.updated_at, 'yyyy-mm-dd') updated_at, "
				+ "        hd.is_deleted, "
				+ "        case "
				+ "          when exists ( "
				+ "            select 1 "
				+ "            from shopping_plan sp "
				+ "            where sp.deal_id = hd.deal_id "
				+ "              and sp.is_deleted = 'N' "
				+ "              and sp.member_id = ? "
				+ "          ) then 'Y' "
				+ "          else 'N' "
				+ "        end as added_to_shopping "
				+ " from hot_deal hd "
				+ " join hot_deal_category c on hd.category_id = c.category_id "
				+ " where hd.deal_id = ? "
				+ "   and hd.is_deleted = 'N' "
				+ "   and c.is_deleted = 'N' "
				+ "   and c.status = 'ACTIVE' ";

		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, paramVO.getMemberId());
		pstmt.setLong(2, paramVO.getDealId());

		rs = pstmt.executeQuery();

		if (rs != null && rs.next()) {
			vo = new HotDealVO();
			vo.setDealId(rs.getLong("deal_id"));
			vo.setCategoryId(rs.getLong("category_id"));
			vo.setCategoryName(rs.getString("category_name"));
			vo.setTitle(rs.getString("title"));
			vo.setPrice(rs.getLong("price"));
			vo.setOriginalPrice(rs.getLong("original_price"));
			vo.setDiscountRate(rs.getDouble("discount_rate"));
			vo.setImageUrl(rs.getString("image_url"));
			vo.setShopName(rs.getString("shop_name"));
			vo.setSellerName(rs.getString("seller_name"));
			vo.setDealUrl(rs.getString("deal_url"));
			vo.setDescription(rs.getString("description"));
			vo.setEndDate(rs.getString("end_date"));
			vo.setViewCount(rs.getLong("view_count"));
			vo.setStatus(rs.getString("status"));
			vo.setCreatedAt(rs.getString("created_at"));
			vo.setUpdatedAt(rs.getString("updated_at"));
			vo.setIsDeleted(rs.getString("is_deleted"));
			vo.setAddedToShopping(rs.getString("added_to_shopping"));
		}

		DB.close(con, pstmt, rs);

		return vo;
	}

	// 관리자 리스트
	public List<HotDealVO> adminList(HotDealVO searchVO) throws Exception {

		List<HotDealVO> list = new ArrayList<>();
		PageObject pageObject = searchVO.getPageObject();

		con = DB.getConnection();

		String sql = ""
				+ " select deal_id, category_name, title, price, discount_rate, shop_name, "
				+ "        status, created_at "
				+ " from ( "
				+ "   select rownum rnum, data.* "
				+ "   from ( "
				+ "     select hd.deal_id, c.category_name, hd.title, hd.price, "
				+ "            case "
				+ "              when hd.original_price is null or hd.original_price = 0 then 0 "
				+ "              else round((hd.original_price - hd.price) * 100 / hd.original_price) "
				+ "            end as discount_rate, "
				+ "            hd.shop_name, hd.status, to_char(hd.created_at, 'yyyy-mm-dd') created_at "
				+ "     from hot_deal hd "
				+ "     join hot_deal_category c on hd.category_id = c.category_id "
				+ "     where hd.is_deleted = 'N' "
				+ adminSearch(searchVO)
				+ "     order by hd.deal_id desc "
				+ "   ) data "
				+ " ) "
				+ " where rnum between ? and ? ";

		pstmt = con.prepareStatement(sql);

		int idx = 1;
		idx = adminSearchDataSet(pstmt, idx, searchVO);
		pstmt.setLong(idx++, pageObject.getStartRow());
		pstmt.setLong(idx++, pageObject.getEndRow());

		rs = pstmt.executeQuery();

		while (rs.next()) {
			HotDealVO vo = new HotDealVO();
			vo.setDealId(rs.getLong("deal_id"));
			vo.setCategoryName(rs.getString("category_name"));
			vo.setTitle(rs.getString("title"));
			vo.setPrice(rs.getLong("price"));
			vo.setDiscountRate(rs.getDouble("discount_rate"));
			vo.setShopName(rs.getString("shop_name"));
			vo.setStatus(rs.getString("status"));
			vo.setCreatedAt(rs.getString("created_at"));
			list.add(vo);
		}

		DB.close(con, pstmt, rs);
		return list;
	}

	public Long getAdminTotalRow(HotDealVO searchVO) throws Exception {

		Long totalRow = 0L;

		con = DB.getConnection();

		String sql = ""
				+ " select count(*) "
				+ " from hot_deal hd "
				+ " where hd.is_deleted = 'N' "
				+ adminSearch(searchVO);

		pstmt = con.prepareStatement(sql);

		int idx = 1;
		idx = adminSearchDataSet(pstmt, idx, searchVO);

		rs = pstmt.executeQuery();

		if (rs != null && rs.next()) {
			totalRow = rs.getLong(1);
		}

		DB.close(con, pstmt, rs);
		return totalRow;
	}

	public HotDealVO adminView(Long dealId) throws Exception {

		HotDealVO vo = null;

		con = DB.getConnection();

		String sql = ""
				+ " select hd.deal_id, hd.category_id, c.category_name, hd.title, hd.price, "
				+ "        hd.original_price, "
				+ "        case "
				+ "          when hd.original_price is null or hd.original_price = 0 then 0 "
				+ "          else round((hd.original_price - hd.price) * 100 / hd.original_price) "
				+ "        end as discount_rate, "
				+ "        hd.image_url, hd.shop_name, "
				+ "        hd.seller_name, hd.deal_url, hd.description, "
				+ "        to_char(hd.end_date, 'yyyy-mm-dd') end_date, "
				+ "        hd.view_count, hd.status, "
				+ "        to_char(hd.created_at, 'yyyy-mm-dd') created_at, "
				+ "        to_char(hd.updated_at, 'yyyy-mm-dd') updated_at "
				+ " from hot_deal hd "
				+ " join hot_deal_category c on hd.category_id = c.category_id "
				+ " where hd.deal_id = ? "
				+ "   and hd.is_deleted = 'N' ";

		pstmt = con.prepareStatement(sql);
		pstmt.setLong(1, dealId);

		rs = pstmt.executeQuery();

		if (rs != null && rs.next()) {
			vo = new HotDealVO();
			vo.setDealId(rs.getLong("deal_id"));
			vo.setCategoryId(rs.getLong("category_id"));
			vo.setCategoryName(rs.getString("category_name"));
			vo.setTitle(rs.getString("title"));
			vo.setPrice(rs.getLong("price"));
			vo.setOriginalPrice(rs.getLong("original_price"));
			vo.setDiscountRate(rs.getDouble("discount_rate"));
			vo.setImageUrl(rs.getString("image_url"));
			vo.setShopName(rs.getString("shop_name"));
			vo.setSellerName(rs.getString("seller_name"));
			vo.setDealUrl(rs.getString("deal_url"));
			vo.setDescription(rs.getString("description"));
			vo.setEndDate(rs.getString("end_date"));
			vo.setViewCount(rs.getLong("view_count"));
			vo.setStatus(rs.getString("status"));
			vo.setCreatedAt(rs.getString("created_at"));
			vo.setUpdatedAt(rs.getString("updated_at"));
		}

		DB.close(con, pstmt, rs);
		return vo;
	}

	public Integer write(HotDealVO vo) throws Exception {

		Integer result = 0;

		con = DB.getConnection();

		String sql = ""
				+ " insert into hot_deal "
				+ " (deal_id, category_id, title, price, original_price, "
				+ "  image_url, shop_name, seller_name, deal_url, description, end_date, "
				+ "  view_count, status, created_at, is_deleted) "
				+ " values "
				+ " (seq_hot_deal.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?, "
				+ "  to_date(?, 'yyyy-mm-dd'), 0, ?, sysdate, 'N') ";

		pstmt = con.prepareStatement(sql);

		int idx = 1;
		pstmt.setLong(idx++, vo.getCategoryId());
		pstmt.setString(idx++, vo.getTitle());
		pstmt.setLong(idx++, vo.getPrice());
		pstmt.setLong(idx++, vo.getOriginalPrice());
		pstmt.setString(idx++, vo.getImageUrl());
		pstmt.setString(idx++, vo.getShopName());
		pstmt.setString(idx++, vo.getSellerName());
		pstmt.setString(idx++, vo.getDealUrl());
		pstmt.setString(idx++, vo.getDescription());
		pstmt.setString(idx++, vo.getEndDate());
		pstmt.setString(idx++, vo.getStatus());

		result = pstmt.executeUpdate();

		DB.close(con, pstmt);
		return result;
	}

	public Integer update(HotDealVO vo) throws Exception {

		Integer result = 0;

		con = DB.getConnection();

		String sql = ""
				+ " update hot_deal "
				+ " set category_id = ?, "
				+ "     title = ?, "
				+ "     price = ?, "
				+ "     original_price = ?, "
				+ "     image_url = ?, "
				+ "     shop_name = ?, "
				+ "     seller_name = ?, "
				+ "     deal_url = ?, "
				+ "     description = ?, "
				+ "     end_date = to_date(?, 'yyyy-mm-dd'), "
				+ "     status = ?, "
				+ "     updated_at = sysdate "
				+ " where deal_id = ? "
				+ "   and is_deleted = 'N' ";

		pstmt = con.prepareStatement(sql);

		int idx = 1;
		pstmt.setLong(idx++, vo.getCategoryId());
		pstmt.setString(idx++, vo.getTitle());
		pstmt.setLong(idx++, vo.getPrice());
		pstmt.setLong(idx++, vo.getOriginalPrice());
		pstmt.setString(idx++, vo.getImageUrl());
		pstmt.setString(idx++, vo.getShopName());
		pstmt.setString(idx++, vo.getSellerName());
		pstmt.setString(idx++, vo.getDealUrl());
		pstmt.setString(idx++, vo.getDescription());
		pstmt.setString(idx++, vo.getEndDate());
		pstmt.setString(idx++, vo.getStatus());
		pstmt.setLong(idx++, vo.getDealId());

		result = pstmt.executeUpdate();

		DB.close(con, pstmt);
		return result;
	}

	public Integer delete(Long dealId) throws Exception {

		Integer result = 0;

		con = DB.getConnection();

		String sql = ""
				+ " update hot_deal "
				+ " set is_deleted = 'Y', updated_at = sysdate "
				+ " where deal_id = ? ";

		pstmt = con.prepareStatement(sql);
		pstmt.setLong(1, dealId);

		result = pstmt.executeUpdate();

		DB.close(con, pstmt);
		return result;
	}

	public Integer changeStatus(HotDealVO vo) throws Exception {

		Integer result = 0;

		con = DB.getConnection();

		String sql = ""
				+ " update hot_deal "
				+ " set status = ?, updated_at = sysdate "
				+ " where deal_id = ? "
				+ "   and is_deleted = 'N' ";

		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, vo.getStatus());
		pstmt.setLong(2, vo.getDealId());

		result = pstmt.executeUpdate();

		DB.close(con, pstmt);
		return result;
	}

	private String adminSearch(HotDealVO vo) {
		String sql = "";

		if (vo.getCategoryId() != null)
			sql += " and hd.category_id = ? ";
		if (vo.getStatus() != null && !vo.getStatus().trim().equals(""))
			sql += " and hd.status = ? ";
		if (vo.getWord() != null && !vo.getWord().trim().equals(""))
			sql += " and hd.title like ? ";

		return sql;
	}

	private int adminSearchDataSet(java.sql.PreparedStatement pstmt, int idx, HotDealVO vo) throws Exception {

		if (vo.getCategoryId() != null)
			pstmt.setLong(idx++, vo.getCategoryId());
		if (vo.getStatus() != null && !vo.getStatus().trim().equals(""))
			pstmt.setString(idx++, vo.getStatus());
		if (vo.getWord() != null && !vo.getWord().trim().equals(""))
			pstmt.setString(idx++, "%" + vo.getWord() + "%");

		return idx;
	}
}