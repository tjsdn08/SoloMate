package com.solomate.main.controller;

import java.util.HashMap;
import java.util.Map;

import com.solomate.admincategory.controller.AdminCategoryController;
import com.solomate.admincategory.dao.HotDealCategoryDAO;
import com.solomate.admincategory.service.AdminCategoryDeleteService;
import com.solomate.admincategory.service.AdminCategoryListService;
import com.solomate.admincategory.service.AdminCategoryStatusService;
import com.solomate.admincategory.service.AdminCategoryUpdateService;
import com.solomate.admincategory.service.AdminCategoryWriteService;
import com.solomate.adminhotdeal.controller.AdminHotDealController;
import com.solomate.adminhotdeal.service.AdminHotDealDeleteService;
import com.solomate.adminhotdeal.service.AdminHotDealListService;
import com.solomate.adminhotdeal.service.AdminHotDealStatusService;
import com.solomate.adminhotdeal.service.AdminHotDealUpdateService;
import com.solomate.adminhotdeal.service.AdminHotDealViewService;
import com.solomate.adminhotdeal.service.AdminHotDealWriteService;
import com.solomate.board.controller.BoardController;
import com.solomate.board.dao.BoardDAO;
import com.solomate.board.service.BoardDeleteService;
import com.solomate.board.service.BoardListService;
import com.solomate.board.service.BoardUpdateService;
import com.solomate.board.service.BoardViewService;
import com.solomate.board.service.BoardWriteService;
import com.solomate.boardreply.controller.BoardReplyController;
import com.solomate.boardreply.dao.BoardReplyDAO;
import com.solomate.boardreply.service.BoardReplyDeleteService;
import com.solomate.boardreply.service.BoardReplyListService;
import com.solomate.boardreply.service.BoardReplyUpdateService;
import com.solomate.boardreply.service.BoardReplyWriteService;
import com.solomate.folder.controller.FolderController;
import com.solomate.folder.dao.FolderDAO;
import com.solomate.folder.service.FolderDeleteService;
import com.solomate.folder.service.FolderListService;
import com.solomate.folder.service.FolderUpdateService;
import com.solomate.folder.service.FolderViewService;
import com.solomate.folder.service.FolderWriteService;
import com.solomate.food.controller.FoodController;
import com.solomate.food.dao.FoodDAO;
import com.solomate.food.service.FoodDeleteService;
import com.solomate.food.service.FoodListService;
import com.solomate.food.service.FoodUpdateService;
import com.solomate.food.service.FoodViewService;
import com.solomate.food.service.FoodWriteService;
import com.solomate.hotdeal.controller.HotDealController;
import com.solomate.hotdeal.dao.HotDealDAO;
import com.solomate.hotdeal.service.HotDealAddShoppingService;
import com.solomate.hotdeal.service.HotDealListService;
import com.solomate.hotdeal.service.HotDealViewService;
import com.solomate.main.dao.DAO;
import com.solomate.main.service.Service;
import com.solomate.member.controller.MemberController;
import com.solomate.member.dao.MemberDAO;
import com.solomate.member.service.LoginService;
import com.solomate.member.service.MemberChangeConDateService;
import com.solomate.member.service.MemberChangeGradeService;
import com.solomate.member.service.MemberChangePwService;
import com.solomate.member.service.MemberChangeStatusService;
import com.solomate.member.service.MemberListService;
import com.solomate.member.service.MemberSearchIdService;
import com.solomate.member.service.MemberUpdateService;
import com.solomate.member.service.MemberViewService;
import com.solomate.shopping.controller.ShoppingController;
import com.solomate.shopping.dao.ShoppingDAO;
import com.solomate.shopping.service.ShoppingCancelService;
import com.solomate.shopping.service.ShoppingCompleteService;
import com.solomate.shopping.service.ShoppingDeleteService;
import com.solomate.shopping.service.ShoppingListService;
import com.solomate.shopping.service.ShoppingUpdateService;
import com.solomate.shopping.service.ShoppingViewService;
import com.solomate.shopping.service.ShoppingWriteService;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;

