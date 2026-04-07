<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

.preview-box {
	margin-top: 10px;
}

.preview-box img {
	width: 180px;
	height: 180px;
	object-fit: cover;
	border-radius: 12px;
	border: 1px solid #ddd;
	background: #f5f5f5;
	display: block;
}
</style>
</head>
<body>

	<div class="form-page">
		<div class="form-card">
			<div class="form-title">관리자 핫딜 수정</div>

			<form
				action="${pageContext.request.contextPath}/adminHotDeal/update.do"
				method="post" enctype="multipart/form-data">

				<input type="hidden" name="dealId" value="${vo.dealId}"> <input
					type="hidden" name="oldImageUrl" value="${vo.imageUrl}">

				<div class="form-grid">
					<div>
						<div class="form-label">카테고리</div>
						<select name="categoryId" class="form-select" required>
							<option value="">선택</option>
							<c:forEach items="${categoryList}" var="cat">
								<c:if test="${cat.status eq 'ACTIVE'}">
									<option value="${cat.categoryId}"
										${vo.categoryId == cat.categoryId ? 'selected="selected"' : ''}>
										${cat.categoryName}</option>
								</c:if>
							</c:forEach>
						</select>
					</div>

					<div>
						<div class="form-label">상태</div>
						<select name="status" class="form-select" required>
							<option value="ACTIVE" ${vo.status eq 'ACTIVE' ? 'selected' : ''}>ACTIVE</option>
							<option value="INACTIVE"
								${vo.status eq 'INACTIVE' ? 'selected' : ''}>INACTIVE</option>
						</select>
					</div>
				</div>

				<div class="form-row-full">
					<div class="form-label">상품명</div>
					<input type="text" name="title" class="form-input"
						value="${vo.title}" required>
				</div>

				<div class="form-grid">
					<div>
						<div class="form-label">가격</div>
						<input type="number" name="price" class="form-input"
							value="${vo.price}" min="0" required>
					</div>

					<div>
						<div class="form-label">원가</div>
						<input type="number" name="originalPrice" class="form-input"
							value="${vo.originalPrice}" min="0" required>
					</div>
				</div>

				<div class="form-grid">
					<div>
						<div class="form-label">할인율</div>
						<input type="number" name="discountRate" class="form-input"
							value="${vo.discountRate}" min="0" readonly>
					</div>

					<div>
						<div class="form-label">종료일</div>
						<input type="date" name="endDate" class="form-input"
							value="${vo.endDate}" required>
					</div>
				</div>

				<div class="form-grid">
					<div>
						<div class="form-label">판매처</div>
						<input type="text" name="shopName" class="form-input"
							value="${vo.shopName}" required>
					</div>

					<div>
						<div class="form-label">판매자</div>
						<input type="text" name="sellerName" class="form-input"
							value="${vo.sellerName}">
					</div>
				</div>

				<div class="form-row-full">
					<div class="form-label">상품 이미지</div>
					<input type="file" name="imageFile" class="form-input"
						accept="image/*">

					<div class="preview-box">
						<c:choose>
							<c:when test="${not empty vo.imageUrl}">
								<img
									src="${pageContext.request.contextPath}/upload/hotdeal/${vo.imageUrl}"
									alt="${vo.title}"
									onerror="this.src='${pageContext.request.contextPath}/upload/hotdeal/default.png'">
							</c:when>
							<c:otherwise>
								<img
									src="${pageContext.request.contextPath}/upload/hotdeal/default.png"
									alt="기본 이미지">
							</c:otherwise>
						</c:choose>
					</div>
				</div>

				<div class="form-row-full">
					<div class="form-label">구매 링크</div>
					<input type="text" name="dealUrl" class="form-input"
						value="${vo.dealUrl}" required>
				</div>

				<div class="form-row-full">
					<div class="form-label">설명</div>
					<textarea name="description" class="form-textarea">${vo.description}</textarea>
				</div>

				<div class="bottom-btns">
					<a
						href="${pageContext.request.contextPath}/adminHotDeal/view.do?dealId=${vo.dealId}"
						class="btn btn-secondary">취소</a>
					<button type="submit" class="btn btn-primary">수정</button>
				</div>
			</form>

		</div>
	</div>

</body>
</html>