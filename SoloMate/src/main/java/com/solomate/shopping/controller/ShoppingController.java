package com.solomate.shopping.controller;

import com.solomate.main.controller.Controller;
import com.solomate.main.controller.Init;
import com.solomate.main.service.Execute;
import com.solomate.member.vo.LoginVO;
import com.solomate.shopping.vo.ShoppingVO;
import com.solomate.util.page.PageObject;

import jakarta.servlet.http.HttpServletRequest;

public class ShoppingController implements Controller {

	@Override
	public String execute(HttpServletRequest request) {

		request.setAttribute("url", request.getRequestURL());
		System.out.println("ShoppingController 실행");

		try {
			String uri = request.getServletPath();
			System.out.println("uri = " + uri);

			LoginVO loginVO = (LoginVO) request.getSession().getAttribute("login");
			String memberId = null;

			if (loginVO != null) {
				memberId = loginVO.getId();
			}

			switch (uri) {

			case "/shopping/list.do":

				if (memberId == null) {
					request.getSession().setAttribute("msg", "로그인 후 이용 가능합니다.");
					return "redirect:/member/loginForm.do";
				}

				PageObject pageObject = PageObject.getInstance(request);

				ShoppingVO searchVO = new ShoppingVO();
				searchVO.setPageObject(pageObject);
				searchVO.setMemberId(memberId);
				searchVO.setStatus(request.getParameter("status"));
				searchVO.setPlanDateSearch(request.getParameter("planDate"));
				searchVO.setWord(request.getParameter("word"));

				request.setAttribute("list", Execute.execute(Init.getService(uri), searchVO));
				request.setAttribute("pageObject", pageObject);
				request.setAttribute("searchVO", searchVO);

				System.out.println("ShoppingController.execute().pageObject - " + pageObject);

				return "shopping/list";

			case "/shopping/view.do":

				Long shoppingId = Long.parseLong(request.getParameter("shoppingId"));
				request.setAttribute("vo", Execute.execute(Init.getService(uri), shoppingId));

				return "shopping/view";

			case "/shopping/writeForm.do":

				if (memberId == null) {
					request.getSession().setAttribute("msg", "로그인 후 이용 가능합니다.");
					return "redirect:/member/loginForm.do";
				}

				return "shopping/writeForm";

			case "/shopping/write.do":

				if (memberId == null) {
					request.getSession().setAttribute("msg", "로그인 후 이용 가능합니다.");
					return "redirect:/member/loginForm.do";
				}

				ShoppingVO vo = new ShoppingVO();
				vo.setMemberId(memberId);

				String dealIdStr = request.getParameter("dealId");
				if (dealIdStr != null && !dealIdStr.trim().equals("")) {
					vo.setDealId(Long.parseLong(dealIdStr));
				}

				vo.setItemName(request.getParameter("itemName"));
				vo.setQuantity(Integer.parseInt(request.getParameter("quantity")));
				vo.setExpectedPrice(Long.parseLong(request.getParameter("expectedPrice")));
				vo.setPlanDate(request.getParameter("planDate"));
				vo.setSourceType("DIRECT");
				vo.setMemo(request.getParameter("memo"));

				Integer result = (Integer) Execute.execute(Init.getService(uri), vo);

				if (result == 1) {
					request.getSession().setAttribute("msg", "장보기 항목이 등록되었습니다.");
				} else {
					request.getSession().setAttribute("msg", "장보기 등록에 실패했습니다.");
				}

				return "redirect:list.do?perPageNum="
						+ (request.getParameter("perPageNum") == null ? "10" : request.getParameter("perPageNum"));

			case "/shopping/updateForm.do":

				Long shoppingId2 = Long.parseLong(request.getParameter("shoppingId"));

				request.setAttribute("vo",
						Execute.execute(Init.getService("/shopping/view.do"), shoppingId2));

				return "shopping/updateForm";

			case "/shopping/update.do":

				ShoppingVO vo2 = new ShoppingVO();
				vo2.setShoppingId(Long.parseLong(request.getParameter("shoppingId")));
				vo2.setItemName(request.getParameter("itemName"));
				vo2.setQuantity(Integer.parseInt(request.getParameter("quantity")));
				vo2.setExpectedPrice(Long.parseLong(request.getParameter("expectedPrice")));
				vo2.setPlanDate(request.getParameter("planDate"));
				vo2.setStatus(request.getParameter("status"));
				vo2.setMemo(request.getParameter("memo"));

				Integer result2 = (Integer) Execute.execute(Init.getService(uri), vo2);

				if (result2 == 1) {
					request.getSession().setAttribute("msg", "장보기 항목이 수정되었습니다.");
				} else {
					request.getSession().setAttribute("msg", "장보기 수정에 실패했습니다.");
				}

				return "redirect:view.do?shoppingId=" + vo2.getShoppingId();

			case "/shopping/delete.do":

				Long deleteId = Long.parseLong(request.getParameter("shoppingId"));

				Integer delResult = (Integer) Execute.execute(Init.getService(uri), deleteId);

				if (delResult == 1) {
					request.getSession().setAttribute("msg", "삭제되었습니다.");
				} else {
					request.getSession().setAttribute("msg", "삭제 실패");
				}

				return "redirect:list.do";

			case "/shopping/complete.do":

				Long completeId = Long.parseLong(request.getParameter("shoppingId"));

				Integer comResult = (Integer) Execute.execute(Init.getService(uri), completeId);

				if (comResult == 1) {
					request.getSession().setAttribute("msg", "구매 완료 처리되었습니다.");
				} else {
					request.getSession().setAttribute("msg", "처리 실패");
				}

				return "redirect:view.do?shoppingId=" + completeId;

			case "/shopping/cancel.do":

				Long cancelId = Long.parseLong(request.getParameter("shoppingId"));

				Integer cancelResult = (Integer) Execute.execute(Init.getService(uri), cancelId);

				if (cancelResult == 1) {
					request.getSession().setAttribute("msg", "취소 처리되었습니다.");
				} else {
					request.getSession().setAttribute("msg", "취소 실패");
				}

				return "redirect:view.do?shoppingId=" + cancelId;

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