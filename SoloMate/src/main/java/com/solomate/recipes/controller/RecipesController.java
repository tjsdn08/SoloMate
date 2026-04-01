package com.solomate.recipes.controller;

import com.solomate.main.controller.Controller;
import com.solomate.main.controller.Init;
import com.solomate.main.service.Execute;
import com.solomate.util.page.PageObject;

import jakarta.servlet.http.HttpServletRequest;

public class RecipesController implements Controller{

	@Override
	public String execute(HttpServletRequest request) {
		// 잘못된 URI 처리 / 오류를 위한 URL 저장
		request.setAttribute("url", request.getRequestURL());
		try {
			String uri = request.getServletPath();
			
//			RecipesVO vo;
//			Integer result;
//			Long no;
			
			switch (uri) {
			case "/recipes/list.do": 
				PageObject pageObject = PageObject.getInstance(request);
				
				request.setAttribute("list", Execute.execute(Init.getService(uri), pageObject));
				System.out.println("RecipesController.execuete().pageObject - " + pageObject);
				request.setAttribute("pageObject", pageObject);
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
