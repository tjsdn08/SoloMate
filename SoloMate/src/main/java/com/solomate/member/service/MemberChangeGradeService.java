package com.solomate.member.service;

import com.solomate.main.dao.DAO;
import com.solomate.main.service.Service;
import com.solomate.member.dao.MemberDAO;
import com.solomate.member.vo.MemberVO;

public class MemberChangeGradeService implements Service {

	private MemberDAO dao = null;
	
	// Init에서 이미 생성된 dao를 전달해서 저장해 놓는다. - 서버가 시작될 때 : 코딩 필
	public void setDAO(DAO dao) {
		this.dao = (MemberDAO) dao;
	}

	@Override
	public Object service(Object obj) throws Exception {
		// TODO Auto-generated method stub
		return dao.changeGrade((MemberVO) obj);
	}

}
