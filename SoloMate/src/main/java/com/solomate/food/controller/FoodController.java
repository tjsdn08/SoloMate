package com.solomate.food.controller;

import com.solomate.food.vo.FoodVO;
import com.solomate.main.controller.Controller;
import com.solomate.main.controller.Init;
import com.solomate.main.service.Execute;
import com.solomate.util.page.PageObject;

import jakarta.servlet.http.HttpServletRequest;

public class FoodController implements Controller {

	@Override
	public String execute(HttpServletRequest request) {
		// TODO Auto-generated method stub
		request.setAttribute("url", request.getRequestURL());
		try { // 정상처리
			String uri = request.getServletPath();
			
			// 사용 변수 선언
			FoodVO vo;
			Integer result;
			Long no;
			switch (uri) {
			case "/food/list.do":
				
				PageObject pageObject = PageObject.getInstance(request);
				
				request.setAttribute("list", Execute.execute(Init.getService(uri), pageObject));
				System.out.println("FoodController.execute().pageObject - " + pageObject);
				request.setAttribute("pageObject", pageObject);
				
				return "food/list";
				
			case "/food/view.do":
				
				no = Long.parseLong(request.getParameter("no"));
				
				request.setAttribute("vo", Execute.execute(Init.getService(uri), no));
				
				return "board/view";
				
			default:
				// /WEB-INF/views + error/noPage + .jsp
				return "error/noPage";
			} // switch ~ case 라벨: ~ default 의 끝
		} // try 정상처리 의 끝
		catch (Exception e) { // 예외 처리
			// 개발자를 위한 코드
			e.printStackTrace();
			e.getStackTrace();
			// 잘못된 예외 처리 - 사용자에게 보여주기
			request.setAttribute("moduleName", "식품 목록 보기");
			request.setAttribute("e", e);
			// /WEB-INF/views + error/err_500 + .jsp
			return "error/err_500";
		} // catch 의 끝
				
	}

}
