package com.solomate.account.controller;

import com.solomate.account.vo.AccountVO;
import com.solomate.board.vo.BoardVO;
import com.solomate.main.controller.Controller;
import com.solomate.main.controller.Init;
import com.solomate.main.service.Execute;
import com.solomate.member.vo.LoginVO;
import com.solomate.util.page.PageObject;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class AccountController implements Controller{

	public String execute(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
	    LoginVO login = (LoginVO) session.getAttribute("login");

	    String id = null;
	    if (login != null) {
	        id = login.getId(); // 현재 로그인한 사람의 아이디 추출
	    }

		request.setAttribute("url", request.getRequestURL());
		
		try {
			
			String uri=request.getServletPath();
			
			BoardVO vo;
			Integer result;
			Long no;
			
			switch (uri) {
			
			case "/account/list.do":
			    PageObject pageObject = PageObject.getInstance(request);
			    String searchMonth = request.getParameter("searchMonth"); // 날짜 선택값 받기
			    
			    // 1. 기존 리스트 (페이징 유지)
			    request.setAttribute("list", Execute.execute(Init.getService(uri), new Object[]{pageObject, id}));
			    
			    // 2. 차트용 데이터 (페이징 무시, 날짜 조건 추가)
			    // 파라미터를 배열로 묶어 전달하거나 Map 사용
			    Object[] chartArgs = {id, searchMonth}; 
			    request.setAttribute("chartData", Execute.execute(Init.getService("/account/monthlyStatus.do"), chartArgs));
			    
			    request.setAttribute("pageObject", pageObject);
			    request.setAttribute("searchMonth", searchMonth); // 선택한 달 유지
			    return "account/list";
				
			case "/account/view.do":
			    // 1. 넘어오는 글 번호(no)를 받는다.
			    String strNo = request.getParameter("no");
			    no = Long.parseLong(strNo);

			    // 2. 검색 및 페이지 정보 유지를 위한 PageObject 생성 (선택 사항)
			    pageObject = PageObject.getInstance(request);

			    // 3. 서비스 실행 (조회수 증가는 가계부에서 보통 필요 없으므로 바로 데이터 가져오기)
			    // Execute.execute(서비스객체, 넘길데이터)
			    // 넘길 데이터가 no 하나라면 바로 no를, 여러 개라면 배열이나 객체에 담습니다.
			    Object resultData = Execute.execute(Init.getService(uri), no);
			    
			    // 4. 결과 데이터를 request에 담기
			    request.setAttribute("vo", resultData);
			    request.setAttribute("pageObject", pageObject); // 다시 리스트로 돌아갈 때 필요

			    // 5. JSP 경로 리턴
			    return "account/view";
				
			case "/account/writeForm.do":
			    return "account/writeForm";

			case "/account/write.do":
			    // 1. 데이터 수집
			    String title = request.getParameter("title");
			    String content = request.getParameter("content");
			    int amount = Integer.parseInt(request.getParameter("amount"));
			    long cno = Long.parseLong(request.getParameter("cno")); 
			    String regDate = request.getParameter("regDate"); // 추가: 사용자가 선택한 날짜
			    
			    // 2. VO 세팅
			    AccountVO writeVo = new AccountVO();
			    writeVo.setTitle(title);
			    writeVo.setContent(content);
			    writeVo.setAmount(amount);
			    writeVo.setCno(cno);
			    writeVo.setRegDate(regDate); // 추가: VO에 날짜 저장
			    writeVo.setId(login.getId());

			    // 3. 실행
			    Execute.execute(Init.getService(uri), writeVo);
			    return "redirect:list.do?perPageNum=" + request.getParameter("perPageNum");
			    
			case "/account/updateForm.do":
			    // 1. 수정할 글 번호를 가져옴
			    no = Long.parseLong(request.getParameter("no"));
			    // 2. 기존 데이터를 가져와서 request에 담음 (ViewService 재사용 가능)
			    request.setAttribute("vo", Execute.execute(Init.getService("/account/view.do"), no));
			    // 3. 카테고리 선택을 위해 카테고리 리스트도 필요하다면 추가 (선택사항)
			    return "account/updateForm";

			case "/account/update.do":
			    // 1. 데이터 수집 (write.do와 비슷하지만 'no'가 추가됨)
			    AccountVO updateVo = new AccountVO();
			    updateVo.setNo(Long.parseLong(request.getParameter("no")));
			    updateVo.setTitle(request.getParameter("title"));
			    updateVo.setContent(request.getParameter("content"));
			    updateVo.setAmount(Long.parseLong(request.getParameter("amount")));
			    updateVo.setCno(Long.parseLong(request.getParameter("cno")));
			    updateVo.setRegDate(request.getParameter("regDate"));
			    
			    // 2. 서비스 실행
			    Execute.execute(Init.getService(uri), updateVo);
			    
			    // 3. 수정 후에는 상세 보기(view)나 리스트로 이동
			    return "redirect:view.do?no=" + updateVo.getNo() + "&" + request.getParameter("pageQuery");
				
			case "/account/delete.do":
			    System.out.println("가계부 내역 삭제 처리");
			    
			    // 1. 데이터 수집 (글번호 받기)
			    // 가계부 VO가 있다면 사용하고, 단순 삭제라면 no만 넘겨도 됩니다.
			    // 여기서는 보여주신 방식대로 VO에 담는 형식을 유지하겠습니다.
			    AccountVO accountVo = new AccountVO();
			    no = Long.parseLong(request.getParameter("no"));
			    accountVo.setNo(no);
			    
			    // 만약 본인 확인을 위해 비밀번호나 아이디가 필요하다면 추가
			    // accountVo.setPw(request.getParameter("pw")); 

			    // 2. 서비스 실행
			    // Init.getService(uri)를 통해 AccountDeleteService가 실행되도록 설정되어 있어야 합니다.
			    result = (Integer) Execute.execute(Init.getService(uri), no); 

			    // 3. 처리 결과 메시지 및 페이지 이동
			    if(result == 1) {
			        // 성공 시 리스트로 이동
			        request.getSession().setAttribute("msg", "가계부 내역이 삭제되었습니다.");
			        return "redirect:list.do?perPageNum=" + request.getParameter("perPageNum");
			    } else {
			        // 실패 시 다시 상세보기로 이동
			        request.getSession().setAttribute("msg", "삭제에 실패했습니다. 번호를 확인해주세요.");
			        return "redirect:view.do?no=" + no + "&inc=0"
			                + "&page=" + request.getParameter("page")
			                + "&perPageNum=" + request.getParameter("perPageNum")
			                + "&key=" + request.getParameter("key")
			                + "&word=" + request.getParameter("word");
			    }
			
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
