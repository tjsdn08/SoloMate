package com.solomate.account.service;

import com.solomate.account.dao.AccountDAO;
import com.solomate.main.dao.DAO;
import com.solomate.main.service.Service;

public class AccountMonthlyStatusService implements Service {
    private AccountDAO dao;

    @Override
    public void setDAO(DAO dao) {
        this.dao = (AccountDAO) dao;
    }

    @Override
    public Object service(Object obj) throws Exception {
        // Controller에서 넘어온 Object[] {id, searchMonth}
        Object[] args = (Object[]) obj;
        String id = (String) args[0];
        String dateStr = (String) args[1]; // searchMonth 추출

        if (this.dao == null) {
            this.dao = new AccountDAO();
        }
        
        // DAO의 getMonthlyStats 호출
        return dao.getMonthlyStats(id, dateStr);
    }
}