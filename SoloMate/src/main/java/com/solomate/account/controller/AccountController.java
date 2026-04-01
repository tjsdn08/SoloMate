package com.solomate.account.controller;

import com.solomate.board.vo.BoardVO;
import com.solomate.main.controller.Controller;
import com.solomate.main.controller.Init;
import com.solomate.main.service.Execute;
import com.solomate.util.page.PageObject;

import jakarta.servlet.http.HttpServletRequest;

public class AccountController implements Controller{

	public String execute(HttpServletRequest request) {
		
		request.setAttribute("url", request.getRequestURL());
		
		try {
			
			String uri=request.getServletPath();
			
			BoardVO vo;
			Integer result;
			Long no;
			
			switch (uri) {
			
			case "/account/list.do":
				PageObject pageObject = PageObject.getInstance(request);
			    String category = request.getParameter("category");
			    pageObject.setCategory(category); 
			    request.setAttribute("list", Execute.execute(Init.getService(uri), pageObject));
			    System.out.println("BoardController.execute().pageObject - " + pageObject);
			    request.setAttribute("pageObject", pageObject);
				return "account/list";
				
			case "/account/view.do":
				return "account/view";
				
			case "/account/writeForm.do":
				return "account/writeForm";
				
			case "/account/write.do":
				return "account/write";
				
			case "/account/updateForm.do":
				return "account/updateForm";
				
			case "/account/update.do":
				return "account/update";
				
			case "/account/delete.do":
				return "account/delete";
			
			default:
				return "error/noPage";
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("moduleName", "꿀팁 아카이브");
			request.setAttribute("e", e);
			return "error/err_500";
		}
	}

}
