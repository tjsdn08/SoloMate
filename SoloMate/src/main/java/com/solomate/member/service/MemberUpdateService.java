package com.solomate.member.service;

import com.solomate.main.dao.DAO;
import com.solomate.main.service.Service;
import com.solomate.member.dao.MemberDAO;
import com.solomate.member.vo.MemberVO;

public class MemberUpdateService implements Service {

    private MemberDAO dao;

    @Override
    public void setDAO(DAO dao) {
        this.dao = (MemberDAO) dao;
    }

    @Override
    public Object service(Object obj) throws Exception {
        MemberVO vo = (MemberVO) obj;
        
        return dao.update(vo);
    }
}