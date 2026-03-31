<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카테고리 관리</title>

<style>
.page { padding: 40px; }
.wrap { max-width: 1100px; margin: auto; }

.top {
	display: flex;
	justify-content: space-between;
	margin-bottom: 24px;
	align-items: center;
}

.title {
	font-size: 36px;
	font-weight: 800;
}

.btn {
	padding: 10px 16px;
	border-radius: 8px;
	border: none;
	cursor: pointer;
	font-weight: 600;
	text-decoration: none;
}

.btn-main { background: #111827; color: white; }
.btn-sub { background: #e5e7eb; color:#111; }

.table {
	width: 100%;
	border-collapse: collapse;
	background: #fff;
	border-radius: 16px;
	overflow: hidden;
	box-shadow: 0 4px 20px rgba(0,0,0,0.06);
}

.table th, .table td {
	padding: 16px;
	border-bottom: 1px solid #eee;
	text-align: left;
	vertical-align: middle;
}

.table th {
	background: #f8f9fa;
	font-weight: 700;
	color: #555;
}

.badge {
	padding: 6px 12px;
	border-radius: 20px;
	font-size: 13px;
	font-weight: 700;
	display: inline-flex;
	align-items: center;
	justify-content: center;
	min-width: 90px;
}

.badge-active {
	background: #e8f6ea;
	color: #2e7d32;
}

.badge-inactive {
	background: #fdecec;
	color: #c62828;
}

.actions {
	display: flex;
	gap: 8px;
}

.icon-btn {
	width: 36px;
	height: 36px;
	border-radius: 8px;
	background: #f3f4f6;
	display: flex;
	align-items: center;
	justify-content: center;
	cursor: pointer;
	text-decoration: none;
	color: #111;
	border: 1px solid #e5e7eb;
}

.icon-btn:hover {
	background: #e5e7eb;
	text-decoration: none;
	color: #111;
}

/* 모달 */
.modal {
	display: none;
	position: fixed;
	top: 0; left: 0;
	width: 100%; height: 100%;
	background: rgba(0,0,0,0.4);
	align-items: center;
	justify-content: center;
}

.modal-content {
	background: white;
	padding: 24px;
	border-radius: 16px;
	width: 420px;
	box-shadow: 0 10px 30px rgba(0,0,0,0.15);
}

.modal h3 {
	margin-bottom: 16px;
	font-size: 24px;
	font-weight: 800;
}

.modal input, .modal select {
	width: 100%;
	padding: 12px;
	margin-bottom: 12px;
	border: 1px solid #ddd;
	border-radius: 8px;
	font-size: 15px;
}
</style>

<script>
function openWriteModal() {
	document.getElementById("writeModal").style.display = "flex";
}

function openUpdateModal(id, name, status) {
	document.getElementById("updateModal").style.display = "flex";
	document.getElementById("u_id").value = id;
	document.getElementById("u_name").value = name;
	document.getElementById("u_status").value = status;
}

function closeModal(id) {
	document.getElementById(id).style.display = "none";
}
</script>

</head>
<body>

<div class="page">
<div class="wrap">

	<div class="top">
		<div class="title">카테고리 관리</div>
		<button class="btn btn-main" onclick="openWriteModal()">+ 등록</button>
	</div>

	<table class="table">
		<thead>
			<tr>
				<th>번호</th>
				<th>카테고리명</th>
				<th>상태</th>
				<th>등록일</th>
				<th>관리</th>
			</tr>
		</thead>

		<tbody>
			<c:if test="${empty list}">
				<tr>
					<td colspan="5" style="text-align:center;">등록된 카테고리가 없습니다.</td>
				</tr>
			</c:if>

			<c:forEach items="${list}" var="vo">
				<tr>
					<td>${vo.categoryId}</td>
					<td>${vo.categoryName}</td>
					<td>
						<c:choose>
							<c:when test="${vo.status eq 'ACTIVE'}">
								<span class="badge badge-active">ACTIVE</span>
							</c:when>
							<c:otherwise>
								<span class="badge badge-inactive">INACTIVE</span>
							</c:otherwise>
						</c:choose>
					</td>
					<td>${vo.createdAt}</td>

					<td>
						<div class="actions">

							<!-- 1. 상태 토글 -->
							<c:choose>
								<c:when test="${vo.status eq 'ACTIVE'}">
									<a href="${pageContext.request.contextPath}/adminCategory/status.do?categoryId=${vo.categoryId}&status=INACTIVE"
									   class="icon-btn" title="비활성화">✕</a>
								</c:when>
								<c:otherwise>
									<a href="${pageContext.request.contextPath}/adminCategory/status.do?categoryId=${vo.categoryId}&status=ACTIVE"
									   class="icon-btn" title="활성화">✓</a>
								</c:otherwise>
							</c:choose>

							<!-- 2. 수정 -->
							<div class="icon-btn"
								onclick="openUpdateModal('${vo.categoryId}','${vo.categoryName}','${vo.status}')"
								title="수정">✎</div>

							<!-- 3. 삭제 -->
							<a href="${pageContext.request.contextPath}/adminCategory/delete.do?categoryId=${vo.categoryId}"
							   class="icon-btn"
							   title="삭제"
							   onclick="return confirm('삭제하시겠습니까?')">🗑</a>

						</div>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

</div>
</div>

<!-- 등록 모달 -->
<div id="writeModal" class="modal">
	<div class="modal-content">
		<h3>카테고리 등록</h3>
		<form action="${pageContext.request.contextPath}/adminCategory/write.do" method="post">
			<input type="text" name="categoryName" placeholder="카테고리명" required>
			<select name="status">
				<option value="ACTIVE">ACTIVE</option>
				<option value="INACTIVE">INACTIVE</option>
			</select>
			<button class="btn btn-main" type="submit">등록</button>
			<button type="button" class="btn btn-sub" onclick="closeModal('writeModal')">취소</button>
		</form>
	</div>
</div>

<!-- 수정 모달 -->
<div id="updateModal" class="modal">
	<div class="modal-content">
		<h3>카테고리 수정</h3>
		<form action="${pageContext.request.contextPath}/adminCategory/update.do" method="post">
			<input type="hidden" name="categoryId" id="u_id">
			<input type="text" name="categoryName" id="u_name" required>
			<select name="status" id="u_status">
				<option value="ACTIVE">ACTIVE</option>
				<option value="INACTIVE">INACTIVE</option>
			</select>
			<button class="btn btn-main" type="submit">수정</button>
			<button type="button" class="btn btn-sub" onclick="closeModal('updateModal')">취소</button>
		</form>
	</div>
</div>

</body>
</html>