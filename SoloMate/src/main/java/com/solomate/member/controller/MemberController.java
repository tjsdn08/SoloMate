package com.solomate.member.controller;

import com.solomate.main.controller.Controller;
import com.solomate.main.controller.Init;
import com.solomate.main.service.Execute;
import com.solomate.member.vo.LoginVO;
import com.solomate.member.vo.MemberVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class MemberController implements Controller {

	@Override
	public String execute(HttpServletRequest request) {

		try {
			String uri = request.getServletPath();
			HttpSession session = request.getSession();
			
			LoginVO loginVO = (LoginVO) session.getAttribute("login");
			switch (uri) {
				// 로그인 폼
				case "/member/loginForm.do":
					return "member/loginForm";
				// 로그인
				case "/member/login.do":
					LoginVO userVO = new LoginVO();
					userVO.setId(request.getParameter("id"));
					userVO.setPw(request.getParameter("pw"));
					loginVO = (LoginVO) Execute.execute(Init.getService(uri), userVO);
					session.setAttribute("login", loginVO);
					// 마지막 접속일 업데이트
					Execute.execute(Init.getService("/member/changeCon.do"), loginVO.getId());
					session.setAttribute("msg", loginVO.getName() + "님, 환영합니다!");
					return "redirect:/";
					
				// 로그아웃
				case "/member/logout.do":
					session.removeAttribute("login");
					session.setAttribute("msg", "로그아웃 되었습니다.");
					return "redirect:/";
					
				// 회원가입 폼
				case "/member/writeForm.do":
					return "member/writeForm";
					
				// 회원가입
				case "/member/write.do":
					MemberVO vo = new MemberVO();
					vo.setId(request.getParameter("id"));
					vo.setPw(request.getParameter("pw"));
					vo.setName(request.getParameter("name"));
					vo.setTel(request.getParameter("tel"));
					vo.setAddress(request.getParameter("address"));
					Execute.execute(Init.getService(uri), vo);
					session.setAttribute("msg", "회원 가입이 완료되었습니다. 로그인 해주세요.");
					return "redirect:/member/loginForm.do";

				// 관리자 회원리스트
				case "/member/list.do":
					if (loginVO == null || loginVO.getGradeNo() != 9) {
						session.setAttribute("msg", "접근 권한이 없습니다.");
						return "redirect:/";
					}
					request.setAttribute("list", Execute.execute(Init.getService(uri), null));
					return "member/list";

				// 관리자 회원 리스트- 회원 상태 수정
				case "/member/changeStatus.do":
					vo = new MemberVO();
					vo.setId(request.getParameter("id"));
					vo.setStatus(request.getParameter("status"));
					Execute.execute(Init.getService(uri), vo);
					session.setAttribute("msg", "회원의 상태가 변경되었습니다.");
					return "redirect:list.do";

				// 관리자 회원 리스트 - 회원 등급 변경
				case "/member/changeGrade.do":
					vo = new MemberVO();
					vo.setId(request.getParameter("id"));
					vo.setGradeNo(Integer.parseInt(request.getParameter("gradeNo")));
					Execute.execute(Init.getService(uri), vo);
					session.setAttribute("msg", "회원의 등급이 변경되었습니다.");
					return "redirect:list.do";

				// 회원 비밀번호 변경
				case "/member/changePwForm.do":
				    return "member/changePwForm";

				case "/member/changePw.do":
				    // 1. 데이터 수집
				    vo = new MemberVO();
				    vo.setId(loginVO.getId());
				    vo.setPw(request.getParameter("pw"));
				    String newPw = request.getParameter("newPw");
				    
				    // 2. 서비스 실행
				    Integer pwResult = (Integer) Execute.execute(Init.getService(uri), new Object[]{vo.getId(), vo.getPw(), newPw});
				    
				    // 3. 결과에 따른 처리
				    if (pwResult == 1) {
				        session.removeAttribute("login");
				        session.setAttribute("msg", "비밀번호가 정상적으로 변경되었습니다. 새 비밀번호로 로그인하세요.");
				        return "redirect:/member/loginForm.do";
				    } else {
				        request.setAttribute("pwResult", "fail");
				        return "member/changePwForm";
				    }

				// 아이디 찾기
				case "/member/searchIdForm.do":
				    return "member/searchIdForm";

				case "/member/searchId.do":
				    // 데이터 수집
				    vo = new MemberVO();
				    vo.setName(request.getParameter("name"));
				    vo.setTel(request.getParameter("tel"));
				    
				    String foundId = (String) Execute.execute(Init.getService(uri), vo);
				    
				    request.setAttribute("foundId", (foundId != null && !foundId.equals("")) ? foundId : "none");
				    
				    return "member/searchIdForm";
				    
				 // 회원 정보 상세 보기
				case "/member/view.do":
					vo = new MemberVO();
					vo.setId(request.getParameter("id"));
					request.setAttribute("vo", Execute.execute(Init.getService(uri), vo.getId()));
					return "member/view";
					

				// 회원 정보 수정

				case "/member/updateForm.do":
				    request.setAttribute("vo", Execute.execute(Init.getService("/member/view.do"), loginVO.getId()));
				    return "member/updateForm";

				case "/member/update.do":
				    vo = new MemberVO();
				    vo.setId(loginVO.getId()); 
				    vo.setPw(request.getParameter("pw")); // 본인 확인용 비번
				    vo.setName(request.getParameter("name"));
				    vo.setTel(request.getParameter("tel"));
				    vo.setAddress(request.getParameter("address"));
				    
				    Integer updateResult = (Integer) Execute.execute(Init.getService(uri), vo);
				    
				    if (updateResult == 1) {
				        session.setAttribute("msg", "회원 정보가 성공적으로 수정되었습니다.");
				        return "redirect:/member/view.do?id=" + vo.getId();
				    } else {
				        request.setAttribute("updateStatus", "fail");
				        request.setAttribute("vo", vo); // 입력했던 내용 유지
				        return "member/updateForm";
				    }
				

				default:
					request.setAttribute("url", request.getRequestURL());
					return "error/noPage";
			}
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("url", request.getRequestURL());
			request.setAttribute("moduleName", "회원 관리");
			request.setAttribute("e", e);
			return "error/err_500";
		}
	}
}