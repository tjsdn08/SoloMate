package com.solomate.member.service;

import com.solomate.main.dao.DAO;
import com.solomate.main.service.Service;
import com.solomate.member.dao.MemberDAO;
import com.solomate.member.vo.LoginVO;

// Service 종류라고 하려면 반드시 Service를 상속 받아야만 한다.
public class LoginService implements Service{

	private MemberDAO dao = null;
	
	// Init에서 이미 생성된 dao를 전달해서 저장해 놓는다. - 서버가 시작될 때 : 코딩 필
	public void setDAO(DAO dao) {
		this.dao = (MemberDAO) dao;
	}

	@Override
	public Object service(Object obj) throws Exception {
	    LoginVO vo = (LoginVO) obj; 
	    
	    LoginVO loginVO = dao.login(vo);
	    
	    if (loginVO == null) {
	        throw new Exception("아이디나 비밀번호가 올바르지 않습니다.");
	    }
	    
	    return loginVO; 
	}


}
