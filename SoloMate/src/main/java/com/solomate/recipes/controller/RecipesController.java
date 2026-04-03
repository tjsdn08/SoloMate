package com.solomate.recipes.controller;

import java.io.File;

import com.solomate.main.controller.Controller;
import com.solomate.main.controller.Init;
import com.solomate.main.service.Execute;
import com.solomate.member.vo.LoginVO;
import com.solomate.recipes.vo.RecipesVO;
import com.solomate.util.page.PageObject;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

public class RecipesController implements Controller{

	@Override
	public String execute(HttpServletRequest request) {
		// 잘못된 URI 처리 / 오류를 위한 URL 저장
		request.setAttribute("url", request.getRequestURL());
		try {
			String uri = request.getServletPath();
			HttpSession session = request.getSession();
			RecipesVO vo;
//			Integer result;
			Long no;
			LoginVO loginvo;
			
			switch (uri) {
			case "/recipes/list.do": 
				PageObject pageObject = PageObject.getInstance(request);
				
				request.setAttribute("list", Execute.execute(Init.getService(uri), pageObject));
				System.out.println("RecipesController.execuete().pageObject - " + pageObject);
				request.setAttribute("pageObject", pageObject);
				return "recipes/list";
			
			case "/recipes/view.do":
			    no = Long.parseLong(request.getParameter("no"));
			    
			    // 로그인 아이디 가져오기 (북마크 여부 확인용)
			    String loginId = null;
			    LoginVO loginForBookmark = (LoginVO) session.getAttribute("login");
			    if (loginForBookmark != null) loginId = loginForBookmark.getId();

			    vo = (RecipesVO) Execute.execute(Init.getService(uri), new Object[]{no, loginId});

			    request.setAttribute("vo", vo);
			    request.setAttribute("pageObject", PageObject.getInstance(request));

			    return "recipes/view";
			    
	 			case "/recipes/writeForm.do":
	 				return "recipes/writeForm";


	 			case "/recipes/write.do":
	 			    System.out.println("recipes/write.do - 레시피 등록 처리");

	 			    RecipesVO writeVo = new RecipesVO();
	 			    writeVo.setRecipes_title(request.getParameter("recipes_title"));
	 			    writeVo.setDescription(request.getParameter("description"));
	 			    writeVo.setRecipes_content(request.getParameter("recipes_content"));
	 			    writeVo.setFood(request.getParameter("food"));
	 			    writeVo.setRecipes_time(Integer.parseInt(request.getParameter("recipes_time")));
	 			    writeVo.setRecipes_level(request.getParameter("recipes_level"));

	 			    Part filePart = request.getPart("imageFile");
	 			    String fileName = filePart.getSubmittedFileName();
	 			    
	 			    if (fileName != null && !fileName.isEmpty()) {
	 			        String savePath = request.getServletContext().getRealPath("/upload/recipes");
	 			        File uploadDir = new File(savePath);
	 			        if (!uploadDir.exists()) uploadDir.mkdirs();
	 			        filePart.write(savePath + File.separator + fileName);
	 			        writeVo.setRecipes_img("/upload/recipes/" + fileName);
	 			    }

	 			    LoginVO login = (LoginVO) session.getAttribute("login");
	 			    if (login != null) {
	 			        writeVo.setId(login.getId());
	 			        writeVo.setName(login.getName());
	 			    }

	 			    Execute.execute(Init.getService(uri), writeVo);

	 			    session.setAttribute("msg", "레시피가 성공적으로 등록되었습니다.");
	 			    
	 			    // perPageNum이 null이면 그냥 list.do로, 있으면 파라미터를 붙여서 이동
	 			    String perPageNum = request.getParameter("perPageNum");
	 			    if (perPageNum == null || perPageNum.equals("null") || perPageNum.isEmpty()) {
	 			        return "redirect:list.do";
	 			    } else {
	 			        return "redirect:list.do?perPageNum=" + perPageNum;
	 			    }
	 			    
	 			case "/recipes/delete.do":
					System.out.println("recipes/delete.do - 레시피 삭제 처리");
					
					no = Long.parseLong(request.getParameter("no"));
					
					Execute.execute(Init.getService(uri), no);
					
					session.setAttribute("msg", "레시피가 삭제되었습니다.");
					
					return "redirect:list.do?perPageNum=" + request.getParameter("perPageNum");
					
					
	 			case "/recipes/updateForm.do":
	 			    System.out.println("recipes/updateForm.do - 수정 폼 이동");
	 			    no = Long.parseLong(request.getParameter("no"));
	 			    
	 			    vo = (RecipesVO) Execute.execute(Init.getService("/recipes/view.do"), new Object[]{no, 0});
	 			    request.setAttribute("vo", vo);
	 			    
	 			    return "recipes/updateForm";

	 			case "/recipes/update.do":
	 			    System.out.println("recipes/update.do - 텍스트 내용 수정 처리");
	 			    
	 			    vo = new RecipesVO();
	 			    vo.setRecipes_no(Long.parseLong(request.getParameter("recipes_no")));
	 			    vo.setRecipes_title(request.getParameter("recipes_title"));
	 			    vo.setDescription(request.getParameter("description"));
	 			    vo.setRecipes_content(request.getParameter("recipes_content"));
	 			    vo.setFood(request.getParameter("food"));
	 			    vo.setRecipes_time(Integer.parseInt(request.getParameter("recipes_time")));
	 			    vo.setRecipes_level(request.getParameter("recipes_level"));
	 			    loginvo = (LoginVO) session.getAttribute("login");
	 			    if (loginvo != null) {
	 			        vo.setId(loginvo.getId());
	 			    }
	 			    Execute.execute(Init.getService(uri), vo);
	 			    session.setAttribute("msg", "레시피 정보가 수정되었습니다.");
	 			    
	 			    return "redirect:view.do?no=" + vo.getRecipes_no() 
	 			         + "&inc=0&perPageNum=" + request.getParameter("perPageNum");
					
	 			    
	 			    
	 			case "/recipes/imageChangeForm.do":
	 			    System.out.println("recipes/imageChangeForm.do - 이미지 변경 폼으로 이동");
	 			    no = Long.parseLong(request.getParameter("no"));
	 			    // 기존 이미지를 보여주기
	 			    vo = (RecipesVO) Execute.execute(Init.getService("/recipes/view.do"), new Object[]{no, 0});
	 			    request.setAttribute("vo", vo);
	 			    return "recipes/imageChangeForm"; // JSP로 이동

				case "/recipes/imageChange.do":
					System.out.println("recipes/imageChange.do - 이미지 변경 처리");
					
					RecipesVO imgVo = new RecipesVO();
					long changeNo = Long.parseLong(request.getParameter("no"));
					imgVo.setRecipes_no(changeNo);
					
					Part imgPart = request.getPart("imageFile");
					String newFileName = imgPart.getSubmittedFileName();
					String savePath = request.getServletContext().getRealPath("/upload/recipes");
					
					if (newFileName != null && !newFileName.isEmpty()) {
						imgPart.write(savePath + File.separator + newFileName);
						imgVo.setRecipes_img("/upload/recipes/" + newFileName);
						
						//기존 파일 삭제
						String oldPath = request.getParameter("old_img");
						if (oldPath != null && !oldPath.isEmpty()) {
							File oldFile = new File(request.getServletContext().getRealPath(oldPath));
							if (oldFile.exists()) oldFile.delete(); 
						}
					}

					LoginVO loginUser = (LoginVO) session.getAttribute("login");
					imgVo.setId(loginUser.getId());

					Execute.execute(Init.getService(uri), imgVo);
					
					session.setAttribute("msg", "대표 이미지가 변경되었습니다.");
					return "redirect:view.do?no=" + changeNo + "&inc=0&perPageNum=" + request.getParameter("perPageNum");
	 			    
	 			    
			default:
				return "error/noPage";
			}
			
			
		}catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("url", request.getRequestURL());
			request.setAttribute("moduleName", "레시피 아카이브");
			request.setAttribute("e", e);
			return "error/err_500";
		}
	}

}
