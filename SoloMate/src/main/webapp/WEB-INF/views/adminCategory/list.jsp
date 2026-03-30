<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카테고리 관리</title>

<style>
.category-page {
	padding: 36px;
}

.category-wrap {
	max-width: 1180px;
	margin: 0 auto;
	background: #fff;
	border-radius: 24px;
	padding: 32px;
	box-shadow: 0 4px 20px rgba(0,0,0,0.06);
}

.category-top {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 28px;
}

.category-title {
	font-size: 42px;
	font-weight: 800;
	margin: 0;
}

.btn-add {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	gap: 8px;
	height: 52px;
	padding: 0 22px;
	border-radius: 14px;
	text-decoration: none;
	font-size: 18px;
	font-weight: 700;
	color: #fff;
	background: #111827;
}

.btn-add:hover {
	color: #fff;
	text-decoration: none;
	opacity: 0.95;
}

.category-table-box {
	border: 1px solid #e5e7eb;
	border-radius: 20px;
	overflow: hidden;
}

.category-table {
	width: 100%;
	border-collapse: collapse;
}

.category-table thead th {
	padding: 22px 24px;
	text-align: left;
	font-size: 18px;
	font-weight: 700;
	color: #555;
	background: #f8f9fa;
	border-bottom: 1px solid #e5e7eb;
}

.category-table tbody td {
	padding: 24px;
	font-size: 20px;
	font-weight: 600;
	border-bottom: 1px solid #f0f1f3;
	vertical-align: middle;
}

.category-table tbody tr:last-child td {
	border-bottom: none;
}

.col-no {
	width: 80px;
}

.col-date {
	width: 180px;
	color: #666;
	font-size: 17px;
	font-weight: 500;
}

.status-badge {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	min-width: 104px;
	height: 40px;
	padding: 0 16px;
	border-radius: 999px;
	font-size: 15px;
	font-weight: 700;
	background: #eef0f4;
	color: #333;
}

.action-group {
	display: flex;
	gap: 10px;
}

.icon-btn {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	width: 46px;
	height: 46px;
	border-radius: 12px;
	text-decoration: none;
	font-size: 20px;
	font-weight: 700;
	color: #333;
	background: #f3f4f6;
	border: 1px solid #e5e7eb;
}

.icon-btn:hover {
	text-decoration: none;
	background: #e9ecef;
	color: #111;
}

.empty-row td {
	text-align: center;
	padding: 44px 20px;
	color: #777;
	font-size: 18px;
	font-weight: 500;
}
</style>
</head>
<body>

<div class="category-page">
	<div class="category-wrap">

		<div class="category-top">
			<h2 class="category-title">카테고리 관리</h2>
			<a href="${pageContext.request.contextPath}/adminCategory/writeForm.do" class="btn-add">
				<span>＋</span><span>카테고리 등록</span>
			</a>
		</div>

		<div class="category-table-box">
			<table class="category-table">
				<thead>
					<tr>
						<th class="col-no">번호</th>
						<th>카테고리명</th>
						<th>상태</th>
						<th class="col-date">등록일</th>
						<th>관리</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty list}">
						<tr class="empty-row">
							<td colspan="5">등록된 카테고리가 없습니다.</td>
						</tr>
					</c:if>

					<c:forEach items="${list}" var="vo">
						<tr>
							<td class="col-no">${vo.categoryId}</td>
							<td>${vo.categoryName}</td>
							<td>
								<span class="status-badge">${vo.status}</span>
							</td>
							<td class="col-date">${vo.createdAt}</td>
							<td>
								<div class="action-group">
									<c:choose>
										<c:when test="${vo.status eq 'ACTIVE'}">
											<a href="${pageContext.request.contextPath}/adminCategory/updateForm.do?categoryId=${vo.categoryId}&categoryName=${vo.categoryName}&status=INACTIVE"
											   class="icon-btn" title="비활성화">✕</a>
										</c:when>
										<c:otherwise>
											<a href="${pageContext.request.contextPath}/adminCategory/updateForm.do?categoryId=${vo.categoryId}&categoryName=${vo.categoryName}&status=ACTIVE"
											   class="icon-btn" title="활성화">✓</a>
										</c:otherwise>
									</c:choose>

									<a href="${pageContext.request.contextPath}/adminCategory/updateForm.do?categoryId=${vo.categoryId}&categoryName=${vo.categoryName}&status=${vo.status}"
									   class="icon-btn" title="수정">✎</a>

									<a href="${pageContext.request.contextPath}/adminCategory/delete.do?categoryId=${vo.categoryId}"
									   class="icon-btn" title="삭제"
									   onclick="return confirm('삭제하시겠습니까?');">🗑</a>
								</div>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>

	</div>
</div>

</body>
</html>