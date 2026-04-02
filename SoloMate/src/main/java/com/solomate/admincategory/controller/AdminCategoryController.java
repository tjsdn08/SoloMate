package com.solomate.admincategory.controller;

import com.solomate.admincategory.vo.HotDealCategoryVO;
import com.solomate.main.controller.Controller;
import com.solomate.main.controller.Init;
import com.solomate.main.service.Execute;

import jakarta.servlet.http.HttpServletRequest;

public class AdminCategoryController implements Controller {

	@Override
	public String execute(HttpServletRequest request) {

		try {
			String uri = request.getServletPath();

			switch (uri) {

			case "/adminCategory/list.do":
				request.setAttribute("list", Execute.execute(Init.getService(uri), null));
				return "adminCategory/list";

			case "/adminCategory/write.do":
				HotDealCategoryVO wvo = new HotDealCategoryVO();
				wvo.setCategoryName(request.getParameter("categoryName"));
				wvo.setStatus(request.getParameter("status"));

				Execute.execute(Init.getService(uri), wvo);
				request.getSession().setAttribute("msg", "카테고리가 등록되었습니다.");
				return "redirect:list.do";

			case "/adminCategory/update.do":
				HotDealCategoryVO uvo = new HotDealCategoryVO();
				uvo.setCategoryId(Long.parseLong(request.getParameter("categoryId")));
				uvo.setCategoryName(request.getParameter("categoryName"));
				uvo.setStatus(request.getParameter("status"));

				Execute.execute(Init.getService(uri), uvo);
				request.getSession().setAttribute("msg", "카테고리가 수정되었습니다.");
				return "redirect:list.do";

			case "/adminCategory/delete.do":
				Long deleteId = Long.parseLong(request.getParameter("categoryId"));
				Execute.execute(Init.getService(uri), deleteId);
				request.getSession().setAttribute("msg", "카테고리가 삭제되었습니다.");
				return "redirect:list.do";

			case "/adminCategory/status.do":
				HotDealCategoryVO svo = new HotDealCategoryVO();
				svo.setCategoryId(Long.parseLong(request.getParameter("categoryId")));
				svo.setStatus(request.getParameter("status"));

				Execute.execute(Init.getService(uri), svo);
				request.getSession().setAttribute("msg", "상태가 변경되었습니다.");
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