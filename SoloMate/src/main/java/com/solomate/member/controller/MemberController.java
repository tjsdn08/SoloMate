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
			String loginId = (loginVO != null) ? loginVO.getId() : null;

			switch (uri) {
				// --- [로그인/로그아웃/가입] ---
				case "/member/loginForm.do":
					return "member/loginForm";
				
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
					
				case "/member/logout.do":
					session.removeAttribute("login");
					session.setAttribute("msg", "로그아웃 되었습니다.");
					return "redirect:/";
					
				case "/member/writeForm.do":
					return "member/writeForm";
					
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

				// --- [관리자 전용 기능] ---
				case "/member/list.do":
					// 관리자 권한 체크 (9번이 관리자라고 가정)
					if (loginVO == null || loginVO.getGradeNo() != 9) {
						session.setAttribute("msg", "접근 권한이 없습니다.");
						return "redirect:/";
					}
					request.setAttribute("list", Execute.execute(Init.getService(uri), null));
					return "member/list";

				case "/member/changeStatus.do":
					vo = new MemberVO();
					vo.setId(request.getParameter("id"));
					vo.setStatus(request.getParameter("status"));
					Execute.execute(Init.getService(uri), vo);
					session.setAttribute("msg", "회원의 상태가 변경되었습니다.");
					return "redirect:list.do";

				case "/member/changeGrade.do":
					vo = new MemberVO();
					vo.setId(request.getParameter("id"));
					vo.setGradeNo(Integer.parseInt(request.getParameter("gradeNo")));
					Execute.execute(Init.getService(uri), vo);
					session.setAttribute("msg", "회원의 등급이 변경되었습니다.");
					return "redirect:list.do";

				// --- [비밀번호 관리] ---
				case "/member/checkpw.do":
					// AJAX 요청 처리: DispatcherServlet에서 "ajax:" 접두어를 인식함
					String inputPw = request.getParameter("pw");
					// 현재 로그인한 사용자의 ID와 입력한 PW를 Map이나 VO에 담아 전달 (여기서는 임시 처리)
					boolean isDuplicate = (boolean) Execute.execute(Init.getService(uri), new Object[]{loginId, inputPw});
					return "ajax:" + isDuplicate;

				case "/member/changePwForm.do":
					return "member/changePwForm";

				case "/member/changePw.do":
					vo = new MemberVO();
					vo.setId(loginId);
					vo.setPw(request.getParameter("pw")); // 기존 비번
					request.setAttribute("newPw", request.getParameter("newPw")); 
					Execute.execute(Init.getService(uri), vo);
					session.setAttribute("msg", "비밀번호가 변경되었습니다. 다시 로그인해 주세요.");
					session.removeAttribute("login");
					return "redirect:/member/loginForm.do";

				// --- [아이디/비번 찾기] ---
				case "/member/searchId.do":
				    vo = new MemberVO();
				    vo.setName(request.getParameter("name"));
				    vo.setTel(request.getParameter("tel"));
				    
				    // 2. 서비스 실행
				    // DB에서 일치하는 사용자의 ID를 String으로 받아옵니다.
				    String foundId = (String) Execute.execute(Init.getService(uri), vo);
				    
				    // 3. AJAX 응답 처리
				    // 아이디가 있으면 아이디를, 없으면 "none" 문자열을 반환합니다.
				    return "ajax:" + (foundId != null ? foundId : "none");
				case "/member/view.do":
					vo = new MemberVO();
					vo.setId(request.getParameter("id"));
					vo.setName(request.getParameter("name"));
					vo.setTel(request.getParameter("tel"));
					vo.setStatus(request.getParameter("status"));
					vo.setGradeName(request.getParameter("gradeName"));
					request.setAttribute("vo", Execute.execute(Init.getService(uri), vo.getId()));
					return "member/view";
				case "/member/searchPwForm.do":
					return "member/searchPwForm";

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