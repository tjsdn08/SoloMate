<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장보기 등록</title>

<style>
.write-wrapper {
	max-width: 820px;
	margin: 40px auto;
	padding: 0 16px;
}

.write-card {
	background: #fff;
	border-radius: 20px;
	box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
	overflow: hidden;
}

.write-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 24px 30px;
	border-bottom: 1px solid #ececec;
}

.write-title {
	font-size: 28px;
	font-weight: 700;
}

.write-close {
	font-size: 28px;
	color: #999;
	text-decoration: none;
}

.write-close:hover {
	color: #333;
}

.write-body {
	padding: 30px;
}

.form-label-custom {
	font-size: 15px;
	font-weight: 700;
	color: #555;
	margin-bottom: 8px;
}

.form-control-custom {
	width: 100%;
	height: 50px;
	border: 1px solid #ddd;
	border-radius: 12px;
	padding: 0 14px;
	font-size: 16px;
}

.form-control-custom:focus {
	border-color: #5b67f1;
	box-shadow: 0 0 0 3px rgba(91,103,241,0.12);
	outline: none;
}

.form-textarea-custom {
	width: 100%;
	min-height: 120px;
	border: 1px solid #ddd;
	border-radius: 12px;
	padding: 14px;
	font-size: 16px;
	resize: none;
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

.write-footer {
	display: flex;
	justify-content: space-between;
	padding: 24px 30px;
	background: #fafafa;
	border-top: 1px solid #ececec;
}

.btn-custom {
	padding: 12px 20px;
	border-radius: 12px;
	font-weight: 700;
	border: none;
	cursor: pointer;
	text-decoration: none;
}

.btn-submit {
	background: #5b67f1;
	color: #fff;
}

.btn-cancel {
	background: #eee;
	color: #333;
}

.btn-reset {
	background: #4f8f5b;
	color: #fff;
}
</style>
</head>
<body>

<div class="write-wrapper">
	<div class="write-card">

		<div class="write-header">
			<div class="write-title">장보기 등록</div>
			<a href="${pageContext.request.contextPath}/shopping/list.do"
			   class="write-close">×</a>
		</div>

		<form action="${pageContext.request.contextPath}/shopping/write.do" method="post">

			<div class="write-body">

				<!-- 품목명 -->
				<div class="form-row-full">
					<div class="form-label-custom">품목명</div>
					<input type="text" name="itemName" class="form-control-custom"
						placeholder="예: 우유, 계란, 세제"
						required>
				</div>

				<!-- 수량 / 금액 -->
				<div class="form-grid">
					<div>
						<div class="form-label-custom">수량</div>
						<input type="number" name="quantity"
							class="form-control-custom"
							min="1" value="1" required>
					</div>

					<div>
						<div class="form-label-custom">예상금액</div>
						<input type="number" name="expectedPrice"
							class="form-control-custom"
							min="0" placeholder="원 단위 입력" required>
					</div>
				</div>

				<!-- 구매예정일 -->
				<div class="form-row-full">
					<div class="form-label-custom">구매예정일</div>
					<input type="date" name="planDate"
						class="form-control-custom"
						required>
				</div>

				<!-- 메모 -->
				<div class="form-row-full">
					<div class="form-label-custom">메모</div>
					<textarea name="memo"
						class="form-textarea-custom"
						placeholder="필요한 내용을 자유롭게 입력하세요 (선택)"></textarea>
				</div>

			</div>

			<div class="write-footer">

				<a href="${pageContext.request.contextPath}/shopping/list.do"
				   class="btn-custom btn-cancel">취소</a>

				<div>
					<button type="reset" class="btn-custom btn-reset">초기화</button>
					<button type="submit" class="btn-custom btn-submit">등록</button>
				</div>

			</div>

		</form>
	</div>
</div>

</body>
</html>