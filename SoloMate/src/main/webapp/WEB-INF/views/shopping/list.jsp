<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="pageNav" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장보기 리스트</title>

<style type="text/css">
.page-wrapper {
	padding: 30px;
}

.shopping-card {
	background: #fff;
	border-radius: 16px;
	padding: 24px;
	box-shadow: 0 2px 10px rgba(0,0,0,0.06);
}

.filter-label {
	font-size: 14px;
	font-weight: 600;
	color: #666;
	margin-bottom: 8px;
}

.dataRow:hover {
	cursor: pointer;
	background-color: #f8f9ff;
}

.status-badge {
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

.table thead th {
	background-color: #f8f9fa;
	color: #666;
	font-size: 14px;
	border-bottom: 1px solid #e9ecef;
}

.table tbody td {
	vertical-align: middle;
}

.bottom-area {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-top: 20px;
}

.write-btn {
	border-radius: 10px;
	padding: 10px 18px;
	font-weight: 600;
}
</style>

<script type="text/javascript">
${(!empty msg)?"alert('" += msg += "');":""}

$(function(){
	$(".dataRow").click(function(){
		let shoppingId = $(this).find(".shoppingId").text();
		location = "${pageContext.request.contextPath}/shopping/view.do?shoppingId="
				+ shoppingId + "&${pageObject.pageQuery}";
	});

	$("#status").val("${param.status}");
	$("#perPageNum").val("${empty param.perPageNum ? pageObject.perPageNum : param.perPageNum}");
	$("#planDate").val("${param.planDate}");
	$("#word").val("${param.word}");
});
</script>

</head>
<body>
<div class="page-wrapper">
	<div class="shopping-card">
		<h2 class="mb-4">장보기 리스트</h2>

		<form action="${pageContext.request.contextPath}/shopping/list.do" method="get" class="mb-4">
			<div class="row g-3 align-items-end">
				<div class="col-md-3">
					<div class="filter-label">상태 선택</div>
					<select class="form-select" name="status" id="status">
						<option value="">전체</option>
						<option value="PLANNED">구매예정</option>
						<option value="PURCHASED">완료</option>
						<option value="CANCELED">취소</option>
					</select>
				</div>

				<div class="col-md-3">
					<div class="filter-label">날짜 검색</div>
					<input type="date" class="form-control" name="planDate" id="planDate">
				</div>

				<div class="col-md-3">
					<div class="filter-label">품목명 검색</div>
					<input type="text" class="form-control" name="word" id="word" placeholder="품목명 입력">
				</div>

				<div class="col-md-1 d-grid">
					<button type="submit" class="btn btn-primary">검색</button>
				</div>

				<div class="col-md-2">
					<div class="filter-label">페이지당 개수</div>
					<select class="form-select" name="perPageNum" id="perPageNum" onchange="this.form.submit()">
						<option value="5">5개</option>
						<option value="10">10개</option>
						<option value="20">20개</option>
					</select>
				</div>
			</div>
		</form>

		<div class="table-responsive">
			<table class="table align-middle">
				<thead>
					<tr>
						<th>번호</th>
						<th>품목명</th>
						<th>수량</th>
						<th>금액</th>
						<th>예정일</th>
						<th>상태</th>
						<th>등록일</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty list}">
						<tr>
							<td colspan="7" class="text-center py-4">데이터가 존재하지 않습니다.</td>
						</tr>
					</c:if>

					<c:if test="${!empty list}">
						<c:forEach items="${list}" var="vo">
							<tr class="dataRow">
								<td class="shoppingId">${vo.shoppingId}</td>
								<td>${vo.itemName}</td>
								<td>${vo.quantity}</td>
								<td>${vo.expectedPrice}원</td>
								<td>${vo.planDate}</td>
								<td>
									<c:choose>
										<c:when test="${vo.status eq 'PLANNED'}">
											<span class="status-badge status-planned">구매예정</span>
										</c:when>
										<c:when test="${vo.status eq 'PURCHASED'}">
											<span class="status-badge status-purchased">완료</span>
										</c:when>
										<c:when test="${vo.status eq 'CANCELED'}">
											<span class="status-badge status-canceled">취소</span>
										</c:when>
										<c:otherwise>
											<span class="status-badge status-planned">${vo.status}</span>
										</c:otherwise>
									</c:choose>
								</td>
								<td>${vo.createdAt}</td>
							</tr>
						</c:forEach>
					</c:if>
				</tbody>
			</table>
		</div>

		<div class="bottom-area">
			<div>
				<%-- pageNav 태그 수정 전까지는 주석 유지하거나 직접 페이징 구현 --%>
				<pageNav:pageNav listURI="list.do" pageObject="${pageObject}" /> 
			</div>

			<div>
				<a href="${pageContext.request.contextPath}/shopping/writeForm.do?perPageNum=${pageObject.perPageNum}"
				   class="btn btn-primary write-btn">+ 장보기 등록</a>
			</div>
		</div>
	</div>
</div>
</body>
</html>