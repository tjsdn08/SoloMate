package com.solomate.board.controller;

import com.solomate.board.vo.BoardVO;
import com.solomate.main.controller.Controller;
import com.solomate.main.controller.Init;
import com.solomate.main.service.Execute;
import com.solomate.util.page.PageObject;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

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
			    PageObject pageObject = PageObject.getInstance(request);
			    String category = request.getParameter("category");
			    pageObject.setCategory(category); 
			    request.setAttribute("list", Execute.execute(Init.getService(uri), pageObject));
			    System.out.println("BoardController.execute().pageObject - " + pageObject);
			    request.setAttribute("pageObject", pageObject);
			    return "board/list";
				
			case "/board/view.do":
			    String noStr = request.getParameter("no");
			    String incStr = request.getParameter("inc");

			    no = (noStr != null && !noStr.isEmpty()) ? Long.parseLong(noStr) : 0L;
			    int inc = (incStr != null && !incStr.isEmpty()) ? Integer.parseInt(incStr) : 0;

			    if (no == 0) {
			        throw new Exception("게시글 번호가 올바르지 않습니다.");
			    }

			    HttpSession session = request.getSession();
			    com.solomate.member.vo.LoginVO login = (com.solomate.member.vo.LoginVO) session.getAttribute("login");
			    
			    String id = null;
			    if(login != null) {
			        id = login.getId(); 
			    }

			    vo = (BoardVO) Execute.execute(Init.getService(uri), new Object[]{no, (long)inc, id});
			    
			    request.setAttribute("vo", vo);
			    
			    String from = request.getParameter("from");
			    request.setAttribute("from", from);
			    return "board/view";

				
			case "/board/writeForm.do":
				return "board/writeForm";
				
			case "/board/write.do":
			    System.out.println("write.do - 글등록 처리");
			    vo = new BoardVO();
			    vo.setTitle(request.getParameter("title"));
			    vo.setContent(request.getParameter("content"));
			    vo.setCategory(request.getParameter("category")); 

			    session = request.getSession();
			    // 글쓰기에서도 view.do와 동일하게 LoginVO를 사용하도록 수정
			    com.solomate.member.vo.LoginVO writerLogin = (com.solomate.member.vo.LoginVO) session.getAttribute("login");

			    if (writerLogin != null) {
			        vo.setWriter(writerLogin.getId());
			    } else {
			        vo.setWriter("admin"); // 테스트용
			    }

			    Execute.execute(Init.getService(uri), vo);
			    request.getSession().setAttribute("msg", "글등록이 되었습니다");
			    return "redirect:list.do?perPageNum=" + request.getParameter("perPageNum");				
			
			case "/board/updateForm.do":
			    no = Long.parseLong(request.getParameter("no"));
			    // 수정 폼으로 갈 때는 조회수를 올리면 안 되므로 0L을 보냅니다.
			    long inc_update = 0L; 

			    // 💡 [추가] 세션에서 로그인 아이디 가져오기 (서비스가 3번째 인자를 기다림)
			    session = request.getSession();
			    com.solomate.member.vo.LoginVO loginUpdateForm = (com.solomate.member.vo.LoginVO) session.getAttribute("login");
			    String idUpdateForm = (loginUpdateForm != null) ? loginUpdateForm.getId() : null;

			    // 💡 [수정] 인자를 3개(no, inc, id)로 맞춰서 보냅니다.
			    request.setAttribute("vo", 
			            Execute.execute(Init.getService("/board/view.do"), new Object[] {no, inc_update, idUpdateForm}));
			    
			    return "board/updateForm";
				
			case "/board/update.do":
				pageObject = PageObject.getInstance(request);
				vo = new BoardVO();
				vo.setNo(Long.parseLong(request.getParameter("no")));
			    vo.setTitle(request.getParameter("title"));
			    vo.setContent(request.getParameter("content"));
			    
			    // 💡 [체크!] updateForm.jsp에 name="writer"인 input 태그가 있나요?
			    // 없다면 null이 들어가서 DB가 수정 대상을 찾지 못합니다(result=0).
			    vo.setWriter(request.getParameter("writer")); 
			    
			    // 안전하게 세션에서 로그인 정보를 가져와서 세팅하는 것을 추천합니다.
			    session = request.getSession();
			    com.solomate.member.vo.LoginVO updateLogin = (com.solomate.member.vo.LoginVO) session.getAttribute("login");
			    if(updateLogin != null) vo.setWriter(updateLogin.getId());
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
			    
			    // 1. [추가] 본인 확인을 위해 세션에서 로그인 아이디를 가져옵니다.
			    session = request.getSession();
			    login = (com.solomate.member.vo.LoginVO) session.getAttribute("login");
			    
			    if (login != null) {
			        // 2. VO에 로그인한 사람의 ID를 세팅 (DAO에서 where writer = ? 에 사용됨)
			        vo.setWriter(login.getId());
			    }

			    // 3. 서비스 실행 (vo 안에는 no와 writer가 들어있어야 함)
			    result = (Integer) Execute.execute(Init.getService(uri), vo);
			    
			    if(result == 1) {
			        request.getSession().setAttribute("msg", "삭제가 되었습니다.");
			        return "redirect:list.do?perPageNum=" + request.getParameter("perPageNum");
			    } else {
			        // result가 0이면: 글번호가 틀렸거나, 내가 쓴 글이 아니라는 뜻입니다.
			        request.getSession().setAttribute("msg", "삭제에 실패하였습니다. 본인 글만 삭제 가능합니다.");
			        return "redirect:view.do?no=" + vo.getNo() + "&inc=0"
			                + "&page=" + request.getParameter("page")
			                + "&perPageNum=" + request.getParameter("perPageNum")
			                + "&key=" + request.getParameter("key")
			                + "&word=" + request.getParameter("word");
			    }
				
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
