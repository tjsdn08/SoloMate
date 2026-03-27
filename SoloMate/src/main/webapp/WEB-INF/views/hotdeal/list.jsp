<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	box-shadow: 0 2px 10px rgba(0,0,0,0.05);
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

.hotdeal-search-input input:focus,
.hotdeal-select:focus {
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
}

.hotdeal-item:hover {
	box-shadow: 0 6px 18px rgba(0,0,0,0.08);
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
	font-size: 17px;
	font-weight: 700;
	color: #222;
	margin-bottom: 8px;
	min-height: 48px;
	line-height: 1.4;
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

.empty-box {
	padding: 80px 0;
	text-align: center;
	color: #888;
	font-size: 16px;
}

@media (max-width: 1200px) {
	.hotdeal-grid {
		grid-template-columns: repeat(2, 1fr);
	}
}

@media (max-width: 768px) {
	.hotdeal-search-bar {
		grid-template-columns: 1fr;
	}
	.hotdeal-grid {
		grid-template-columns: 1fr;
	}
}
</style>

<script type="text/javascript">
$(function(){

	$("#categoryId").val("${searchVO.categoryId}");
	$("#sort").val("${searchVO.sort}");
	$("#word").val("${searchVO.word}");

	$(".hotdeal-item").click(function(e){
		// 장보기 추가 버튼 클릭 시 카드 상세이동 막기
		if($(e.target).closest(".add-btn").length > 0) return;

		let dealId = $(this).data("id");
		location = "${pageContext.request.contextPath}/hotdeal/view.do?dealId=" + dealId
				+ "&${pageObject.pageQuery}";
	});
});
</script>
</head>
<body>

<div class="hotdeal-page">
	<div class="hotdeal-wrap">

		<form action="${pageContext.request.contextPath}/hotdeal/list.do" method="get">
			<div class="hotdeal-search-bar">

				<div class="hotdeal-search-input">
					<span class="hotdeal-search-icon">🔍</span>
					<input type="text" name="word" id="word" placeholder="상품명 검색">
				</div>

				<select name="categoryId" id="categoryId" class="hotdeal-select">
					<option value="">전체</option>
					<option value="1">식품</option>
					<option value="2">생활용품</option>
					<option value="3">가전</option>
				</select>

				<select name="sort" id="sort" class="hotdeal-select">
					<option value="">최신순</option>
					<option value="popular">인기순</option>
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
									<img src="${vo.imageUrl}" alt="${vo.title}">
								</c:when>
								<c:otherwise>
									<img src="${pageContext.request.contextPath}/images/no-image.png" alt="이미지 없음">
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
								<div class="discount-badge">${vo.discountRate}% 할인</div>

								<a href="${pageContext.request.contextPath}/shopping/writeForm.do?dealId=${vo.dealId}&itemName=${vo.title}&expectedPrice=${vo.price}"
								   class="add-btn">
									+ 장보기 추가
								</a>
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