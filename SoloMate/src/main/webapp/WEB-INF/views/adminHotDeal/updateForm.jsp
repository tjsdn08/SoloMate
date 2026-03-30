<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 핫딜 수정</title>

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
	box-shadow: 0 2px 10px rgba(0,0,0,0.05);
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

.form-row-full {
	margin-bottom: 20px;
}

.form-label {
	font-size: 15px;
	font-weight: 700;
	color: #555;
	margin-bottom: 8px;
}

.form-input, .form-select, .form-textarea {
	width: 100%;
	border: 1px solid #ddd;
	border-radius: 12px;
	font-size: 15px;
	outline: none;
}

.form-input, .form-select {
	height: 48px;
	padding: 0 14px;
}

.form-textarea {
	min-height: 140px;
	padding: 14px;
	resize: none;
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
		<div class="form-title">관리자 핫딜 수정</div>

		<form action="${pageContext.request.contextPath}/adminHotDeal/update.do" method="post">
			<input type="hidden" name="dealId" value="${vo.dealId}">

			<div class="form-grid">
				<div>
					<div class="form-label">카테고리</div>
					<select name="categoryId" class="form-select" required>
						<option value="1" ${vo.categoryId eq 1 ? 'selected' : ''}>식품</option>
						<option value="2" ${vo.categoryId eq 2 ? 'selected' : ''}>생활용품</option>
						<option value="3" ${vo.categoryId eq 3 ? 'selected' : ''}>가전</option>
					</select>
				</div>

				<div>
					<div class="form-label">상태</div>
					<select name="status" class="form-select" required>
						<option value="ACTIVE" ${vo.status eq 'ACTIVE' ? 'selected' : ''}>ACTIVE</option>
						<option value="INACTIVE" ${vo.status eq 'INACTIVE' ? 'selected' : ''}>INACTIVE</option>
					</select>
				</div>
			</div>

			<div class="form-row-full">
				<div class="form-label">상품명</div>
				<input type="text" name="title" class="form-input" value="${vo.title}" required>
			</div>

			<div class="form-grid">
				<div>
					<div class="form-label">가격</div>
					<input type="number" name="price" class="form-input" value="${vo.price}" min="0" required>
				</div>

				<div>
					<div class="form-label">원가</div>
					<input type="number" name="originalPrice" class="form-input" value="${vo.originalPrice}" min="0" required>
				</div>
			</div>

			<div class="form-grid">
				<div>
					<div class="form-label">할인율</div>
					<input type="number" step="0.01" name="discountRate" class="form-input" value="${vo.discountRate}" min="0" required>
				</div>

				<div>
					<div class="form-label">종료일</div>
					<input type="date" name="endDate" class="form-input" value="${vo.endDate}" required>
				</div>
			</div>

			<div class="form-grid">
				<div>
					<div class="form-label">판매처</div>
					<input type="text" name="shopName" class="form-input" value="${vo.shopName}" required>
				</div>

				<div>
					<div class="form-label">판매자</div>
					<input type="text" name="sellerName" class="form-input" value="${vo.sellerName}">
				</div>
			</div>

			<div class="form-row-full">
				<div class="form-label">이미지 URL</div>
				<input type="text" name="imageUrl" class="form-input" value="${vo.imageUrl}">
			</div>

			<div class="form-row-full">
				<div class="form-label">구매 링크</div>
				<input type="text" name="dealUrl" class="form-input" value="${vo.dealUrl}" required>
			</div>

			<div class="form-row-full">
				<div class="form-label">설명</div>
				<textarea name="description" class="form-textarea">${vo.description}</textarea>
			</div>

			<div class="bottom-btns">
				<a href="${pageContext.request.contextPath}/adminHotDeal/view.do?dealId=${vo.dealId}" class="btn btn-secondary">취소</a>
				<button type="submit" class="btn btn-primary">수정</button>
			</div>
		</form>

	</div>
</div>

</body>
</html>