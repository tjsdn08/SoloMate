package com.solomate.main.controller;

import com.solomate.main.dao.MainDAO;
import com.solomate.main.service.Execute;
import com.solomate.member.vo.LoginVO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class MainController implements Controller {

	public String execute(HttpServletRequest request) {
	    request.setAttribute("url", request.getRequestURL());
	    try {
	        String uri = request.getServletPath();
	        switch (uri) {
	        case "/main/main.do":
	            HttpSession session = request.getSession();
	            LoginVO loginVO = (LoginVO) session.getAttribute("login");

	            MainDAO mainDao = new com.solomate.main.dao.MainDAO();
	            request.setAttribute("topHotDeals", mainDao.getTopHotDeals()); 

	            if (loginVO != null) {
	                Object[] summaryData = (Object[]) Execute.execute(
	                    Init.getService("/main/summary.do"),
	                    loginVO.getId()
	                );
	                request.setAttribute("recentRecipe",   summaryData[0]);
	                request.setAttribute("recentTip",      summaryData[1]);
	                request.setAttribute("expiringFoods",  summaryData[2]);
	                request.setAttribute("shoppingList",   summaryData[3]);
	                request.setAttribute("totalExpense",   summaryData[4]); 
	                request.setAttribute("ingredientNames", summaryData[5]); 
	                request.setAttribute("fridgeRecipes",   summaryData[6]); 
	                request.setAttribute("chartData",      summaryData[7]); 
	            }
	            return "main/main";

	            default:
	                return "error/noPage";
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        request.setAttribute("exception", e);
	        return "error/errorPage";
	    }
	}
}