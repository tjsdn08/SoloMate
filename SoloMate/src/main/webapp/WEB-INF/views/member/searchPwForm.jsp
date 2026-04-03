<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>비밀번호 찾기</title>

<style>
.admin-page {
	padding: 80px 30px 30px 30px;
	background-color: #fff;
	min-height: 100vh;
	display: flex;
	align-items: flex-start;
	justify-content: center;
	box-sizing: border-box;
}

.admin-card {
	background: #fff;
	border-radius: 18px;
	padding: 40px 30px;
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
	width: 100%;
	max-width: 450px;
}

.top-bar {
	text-align: center;
	margin-bottom: 20px;
}

.top-title {
	font-size: 28px;
	font-weight: 800;
	color: #111;
	margin: 0;
}

/* 안내 텍스트 */
.sub-text {
	text-align: center;
	font-size: 14px;
	color: #6b7280;
	margin-bottom: 30px;
	line-height: 1.5;
}

.sub-text b {
	color: #111;
	font-weight: 700;
}

/* 폼 전용 스타일 */
.form-group {
	margin-bottom: 24px;
}

.form-label {
	display: block;
	font-size: 14px;
	font-weight: 600;
	color: #4b5563;
	margin-bottom: 8px;
}

.form-input {
	width: 100%;
	height: 48px;
	border: 1px solid #ddd;
	border-radius: 12px;
	padding: 0 14px;
	font-size: 15px;
	outline: none;
	box-sizing: border-box;
	transition: border-color 0.2s ease;
}

.form-input:focus {
	border-color: #111;
}

/* 하단 버튼 영역 */
.btn-main, .btn-sub {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	height: 48px;
	border-radius: 12px;
	border: none;
	font-size: 15px;
	font-weight: 700;
	text-decoration: none;
	cursor: pointer;
	transition: background 0.2s ease;
	width: 100%;
	box-sizing: border-box;
}

.btn-main {
	background: #111827;
	color: #fff;
	margin-bottom: 12px;
}

.btn-main:hover {
	background: #374151;
	color: #fff;
}

.btn-sub {
	background: #eef0f4;
	color: #333;
}

.btn-sub:hover {
	background: #e5e7eb;
}

/* 결과 출력 영역 스타일 */
.result-box {
	margin-top: 30px;
	padding: 24px;
	border-radius: 12px;
	text-align: center;
}

.result-success {
	background-color: #f0fdf4;
	border: 1px solid #dcfce7;
}

.result-fail {
	background-color: #fff5f5;
	border: 1px solid #ffe3e3;
	color: #c92a2a;
	font-weight: 500;
	font-size: 15px;
}

.result-title {
	font-size: 13px;
	color: #15803d;
	font-weight: 600;
	margin-bottom: 8px;
}

.result-label {
	font-size: 13px;
	color: #4b5563;
	margin-bottom: 4px;
}

.result-id {
	font-size: 22px;
	font-weight: 800;
	color: #2563eb; /* 임시 비밀번호 강조 */
	margin-bottom: 16px;
}

.result-note {
	font-size: 12px;
	color: #6b7280;
	margin-bottom: 20px;
}

.result-note b {
	color: #111;
}

.btn-success-link {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	height: 48px;
	width: 100%;
	border-radius: 12px;
	background: #15803d;
	color: #fff;
	font-size: 15px;
	font-weight: 700;
	text-decoration: none;
	transition: background 0.2s ease;
	box-sizing: border-box;
}

.btn-success-link:hover {
	background: #166534;
	color: #fff;
}
</style>
</head>
<body>

	<div class="admin-page">
		<div class="admin-card">
			
			<div class="top-bar">
				<h2 class="top-title">비밀번호 찾기</h2>
			</div>
			
			<p class="sub-text">
				가입 시 입력한 정보를 입력하시면<br>
				비밀번호가 <b>등록된 연락처</b>로 재설정됩니다.
			</p>
			
			<form action="findPw.do" method="post">
				<div class="form-group">
					<label for="name" class="form-label">이름</label>
					<input type="text" class="form-input" name="name" id="name"
						   value="${param.name}" placeholder="이름 입력" required>
				</div>
				
				<div class="form-group">
					<label for="id" class="form-label">아이디</label>
					<input type="text" class="form-input" name="id" id="id"
						   value="${param.id}" placeholder="아이디 입력" required>
				</div>
				
				<div class="form-group">
					<label for="tel" class="form-label">연락처</label>
					<input type="tel" class="form-input" name="tel" id="tel"
						   value="${param.tel}" placeholder="010-0000-0000" required>
				</div>
				
				<div>
					<button type="submit" class="btn-main">비밀번호 재설정</button>
					<a href="loginForm.do" class="btn-sub">취소</a>
				</div>
			</form>

			<c:if test="${!empty msg}">
				<c:choose>
					<%-- 성공 시: 컨트롤러에서 maskedTel을 넘겨준다고 가정 --%>
					<c:when test="${not empty maskedTel}">
						<div class="result-box result-success">
							<div class="result-title">재설정 완료</div>
							<div class="result-label">새 비밀번호:</div>
							<div class="result-id">${maskedTel}</div>
							<div class="result-note">
								* 가입하신 <b>연락처</b>가 임시 비밀번호로 설정되었습니다.
							</div>
							<a href="loginForm.do" class="btn-success-link">로그인 하러가기</a>
						</div>
					</c:when>
					
					<%-- 실패 시 --%>
					<c:otherwise>
						<div class="result-box result-fail">
							${msg}
						</div>
					</c:otherwise>
				</c:choose>
			</c:if>

		</div>
	</div>

</body>
</html>