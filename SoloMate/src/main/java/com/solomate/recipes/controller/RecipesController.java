package com.solomate.recipes.controller;

import com.solomate.main.controller.Controller;
import com.solomate.main.controller.Init;
import com.solomate.main.service.Execute;
import com.solomate.recipes.vo.RecipesVO;
import com.solomate.util.page.PageObject;

import jakarta.servlet.http.HttpServletRequest;

public class RecipesController implements Controller{

	@Override
	public String execute(HttpServletRequest request) {
		// 잘못된 URI 처리 / 오류를 위한 URL 저장
		request.setAttribute("url", request.getRequestURL());
		try {
			// 요청 uri에 따라서 처리된다.
			// list - /board/list.do
			// 1. 일반게시판 메뉴 입력
			String uri = request.getServletPath();
			
			// 2. 일반게시판 메뉴 처리
			// 사용 변수 선언
			RecipesVO vo;
			Integer result;
			Long no;
			
			switch (uri) {
			case "/recipes/list.do": 
				PageObject pageObject = PageObject.getInstance(request);
				
				// 생성된 Service를 가져와서 실행 -> Execute가 실행하면 로그를 남긴다.
				// DB에서 데이터 수집을 해온다.
				// 사용자에게 제공한다.
				request.setAttribute("list", Execute.execute(Init.getService(uri), pageObject));
				// 처리된 후의 pageObject 데이터 확인
				System.out.println("RecipesController.execuete().pageObject - " + pageObject);
				request.setAttribute("pageObject", pageObject);
				// jsp의 위치 정보 "/WEB-INF/views/" + "board/list" + ".jsp"
				return "recipes/list";
			
			default:
				return "error/noPage";
			}
			
			
		}catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("url", request.getRequestURL());
			request.setAttribute("moduleName", "레시피 아카이브");
			request.setAttribute("e", e);
			return "error/err_500";
		}
	}

}
