package com.solomate.board.controller;

import com.solomate.board.vo.BoardVO;
import com.solomate.main.controller.Controller;
import com.solomate.main.controller.Init;
import com.solomate.main.service.Execute;
import com.solomate.util.page.PageObject;

import jakarta.servlet.http.HttpServletRequest;

public class BoardController implements Controller {

	@Override
	public String execute(HttpServletRequest request) {
		
		request.setAttribute("url", request.getRequestURL());
		try {
			
			String uri=request.getServletPath();
			
			BoardVO vo;
			Integer result;
			Long no;
			
			switch(uri) {
			
			case "/board/list.do":
				PageObject pageObject=PageObject.getInstance(request);
				request.setAttribute("list", Execute.execute(Init.getService(uri), pageObject));
				System.out.println("BoardController.execute().pageObject - "+pageObject);
				request.setAttribute("pageObject", pageObject);
				return "board/list";
				
			case "/board/view.do":
				no=Long.parseLong(request.getParameter("no"));
				long inc=Long.parseLong(request.getParameter("inc"));
				String id = (String) request.getSession().getAttribute("login");
				request.setAttribute("vo", Execute.execute(Init.getService(uri), new Object[] {no,inc,id}));
				return "board/view";
				
			case "/board/writeForm.do":
				return "board/writeForm";
				
			case "/board/write.do":
				System.out.println("write.do - 글등록 처리");
				vo=new BoardVO();
				vo.setTitle(request.getParameter("title"));
				vo.setContent(request.getParameter("content"));
				vo.setWriter(request.getParameter("writer"));
				Execute.execute(Init.getService(uri), vo);
				request.getSession().setAttribute("msg", "글등록이 되었습니다");
				return "redirect:list.do?perPageNum=" + request.getParameter("perPageNum");
				
			case "/board/updateForm.do":
				no = Long.parseLong(request.getParameter("no"));
				inc = Long.parseLong(request.getParameter("inc"));
				request.setAttribute("vo", 
						Execute.execute(Init.getService("/board/view.do"), new Long[] {no, inc}));
				return "board/updateForm";
				
			case "/board/update.do":
				pageObject = PageObject.getInstance(request);
				vo = new BoardVO();
				vo.setNo(Long.parseLong(request.getParameter("no")));
				vo.setTitle(request.getParameter("title"));
				vo.setContent(request.getParameter("content"));
				vo.setWriter(request.getParameter("writer"));
				result = (Integer) Execute.execute(Init.getService(uri), vo);
				if(result == 1)
					request.getSession().setAttribute("msg", "수정이 되었습니다.");
				else
					request.getSession().setAttribute("msg", "수정에 실패하였습니다. 정보를 확인해주세요.");
				return "redirect:view.do?no=" + vo.getNo() + "&inc=0&" + pageObject.getPageQuery();
				
			case "/board/delete.do":
				System.out.println("일반게시판 글삭제 처리");
				vo = new BoardVO();
				vo.setNo(Long.parseLong(request.getParameter("no")));
				result = (Integer) Execute.execute(Init.getService(uri), vo);
				if(result == 1) {
					request.getSession().setAttribute("msg", "삭제가 되었습니다.");
					return "redirect:list.do?perPageNum=" + request.getParameter("perPageNum");
				} else {
					request.getSession().setAttribute("msg", "삭제에 실패하였습니다. 정보를 확인해주세요.");
					return "redirect:view.do?no=" + vo.getNo() + "&inc=0"
							+ "&page=" + request.getParameter("page")
							+ "&perPageNum=" + request.getParameter("perPageNum")
							+ "&key=" + request.getParameter("key")
							+ "&word=" + request.getParameter("word")
							;
				} // else의 끝
				
			default:
				return "error/noPage";
			
			} // switch-case의 끝
			
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("moduleName", "꿀팁 아카이브");
			request.setAttribute("e", e);
			return "error/err_500";
		}
		
	}

}
