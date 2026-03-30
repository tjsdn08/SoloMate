package com.solomate.main.controller;

import java.util.HashMap;
import java.util.Map;

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

		//------------------------------장선우--------------------------------
		// ***장보기 계획
		// DAO
		daoMap.put("shoppingDAO", new ShoppingDAO());
		// Service
		serviceMap.put("/shopping/list.do", new ShoppingListService());
		serviceMap.put("/shopping/view.do", new ShoppingViewService());
		serviceMap.put("/shopping/write.do", new ShoppingWriteService());
		serviceMap.put("/shopping/update.do", new ShoppingUpdateService());
		serviceMap.put("/shopping/delete.do", new ShoppingDeleteService());
		serviceMap.put("/shopping/complete.do", new ShoppingCompleteService());
		serviceMap.put("/shopping/cancel.do", new ShoppingCancelService());
		// 조립
		serviceMap.get("/shopping/list.do").setDAO(daoMap.get("shoppingDAO"));
		serviceMap.get("/shopping/view.do").setDAO(daoMap.get("shoppingDAO"));
		serviceMap.get("/shopping/write.do").setDAO(daoMap.get("shoppingDAO"));
		serviceMap.get("/shopping/update.do").setDAO(daoMap.get("shoppingDAO"));
		serviceMap.get("/shopping/delete.do").setDAO(daoMap.get("shoppingDAO"));
		serviceMap.get("/shopping/complete.do").setDAO(daoMap.get("shoppingDAO"));
		serviceMap.get("/shopping/cancel.do").setDAO(daoMap.get("shoppingDAO"));
		// Controller
		controllerMap.put("/shopping", new ShoppingController());
		
		
		
		// *** 핫딜
		daoMap.put("hotDealDAO", new HotDealDAO());
		serviceMap.put("/hotdeal/list.do", new HotDealListService());
		serviceMap.put("/hotdeal/view.do", new HotDealViewService());
		serviceMap.put("/hotdeal/addShopping.do", new HotDealAddShoppingService());
		serviceMap.get("/hotdeal/list.do").setDAO(daoMap.get("hotDealDAO"));
		serviceMap.get("/hotdeal/view.do").setDAO(daoMap.get("hotDealDAO"));
		serviceMap.get("/hotdeal/addShopping.do").setDAO(daoMap.get("shoppingDAO"));
		controllerMap.put("/hotdeal", new HotDealController());
		
		
		// admin hotdeal service
		serviceMap.put("/adminHotDeal/list.do", new AdminHotDealListService());
		serviceMap.put("/adminHotDeal/view.do", new AdminHotDealViewService());
		serviceMap.put("/adminHotDeal/write.do", new AdminHotDealWriteService());
		serviceMap.put("/adminHotDeal/update.do", new AdminHotDealUpdateService());
		serviceMap.put("/adminHotDeal/delete.do", new AdminHotDealDeleteService());
		serviceMap.put("/adminHotDeal/status.do", new AdminHotDealStatusService());

		// admin hotdeal 조립
		serviceMap.get("/adminHotDeal/list.do").setDAO(daoMap.get("hotDealDAO"));
		serviceMap.get("/adminHotDeal/view.do").setDAO(daoMap.get("hotDealDAO"));
		serviceMap.get("/adminHotDeal/write.do").setDAO(daoMap.get("hotDealDAO"));
		serviceMap.get("/adminHotDeal/update.do").setDAO(daoMap.get("hotDealDAO"));
		serviceMap.get("/adminHotDeal/delete.do").setDAO(daoMap.get("hotDealDAO"));
		serviceMap.get("/adminHotDeal/status.do").setDAO(daoMap.get("hotDealDAO"));

		// admin hotdeal controller
		controllerMap.put("/adminHotDeal", new AdminHotDealController());
		
		
		
		//------------------------------장은희--------------------------------
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
		
		//------------------------------박현정--------------------------------
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
	}
}