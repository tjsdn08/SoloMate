package com.solomate.folder.dao;

import java.util.ArrayList;
import java.util.List;

import com.solomate.folder.vo.FolderVO;
import com.solomate.main.dao.DAO;
import com.solomate.util.db.DB;
import com.solomate.util.page.PageObject;

public class FolderDAO extends DAO{
	
	// 전체 조회 (폼용)
	public List<FolderVO> listAll(String memberId) throws Exception {
	    List<FolderVO> list = new ArrayList<>();

	    con = DB.getConnection();

	    String sql = "SELECT no, name, TO_CHAR(createdAt, 'yyyy-mm-dd') createdAt FROM folder WHERE memberId = ? order by createdAt desc ";

	    pstmt = con.prepareStatement(sql);
	    pstmt.setString(1, "test"); // -> 나중엔 로그인값

	    rs = pstmt.executeQuery();

	    while(rs.next()) {
	        FolderVO vo = new FolderVO();
	        vo.setNo(rs.getLong("no"));
	        vo.setName(rs.getString("name"));
	        vo.setCreatedAt(rs.getString("createdAt"));
	        list.add(vo);
	    }

	    DB.close(con, pstmt, rs);

	    return list;
	}

}
