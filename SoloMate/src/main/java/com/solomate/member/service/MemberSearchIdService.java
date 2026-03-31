package com.solomate.member.service;

import com.solomate.main.dao.DAO;
import com.solomate.main.service.Service;
import com.solomate.member.dao.MemberDAO;
import com.solomate.member.vo.MemberVO;

public class MemberSearchIdService implements Service {

    private MemberDAO dao;

    // Init에서 주입받는 setter
    @Override
    public void setDAO(DAO dao) {
        this.dao = (MemberDAO) dao;
    }

    @Override
    public Object service(Object obj) throws Exception {
        return dao.searchId((MemberVO) obj);
    }
}