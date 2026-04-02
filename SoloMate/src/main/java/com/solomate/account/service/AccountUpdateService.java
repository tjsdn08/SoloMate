package com.solomate.account.service;

import com.solomate.account.dao.AccountDAO;
import com.solomate.account.vo.AccountVO;
import com.solomate.main.dao.DAO;
import com.solomate.main.service.Service;

public class AccountUpdateService implements Service {
    private AccountDAO dao;
    
    @Override
    public void setDAO(DAO dao) {
        this.dao = (AccountDAO) dao;
    }

    @Override
    public Object service(Object obj) throws Exception {
        return dao.update((AccountVO) obj);
    }
}