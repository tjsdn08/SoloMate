package com.solomate.boardbookmark.controller;

import java.util.List;

import com.solomate.boardbookmark.dao.BoardBookmarkDAO;
import com.solomate.boardbookmark.service.BoardBookmarkListService;
import com.solomate.boardbookmark.vo.BoardBookmarkVO;
import com.solomate.main.controller.Controller;
import com.solomate.main.controller.Init;
import com.solomate.main.service.Execute;
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
			    // 1. 데이터 수집
			    long no = Long.parseLong(request.getParameter("no"));
			    String from = request.getParameter("from"); // JSP에서 보낸 from 받기

			    BoardBookmarkVO vo = new BoardBookmarkVO();
			    vo.setBoardNo(no);
			    vo.setId(id); // 세션에서 꺼낸 ID

			    // 2. 서비스 실행 (토글: 있으면 삭제, 없으면 등록)
			    Execute.execute(Init.getService(uri), vo);

			    // 3. 쿼리 스트링 조립 (기본 정보)
			    String query = "no=" + no + "&inc=0" 
			                 + "&page=" + request.getParameter("page")
			                 + "&perPageNum=" + request.getParameter("perPageNum");

			    // 4. from 정보가 있다면 쿼리에 추가 (상태 유지 핵심)
			    if (from != null && !from.isEmpty()) {
			        query += "&from=" + from;
			    }

			    // 5. 결과 처리: 다시 글보기 페이지로 돌아갑니다.
			    return "redirect:/board/view.do?" + query;
			    
			case "/boardbookmark/delete.do":
			    // 1. 데이터 수집
			    no = Long.parseLong(request.getParameter("no"));
			    from = request.getParameter("from");

			    vo = new BoardBookmarkVO();
			    vo.setBoardNo(no);
			    vo.setId(id);

			    // 2. 서비스 실행
			    Execute.execute(Init.getService(uri), vo);

			    // 3. 쿼리 스트링 조립 (공통 부분 먼저 생성)
			    query = "no=" + no + "&inc=0" 
			                 + "&page=" + request.getParameter("page")
			                 + "&perPageNum=" + request.getParameter("perPageNum");

			    // 4. from 정보가 있다면 쿼리에 추가
			    if (from != null && !from.isEmpty()) {
			        query += "&from=" + from;
			    }

			    // 5. 최종 리다이렉트 (한 번만 리턴)
			    return "redirect:/board/view.do?" + query;
				
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
