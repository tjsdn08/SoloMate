<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>핫딜 리스트</title>

<style>
.hotdeal-page {
	padding: 30px;
}

.hotdeal-wrap {
	background: #fff;
	border-radius: 18px;
	padding: 18px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
}

.hotdeal-search-bar {
	display: grid;
	grid-template-columns: 1fr 110px 130px 100px;
	gap: 10px;
	align-items: center;
	margin-bottom: 20px;
}

.hotdeal-search-input {
	position: relative;
}

.hotdeal-search-input input {
	width: 100%;
	height: 52px;
	border: 1px solid #ddd;
	border-radius: 12px;
	padding: 0 16px 0 42px;
	font-size: 16px;
	outline: none;
}

.hotdeal-search-input input:focus, .hotdeal-select:focus {
	border-color: #222;
}

.hotdeal-search-icon {
	position: absolute;
	left: 14px;
	top: 50%;
	transform: translateY(-50%);
	font-size: 16px;
	color: #888;
}

.hotdeal-select {
	width: 100%;
	height: 52px;
	border: 1px solid #ddd;
	border-radius: 12px;
	padding: 0 14px;
	font-size: 15px;
	background: #fff;
	outline: none;
}

.hotdeal-search-btn {
	height: 52px;
	border: none;
	border-radius: 12px;
	background: #03051a;
	color: #fff;
	font-size: 15px;
	font-weight: 700;
}

.hotdeal-grid {
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: 18px;
}

.hotdeal-item {
	border: 1px solid #e8e8e8;
	border-radius: 16px;
	overflow: hidden;
	background: #fff;
	transition: 0.2s;
	cursor: pointer;
}

.hotdeal-item:hover {
	box-shadow: 0 6px 18px rgba(0, 0, 0, 0.08);
	transform: translateY(-2px);
}

.hotdeal-thumb {
	width: 100%;
	height: 265px;
	background: #f5f5f5;
	overflow: hidden;
}

.hotdeal-thumb img {
	width: 100%;
	height: 100%;
	object-fit: cover;
	display: block;
}

.hotdeal-body {
	padding: 14px 14px 18px 14px;
}

.hotdeal-title {
	font-size: 22px;
	font-weight: 700;
	color: #222;
	margin-bottom: 4px;
	min-height: auto;
	line-height: 1.5;
}

.hotdeal-shop {
	display: inline-block;
	font-size: 12px;
	color: #666;
	background: #f2f3f5;
	padding: 4px 8px;
	border-radius: 8px;
	margin-bottom: 14px;
}

.hotdeal-price-row {
	display: flex;
	align-items: baseline;
	gap: 8px;
	margin-bottom: 14px;
}

.hotdeal-price {
	font-size: 18px;
	font-weight: 800;
	color: #111;
}

.hotdeal-original {
	font-size: 13px;
	color: #999;
	text-decoration: line-through;
}

