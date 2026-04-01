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
		PageObject pageObject;
		
		request.setAttribute("url", request.getRequestURL());
		
		try {
			
			String uri = request.getServletPath();
			
			
			switch(uri) {
			case "/boardbookmark/list.do":
			    // 1. 페이지 정보 가져오기
			    pageObject = PageObject.getInstance(request);
			    
			    // 2. 서비스에 넘길 데이터 구성 (배열로 묶기)
			    // 리스트 서비스가 Object[]를 받도록 되어 있으므로 똑같이 맞춰줍니다.
			    Object[] listObjs = {pageObject, id}; 
			    
			    // 3. 실행 (Init에 등록된 서비스를 가져와서 실행)
			    // Execute.execute를 써야 로그도 찍히고 관리가 편합니다.
			    List<BoardBookmarkVO> list = (List<BoardBookmarkVO>) Execute.execute(Init.getService(uri), listObjs);
			    
			    // 4. 결과 저장
			    request.setAttribute("list", list);
			    request.setAttribute("pageObject", pageObject);
			    
			    return "boardbookmark/list";
				
			case "/boardbookmark/write.do":
			    // 1. 데이터 수집
			    long no = Long.parseLong(request.getParameter("no"));
			    String from = request.getParameter("from");

			    BoardBookmarkVO vo = new BoardBookmarkVO();
			    vo.setBoardNo(no);
			    vo.setId(id); // 세션에서 가져온 ID

			    // ★ 핵심 수정: 서비스가 Object[]를 기다리고 있으므로 배열에 담습니다.
			    Object[] writeObjs = {vo}; // 만약 서비스에서 VO만 쓴다면 이렇게, 
			                               // 혹은 다른 정보가 더 필요하면 추가하세요.

			    // 2. 서비스 실행 (배열을 던져줍니다)
			    Execute.execute(Init.getService(uri), writeObjs);

			    // 3. 리다이렉트 처리 (기존 로직 유지)
			    String query = "no=" + no + "&inc=0&page=" + request.getParameter("page")
			                 + "&perPageNum=" + request.getParameter("perPageNum");
			    if (from != null && !from.isEmpty()) query += "&from=" + from;

			    return "redirect:/board/view.do?" + query;
			    
			case "/boardbookmark/delete.do":
			    // 1. 데이터 수집
			    no = Long.parseLong(request.getParameter("no"));
			    from = request.getParameter("from");

			    vo = new BoardBookmarkVO();
			    vo.setBoardNo(no);
			    vo.setId(id); // 세션의 로그인 ID

			    // 2. 서비스 실행
			    Execute.execute(Init.getService(uri), vo);

			    // 3. 페이지 정보 수집 (리스트든 글보기든 공통으로 필요)
			    String page = request.getParameter("page");
			    String perPageNum = request.getParameter("perPageNum");
			    
			    // 4. 목적지 결정 (분기 처리)
			    if ("bookmark".equals(from)) {
			        // [케이스 A] 북마크 리스트에서 삭제한 경우 -> 다시 북마크 리스트로
			        return "redirect:list.do?page=" + page + "&perPageNum=" + perPageNum;
			    } else {
			        // [케이스 B] 일반 글보기에서 북마크 취소한 경우 -> 다시 해당 글보기로
			        query = "no=" + no + "&inc=0&page=" + page + "&perPageNum=" + perPageNum;
			        
			        // 만약 다른 곳에서 넘어온 from 정보가 있다면 유지
			        if (from != null && !from.isEmpty()) {
			            query += "&from=" + from;
			        }
			        return "redirect:/board/view.do?" + query;
			    }
				
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
