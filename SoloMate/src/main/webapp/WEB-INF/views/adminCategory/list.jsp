<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카테고리 관리</title>

<style>
.admin-page {
	padding: 30px;
}

.admin-card {
	background: #fff;
	border-radius: 18px;
	padding: 24px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
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

.btn-main, .btn-sub, .btn-icon {
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

.btn-icon {
	width: 42px;
	height: 42px;
	padding: 0;
	background: #eef0f4;
	color: #333;
	font-size: 16px;
}

.table-custom {
	width: 100%;
	border-collapse: collapse;
}

.table-custom th,
.table-custom td {
	padding: 16px 14px;
	text-align: left;
	border-bottom: 1px solid #f0f1f3;
	vertical-align: middle;
}

.table-custom thead th {
	background: #f8f9fa;
	color: #666;
	font-size: 14px;
	font-weight: 700;
}

.table-custom tbody td {
	font-size: 15px;
	font-weight: 500;
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

.manage-box {
	display: flex;
	gap: 8px;
	align-items: center;
}

.manage-box form {
	margin: 0;
}

.empty-row td {
	text-align: center;
	color: #777;
	padding: 40px 20px;
}

.bottom-row {
	display: flex;
	justify-content: flex-end;
	align-items: center;
	margin-top: 20px;
}
</style>

<script type="text/javascript">
	$(function() {
		$(".status-btn").click(function() {
			const currentStatus = $(this).data("status");
			const nextStatus = currentStatus === "ACTIVE" ? "INACTIVE" : "ACTIVE";
			return confirm("상태를 " + nextStatus + " 로 변경하시겠습니까?");
		});

		$(".delete-btn").click(function() {
			return confirm("삭제하시겠습니까?");
		});
	});
</script>
</head>
<body>

<div class="admin-page">
	<div class="admin-card">

		<div class="top-bar">
			<div class="top-title">카테고리 관리</div>
			<a href="${pageContext.request.contextPath}/adminCategory/writeForm.do" class="btn-main">+ 등록</a>
		</div>

		<table class="table-custom">
			<thead>
				<tr>
					<th style="width: 90px;">번호</th>
					<th>카테고리명</th>
					<th style="width: 140px;">상태</th>
					<th style="width: 160px;">등록일</th>
					<th style="width: 160px;">관리</th>
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
						<td>${vo.categoryId}</td>
						<td>${vo.categoryName}</td>
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
						<td>
							<div class="manage-box">
								<form action="${pageContext.request.contextPath}/adminCategory/status.do" method="post">
									<input type="hidden" name="categoryId" value="${vo.categoryId}">
									<input type="hidden" name="status"
										value="${vo.status eq 'ACTIVE' ? 'INACTIVE' : 'ACTIVE'}">
									<button type="submit" class="btn-icon status-btn"
										data-status="${vo.status}" title="상태 변경">
										<c:choose>
											<c:when test="${vo.status eq 'ACTIVE'}"><svg xmlns="http://www.w3.org/2000/svg" width="24"
														height="24" viewBox="0 0 24 24">
														<g fill="none">
														<path
															d="m12.593 23.258l-.011.002l-.071.035l-.02.004l-.014-.004l-.071-.035q-.016-.005-.024.005l-.004.01l-.017.428l.005.02l.01.013l.104.074l.015.004l.012-.004l.104-.074l.012-.016l.004-.017l-.017-.427q-.004-.016-.017-.018m.265-.113l-.013.002l-.185.093l-.01.01l-.003.011l.018.43l.005.012l.008.007l.201.093q.019.005.029-.008l.004-.014l-.034-.614q-.005-.018-.02-.022m-.715.002a.02.02 0 0 0-.027.006l-.006.014l-.034.614q.001.018.017.024l.015-.002l.201-.093l.01-.008l.004-.011l.017-.43l-.003-.012l-.01-.01z" />
														<path fill="currentColor"
															d="M3.05 9.31a1 1 0 1 1 1.914-.577c2.086 6.986 11.982 6.987 14.07.004a1 1 0 1 1 1.918.57a9.5 9.5 0 0 1-1.813 3.417L20.414 14A1 1 0 0 1 19 15.414l-1.311-1.311a9.1 9.1 0 0 1-2.32 1.269l.357 1.335a1 1 0 1 1-1.931.518l-.364-1.357c-.947.14-1.915.14-2.862 0l-.364 1.357a1 1 0 1 1-1.931-.518l.357-1.335a9.1 9.1 0 0 1-2.32-1.27l-1.31 1.312A1 1 0 0 1 3.585 14l1.275-1.275c-.784-.936-1.41-2.074-1.812-3.414Z" /></g></svg></c:when>
											<c:otherwise><svg xmlns="http://www.w3.org/2000/svg" width="24"
														height="24" viewBox="0 0 24 24">
														<g fill="none" stroke="currentColor"
															stroke-linecap="round" stroke-linejoin="round"
															stroke-width="2">
														<path
															d="M21.257 10.962c.474.62.474 1.457 0 2.076C19.764 14.987 16.182 19 12 19s-7.764-4.013-9.257-5.962a1.69 1.69 0 0 1 0-2.076C4.236 9.013 7.818 5 12 5s7.764 4.013 9.257 5.962" />
														<circle cx="12" cy="12" r="3" /></g></svg></c:otherwise>
										</c:choose>
									</button>
								</form>

								<a href="${pageContext.request.contextPath}/adminCategory/updateForm.do?categoryId=${vo.categoryId}"
								   class="btn-icon" title="수정"><svg
											xmlns="http://www.w3.org/2000/svg" width="24" height="24"
											viewBox="0 0 24 24">
											<g fill="none" stroke="currentColor" stroke-linecap="round"
												stroke-linejoin="round" stroke-width="1">
											<g stroke-width="2">
											<path stroke-dasharray="56"
												d="M3 21l2 -6l11 -11c1 -1 3 -1 4 0c1 1 1 3 0 4l-11 11l-6 2">
											<animate fill="freeze" attributeName="stroke-dashoffset"
												dur="0.6s" values="56;0" /></path>
											<path stroke-dasharray="8" stroke-dashoffset="8"
												d="M15 5l4 4">
											<animate fill="freeze" attributeName="stroke-dashoffset"
												begin="0.6s" dur="0.2s" to="0" /></path></g>
											<path stroke-dasharray="8" stroke-dashoffset="8"
												d="M6 15l3 3">
											<animate fill="freeze" attributeName="stroke-dashoffset"
												begin="0.8s" dur="0.2s" to="0" /></path></g></svg></a>

								<form action="${pageContext.request.contextPath}/adminCategory/delete.do" method="post">
									<input type="hidden" name="categoryId" value="${vo.categoryId}">
									<button type="submit" class="btn-icon delete-btn" title="삭제"><svg xmlns="http://www.w3.org/2000/svg" width="24"
												height="24" viewBox="0 0 24 24">
												<g fill="none" stroke="currentColor" stroke-linecap="round"
													stroke-linejoin="round" stroke-width="2">
												<path stroke-dasharray="24"
													d="M12 20h5c0.5 0 1 -0.5 1 -1v-14M12 20h-5c-0.5 0 -1 -0.5 -1 -1v-14">
												<animate fill="freeze" attributeName="stroke-dashoffset"
													dur="0.5s" values="24;0" /></path>
												<path stroke-dasharray="18" stroke-dashoffset="18"
													d="M4 5h16">
												<animate fill="freeze" attributeName="stroke-dashoffset"
													begin="0.5s" dur="0.3s" to="0" /></path>
												<path stroke-dasharray="10" stroke-dashoffset="10"
													d="M10 4h4M10 9v7M14 9v7">
												<animate fill="freeze" attributeName="stroke-dashoffset"
													begin="0.8s" dur="0.2s" to="0" /></path></g></svg></button>
								</form>
							</div>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>

		<div class="bottom-row">
			<a href="${pageContext.request.contextPath}/adminCategory/list.do" class="btn-sub">새로고침</a>
		</div>

	</div>
</div>

</body>
</html>