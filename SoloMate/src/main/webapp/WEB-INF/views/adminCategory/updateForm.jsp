<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카테고리 수정</title>

<style>
.form-page {
	padding: 40px;
	min-height: 100vh;
	display: flex;
	align-items: center;
	justify-content: center;
}

.form-wrap {
	width: 660px;
	background: #fff;
	border-radius: 24px;
	box-shadow: 0 4px 20px rgba(0,0,0,0.08);
	overflow: hidden;
	border: 1px solid #e5e7eb;
}

.form-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 24px 28px 12px 28px;
}

.form-title {
	font-size: 34px;
	font-weight: 800;
	margin: 0;
}

.form-close {
	font-size: 32px;
	color: #888;
	text-decoration: none;
	line-height: 1;
}

.form-close:hover {
	color: #111;
	text-decoration: none;
}

.form-body {
	padding: 12px 28px 28px 28px;
}

.form-label {
	display: block;
	font-size: 17px;
	font-weight: 700;
	margin-bottom: 10px;
	color: #444;
}

.form-group {
	margin-bottom: 24px;
}

.form-input,
.form-select {
	width: 100%;
	height: 56px;
	border-radius: 14px;
	border: 1px solid #d1d5db;
	background: #fff;
	font-size: 17px;
	padding: 0 16px;
	outline: none;
}

.form-input:focus,
.form-select:focus {
	border-color: #888;
	box-shadow: 0 0 0 3px rgba(0,0,0,0.05);
}

.submit-btn {
	width: 100%;
	height: 56px;
	border: none;
	border-radius: 14px;
	font-size: 22px;
	font-weight: 800;
	color: #fff;
	background: #111827;
	cursor: pointer;
}

.submit-btn:hover {
	opacity: 0.95;
}
</style>
</head>
<body>

<div class="form-page">
	<div class="form-wrap">
		<div class="form-header">
			<h2 class="form-title">카테고리 수정</h2>
			<a href="${pageContext.request.contextPath}/adminCategory/list.do" class="form-close">×</a>
		</div>

		<div class="form-body">
			<form action="${pageContext.request.contextPath}/adminCategory/update.do" method="post">
				<input type="hidden" name="categoryId" value="${param.categoryId}">

				<div class="form-group">
					<label class="form-label">카테고리명</label>
					<input type="text" name="categoryName" class="form-input"
						   value="${param.categoryName}" required>
				</div>

				<div class="form-group">
					<label class="form-label">상태</label>
					<select name="status" class="form-select" required>
						<option value="ACTIVE" ${param.status eq 'ACTIVE' ? 'selected' : ''}>ACTIVE</option>
						<option value="INACTIVE" ${param.status eq 'INACTIVE' ? 'selected' : ''}>INACTIVE</option>
					</select>
				</div>

				<button type="submit" class="submit-btn">수정하기</button>
			</form>
		</div>
	</div>
</div>

</body>
</html>