public class Init extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private static Map<String, Controller> controllerMap = new HashMap<>();
	private static Map<String, Service> serviceMap = new HashMap<>();
	private static Map<String, DAO> daoMap = new HashMap<>();

	public static Controller getController(String module) {
		return controllerMap.get(module);
	}

	public static Service getService(String uri) {
		return serviceMap.get(uri);
	}

	public void init(ServletConfig config) throws ServletException {

		// ------------------------------장선우--------------------------------
		// shopping
		daoMap.put("shoppingDAO", new ShoppingDAO());

		serviceMap.put("/shopping/list.do", new ShoppingListService());
		serviceMap.put("/shopping/view.do", new ShoppingViewService());
		serviceMap.put("/shopping/write.do", new ShoppingWriteService());
		serviceMap.put("/shopping/update.do", new ShoppingUpdateService());
		serviceMap.put("/shopping/delete.do", new ShoppingDeleteService());
		serviceMap.put("/shopping/complete.do", new ShoppingCompleteService());
		serviceMap.put("/shopping/cancel.do", new ShoppingCancelService());

		serviceMap.get("/shopping/list.do").setDAO(daoMap.get("shoppingDAO"));
		serviceMap.get("/shopping/view.do").setDAO(daoMap.get("shoppingDAO"));
		serviceMap.get("/shopping/write.do").setDAO(daoMap.get("shoppingDAO"));
		serviceMap.get("/shopping/update.do").setDAO(daoMap.get("shoppingDAO"));
		serviceMap.get("/shopping/delete.do").setDAO(daoMap.get("shoppingDAO"));
		serviceMap.get("/shopping/complete.do").setDAO(daoMap.get("shoppingDAO"));
		serviceMap.get("/shopping/cancel.do").setDAO(daoMap.get("shoppingDAO"));

		controllerMap.put("/shopping", new ShoppingController());

		daoMap.put("hotDealDAO", new HotDealDAO());

		// hotdeal
		serviceMap.put("/hotdeal/list.do", new HotDealListService());
		serviceMap.put("/hotdeal/view.do", new HotDealViewService());
		serviceMap.put("/hotdeal/addShopping.do", new HotDealAddShoppingService());

		serviceMap.get("/hotdeal/list.do").setDAO(daoMap.get("hotDealDAO"));
		serviceMap.get("/hotdeal/view.do").setDAO(daoMap.get("hotDealDAO"));
		serviceMap.get("/hotdeal/addShopping.do").setDAO(daoMap.get("shoppingDAO"));

		controllerMap.put("/hotdeal", new HotDealController());

		// 관리자 핫딜
		serviceMap.put("/adminHotDeal/list.do", new AdminHotDealListService());
		serviceMap.put("/adminHotDeal/view.do", new AdminHotDealViewService());
		serviceMap.put("/adminHotDeal/write.do", new AdminHotDealWriteService());
		serviceMap.put("/adminHotDeal/update.do", new AdminHotDealUpdateService());
		serviceMap.put("/adminHotDeal/delete.do", new AdminHotDealDeleteService());
		serviceMap.put("/adminHotDeal/status.do", new AdminHotDealStatusService());

		serviceMap.get("/adminHotDeal/list.do").setDAO(daoMap.get("hotDealDAO"));
		serviceMap.get("/adminHotDeal/view.do").setDAO(daoMap.get("hotDealDAO"));
		serviceMap.get("/adminHotDeal/write.do").setDAO(daoMap.get("hotDealDAO"));
		serviceMap.get("/adminHotDeal/update.do").setDAO(daoMap.get("hotDealDAO"));
		serviceMap.get("/adminHotDeal/delete.do").setDAO(daoMap.get("hotDealDAO"));
		serviceMap.get("/adminHotDeal/status.do").setDAO(daoMap.get("hotDealDAO"));

		controllerMap.put("/adminHotDeal", new AdminHotDealController());

		// 관리자 카테고리
		daoMap.put("categoryDAO", new HotDealCategoryDAO());

		serviceMap.put("/adminCategory/list.do", new AdminCategoryListService());
		serviceMap.put("/adminCategory/write.do", new AdminCategoryWriteService());
		serviceMap.put("/adminCategory/update.do", new AdminCategoryUpdateService());
		serviceMap.put("/adminCategory/delete.do", new AdminCategoryDeleteService());
		serviceMap.put("/adminCategory/status.do", new AdminCategoryStatusService());

		serviceMap.get("/adminCategory/list.do").setDAO(daoMap.get("categoryDAO"));
		serviceMap.get("/adminCategory/write.do").setDAO(daoMap.get("categoryDAO"));
		serviceMap.get("/adminCategory/update.do").setDAO(daoMap.get("categoryDAO"));
		serviceMap.get("/adminCategory/delete.do").setDAO(daoMap.get("categoryDAO"));
		serviceMap.get("/adminCategory/status.do").setDAO(daoMap.get("categoryDAO"));

		controllerMap.put("/adminCategory", new AdminCategoryController());

		// ------------------------------장은희--------------------------------
		// *** 식품 생성 / 저장 / 조립
		// == controller는 모듈명으로 저장
		controllerMap.put("/food", new FoodController());
		// == service는 URI로 저장
		serviceMap.put("/food/list.do", new FoodListService());
		serviceMap.put("/food/view.do", new FoodViewService());
		serviceMap.put("/food/write.do", new FoodWriteService());
		serviceMap.put("/food/update.do", new FoodUpdateService());
		serviceMap.put("/food/delete.do", new FoodDeleteService());
		// == dao는 클래스 이름으로 저장. 맨 앞자를 소문자로 바꾼다.
		daoMap.put("foodDAO", new FoodDAO());
		// 조립 service <- dao : service를 꺼내서 setter를 이용해서 dao를 꺼내서 넣는다.
		serviceMap.get("/food/list.do").setDAO(daoMap.get("foodDAO"));
		serviceMap.get("/food/view.do").setDAO(daoMap.get("foodDAO"));
		serviceMap.get("/food/write.do").setDAO(daoMap.get("foodDAO"));
		serviceMap.get("/food/update.do").setDAO(daoMap.get("foodDAO"));
		serviceMap.get("/food/delete.do").setDAO(daoMap.get("foodDAO"));

		// *** 폴더 생성 / 저장 / 조립
		// == controller는 모듈명으로 저장
		controllerMap.put("/folder", new FolderController());
		// == service는 URI로 저장
		serviceMap.put("/folder/list.do", new FolderListService());
		serviceMap.put("/folder/view.do", new FolderViewService());
		serviceMap.put("/folder/write.do", new FolderWriteService());
		serviceMap.put("/folder/update.do", new FolderUpdateService());
		serviceMap.put("/folder/delete.do", new FolderDeleteService());
		// == dao는 클래스 이름으로 저장. 맨 앞자를 소문자로 바꾼다.
		daoMap.put("folderDAO", new FolderDAO());
		// 조립 service <- dao : service를 꺼내서 setter를 이용해서 dao를 꺼내서 넣는다.
		serviceMap.get("/folder/list.do").setDAO(daoMap.get("folderDAO"));
		serviceMap.get("/folder/view.do").setDAO(daoMap.get("folderDAO"));
		serviceMap.get("/folder/write.do").setDAO(daoMap.get("folderDAO"));
		serviceMap.get("/folder/update.do").setDAO(daoMap.get("folderDAO"));
		serviceMap.get("/folder/delete.do").setDAO(daoMap.get("folderDAO"));

		// ------------------------------박현정--------------------------------
		// *** 일반 게시판 생성 / 저장 / 조립
		// == controller는 모듈명으로 저장
		controllerMap.put("/board", new BoardController());
		// == service는 URI로 저장
		serviceMap.put("/board/list.do", new BoardListService());
		serviceMap.put("/board/view.do", new BoardViewService());
		// writeForm.do는 service 필요 없음.
		serviceMap.put("/board/write.do", new BoardWriteService());
		// updateForm.do 인 경우 먼저 글보기 실행 강제 코딩으로 /board/view.do 로 서비스 꺼내서 실행.
		serviceMap.put("/board/update.do", new BoardUpdateService());
		serviceMap.put("/board/delete.do", new BoardDeleteService());
		// == dao는 클래스 이름으로 저장. 맨 앞자를 소문자로 바꾼다.
		daoMap.put("boardDAO", new BoardDAO());
		// 조립 service <- dao : service를 꺼내서 setter를 이용해서 dao를 꺼내서 넣는다.
		serviceMap.get("/board/list.do").setDAO(daoMap.get("boardDAO"));
		serviceMap.get("/board/view.do").setDAO(daoMap.get("boardDAO"));
		serviceMap.get("/board/write.do").setDAO(daoMap.get("boardDAO"));
		serviceMap.get("/board/update.do").setDAO(daoMap.get("boardDAO"));
		serviceMap.get("/board/delete.do").setDAO(daoMap.get("boardDAO"));

		// *** 일반게시판 댓글 생성 / 저장 / 조립
		// -- Controller 저장 - 모듈 이름
		controllerMap.put("/boardreply", new BoardReplyController());
		// -- Service 저장 - uri
		serviceMap.put("/boardreply/list.do", new BoardReplyListService());
		serviceMap.put("/boardreply/write.do", new BoardReplyWriteService());
		serviceMap.put("/boardreply/update.do", new BoardReplyUpdateService());
		serviceMap.put("/boardreply/delete.do", new BoardReplyDeleteService());
		// -- DAO 저장 - 변수 타입
		daoMap.put("boardReplyDAO", new BoardReplyDAO());
		// -- service에 dao를 조립한다.
		serviceMap.get("/boardreply/list.do").setDAO(daoMap.get("boardReplyDAO"));
		serviceMap.get("/boardreply/write.do").setDAO(daoMap.get("boardReplyDAO"));
		serviceMap.get("/boardreply/update.do").setDAO(daoMap.get("boardReplyDAO"));
		serviceMap.get("/boardreply/delete.do").setDAO(daoMap.get("boardReplyDAO"));

		// -- 꿀팁 아카이브 북마크 Init --
		// *** 북마크 생성 / 저장 / 조립
		// -- Controller 저장 - 모듈 이름 (보통 /bookmark로 시작하는 요청 처리)
		// controllerMap.put("/bookmark", new BookmarkController());

		// -- Service 저장 - uri
		// 1. 북마크 목록 (내가 북마크한 글만 모아보기)
		// serviceMap.put("/bookmark/list.do", new BookmarkListService());
		// 2. 북마크 추가 (등록)
		// serviceMap.put("/bookmark/write.do", new BookmarkWriteService());
		// 3. 북마크 삭제 (해제)
		// serviceMap.put("/bookmark/delete.do", new BookmarkDeleteService());

		// -- DAO 저장 - 변수명으로 저장하여 각 서비스에 주입
		// daoMap.put("bookmarkDAO", new BookmarkDAO());

		// -- Service에 DAO를 조립 (의존성 주입)
//		serviceMap.get("/bookmark/list.do").setDAO(daoMap.get("bookmarkDAO"));
//		serviceMap.get("/bookmark/write.do").setDAO(daoMap.get("bookmarkDAO"));
//		serviceMap.get("/bookmark/delete.do").setDAO(daoMap.get("bookmarkDAO"));

		
		
		
		// ------------------------------고승희--------------------------------
		// 고승희 - 회원관리
		controllerMap.put("/member", new MemberController());
//		// -- Service 저장
		serviceMap.put("/member/login.do", new LoginService());
		serviceMap.put("/member/changeCon.do", new MemberChangeConDateService());
		serviceMap.put("/member/changeGrade.do", new MemberChangeGradeService());
		serviceMap.put("/member/changeStatus.do", new MemberChangeStatusService());
		serviceMap.put("/member/list.do", new MemberListService());
		serviceMap.put("/member/view.do", new MemberViewService());
		serviceMap.put("/member/searchId.do", new MemberSearchIdService());
		serviceMap.put("/member/changePw.do", new MemberChangePwService());
//		serviceMap.put("/member/write.do", new MemberWriteService());
//		serviceMap.put("/member/checkId.do", new MemberCheckIdService());
		serviceMap.put("/member/update.do", new MemberUpdateService());
		
//		//serviceMap.put("/member/checkPw.do", new MemberCheckPwService());
//		// -- DAO 저장
		daoMap.put("memberDAO", new MemberDAO());
//		// service
		serviceMap.get("/member/login.do").setDAO(daoMap.get("memberDAO"));
		serviceMap.get("/member/changeCon.do").setDAO(daoMap.get("memberDAO"));
		serviceMap.get("/member/changeGrade.do").setDAO(daoMap.get("memberDAO"));
		serviceMap.get("/member/changeStatus.do").setDAO(daoMap.get("memberDAO"));
		serviceMap.get("/member/list.do").setDAO(daoMap.get("memberDAO"));
		serviceMap.get("/member/view.do").setDAO(daoMap.get("memberDAO"));
		serviceMap.get("/member/searchId.do").setDAO(daoMap.get("memberDAO"));
		serviceMap.get("/member/changePw.do").setDAO(daoMap.get("memberDAO"));
		serviceMap.get("/member/update.do").setDAO(daoMap.get("memberDAO"));
//		serviceMap.get("/member/write.do").setDAO(daoMap.get("memberDAO"));
//		serviceMap.get("/member/checkId.do").setDAO(daoMap.get("memberDAO"));
//		serviceMap.get("/member/searchId.do").setDAO(daoMap.get("memberDAO"));
//		serviceMap.get("/member/checkPw.do").setDAO(daoMap.get("memberDAO"));

		// 고승희 - 레시피 아카이브

		//controllerMap.put("/recipes", new MemberRecipesController());

		// -- Service 저장
		//serviceMap.put("/recipes/list.do", new RecipesListService());
		//serviceMap.put("/recipes/view.do", new RecipesViewService());
		//serviceMap.put("/recipes/update.do", new RecipesUpdateService());
		//serviceMap.put("/recipes/write.do", new RecipesWriteService());
		//serviceMap.put("/recipes/changeImg.do", new RecipesChangeImgService());
		//serviceMap.put("/recipes/delete.do", new RecipesDeleteService());

		// -- DAO 저장
//		daoMap.put("recipesDAO", new recipesDAO());
//		 -- service
//		serviceMap.get("/recipes/list.do").setDAO(daoMap.get("recipesDAO"));
//		serviceMap.get("/recipes/view.do").setDAO(daoMap.get("recipesDAO"));
//		serviceMap.get("/recipes/update.do").setDAO(daoMap.get("recipesDAO"));
//		serviceMap.get("/recipes/write.do").setDAO(daoMap.get("recipesDAO"));
//		serviceMap.get("/recipes/changeImg.do").setDAO(daoMap.get("recipesDAO"));
//		serviceMap.get("/recipes/delete.do").setDAO(daoMap.get("recipesDAO"));

		// 고승희 - 레시피 아카이브 북마크 처리

		//controllerMap.put("/recipesBookmarks", new MemberRecipesBookmarksController());

		// -- Service 저장
		//serviceMap.put("/recipesBookmarks/list.do", new RecipesBookmarksListService());
		//serviceMap.put("/recipesBookmarks/update.do", new RecipesBookmarksUpdateService());
		//serviceMap.put("/recipesBookmarks/delete.do", new RecipesBookmarksDeleteService());
		// -- DAO 저장
		//daoMap.put("recipesBookmarksDAO", new recipesBookmarksDAO());
		// -- service
//		serviceMap.get("/recipesBookmarks/list.do").setDAO(daoMap.get("recipesBookmarksDAO"));
//		serviceMap.get("/recipesBookmarks/update.do").setDAO(daoMap.get("recipesBookmarksDAO"));
//		serviceMap.get("/recipesBookmarks/delete.do").setDAO(daoMap.get("recipesBookmarksDAO"));
	}
}