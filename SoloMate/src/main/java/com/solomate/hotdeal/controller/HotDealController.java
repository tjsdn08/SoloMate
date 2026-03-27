package com.solomate.hotdeal.controller;

import com.solomate.hotdeal.vo.HotDealVO;
import com.solomate.main.controller.Controller;
import com.solomate.main.controller.Init;
import com.solomate.main.service.Execute;
import com.solomate.util.page.PageObject;

import jakarta.servlet.http.HttpServletRequest;

public class HotDealController implements Controller {

	@Override
	public String execute(HttpServletRequest request) {

		request.setAttribute("url", request.getRequestURL());
		System.out.println("HotDealController 실행");

		try {
			String uri = request.getServletPath();
			System.out.println("uri = " + uri);

			switch (uri) {

			case "/hotdeal/list.do":

				PageObject pageObject = PageObject.getInstance(request);

				HotDealVO searchVO = new HotDealVO();
				searchVO.setPageObject(pageObject);

				String categoryIdStr = request.getParameter("categoryId");
				if (categoryIdStr != null && !categoryIdStr.trim().equals("")) {
					searchVO.setCategoryId(Long.parseLong(categoryIdStr));
				}

				searchVO.setWord(request.getParameter("word"));
				searchVO.setSort(request.getParameter("sort"));

				request.setAttribute("list", Execute.execute(Init.getService(uri), searchVO));
				request.setAttribute("pageObject", pageObject);
				request.setAttribute("searchVO", searchVO);

				return "hotdeal/list";

			default:
				return "error/noPage";
			}

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("e", e);
			return "error/err_500";
		}
	}
}