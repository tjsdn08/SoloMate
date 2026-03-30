<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 핫딜 리스트</title>

<style>
.admin-page {
	padding: 30px;
}

.admin-card {
	background: #fff;
	border-radius: 18px;
	padding: 24px;
	box-shadow: 0 2px 10px rgba(0,0,0,0.05);
}

.top-bar {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 20px;
}

.top-title {
	font-size: 28px;
	font-weight: 800;
	color: #111;
}

.search-row {
	display: grid;
	grid-template-columns: 1fr 140px 140px 120px 140px;
	gap: 10px;
	align-items: center;
	margin-bottom: 20px;
}

.form-input, .form-select {
	width: 100%;
	height: 48px;
	border: 1px solid #ddd;
	border-radius: 12px;
	padding: 0 14px;
	font-size: 15px;
	outline: none;
}

.form-input:focus, .form-select:focus {
	border-color: #333;
}

.btn-main, .btn-sub {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	height: 48px;
	padding: 0 18px;
	border-radius: 12px;
	border: none;
	font-size: 15px;
	font-weight: 700;
	text-decoration: none;
	cursor: pointer;
}

.btn-main {
	background: #111827;
	color: #fff;
}

.btn-sub {
	background: #eef0f4;
	color: #333;
}

.dataRow:hover {
	cursor: pointer;
	background: #f8f9fc;
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

.bottom-row {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-top: 20px;
}
</style>

<script type="text/javascript">
$(function(){

	$("#word").val("${searchVO.word}");
	$("#status").val("${searchVO.status}");
	$("#categoryId").val("${searchVO.categoryId}");
	$("#perPageNum").val("${pageObject.perPageNum}");

	$(".dataRow").click(function(){
		let dealId = $(this).find(".dealId").text();
		location = "${pageContext.request.contextPath}/adminHotDeal/view.do?dealId=" + dealId;
	});
});
</script>
</head>
<body>

<div class="admin-page">
	<div class="admin-card">

		<div class="top-bar">
			<div class="top-title">관리자 핫딜 관리</div>
			<a href="${pageContext.request.contextPath}/adminHotDeal/writeForm.do" class="btn-main">+ 핫딜 등록</a>
		</div>

		<form action="${pageContext.request.contextPath}/adminHotDeal/list.do" method="get">
			<div class="search-row">
				<input type="text" name="word" id="word" class="form-input" placeholder="상품명 검색">

				<select name="categoryId" id="categoryId" class="form-select">
					<option value="">전체 카테고리</option>
					<option value="1">식품</option>
					<option value="2">생활용품</option>
					<option value="3">가전</option>
				</select>

				<select name="status" id="status" class="form-select">
					<option value="">전체 상태</option>
					<option value="ACTIVE">ACTIVE</option>
					<option value="INACTIVE">INACTIVE</option>
				</select>

				<select name="perPageNum" id="perPageNum" class="form-select" onchange="this.form.submit()">
					<option value="5">5개</option>
					<option value="10">10개</option>
					<option value="20">20개</option>
				</select>

				<button type="submit" class="btn-main">검색</button>
			</div>
		</form>

		<table class="table table-hover align-middle">
			<thead class="table-light">
				<tr>
					<th>번호</th>
					<th>카테고리</th>
					<th>상품명</th>
					<th>가격</th>
					<th>할인율</th>
					<th>판매처</th>
					<th>상태</th>
					<th>등록일</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty list}">
					<tr>
						<td colspan="8" class="text-center py-4">등록된 핫딜이 없습니다.</td>
					</tr>
				</c:if>

				<c:forEach items="${list}" var="vo">
					<tr class="dataRow">
						<td class="dealId">${vo.dealId}</td>
						<td>${vo.categoryName}</td>
						<td>${vo.title}</td>
						<td>${vo.price}원</td>
						<td>${vo.discountRate}%</td>
						<td>${vo.shopName}</td>
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
						<td>${vo.createdAt}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>

		<div class="bottom-row">
			<div>
				<%-- pageNav 태그 연동 시 사용 --%>
				<%-- <pageNav:pageNav listURI="list.do" pageObject="${pageObject}" /> --%>
			</div>
			<div>
				<a href="${pageContext.request.contextPath}/adminHotDeal/list.do" class="btn-sub">새로고침</a>
			</div>
		</div>

	</div>
</div>

</body>
</html>