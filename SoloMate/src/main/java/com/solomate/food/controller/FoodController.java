package com.solomate.food.controller;

import java.util.ArrayList;
import java.util.List;

import com.solomate.folder.dao.FolderDAO;
import com.solomate.food.vo.FoodVO;
import com.solomate.main.controller.Controller;
import com.solomate.main.controller.Init;
import com.solomate.main.service.Execute;
import com.solomate.member.vo.LoginVO;
import com.solomate.util.page.PageObject;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class FoodController implements Controller {

	@Override
	public String execute(HttpServletRequest request) {
		// TODO Auto-generated method stub
		request.setAttribute("url", request.getRequestURL());
		try { // 정상처리
			String uri = request.getServletPath();
			HttpSession session = request.getSession();
			// 로그인 한 아이디 꺼내기
			LoginVO loginVO = (LoginVO) session.getAttribute("login");
			String loginId = null;
			if(loginVO != null) loginId = loginVO.getId();	
			
			// 사용 변수 선언
			FoodVO vo;
			Integer result;
			Long no;
			switch (uri) {
			case "/food/list.do":
				
				PageObject pageObject = PageObject.getInstance(request);
				
				request.setAttribute("list", Execute.execute(Init.getService(uri), pageObject));
				System.out.println("FoodController.execute().pageObject - " + pageObject);
				request.setAttribute("pageObject", pageObject);
				
				return "food/list";
				
			case "/food/view.do":
				
				no = Long.parseLong(request.getParameter("no"));
				
				request.setAttribute("vo", Execute.execute(Init.getService(uri), no));
				
				return "food/view";
			case "/food/writeForm.do":
				
				// 선택 용 폴더 
				FolderDAO dao = new FolderDAO();
				request.setAttribute("folderList", dao.listAll("test"));
				
				return "food/writeForm";
			
			case "/food/write.do":
				
				vo = new FoodVO();
				vo.setName(request.getParameter("name"));
				vo.setExpiryDate(request.getParameter("expiryDate"));
				vo.setQuantity(Long.parseLong(request.getParameter("quantity")));
				vo.setStorageType(request.getParameter("storageType"));
				vo.setMemo(request.getParameter("memo"));
				vo.setMemberId(loginId);
				
				// 폴더
				String[] folderNoArr = request.getParameterValues("folderNos");
				// 3. 폴더 리스트 세팅
			    if (folderNoArr != null) {
			        List<Long> folderNos = new ArrayList<>();
			        for (String f : folderNoArr) {
			            folderNos.add(Long.parseLong(f));
			        }
			        vo.setFolderNos(folderNos);
			    }
			    // 4. 실행
			    Execute.execute(Init.getService(uri), vo);
				
			    return "redirect:list.do?perPageNum=" + request.getParameter("perPageNum");

			default:
				// /WEB-INF/views + error/noPage + .jsp
				return "error/noPage";
			} // switch ~ case 라벨: ~ default 의 끝
		} // try 정상처리 의 끝
		catch (Exception e) { // 예외 처리
			// 개발자를 위한 코드
			e.printStackTrace();
			e.getStackTrace();
			// 잘못된 예외 처리 - 사용자에게 보여주기
			request.setAttribute("moduleName", "식품 목록 보기");
			request.setAttribute("e", e);
			// /WEB-INF/views + error/err_500 + .jsp
			return "error/err_500";
		} // catch 의 끝
				
	}

}
