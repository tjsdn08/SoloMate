package com.solomate.main.controller;

import java.util.HashMap;
import java.util.Map;

import com.solomate.food.controller.FoodController;
import com.solomate.food.dao.FoodDAO;
import com.solomate.food.service.FoodListService;
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

		// 장보기 계획
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
		
		
		// *** 식품 생성 / 저장 / 조립
		// == controller는 모듈명으로 저장
		controllerMap.put("/food", new FoodController());
		// == service는 URI로 저장
		serviceMap.put("/food/list.do", new FoodListService());
		// == dao는 클래스 이름으로 저장. 맨 앞자를 소문자로 바꾼다.
		daoMap.put("foodDAO", new FoodDAO());
		// 조립 service <- dao : service를 꺼내서 setter를 이용해서 dao를 꺼내서 넣는다.
		serviceMap.get("/food/list.do").setDAO(daoMap.get("foodDAO"));

	}
}