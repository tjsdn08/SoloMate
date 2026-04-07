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

				// 핫딜 목록
				request.setAttribute("list", Execute.execute(Init.getService(uri), searchVO));

				// 활성 카테고리 목록
				request.setAttribute("categoryList",
						Execute.execute(Init.getService("/hotdeal/categoryList.do"), null));

				request.setAttribute("pageObject", pageObject);
				request.setAttribute("searchVO", searchVO);

				return "hotdeal/list";

			case "/hotdeal/view.do":

				Long dealId2 = Long.parseLong(request.getParameter("dealId"));

				request.setAttribute("vo", Execute.execute(Init.getService(uri), dealId2));

				return "hotdeal/view";

			case "/hotdeal/addShopping.do":

				Long dealId = Long.parseLong(request.getParameter("dealId"));

				Integer result = (Integer) Execute.execute(Init.getService(uri), dealId);

				if (result == 1) {
					request.getSession().setAttribute("msg", "장보기에 추가되었습니다.");
				} else {
					request.getSession().setAttribute("msg", "이미 장보기에 추가된 상품입니다.");
				}

				return "redirect:list.do";

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