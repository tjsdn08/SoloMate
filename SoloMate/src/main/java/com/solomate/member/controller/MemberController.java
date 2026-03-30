package com.solomate.member.controller;

import com.solomate.main.controller.Controller;
import com.solomate.main.controller.Init;
import com.solomate.main.service.Execute;
import com.solomate.member.vo.LoginVO;
import com.solomate.member.vo.MemberVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class MemberController implements Controller{

	@Override
	public String execute(HttpServletRequest request) {

		try {
			
			String uri = request.getServletPath();
			HttpSession session = request.getSession();
			
			LoginVO loginVO = (LoginVO) session.getAttribute("login");
			String loginId = null;
			if(loginVO != null) loginId = loginVO.getId();
			
			switch (uri) {
			case "/member/loginForm.do":
				
				return "member/loginForm";
			
			case "/member/login.do":
				LoginVO userVO = new LoginVO();
				userVO.setId(request.getParameter("id"));
				userVO.setPw(request.getParameter("pw"));
				loginVO = (LoginVO) Execute.execute(Init.getService(uri), userVO);
				session.setAttribute("login", loginVO);
				Execute.execute(Init.getService("/member/changeCon.do"), loginVO.getId());
				session.setAttribute("msg", "로그인 되었습니다.");
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
				
				loginVO = new LoginVO();
				loginVO.setId(vo.getId());
				loginVO.setName(vo.getName());
				loginVO.setGradeNo(1);
				loginVO.setGradeName("일반회원");
				
				session.setAttribute("login", loginVO);
				session.setAttribute("msg", "회원 가입을 축하합니다!");
				
				return "redirect:/";
				
			default:
			// 잘못된 URI 처리
			request.setAttribute("url", request.getRequestURL());
			// /WEB-INF/views/ + error/noPage + .jsp
			return "error/noPage";
		} // 메뉴 처리 switch 문의 끝
			
			
			
		}catch (Exception e) {
			e.printStackTrace();
			e.getStackTrace();
			request.setAttribute("url", request.getRequestURL());
			request.setAttribute("moduleName", "회원 관리");
			request.setAttribute("e", e);
			// /WEB-INF/views/ + error/err_500 + .jsp
			return "error/err_500";
		}
		
	}

}
