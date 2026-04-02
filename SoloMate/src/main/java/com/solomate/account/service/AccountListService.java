package com.solomate.account.service;

import com.solomate.account.dao.AccountDAO; // BoardDAO가 아니라 AccountDAO여야 함
import com.solomate.main.dao.DAO;
import com.solomate.main.service.Service;
import com.solomate.util.page.PageObject;

public class AccountListService implements Service {

    private AccountDAO dao = null; // 타입 변경
    
    @Override
    public void setDAO(DAO dao) {
        this.dao = (AccountDAO) dao; // AccountDAO로 캐스팅
    }

    @Override
    public Object service(Object obj) throws Exception {
    	Object[] args = (Object[]) obj;
        PageObject pageObject = (PageObject) args[0];
        String id = (String) args[1];

        // DAO의 list 메서드 호출 시 id 전달
        return dao.list(pageObject, id);
    }
}