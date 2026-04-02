<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카테고리 관리</title>

<style>
.page {
	padding: 40px;
}

.wrap {
	max-width: 1100px;
	margin: auto;
	background: #fff;
	border-radius: 24px;
	padding: 32px;
	box-shadow: 0 4px 20px rgba(0,0,0,0.06);
}

.top {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 24px;
}

.title {
	font-size: 38px;
	font-weight: 800;
	margin: 0;
}

.btn-add {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	gap: 8px;
	height: 50px;
	padding: 0 18px;
	border-radius: 12px;
	border: none;
	background: #111827;
	color: #fff;
	font-size: 16px;
	font-weight: 700;
	cursor: pointer;
}

.table-box {
	border: 1px solid #e5e7eb;
	border-radius: 20px;
	overflow: hidden;
}

.table-custom {
	width: 100%;
	border-collapse: collapse;
}

.table-custom th,
.table-custom td {
	padding: 20px 22px;
	text-align: left;
	border-bottom: 1px solid #f0f1f3;
	vertical-align: middle;
}

.table-custom thead th {
	background: #f8f9fa;
	color: #666;
	font-size: 17px;
	font-weight: 700;
}

.table-custom tbody td {
	font-size: 19px;
	font-weight: 600;
}

.table-custom tbody tr:last-child td {
	border-bottom: none;
}

.badge-status {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	min-width: 98px;
	height: 36px;
	padding: 0 14px;
	border-radius: 999px;
	font-size: 14px;
	font-weight: 700;
	background: #eef0f4;
	color: #333;
}

.actions {
	display: flex;
	gap: 10px;
}

.icon-btn {
	width: 42px;
	height: 42px;
	border-radius: 10px;
	background: #f3f4f6;
	border: 1px solid #e5e7eb;
	display: inline-flex;
	align-items: center;
	justify-content: center;
	text-decoration: none;
	color: #222;
	font-size: 18px;
	cursor: pointer;
}

.icon-btn:hover {
	background: #e9ecef;
	color: #111;
	text-decoration: none;
}

/* 모달 */
.modal {
	display: none;
	position: fixed;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	background: rgba(0,0,0,0.45);
	z-index: 999;
	align-items: center;
	justify-content: center;
}

.modal-card {
	width: 560px;
	background: #fff;
	border-radius: 22px;
	padding: 26px;
	box-shadow: 0 18px 50px rgba(0,0,0,0.2);
}

.modal-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 20px;
}

.modal-title {
	font-size: 30px;
	font-weight: 800;
	margin: 0;
}

.modal-close {
	border: none;
	background: none;
	font-size: 28px;
	cursor: pointer;
	color: #777;
}

.form-group {
	margin-bottom: 20px;
}

.form-label {
	display: block;
	font-size: 16px;
	font-weight: 700;
	color: #444;
	margin-bottom: 10px;
}

.form-input,
.form-select {
	width: 100%;
	height: 54px;
	border-radius: 14px;
	border: 1px solid #d1d5db;
	padding: 0 16px;
	font-size: 16px;
	outline: none;
}

.form-input:focus,
.form-select:focus {
	border-color: #888;
	box-shadow: 0 0 0 3px rgba(0,0,0,0.05);
}

.submit-btn {
	width: 100%;
	height: 54px;
	border: none;
	border-radius: 14px;
	background: #111827;
	color: #fff;
	font-size: 19px;
	font-weight: 800;
	cursor: pointer;
}

.empty-row td {
	text-align: center;
	color: #777;
	font-size: 17px;
	font-weight: 500;
	padding: 40px 20px;
}
</style>

<script type="text/javascript">
function openWriteModal() {
	document.getElementById("writeModal").style.display = "flex";
}

function openUpdateModal(id, name, status) {
	document.getElementById("updateModal").style.display = "flex";
	document.getElementById("u_categoryId").value = id;
	document.getElementById("u_categoryName").value = name;
	document.getElementById("u_status").value = status;
}

function closeModal(id) {
	const modal = document.getElementById(id);
	if (modal) {
		modal.style.display = "none";
	}
}

window.addEventListener("DOMContentLoaded", function() {

	document.querySelectorAll(".modal-close").forEach(function(btn) {
		btn.addEventListener("click", function(e) {
			e.preventDefault();
			e.stopPropagation();
			const modalId = this.getAttribute("data-close");
			closeModal(modalId);
		});
	});

	document.querySelectorAll(".modal").forEach(function(modal) {
		modal.addEventListener("click", function() {
			modal.style.display = "none";
		});
	});
});
</script>
</head>
<body>

<div class="page">
	<div class="wrap">

		<div class="top">
			<h2 class="title">카테고리 관리</h2>
			<button type="button" class="btn-add" onclick="openWriteModal()">＋ 카테고리 등록</button>
		</div>

		<div class="table-box">
			<table class="table-custom">
				<thead>
					<tr>
						<th style="width: 90px;">번호</th>
						<th>카테고리명</th>
						<th style="width: 180px;">상태</th>
						<th style="width: 180px;">등록일</th>
						<th style="width: 220px;">관리</th>
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
								<span class="badge-status">${vo.status}</span>
							</td>
							<td>${vo.createdAt}</td>
							<td>
								<div class="actions">
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

									<button type="button"
											class="icon-btn"
											title="수정"
											onclick="openUpdateModal('${vo.categoryId}','${vo.categoryName}','${vo.status}')">✎</button>

									<a href="${pageContext.request.contextPath}/adminCategory/delete.do?categoryId=${vo.categoryId}"
									   class="icon-btn"
									   title="삭제"
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

<!-- 등록 모달 -->
<div id="writeModal" class="modal">
	<div class="modal-card" onclick="event.stopPropagation();">
		<div class="modal-header">
			<h3 class="modal-title">카테고리 등록</h3>
			<button type="button" class="modal-close" data-close="writeModal">×</button>
		</div>

		<form action="${pageContext.request.contextPath}/adminCategory/write.do" method="post">
			<div class="form-group">
				<label class="form-label">카테고리명</label>
				<input type="text" name="categoryName" class="form-input" placeholder="예: 식품" required>
			</div>

			<div class="form-group">
				<label class="form-label">상태</label>
				<select name="status" class="form-select" required>
					<option value="ACTIVE">ACTIVE</option>
					<option value="INACTIVE">INACTIVE</option>
				</select>
			</div>

			<button type="submit" class="submit-btn">등록하기</button>
		</form>
	</div>
</div>

<!-- 수정 모달 -->
<div id="updateModal" class="modal">
	<div class="modal-card" onclick="event.stopPropagation();">
		<div class="modal-header">
			<h3 class="modal-title">카테고리 수정</h3>
			<button type="button" class="modal-close" data-close="updateModal">×</button>
		</div>

		<form action="${pageContext.request.contextPath}/adminCategory/update.do" method="post">
			<input type="hidden" name="categoryId" id="u_categoryId">

			<div class="form-group">
				<label class="form-label">카테고리명</label>
				<input type="text" name="categoryName" id="u_categoryName" class="form-input" required>
			</div>

			<div class="form-group">
				<label class="form-label">상태</label>
				<select name="status" id="u_status" class="form-select" required>
					<option value="ACTIVE">ACTIVE</option>
					<option value="INACTIVE">INACTIVE</option>
				</select>
			</div>

			<button type="submit" class="submit-btn">수정하기</button>
		</form>
	</div>
</div>

</body>
</html>