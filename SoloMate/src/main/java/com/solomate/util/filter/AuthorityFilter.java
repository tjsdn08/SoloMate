package com.solomate.util.filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;

import java.io.IOException;

public class AuthorityFilter extends HttpFilter implements Filter {

	private static final long serialVersionUID = 1L;

	@Override
	public void init(FilterConfig fConfig) throws ServletException {
		System.out.println("🔥 AuthorityFilter.init()");
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {

		HttpServletRequest req = (HttpServletRequest) request;

		String uri = req.getServletPath();
		System.out.println("🔥 AuthorityFilter servletPath = " + uri);
		System.out.println("🔥 AuthorityFilter before chain");

		chain.doFilter(request, response);

		System.out.println("🔥 AuthorityFilter after chain");
	}

	@Override
	public void destroy() {
	}
}