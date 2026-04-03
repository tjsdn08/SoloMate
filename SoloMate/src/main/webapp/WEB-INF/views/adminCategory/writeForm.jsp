<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카테고리 등록</title>

<style>
.form-page {
	max-width: 980px;
	margin: 30px auto;
	padding: 0 16px;
}

.form-card {
	background: #fff;
	border-radius: 18px;
	padding: 28px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
}

.form-title {
	font-size: 28px;
	font-weight: 800;
	margin-bottom: 24px;
}

.form-grid {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 20px;
	margin-bottom: 20px;
}

.form-label {
	font-size: 15px;
	font-weight: 700;
	color: #555;
	margin-bottom: 8px;
}

.form-input, .form-select {
	width: 100%;
	height: 48px;
	border: 1px solid #ddd;
	border-radius: 12px;
	padding: 0 14px;
	font-size: 15px;
	outline: none;
	box-sizing: border-box;
}

.bottom-btns {
	display: flex;
	justify-content: space-between;
	margin-top: 24px;
}
</style>
</head>
<body>

<div class="form-page">
	<div class="form-card">
		<div class="form-title">카테고리 등록</div>

		<form action="${pageContext.request.contextPath}/adminCategory/write.do" method="post">
			<div class="form-grid">
				<div>
					<div class="form-label">카테고리명</div>
					<input type="text" name="categoryName" class="form-input" required>
				</div>

				<div>
					<div class="form-label">상태</div>
					<select name="status" class="form-select" required>
						<option value="ACTIVE">ACTIVE</option>
						<option value="INACTIVE">INACTIVE</option>
					</select>
				</div>
			</div>

			<div class="bottom-btns">
				<a href="${pageContext.request.contextPath}/adminCategory/list.do" class="btn btn-secondary">취소</a>
				<button type="submit" class="btn btn-primary">등록</button>
			</div>
		</form>
	</div>
</div>

</body>
</html>