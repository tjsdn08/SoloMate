package com.solomate.member.service;

import com.solomate.main.dao.DAO;
import com.solomate.main.service.Service;
import com.solomate.member.dao.MemberDAO;

public class MemberChangePwService implements Service {

    private MemberDAO dao;

    @Override
    public void setDAO(DAO dao) {
        this.dao = (MemberDAO) dao;
    }

    @Override
    public Object service(Object obj) throws Exception {
        Object[] objs = (Object[]) obj;
        String id = (String) objs[0];
        String pw = (String) objs[1];
        String newPw = (String) objs[2];

        return dao.changePw(id, pw, newPw);
    }
}