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

	            // 1. 핫딜은 로그인과 무관하게 무조건 가져오자
	            MainDAO mainDao = new com.solomate.main.dao.MainDAO();
	            request.setAttribute("topHotDeals", mainDao.getTopHotDeals()); 

	            // 2. 로그인 한 경우에만 나머지 개인 데이터를 가져옵니다.
	            if (loginVO != null) {
	                Object[] summaryData = (Object[]) Execute.execute(
	                    Init.getService("/main/summary.do"),
	                    loginVO.getId()
	                );
	                request.setAttribute("recentRecipe",  summaryData[0]);
	                request.setAttribute("recentTip",     summaryData[1]);
	                request.setAttribute("expiringFoods", summaryData[2]);
	                request.setAttribute("shoppingList",  summaryData[3]);
	                request.setAttribute("totalExpense",  summaryData[4]); 
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