.hotdeal-bottom {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.discount-badge {
	display: inline-block;
	padding: 6px 10px;
	border-radius: 6px;
	background: #b63b46;
	color: #fff;
	font-size: 13px;
	font-weight: 700;
}

.add-btn {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	height: 42px;
	padding: 0 16px;
	border-radius: 12px;
	background: #03051a;
	color: #fff;
	font-size: 15px;
	font-weight: 700;
	text-decoration: none;
}

.add-btn:hover {
	color: #fff;
	text-decoration: none;
	opacity: 0.93;
}

.add-done {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	height: 42px;
	padding: 0 16px;
	border-radius: 12px;
	background: #9aa0a6;
	color: #fff;
	font-size: 15px;
	font-weight: 700;
}

.empty-box {
	padding: 80px 0;
	text-align: center;
	color: #888;
	font-size: 16px;
}

@media ( max-width : 1200px) {
	.hotdeal-grid {
		grid-template-columns: repeat(2, 1fr);
	}
}

@media ( max-width : 768px) {
	.hotdeal-search-bar {
		grid-template-columns: 1fr;
	}
	.hotdeal-grid {
		grid-template-columns: 1fr;
	}
}
</style>

<script type="text/javascript">
	$(function() {

		$("#categoryId").val("${searchVO.categoryId}");
		$("#sort").val("${searchVO.sort}");
		$("#word").val("${searchVO.word}");

		$(".hotdeal-item")
				.click(
						function(e) {
							if ($(e.target).closest(".add-btn").length > 0)
								return;
							if ($(e.target).closest(".add-done").length > 0)
								return;

							let dealId = $(this).data("id");
							location = "${pageContext.request.contextPath}/hotdeal/view.do?dealId="
									+ dealId;
						});
	});
</script>
</head>
<body>

	<div class="hotdeal-page">
		<div class="hotdeal-wrap">

			<form action="${pageContext.request.contextPath}/hotdeal/list.do"
				method="get">
				<div class="hotdeal-search-bar">

					<div class="hotdeal-search-input">
						<span class="hotdeal-search-icon"> <svg
								xmlns="http://www.w3.org/2000/svg" width="24" height="24"
								viewBox="0 0 24 24">
								<path fill="currentColor"
									d="m19.6 21l-6.3-6.3q-.75.6-1.725.95T9.5 16q-2.725 0-4.612-1.888T3 9.5t1.888-4.612T9.5 3t4.613 1.888T16 9.5q0 1.1-.35 2.075T14.7 13.3l6.3 6.3zM9.5 14q1.875 0 3.188-1.312T14 9.5t-1.312-3.187T9.5 5T6.313 6.313T5 9.5t1.313 3.188T9.5 14" />
							</svg>
						</span> <input type="text" name="word" id="word" placeholder="상품명 검색">
					</div>

					<select name="categoryId" id="categoryId" class="hotdeal-select">
						<option value="">전체</option>
						<c:forEach items="${categoryList}" var="cat">
							<option value="${cat.categoryId}">${cat.categoryName}</option>
						</c:forEach>
					</select> <select name="sort" id="sort" class="hotdeal-select">
						<option value="">최신순</option>
						<option value="endSoon">종료임박순</option>
					</select>

					<button type="submit" class="hotdeal-search-btn">검색</button>
				</div>
			</form>

			<c:if test="${empty list}">
				<div class="empty-box">등록된 핫딜 상품이 없습니다.</div>
			</c:if>

			<c:if test="${!empty list}">
				<div class="hotdeal-grid">
					<c:forEach items="${list}" var="vo">
						<div class="hotdeal-item" data-id="${vo.dealId}">
							<div class="hotdeal-thumb">
								<c:choose>
									<c:when test="${!empty vo.imageUrl}">
										<img src="${pageContext.request.contextPath}${vo.imageUrl}"
											alt="${vo.title}"
											onerror="this.src='${pageContext.request.contextPath}/upload/hotdeal/default.png'">
									</c:when>
									<c:otherwise>
										<img
											src="${pageContext.request.contextPath}/upload/hotdeal/default.png"
											alt="기본 이미지">
									</c:otherwise>
								</c:choose>
							</div>

							<div class="hotdeal-body">
								<div class="hotdeal-title">${vo.title}</div>
								<div class="hotdeal-shop">${vo.shopName}</div>

								<div class="hotdeal-price-row">
									<div class="hotdeal-price">${vo.price}원</div>
									<div class="hotdeal-original">${vo.originalPrice}원</div>
								</div>

								<div class="hotdeal-bottom">
									<div class="discount-badge">${vo.discountRateInt}%할인</div>

									<c:choose>
										<c:when test="${vo.addedToShopping eq 'Y'}">
											<span class="add-done">추가완료</span>
										</c:when>
										<c:otherwise>
											<a
												href="${pageContext.request.contextPath}/hotdeal/addShopping.do?dealId=${vo.dealId}"
												class="add-btn">+ 장보기 추가</a>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</c:if>

		</div>
	</div>

</body>
</html>