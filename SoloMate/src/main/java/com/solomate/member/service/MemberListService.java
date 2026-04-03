package com.solomate.member.service;

import java.util.List;
import com.solomate.main.dao.DAO;
import com.solomate.main.service.Service;
import com.solomate.member.dao.MemberDAO;
import com.solomate.member.vo.MemberVO;
import com.solomate.util.page.PageObject;

public class MemberListService implements Service {

	private MemberDAO dao = null;
	
	public void setDAO(DAO dao) {
		this.dao = (MemberDAO) dao;
	}

	@Override
	public List<MemberVO> service(Object obj) throws Exception {
		PageObject pageObject = (PageObject) obj;
		
		pageObject.setTotalRow(dao.getTotalRow(pageObject));
		
		return dao.list(pageObject);
	}
}