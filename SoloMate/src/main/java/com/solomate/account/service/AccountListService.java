package com.solomate.account.service;

import com.solomate.account.dao.AccountDAO;
import com.solomate.main.dao.DAO;
import com.solomate.main.service.Service;
import com.solomate.util.page.PageObject;

public class AccountListService implements Service {

    private AccountDAO dao = null;
    
    @Override
    public void setDAO(DAO dao) {
        this.dao = (AccountDAO) dao;
    }

    @Override
    public Object service(Object obj) throws Exception {
        Object[] args = (Object[]) obj;
        PageObject pageObject = (PageObject) args[0];
        String id = (String) args[1];

        // [이 코드가 핵심!] DB에서 로그인한 사용자의 전체 데이터 개수를 가져옵니다.
        // 이 한 줄이 실행되어야 JSP에서 '1 2' 같은 페이지 번호가 계산됩니다.
        long totalRow = dao.getTotalRow(pageObject, id); 
        pageObject.setTotalRow(totalRow); 

        // 콘솔에 숫자가 11이라고 찍히는지 확인해보세요.
        System.out.println("가계부 전체 데이터 개수: " + totalRow);

        // 이제 계산된 정보를 가지고 리스트를 가져옵니다.
        return dao.list(pageObject, id);
    }
}