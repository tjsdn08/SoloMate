package com.solomate.main.controller;

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

	                if (loginVO != null) {
	                    // 여기서 에러가 발생하면 catch 블록으로 이동함
	                    Object[] summaryData = (Object[]) Execute.execute(
	                        Init.getService("/main/summary.do"),
	                        loginVO.getId()
	                    );
	                    request.setAttribute("recentRecipe",  summaryData[0]);
	                    request.setAttribute("recentTip",     summaryData[1]);
	                    request.setAttribute("expiringFoods", summaryData[2]);
	                    request.setAttribute("shoppingList",  summaryData[3]);
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