package com.solomate.recipes.service;

import com.solomate.main.dao.DAO;
import com.solomate.main.service.Service;
import com.solomate.recipes.dao.RecipesDAO;
import com.solomate.recipes.vo.RecipesVO;

public class RecipesViewService implements Service {

    private RecipesDAO dao;

    @Override
    public void setDAO(DAO dao) {
        this.dao = (RecipesDAO) dao;
    }

    @Override
    public RecipesVO service(Object obj) throws Exception {
        Object[] objs = (Object[]) obj;
        Long no = (Long) objs[0];
        String id = (String) objs[1]; 

        return dao.view(no, id);
    }
}