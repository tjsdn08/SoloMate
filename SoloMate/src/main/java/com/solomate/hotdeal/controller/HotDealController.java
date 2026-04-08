package com.solomate.hotdeal.controller;

import com.solomate.hotdeal.vo.HotDealVO;
import com.solomate.main.controller.Controller;
import com.solomate.main.controller.Init;
import com.solomate.main.service.Execute;
import com.solomate.member.vo.LoginVO;
import com.solomate.shopping.vo.ShoppingVO;
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

			LoginVO loginVO = (LoginVO) request.getSession().getAttribute("login");
			String memberId = null;

			if (loginVO != null) {
				memberId = loginVO.getId();
			}

			switch (uri) {

			case "/hotdeal/list.do":

				PageObject pageObject = PageObject.getInstance(request);

				HotDealVO searchVO = new HotDealVO();
				searchVO.setPageObject(pageObject);
				searchVO.setMemberId(memberId);

				String categoryIdStr = request.getParameter("categoryId");
				if (categoryIdStr != null && !categoryIdStr.trim().equals("")) {
					searchVO.setCategoryId(Long.parseLong(categoryIdStr));
				}

				searchVO.setWord(request.getParameter("word"));
				searchVO.setSort(request.getParameter("sort"));

				request.setAttribute("list", Execute.execute(Init.getService(uri), searchVO));

				request.setAttribute("categoryList",
						Execute.execute(Init.getService("/hotdeal/categoryList.do"), null));

				request.setAttribute("pageObject", pageObject);
				request.setAttribute("searchVO", searchVO);

				return "hotdeal/list";

			case "/hotdeal/view.do":

				Long dealId2 = Long.parseLong(request.getParameter("dealId"));

				HotDealVO viewVO = new HotDealVO();
				viewVO.setDealId(dealId2);
				viewVO.setMemberId(memberId);

				request.setAttribute("vo", Execute.execute(Init.getService(uri), viewVO));

				return "hotdeal/view";

			case "/hotdeal/addShopping.do":

				Long dealId = Long.parseLong(request.getParameter("dealId"));

				if (memberId == null) {
					request.getSession().setAttribute("msg", "로그인 후 이용 가능합니다.");
					return "redirect:/member/loginForm.do";
				}

				ShoppingVO shoppingVO = new ShoppingVO();
				shoppingVO.setDealId(dealId);
				shoppingVO.setMemberId(memberId);

				Integer result = (Integer) Execute.execute(Init.getService(uri), shoppingVO);

				if (result == 1) {
					request.getSession().setAttribute("msg", "장보기에 추가되었습니다.");
				} else {
					request.getSession().setAttribute("msg", "이미 내 장보기에 추가된 상품입니다.");
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