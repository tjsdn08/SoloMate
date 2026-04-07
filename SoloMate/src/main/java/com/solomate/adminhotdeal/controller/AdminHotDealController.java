package com.solomate.adminhotdeal.controller;

import java.io.File;
import java.util.UUID;

import com.solomate.hotdeal.vo.HotDealVO;
import com.solomate.main.controller.Controller;
import com.solomate.main.controller.Init;
import com.solomate.main.service.Execute;
import com.solomate.util.page.PageObject;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;

public class AdminHotDealController implements Controller {

	@Override
	public String execute(HttpServletRequest request) {

		request.setAttribute("url", request.getRequestURL());

		try {
			String uri = request.getServletPath();

			switch (uri) {

			case "/adminHotDeal/list.do":

				PageObject pageObject = PageObject.getInstance(request);

				HotDealVO searchVO = new HotDealVO();
				searchVO.setPageObject(pageObject);
				searchVO.setWord(request.getParameter("word"));
				searchVO.setStatus(request.getParameter("status"));

				String categoryIdStr = request.getParameter("categoryId");
				if (categoryIdStr != null && !categoryIdStr.trim().equals("")) {
					searchVO.setCategoryId(Long.parseLong(categoryIdStr));
				}

				request.setAttribute("list", Execute.execute(Init.getService(uri), searchVO));
				request.setAttribute("pageObject", pageObject);
				request.setAttribute("searchVO", searchVO);

				// 관리자 카테고리 목록 추가
				request.setAttribute("categoryList",
						Execute.execute(Init.getService("/adminCategory/list.do"), null));

				return "adminHotDeal/list";

			case "/adminHotDeal/view.do":

				Long dealId = Long.parseLong(request.getParameter("dealId"));
				request.setAttribute("vo", Execute.execute(Init.getService(uri), dealId));

				return "adminHotDeal/view";

			case "/adminHotDeal/writeForm.do":

				request.setAttribute("categoryList",
						Execute.execute(Init.getService("/adminCategory/list.do"), null));

				return "adminHotDeal/writeForm";

			case "/adminHotDeal/write.do":

				HotDealVO writeVO = new HotDealVO();
				setData(request, writeVO, false);

				Integer writeResult = (Integer) Execute.execute(Init.getService(uri), writeVO);

				request.getSession().setAttribute("msg",
						writeResult == 1 ? "핫딜이 등록되었습니다." : "핫딜 등록 실패");

				return "redirect:list.do";

			case "/adminHotDeal/updateForm.do":

				Long updateFormId = Long.parseLong(request.getParameter("dealId"));
				request.setAttribute("vo", Execute.execute(Init.getService("/adminHotDeal/view.do"), updateFormId));
				request.setAttribute("categoryList",
						Execute.execute(Init.getService("/adminCategory/list.do"), null));

				return "adminHotDeal/updateForm";

			case "/adminHotDeal/update.do":

				HotDealVO updateVO = new HotDealVO();
				updateVO.setDealId(Long.parseLong(request.getParameter("dealId")));
				setData(request, updateVO, true);

				Integer updateResult = (Integer) Execute.execute(Init.getService(uri), updateVO);

				request.getSession().setAttribute("msg",
						updateResult == 1 ? "핫딜이 수정되었습니다." : "핫딜 수정 실패");

				return "redirect:view.do?dealId=" + updateVO.getDealId();

			case "/adminHotDeal/delete.do":

				Long deleteId = Long.parseLong(request.getParameter("dealId"));
				Integer deleteResult = (Integer) Execute.execute(Init.getService(uri), deleteId);

				request.getSession().setAttribute("msg",
						deleteResult == 1 ? "핫딜이 삭제되었습니다." : "핫딜 삭제 실패");

				return "redirect:list.do";

			case "/adminHotDeal/status.do":

				HotDealVO statusVO = new HotDealVO();
				statusVO.setDealId(Long.parseLong(request.getParameter("dealId")));
				statusVO.setStatus(request.getParameter("status"));

				Integer statusResult = (Integer) Execute.execute(Init.getService(uri), statusVO);

				request.getSession().setAttribute("msg",
						statusResult == 1 ? "상태가 변경되었습니다." : "상태 변경 실패");

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

	private void setData(HttpServletRequest request, HotDealVO vo, boolean isUpdate) throws Exception {
		vo.setCategoryId(Long.parseLong(request.getParameter("categoryId")));
		vo.setTitle(request.getParameter("title"));

		Long price = Long.parseLong(request.getParameter("price"));
		Long originalPrice = Long.parseLong(request.getParameter("originalPrice"));

		vo.setPrice(price);
		vo.setOriginalPrice(originalPrice);

		double discountRate = 0;
		if (originalPrice > 0 && originalPrice >= price) {
			discountRate = Math.round((originalPrice - price) * 100.0 / originalPrice);
		}
		vo.setDiscountRate(discountRate);

		vo.setShopName(request.getParameter("shopName"));
		vo.setSellerName(request.getParameter("sellerName"));
		vo.setDealUrl(request.getParameter("dealUrl"));
		vo.setDescription(request.getParameter("description"));
		vo.setEndDate(request.getParameter("endDate"));

		String status = request.getParameter("status");
		if (status == null || status.trim().equals("")) {
			status = "ACTIVE";
		}
		vo.setStatus(status);

		// 이미지 처리
		Part imagePart = request.getPart("imageFile");
		String imageFileName = null;

		if (imagePart != null && imagePart.getSize() > 0) {
			String originalFileName = imagePart.getSubmittedFileName();

			if (originalFileName != null && !originalFileName.trim().equals("")) {
				String ext = "";
				int dotIdx = originalFileName.lastIndexOf(".");
				if (dotIdx != -1) {
					ext = originalFileName.substring(dotIdx);
				}

				String saveFileName = UUID.randomUUID().toString() + ext;

				String uploadPath = request.getServletContext().getRealPath("/upload/hotdeal");
				File uploadDir = new File(uploadPath);
				if (!uploadDir.exists()) {
					uploadDir.mkdirs();
				}

				imagePart.write(uploadPath + File.separator + saveFileName);
				imageFileName = saveFileName;
			}
		}

		// 등록일 때
		if (!isUpdate) {
			if (imageFileName == null) {
				imageFileName = "default.png";
			}
			vo.setImageUrl(imageFileName);
		}
		// 수정일 때
		else {
			if (imageFileName != null) {
				vo.setImageUrl(imageFileName);
			} else {
				String oldImageUrl = request.getParameter("oldImageUrl");
				if (oldImageUrl == null || oldImageUrl.trim().equals("")) {
					oldImageUrl = "default.png";
				}
				vo.setImageUrl(oldImageUrl);
			}
		}
	}
}