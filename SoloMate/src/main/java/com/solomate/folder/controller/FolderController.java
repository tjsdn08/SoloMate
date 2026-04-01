package com.solomate.folder.controller;

import com.solomate.folder.vo.FolderVO;
import com.solomate.main.controller.Controller;
import com.solomate.main.controller.Init;
import com.solomate.main.service.Execute;
import com.solomate.member.vo.LoginVO;
import com.solomate.util.page.PageObject;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class FolderController implements Controller{

	@Override
	public String execute(HttpServletRequest request) {
		// TODO Auto-generated method stub
		request.setAttribute("url", request.getRequestURL());
		try {
			String uri = request.getServletPath();
			HttpSession session = request.getSession();
			// 로그인 한 아이디 꺼내기
			LoginVO loginVO = (LoginVO) session.getAttribute("login");
			String loginId = null;
			if(loginVO != null) loginId = loginVO.getId();	
			
			// 사용 변수 선언
			FolderVO vo;
			Long no;
			
			switch (uri) {
			case "/folder/list.do":
				PageObject pageObject = PageObject.getInstance(request);
				// 아이디를 pageObject에 넣기
				pageObject.setAccepter("test");
				
				request.setAttribute("list", Execute.execute(Init.getService(uri), pageObject));
				System.out.println("FoodController.execute().pageObject - " + pageObject);
				request.setAttribute("pageObject", pageObject);
				
				return "folder/list";
				
			case "/folder/view.do":
				
				no = Long.parseLong(request.getParameter("no"));
				request.setAttribute("vo", Execute.execute(Init.getService(uri), no));
				
				return "folder/view";
				
			case "/folder/writeForm.do":
				
				return "folder/writeForm";
				
			case "/folder/write.do":
				
				vo = new FolderVO();
				vo.setMemberId("test"); // 더미 데이터 !!!!!!!!!!
				vo.setName(request.getParameter("name"));
				Execute.execute(Init.getService(uri), vo);
				
				return "redirect:list.do?perPageNum=" + request.getParameter("perPageNum");

			default:
				return "error/noPage";
			}
			
		} catch (Exception e) {
			// TODO: handle exception
			// 개발자를 위한 코드
			e.printStackTrace();
			e.getStackTrace();
			// 잘못된 예외 처리 - 사용자에게 보여주기
			request.setAttribute("moduleName", "식품 폴더 목록 보기");
			request.setAttribute("e", e);
			// /WEB-INF/views + error/err_500 + .jsp
			return "error/err_500";
		}
		
	}

}
