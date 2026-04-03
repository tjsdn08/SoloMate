<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>아이디 찾기</title>

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
	max-width: 450px; /* 로그인/찾기 폼 전용 너비 */
}

.top-bar {
	text-align: center;
	margin-bottom: 30px;
}

.top-title {
	font-size: 28px;
	font-weight: 800;
	color: #111;
	margin: 0;
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

.result-id {
	font-size: 22px;
	font-weight: 800;
	color: #111;
	margin-bottom: 20px;
}

.btn-success-link {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	height: 40px;
	padding: 0 20px;
	border-radius: 8px;
	background: #15803d;
	color: #fff;
	font-size: 14px;
	font-weight: 600;
	text-decoration: none;
	transition: background 0.2s ease;
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
				<h2 class="top-title">아이디 찾기</h2>
			</div>
			
			<form action="searchId.do" method="post">
				<div class="form-group">
					<label for="name" class="form-label">이름</label>
					<input type="text" class="form-input" id="name" name="name" 
						   value="${param.name}" placeholder="이름 입력" required>
				</div>
				
				<div class="form-group">
					<label for="tel" class="form-label">연락처</label>
					<input type="tel" class="form-input" id="tel" name="tel" 
						   value="${param.tel}" placeholder="연락처 입력" required>
				</div>
				
				<div>
					<button type="submit" class="btn-main">아이디 찾기</button>
					<a href="loginForm.do" class="btn-sub">취소</a>
				</div>
			</form>

			<c:if test="${!empty foundId}">
				<c:choose>
					<c:when test="${foundId != 'none'}">
						<div class="result-box result-success">
							<div class="result-title">아이디 찾기 성공</div>
							<div class="result-id">${foundId}</div>
							<a href="loginForm.do" class="btn-success-link">로그인 하러가기</a>
						</div>
					</c:when>
					
					<c:otherwise>
						<div class="result-box result-fail">
							일치하는 회원이 없습니다.
						</div>
					</c:otherwise>
				</c:choose>
			</c:if>

		</div>
	</div>

</body>
</html>