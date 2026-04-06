package com.solomate.util.filter;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.solomate.member.vo.LoginVO;

public class AuthorityFilter extends HttpFilter implements Filter {

	private static final long serialVersionUID = 1L;

	// 페이지별 권한
	// 0 : 비로그인 허용
	// 1 : 로그인 사용자
	// 9 : 관리자
	private Map<String, Integer> authMap = new HashMap<>();

	public AuthorityFilter() {
		super();
	}

	@Override
	public void init(FilterConfig fConfig) throws ServletException {

		// ---------------- 누구나 접근 가능 ----------------
		authMap.put("/main.do", 0);
		authMap.put("/main/main.do", 0);

		authMap.put("/member/loginForm.do", 0);
		authMap.put("/member/login.do", 0);
		authMap.put("/member/writeForm.do", 0);
		authMap.put("/member/write.do", 0);
		authMap.put("/member/checkId.do", 0);
		authMap.put("/member/searchIdForm.do", 0);
		authMap.put("/member/searchId.do", 0);
		authMap.put("/member/searchPwForm.do", 0);
		authMap.put("/member/findPw.do", 0);

		// ---------------- 로그인 사용자만 ----------------
		authMap.put("/member/logout.do", 1);
		authMap.put("/member/view.do", 1);
		authMap.put("/member/updateForm.do", 1);
		authMap.put("/member/update.do", 1);
		authMap.put("/member/changePwForm.do", 1);
		authMap.put("/member/changePw.do", 1);
		authMap.put("/member/deleteForm.do", 1);
		authMap.put("/member/delete.do", 1);

		authMap.put("/shopping/list.do", 1);
		authMap.put("/shopping/view.do", 1);
		authMap.put("/shopping/writeForm.do", 1);
		authMap.put("/shopping/write.do", 1);
		authMap.put("/shopping/updateForm.do", 1);
		authMap.put("/shopping/update.do", 1);
		authMap.put("/shopping/delete.do", 1);
		authMap.put("/shopping/complete.do", 1);
		authMap.put("/shopping/cancel.do", 1);

		authMap.put("/hotdeal/list.do", 1);
		authMap.put("/hotdeal/view.do", 1);
		authMap.put("/hotdeal/addShopping.do", 1);

		
		authMap.put("/recipes/writeForm.do", 1);
		authMap.put("/recipes/write.do", 1);
		authMap.put("/recipes/updateForm.do", 1);
		authMap.put("/recipes/update.do", 1);
		authMap.put("/recipes/delete.do", 1);
		authMap.put("/recipes/imageChangeForm.do", 1);
		authMap.put("/recipes/changeImage.do", 1);

		// ---------------- 관리자만 ----------------
		authMap.put("/member/list.do", 9);
		authMap.put("/member/changeStatus.do", 9);
		authMap.put("/member/changeGrade.do", 9);

		authMap.put("/adminHotDeal/list.do", 9);
		authMap.put("/adminHotDeal/view.do", 9);
		authMap.put("/adminHotDeal/writeForm.do", 9);
		authMap.put("/adminHotDeal/write.do", 9);
		authMap.put("/adminHotDeal/updateForm.do", 9);
		authMap.put("/adminHotDeal/update.do", 9);
		authMap.put("/adminHotDeal/delete.do", 9);
		authMap.put("/adminHotDeal/status.do", 9);

		authMap.put("/adminCategory/list.do", 9);
		authMap.put("/adminCategory/view.do", 9);
		authMap.put("/adminCategory/writeForm.do", 9);
		authMap.put("/adminCategory/write.do", 9);
		authMap.put("/adminCategory/updateForm.do", 9);
		authMap.put("/adminCategory/update.do", 9);
		authMap.put("/adminCategory/delete.do", 9);
		authMap.put("/adminCategory/status.do", 9);
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {

		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;

		String uri = req.getServletPath();
		System.out.println("AuthorityFilter servletPath = " + uri);

		// authMap에 없는 페이지는 기본 허용
		Integer pageGradeNo = authMap.get(uri);
		if (pageGradeNo == null) {
			chain.doFilter(request, response);
			return;
		}

		// 0이면 누구나 접근 가능
		if (pageGradeNo == 0) {
			chain.doFilter(request, response);
			return;
		}

		HttpSession session = req.getSession();
		Object loginObj = session.getAttribute("login");

		// 로그인 필요 페이지인데 로그인 안 한 경우
		if (loginObj == null) {
			session.setAttribute("msg", "로그인 후 이용 가능합니다.");
			res.sendRedirect(req.getContextPath() + "/member/loginForm.do");
			return;
		}

		LoginVO login = (LoginVO) loginObj;
		int userGradeNo = login.getGradeNo();

		// 권한 부족
		if (userGradeNo < pageGradeNo) {
			session.setAttribute("msg", "접근 권한이 없습니다.");
			res.sendRedirect(req.getContextPath() + "/main/main.do");
			return;
		}

		chain.doFilter(request, response);
	}

	@Override
	public void destroy() {
	}
}