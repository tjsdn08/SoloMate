<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴</title>

<style>
/* 공통 레이아웃 스타일 */
.admin-page {
	padding: 30px;
}

.admin-card {
	background: #fff;
	border-radius: 18px;
	padding: 30px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
	max-width: 600px; /* 입력 폼에 맞게 너비 유지 */
	margin: 0 auto;
}

.top-bar {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 24px;
	padding-bottom: 16px;
	border-bottom: 2px solid #f8f9fc;
}

.top-title {
	font-size: 28px;
	font-weight: 800;
	color: #111;
	margin: 0;
}

/* 탈퇴 페이지 전용 타이틀 컬러 */
.top-title.title-danger {
	color: #dc3545;
}

/* 경고 박스 (주의사항) */
.warning-box {
	padding: 20px;
	background-color: #fff5f5;
	border: 1px solid #ffe3e3;
	border-radius: 12px;
	margin-bottom: 24px;
}

.warning-box .warning-title {
	font-size: 15px;
	font-weight: 700;
	color: #c92a2a;
	margin: 0 0 6px 0;
}

.warning-box .warning-desc {
	font-size: 14px;
	color: #6b7280;
	margin: 0;
	line-height: 1.5;
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

/* 설명 텍스트 */
.msg-text {
	font-size: 13px;
	margin-top: 6px;
	display: block;
	color: #6b7280;
	min-height: 18px;
}

/* 실패 알림 박스 */
.fail-msg {
	margin-top: 24px;
	padding: 16px;
	background-color: #fff5f5;
	border: 1px solid #ffe3e3;
	border-radius: 12px;
	color: #c92a2a;
	font-size: 14px;
	font-weight: 500;
}

/* 하단 버튼 영역 */
.btn-sub, .btn-danger-custom {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	height: 48px;
	padding: 0 24px;
	border-radius: 12px;
	border: none;
	font-size: 15px;
	font-weight: 700;
	text-decoration: none;
	cursor: pointer;
	transition: background 0.2s ease;
}

/* 탈퇴 전용 경고 버튼 */
.btn-danger-custom {
	background: #dc3545;
	color: #fff;
}

.btn-danger-custom:hover {
	background: #b02a37;
	color: #fff;
}

.btn-sub {
	background: #eef0f4;
	color: #333;
}

.btn-sub:hover {
	background: #e5e7eb;
}

.bottom-buttons {
	display: flex;
	justify-content: flex-start;
	gap: 12px;
	margin-top: 32px;
}
</style>

<script type="text/javascript">
    function validate() {
        let failMsg = document.getElementById("failMsg");
        if (failMsg) failMsg.style.display = "none";
    }
</script>
</head>
<body>

	<div class="admin-page">
		<div class="admin-card">
			
			<div class="top-bar">
				<h2 class="top-title title-danger">회원 탈퇴</h2>
			</div>
			
			<div class="warning-box">
				<p class="warning-title">주의사항</p>
				<p class="warning-desc">탈퇴 시 회원 정보 및 이용 기록이 모두 삭제되며, 복구가 불가능합니다.</p>
			</div>

			<form action="delete.do" method="post">
				
				<div class="form-group">
					<label for="pw" class="form-label">비밀번호 확인</label>
					<input type="password" class="form-input" id="pw" name="pw" placeholder="현재 비밀번호를 입력하세요" oninput="validate()" required>
					<span class="msg-text">본인 확인을 위해 비밀번호가 필요합니다.</span>
				</div>

				<div class="bottom-buttons">
					<button type="submit" class="btn-danger-custom" onclick="return confirm('정말로 탈퇴하시겠습니까?')">탈퇴하기</button>
					<button type="button" class="btn-sub" onclick="history.back()">취소</button>
				</div>
				
			</form>

			<c:if test="${deleteStatus == 'fail'}">
				<div id="failMsg" class="fail-msg">
					비밀번호가 일치하지 않습니다. 다시 확인해주세요.
				</div>
			</c:if>
			
		</div>
	</div>

</body>
</html>