package com.solomate.member.service;

import com.solomate.main.dao.DAO;
import com.solomate.main.service.Service;
import com.solomate.member.dao.MemberDAO;

public class MemberReactivateService implements Service {

    private MemberDAO dao;

    @Override
    public void setDAO(DAO dao) {
        this.dao = (MemberDAO) dao;
    }


    public Object service(Object obj) throws Exception{
    		return dao.reactivate((String) obj);
    }
}