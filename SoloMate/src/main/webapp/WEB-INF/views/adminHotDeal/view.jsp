<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 핫딜 상세보기</title>

<style>
.view-page {
	padding: 30px;
}

.view-card {
	background: #fff;
	border-radius: 18px;
	padding: 24px;
	box-shadow: 0 2px 10px rgba(0,0,0,0.05);
}

.view-title {
	font-size: 28px;
	font-weight: 800;
	margin-bottom: 24px;
}

.info-table th {
	width: 220px;
	background: #f8f9fa;
	color: #666;
	font-weight: 600;
	vertical-align: middle;
}

.info-table td {
	vertical-align: middle;
}

.status-badge {
	display: inline-block;
	padding: 6px 10px;
	border-radius: 999px;
	font-size: 13px;
	font-weight: 700;
}

.status-active {
	background: #e8f6ea;
	color: #2e7d32;
}

.status-inactive {
	background: #fdecec;
	color: #c62828;
}

.thumb-box {
	width: 280px;
	height: 280px;
	border-radius: 14px;
	overflow: hidden;
	background: #f5f5f5;
}

.thumb-box img {
	width: 100%;
	height: 100%;
	object-fit: cover;
	display: block;
}

.bottom-btns {
	display: flex;
	justify-content: space-between;
	margin-top: 24px;
}

.left-btns a, .left-btns form {
	margin-right: 10px;
	display: inline-block;
}
</style>
</head>
<body>

<div class="view-page">
	<div class="view-card">
		<div class="view-title">관리자 핫딜 상세보기</div>

		<c:if test="${empty vo}">
			<div class="alert alert-warning">존재하지 않는 핫딜입니다.</div>
			<a href="${pageContext.request.contextPath}/adminHotDeal/list.do" class="btn btn-secondary">목록</a>
		</c:if>

		<c:if test="${!empty vo}">
			<table class="table table-bordered info-table">
				<tr>
					<th>번호</th>
					<td>${vo.dealId}</td>
				</tr>
				<tr>
					<th>이미지</th>
					<td>
						<div class="thumb-box">
							<c:choose>
								<c:when test="${not empty vo.imageUrl}">
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
					</td>
				</tr>
				<tr>
					<th>카테고리</th>
					<td>${vo.categoryName}</td>
				</tr>
				<tr>
					<th>상품명</th>
					<td>${vo.title}</td>
				</tr>
				<tr>
					<th>가격</th>
					<td>${vo.price}원</td>
				</tr>
				<tr>
					<th>원가</th>
					<td>${vo.originalPrice}원</td>
				</tr>
				<tr>
					<th>할인율</th>
					<td>${vo.discountRateInt}%</td>
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
					<th>구매 링크</th>
					<td>
						<c:choose>
							<c:when test="${not empty vo.dealUrl}">
								<a href="${vo.dealUrl}" target="_blank" rel="noopener noreferrer">${vo.dealUrl}</a>
							</c:when>
							<c:otherwise>
								구매 링크 없음
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<th>설명</th>
					<td>${vo.description}</td>
				</tr>
				<tr>
					<th>종료일</th>
					<td>${vo.endDate}</td>
				</tr>
				<tr>
					<th>조회수</th>
					<td>${vo.viewCount}</td>
				</tr>
				<tr>
					<th>상태</th>
					<td>
						<c:choose>
							<c:when test="${vo.status eq 'ACTIVE'}">
								<span class="status-badge status-active">ACTIVE</span>
							</c:when>
							<c:otherwise>
								<span class="status-badge status-inactive">INACTIVE</span>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<th>등록일</th>
					<td>${vo.createdAt}</td>
				</tr>
				<tr>
					<th>수정일</th>
					<td>${vo.updatedAt}</td>
				</tr>
			</table>

			<div class="bottom-btns">
				<div class="left-btns">
					<a href="${pageContext.request.contextPath}/adminHotDeal/updateForm.do?dealId=${vo.dealId}"
					   class="btn btn-primary">수정</a>

					<a href="${pageContext.request.contextPath}/adminHotDeal/delete.do?dealId=${vo.dealId}"
					   class="btn btn-danger"
					   onclick="return confirm('삭제하시겠습니까?');">삭제</a>

					<c:choose>
						<c:when test="${vo.status eq 'ACTIVE'}">
							<a href="${pageContext.request.contextPath}/adminHotDeal/status.do?dealId=${vo.dealId}&status=INACTIVE"
							   class="btn btn-warning">비활성화</a>
						</c:when>
						<c:otherwise>
							<a href="${pageContext.request.contextPath}/adminHotDeal/status.do?dealId=${vo.dealId}&status=ACTIVE"
							   class="btn btn-success">활성화</a>
						</c:otherwise>
					</c:choose>
				</div>

				<div>
					<a href="${pageContext.request.contextPath}/adminHotDeal/list.do"
					   class="btn btn-secondary">목록</a>
				</div>
			</div>
		</c:if>
	</div>
</div>

</body>
</html>