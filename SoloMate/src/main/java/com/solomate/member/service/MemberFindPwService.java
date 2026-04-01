package com.solomate.member.service;

import com.solomate.main.dao.DAO;
import com.solomate.main.service.Service;
import com.solomate.member.dao.MemberDAO;
import com.solomate.member.vo.MemberVO;

public class MemberFindPwService implements Service {

	private MemberDAO dao = null;
	
	// Init에서 이미 생성된 dao를 전달해서 저장해 놓는다. - 서버가 시작될 때 : 코딩 필
	public void setDAO(DAO dao) {
		this.dao = (MemberDAO) dao;
	}

	// MemberFindPwService.java
	@Override
	public Object service(Object obj) throws Exception {
	    MemberVO vo = (MemberVO) obj;
	    
	    //DB에서 해당 정보로 연락처가 있는지 확인
	    String tel = dao.findTel(vo.getId(), vo.getName(), vo.getTel());
	    
	    if (tel != null) {
	        //정보가 일치한다면 비밀번호를 해당 연락처로 업데이트
	        dao.updatePw(vo.getId(), tel);
	        return tel; // 성공 시 연락처 문자열 반환
	    }
	    
	    return null; // 실패 시 null 반환
	}

}
