package com.solomate.util.filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
//import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;


/**
 * Servlet Filter implementation class AutorityFilter
 */
//@WebFilter("/AutorityFilter") -> web.sml에 설정. 여기는 반드시 주석처리한다.
public class AuthorityFilter extends HttpFilter implements Filter {
       
	private static final long serialVersionUID = 1L;
	
	private Map<String, Integer> authMap = new HashMap<>();

	/**
     * @see HttpFilter#HttpFilter()
     */
    public AuthorityFilter() { // 생성자
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() { // 소멸자
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain) 
	 * 
	 * 필터 처리 메서드 - request, response 타입이 다르다.
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub
		// place your code here - 실행 전 필터 처리 : 권한 처리
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		
		String uri = req.getServletPath();
		
		System.out.println("AutorityFilter.doFilter().uri : " + uri);
		
		System.out.println("AutorityFilter.doFilter() 실행 전 처리 : 권한 처리 --------------------------");

		Integer pageGradeNo = authMap.get(uri);
		              
	}

	/**
	 * @see Filter#init(FilterConfig)
	 * 모든 페이지에 대한 권한 저장 
	 */
	public void init(FilterConfig fConfig) throws ServletException {
	
		
	}

}
