package com.solomate.recipes.service;

import com.solomate.main.dao.DAO;
import com.solomate.main.service.Service;
import com.solomate.recipes.dao.RecipesDAO;

public class RecipesViewService implements Service {

    private RecipesDAO dao;

    @Override
    public void setDAO(DAO dao) {
        this.dao = (RecipesDAO) dao;
    }

    @Override
    public Object service(Object obj) throws Exception {
        Object[] objs = (Object[]) obj;
        Long no = (Long) objs[0];
        return dao.view(no);
    }
}