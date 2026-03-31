package com.solomate.boardbookmark.controller;

import java.util.List;

import com.solomate.boardbookmark.dao.BoardBookmarkDAO;
import com.solomate.boardbookmark.service.BoardBookmarkDeleteService;
import com.solomate.boardbookmark.service.BoardBookmarkListService;
import com.solomate.boardbookmark.service.BoardBookmarkWriteService;
import com.solomate.boardbookmark.vo.BoardBookmarkVO;
import com.solomate.main.controller.Controller;
import com.solomate.member.vo.LoginVO;
import com.solomate.util.page.PageObject;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class BoardBookmarkController implements Controller {

	@SuppressWarnings("unchecked")
	@Override
	public String execute(HttpServletRequest request) {
		// TODO Auto-generated method stub
		
		HttpSession session = request.getSession();
		LoginVO login=(LoginVO) session.getAttribute("login");
		String id=null;
		if(login!=null) id=login.getId();
		
		request.setAttribute("url", request.getRequestURL());
		
		try {
			
			String uri = request.getServletPath();
			
			switch(uri) {
			case "/boardbookmark/list.do":
				PageObject pageObject = PageObject.getInstance(request);
				request.setAttribute("pageObject", pageObject);
				BoardBookmarkDAO dao = new BoardBookmarkDAO();
				pageObject.setTotalRow(dao.getTotalRow(id));
				BoardBookmarkListService listService = new BoardBookmarkListService();
				listService.setDAO(new BoardBookmarkDAO());
				Object[] objs = {pageObject, id};
				List<BoardBookmarkVO> list =
					(List<BoardBookmarkVO>) listService.service(objs);
				request.setAttribute("list", list);
				request.setAttribute("pageObject", pageObject);
				return "boardbookmark/list";
				
			case "/boardbookmark/write.do":
				
//				Long no = Long.parseLong(request.getParameter("no"));
//
//				BoardBookmarkVO writeVO = new BoardBookmarkVO();
//				writeVO.setNo(no);
//				writeVO.setId(id);
//
//				BoardBookmarkWriteService writeService = new BoardBookmarkWriteService();
//				writeService.service(writeVO);
				
				return "redirect:/board/view.do?no=";// + no
				
			case "/boardbookmark/delete.do":
//				Long delNo = Long.parseLong(request.getParameter("no"));
//
//				BoardBookmarkVO deleteVO = new BoardBookmarkVO();
//				deleteVO.setNo(delNo);
//				deleteVO.setId(id);
//
//				BoardBookmarkDeleteService deleteService = new BoardBookmarkDeleteService();
//				deleteService.service(deleteVO);

				return "redirect:/board/view.do?no="; // + delNo
				
			default:
				break;
				
			}
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			// 잘못된 예외 처리 - 사용자에게 보여주기
			request.setAttribute("moduleName", "일반 게시판");
			request.setAttribute("e", e);
			// /WEB-INF/views/ + error/err_500 + .jsp
			return "error/err_500";
		}
		
		return null;
	}

}
