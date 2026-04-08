<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>핫딜 상세보기</title>

<style>
.view-page {
	padding: 30px;
}

.view-card {
	background: #fff;
	border-radius: 18px;
	padding: 28px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
}

.view-grid {
	display: grid;
	grid-template-columns: 1.1fr 1fr;
	gap: 28px;
}

.view-thumb {
	width: 100%;
	height: 420px;
	border-radius: 18px;
	overflow: hidden;
	background: #f5f5f5;
}

.view-thumb img {
	width: 100%;
	height: 100%;
	object-fit: cover;
	display: block;
}

.view-title {
	font-size: 30px;
	font-weight: 800;
	color: #111;
	margin-bottom: 14px;
	line-height: 1.35;
}

.meta-badge {
	display: inline-block;
	padding: 6px 10px;
	border-radius: 10px;
	background: #f2f3f5;
	color: #666;
	font-size: 13px;
	font-weight: 600;
	margin-bottom: 16px;
}

.price-row {
	display: flex;
	align-items: baseline;
	gap: 10px;
	margin-bottom: 16px;
}

.price-main {
	font-size: 30px;
	font-weight: 800;
	color: #111;
}

.price-original {
	font-size: 16px;
	color: #999;
	text-decoration: line-through;
}

.discount-badge {
	display: inline-block;
	padding: 6px 10px;
	border-radius: 8px;
	background: #b63b46;
	color: #fff;
	font-size: 13px;
	font-weight: 700;
	margin-bottom: 18px;
}

.info-table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 24px;
}

.info-table th, .info-table td {
	padding: 14px 10px;
	border-bottom: 1px solid #ececec;
	text-align: left;
	vertical-align: top;
}

.info-table th {
	width: 120px;
	color: #666;
	font-weight: 600;
}

.view-desc {
	padding: 18px;
	border-radius: 14px;
	background: #fafafa;
	color: #444;
	line-height: 1.7;
	margin-bottom: 24px;
	min-height: 110px;
}

.bottom-btns {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.btn-main, .btn-sub, .btn-done {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	height: 48px;
	padding: 0 18px;
	border-radius: 12px;
	font-size: 15px;
	font-weight: 700;
	text-decoration: none;
}

.btn-main {
	background: #03051a;
	color: #fff;
}

.btn-sub {
	background: #eef0f4;
	color: #333;
}

.btn-done {
	background: #9aa0a6;
	color: #fff;
}

.btn-main:hover, .btn-sub:hover {
	text-decoration: none;
	opacity: 0.93;
	color: inherit;
}
</style>
</head>
<body>

	<div class="view-page">
		<div class="view-card">

			<c:if test="${empty vo}">
				<div class="alert alert-warning">존재하지 않는 핫딜 상품입니다.</div>
				<a href="${pageContext.request.contextPath}/hotdeal/list.do"
					class="btn btn-secondary">목록</a>
			</c:if>

			<c:if test="${!empty vo}">
				<div class="view-grid">

					<div class="view-thumb">
						<c:choose>
							<c:when test="${!empty vo.imageUrl}">
								<img
									src="${pageContext.request.contextPath}/upload/hotdeal/${vo.imageUrl}"
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

					<div>
						<div class="view-title">${vo.title}</div>

						<div class="meta-badge">${vo.shopName}</div>

						<div class="price-row">
							<div class="price-main">${vo.price}원</div>
							<div class="price-original">${vo.originalPrice}원</div>
						</div>

						<div class="discount-badge">${vo.discountRateInt}%할인</div>

						<table class="info-table">
							<tr>
								<th>카테고리</th>
								<td>${vo.categoryName}</td>
							</tr>
							<tr>
								<th>판매처</th>
								<td>${vo.shopName}</td>
							</tr>
							<tr>
								<th>판매자</th>
								<td>${vo.sellerName}</td>
							</tr>
							<tr>
								<th>종료일</th>
								<td>${vo.endDate}</td>
							</tr>
							<tr>
								<th>조회수</th>
								<td>${vo.viewCount}</td>
							</tr>
						</table>

						<div class="view-desc">
							<c:choose>
								<c:when test="${!empty vo.description}">
									${vo.description}
								</c:when>
								<c:otherwise>
									상품 설명이 없습니다.
								</c:otherwise>
							</c:choose>
						</div>

						<div class="bottom-btns">
							<div>
								<c:choose>
									<c:when test="${vo.addedToShopping eq 'Y'}">
										<span class="btn-done">추가완료</span>
									</c:when>
									<c:otherwise>
										<a
											href="${pageContext.request.contextPath}/hotdeal/addShopping.do?dealId=${vo.dealId}"
											class="btn-main">+ 장보기 추가</a>
									</c:otherwise>
								</c:choose>

								<a href="https://www.coupang.com/" target="_blank"
									rel="noopener noreferrer" class="btn-main">쿠팡에서 구매하기</a>
							</div>

							<div>
								<a href="${pageContext.request.contextPath}/hotdeal/list.do"
									class="btn-sub">목록</a>
							</div>
						</div>

					</div>

				</div>
			</c:if>

		</div>
	</div>

</body>
</html>