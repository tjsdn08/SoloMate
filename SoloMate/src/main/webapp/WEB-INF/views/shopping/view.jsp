<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장보기 상세보기</title>

<style type="text/css">
.view-wrapper {
	padding: 30px;
}

.view-card {
	background: #fff;
	border-radius: 16px;
	padding: 24px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.06);
}

.view-title {
	font-size: 28px;
	font-weight: 700;
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
	font-size: 16px;
}

.status-badge, .source-badge {
	display: inline-block;
	padding: 6px 12px;
	border-radius: 999px;
	font-size: 13px;
	font-weight: 600;
}

.status-planned {
	background-color: #f1f1f5;
	color: #666;
}

.status-purchased {
	background-color: #e6f4ea;
	color: #2e7d32;
}

.status-canceled {
	background-color: #fdeaea;
	color: #c62828;
}

.source-direct {
	background-color: #f3f4f6;
	color: #555;
}

.source-hotdeal {
	background-color: #eef2ff;
	color: #4f46e5;
}

.bottom-btns {
	display: flex;
	justify-content: space-between;
	margin-top: 24px;
}

.left-btns a {
	margin-right: 10px;
}
</style>
</head>
<body>

	<div class="view-wrapper">
		<div class="view-card">
			<div class="view-title">장보기 상세보기</div>

			<c:if test="${empty vo}">
				<div class="alert alert-warning">존재하지 않는 장보기 항목입니다.</div>
				<a href="${pageContext.request.contextPath}/shopping/list.do"
					class="btn btn-secondary">목록</a>
			</c:if>

			<c:if test="${!empty vo}">
				<table class="table table-bordered info-table">
					<tr>
						<th>번호</th>
						<td>${vo.shoppingId}</td>
					</tr>
					<tr>
						<th>품목명</th>
						<td>${vo.itemName}</td>
					</tr>
					<tr>
						<th>수량</th>
						<td>${vo.quantity}</td>
					</tr>
					<tr>
						<th>예상금액</th>
						<td>${vo.expectedPrice}원</td>
					</tr>
					<tr>
						<th>구매예정일</th>
						<td>${vo.planDate}</td>
					</tr>
					<tr>
						<th>상태</th>
						<td><c:choose>
								<c:when test="${vo.status eq 'PLANNED'}">
									<span class="status-badge status-planned">구매예정</span>
								</c:when>
								<c:when test="${vo.status eq 'PURCHASED'}">
									<span class="status-badge status-purchased">구매완료</span>
								</c:when>
								<c:when test="${vo.status eq 'CANCELED'}">
									<span class="status-badge status-canceled">취소</span>
								</c:when>
								<c:otherwise>
									<span class="status-badge status-planned">${vo.status}</span>
								</c:otherwise>
							</c:choose></td>
					</tr>
					<tr>
						<th>메모</th>
						<td><c:choose>
								<c:when test="${!empty vo.memo}">${vo.memo}</c:when>
								<c:otherwise>-</c:otherwise>
							</c:choose></td>
					</tr>
					<tr>
						<th>연동유형</th>
						<td><c:choose>
								<c:when test="${vo.sourceType eq 'HOTDEAL'}">
									<span class="source-badge source-hotdeal">HOTDEAL</span>
								</c:when>
								<c:otherwise>
									<span class="source-badge source-direct">DIRECT</span>
								</c:otherwise>
							</c:choose></td>
					</tr>
					<tr>
						<th>연동 핫딜</th>
						<td><c:choose>
								<c:when test="${!empty vo.hotDealTitle}">${vo.hotDealTitle}</c:when>
								<c:otherwise>-</c:otherwise>
							</c:choose></td>
					</tr>
					<tr>
						<th>등록일</th>
						<td>${vo.createdAt}</td>
					</tr>
					<tr>
						<th>수정일</th>
						<td><c:choose>
								<c:when test="${!empty vo.updatedAt}">${vo.updatedAt}</c:when>
								<c:otherwise>-</c:otherwise>
							</c:choose></td>
					</tr>
				</table>

				<div class="bottom-btns">

					<div class="left-btns">

						<a
							href="${pageContext.request.contextPath}/shopping/updateForm.do?shoppingId=${vo.shoppingId}"
							class="btn btn-primary">수정</a> <a
							href="${pageContext.request.contextPath}/shopping/delete.do?shoppingId=${vo.shoppingId}"
							class="btn btn-danger" onclick="return confirm('삭제하시겠습니까?');">삭제</a>

						<c:if test="${vo.status eq 'PLANNED'}">
							<a
								href="${pageContext.request.contextPath}/shopping/complete.do?shoppingId=${vo.shoppingId}"
								class="btn btn-success">구매완료</a>

							<a
								href="${pageContext.request.contextPath}/shopping/cancel.do?shoppingId=${vo.shoppingId}"
								class="btn btn-warning" onclick="return confirm('취소하시겠습니까?');">취소</a>
						</c:if>

					</div>

					<div>
						<a href="${pageContext.request.contextPath}/shopping/list.do"
							class="btn btn-secondary">목록</a>
					</div>

				</div>

			</c:if>

		</div>
	</div>

</body>
</html>