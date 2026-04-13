package com.solomate.recipesbookmark.controller;

import java.util.List;

import com.solomate.main.controller.Controller;
import com.solomate.main.controller.Init;
import com.solomate.main.service.Execute;
import com.solomate.member.vo.LoginVO;
import com.solomate.recipesbookmark.vo.RecipesBookmarkVO;
import com.solomate.util.page.PageObject;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class RecipesBookmarkController implements Controller {

	@SuppressWarnings("unchecked")
	@Override
	public String execute(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		// 세션에서 로그인 정보 꺼내기
		LoginVO login = (LoginVO) session.getAttribute("login");
		String id = null;
		if(login != null) id = login.getId();
		
		PageObject pageObject;
		request.setAttribute("url", request.getRequestURL());
		
		try {
			String uri = request.getServletPath();
			long no;
			String from;
			String query;

			switch(uri) {
			// 1. 내가 북마크한 레시피 목록 보기
			case "/recipesbookmark/list.do":
				// 페이지 정보 생성
				pageObject = PageObject.getInstance(request);
				
				// 서비스에 넘길 데이터: [0] PageObject, [1] id
				Object[] listObjs = {pageObject, id}; 
				
				// 서비스 실행 및 리스트 수집
				List<RecipesBookmarkVO> list = (List<RecipesBookmarkVO>) Execute.execute(Init.getService(uri), listObjs);
				
				// JSP에 데이터 전달
				request.setAttribute("list", list);
				request.setAttribute("pageObject", pageObject);
				
				return "recipesbookmark/list";
				
			// 2. 레시피 북마크 추가 처리
			case "/recipesbookmark/write.do":
				// 수정할 레시피 번호와 이전 페이지 정보 수집
				no = Long.parseLong(request.getParameter("no"));
			    from = request.getParameter("from");

			    String pageStr = request.getParameter("page");
			    String perPageNumStr = request.getParameter("perPageNum");

			    if (pageStr == null || pageStr.equals("null") || pageStr.isEmpty()) pageStr = "1";
			    if (perPageNumStr == null || perPageNumStr.equals("null") || perPageNumStr.isEmpty()) perPageNumStr = "10";

			    RecipesBookmarkVO writeVo = new RecipesBookmarkVO();
			    writeVo.setRecipes_no(no);
			    writeVo.setId(id);
			    Execute.execute(Init.getService(uri), writeVo);

			    query = "no=" + no + "&inc=0&page=" + pageStr + "&perPageNum=" + perPageNumStr;
			    if (from != null && !from.isEmpty()) query += "&from=" + from;

			    session.setAttribute("msg", "레시피가 북마크에 추가되었습니다.");
			    return "redirect:/recipes/view.do?" + query;
				
			// 3. 레시피 북마크 삭제(해제) 처리
			case "/recipesbookmark/delete.do":
				no = Long.parseLong(request.getParameter("no"));
				from = request.getParameter("from");           
				String action = request.getParameter("action");

				// VO에 삭제할 정보 세팅
				RecipesBookmarkVO deleteVo = new RecipesBookmarkVO();
				deleteVo.setRecipes_no(no);
				deleteVo.setId(id);

				// 삭제 서비스 실행
				Execute.execute(Init.getService(uri), deleteVo);

			    String page = request.getParameter("page");
			    String perPageNum = request.getParameter("perPageNum");

			    if (page == null || page.equals("null") || page.isEmpty()) page = "1";
			    if (perPageNum == null || perPageNum.equals("null") || perPageNum.isEmpty()) perPageNum = "10";

			    if ("view".equals(action)) {
			        query = "no=" + no + "&inc=0&page=" + page + "&perPageNum=" + perPageNum;
			        if(from != null && !from.isEmpty()) query += "&from=" + from;
			        session.setAttribute("msg", "북마크가 해제되었습니다.");
			        return "redirect:/recipes/view.do?" + query;
			    } 
			    else {
			        session.setAttribute("msg", "북마크 리스트에서 삭제되었습니다.");
			        return "redirect:/recipesbookmark/list.do?page=" + page + "&perPageNum=" + perPageNum;
			    }
				
			default:
				return "error/noPage";
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("moduleName", "레시피 북마크 관리");
			request.setAttribute("e", e);
			return "error/err_500";
		}
	}
}