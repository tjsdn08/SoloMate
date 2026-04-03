<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>로그인</title>

<style>
.admin-page {
	padding: 100px 30px 30px 30px;
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
	max-width: 450px; /* 로그인 폼 전용 너비 */
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

/* 버튼 영역 */
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
	margin-bottom: 16px;
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

.sub-btn-group {
	display: flex;
	gap: 12px;
	margin-bottom: 24px;
}

/* 아이디/비밀번호 찾기 버튼 반반 분할 */
.sub-btn-group .btn-sub {
	flex: 1;
}

/* 하단 텍스트 링크 */
.footer-text {
	text-align: center;
	font-size: 14px;
	color: #6b7280;
}

.footer-text a {
	color: #2563eb;
	text-decoration: none;
	font-weight: 600;
	margin-left: 4px;
}

.footer-text a:hover {
	text-decoration: underline;
}
</style>
</head>
<body>

	<div class="admin-page">
		<div class="admin-card">
			
			<div class="top-bar">
				<h2 class="top-title">로그인</h2>
			</div>
			
			<form action="login.do" method="post">
				
				<div class="form-group">
					<label for="id" class="form-label">아이디</label>
					<input type="text" class="form-input" id="id" placeholder="아이디 입력" name="id"
						   required autocomplete="off" maxlength="20" autofocus>
				</div>
				
				<div class="form-group">
					<label for="pw" class="form-label">비밀번호</label>
					<input type="password" class="form-input" id="pw" placeholder="비밀번호 입력" name="pw"
						   required maxlength="20">
				</div>

				<button type="submit" class="btn-main">로그인</button>

				<div class="sub-btn-group">
					<a href="searchIdForm.do" class="btn-sub">아이디 찾기</a>
					<a href="searchPwForm.do" class="btn-sub">비밀번호 찾기</a>
				</div>
				
				<div class="footer-text">
					계정이 없으신가요? <a href="writeForm.do">회원가입</a>
				</div>
				
			</form>
			
		</div>
	</div>

</body>
</html>