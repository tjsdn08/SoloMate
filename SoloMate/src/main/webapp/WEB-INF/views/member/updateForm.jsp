<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>

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
	max-width: 600px; /* 입력 폼에 맞게 너비 살짝 축소 */
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

.form-input.readonly {
	background-color: #f8f9fc;
	color: #6b7280;
	cursor: not-allowed;
}

.form-divider {
	height: 1px;
	background-color: #f1f3f5;
	margin: 32px 0;
	border: none;
}

/* 메시지 텍스트 */
.msg-text {
	font-size: 13px;
	margin-top: 6px;
	display: block;
}

.text-warn {
	color: #dc3545;
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
.btn-main, .btn-sub {
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

.btn-main {
	background: #111827;
	color: #fff;
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

.bottom-buttons {
	display: flex;
	justify-content: flex-start;
	gap: 12px;
	margin-top: 32px;
}
</style>

<script type="text/javascript">
    function validate() {
        // 기존 함수 로직 유지
    }

    function checkForm() {
        let pw = document.getElementById("pw").value;
        if (pw.length < 1) {
            alert("본인 확인을 위해 비밀번호를 입력해주세요.");
            return false;
        }
        return true;
    }
</script>
</head>
<body>

	<div class="admin-page">
		<div class="admin-card">
			
			<div class="top-bar">
				<h2 class="top-title m-0">정보 수정</h2>
			</div>
			
			<form action="update.do" method="post" onsubmit="return checkForm()">
				<div class="form-group">
					<label class="form-label">아이디</label>
					<input type="text" class="form-input readonly" name="id" value="${vo.id}" readonly>
				</div>

				<div class="form-group">
					<label for="pw" class="form-label">비밀번호 확인</label>
					<input type="password" class="form-input" id="pw" name="pw" placeholder="현재 비밀번호 입력" oninput="validate()" required>
					<span class="msg-text text-warn">수정하려면 비밀번호를 입력해야 합니다.</span>
				</div>

				<hr class="form-divider">

				<div class="form-group">
					<label for="name" class="form-label">이름</label>
					<input type="text" class="form-input" id="name" name="name" value="${vo.name}" required>
				</div>

				<div class="form-group">
					<label for="tel" class="form-label">전화번호</label>
					<input type="tel" class="form-input" id="tel" name="tel" value="${vo.tel}" required>
				</div>

				<div class="form-group">
					<label for="address" class="form-label">주소</label>
					<input type="text" class="form-input" id="address" name="address" value="${vo.address}">
				</div>

				<div class="bottom-buttons">
					<button type="submit" class="btn-main">정보 수정</button>
					<button type="button" class="btn-sub" onclick="history.back()">취소</button>
				</div>
			</form>

			<c:if test="${updateStatus == 'fail'}">
				<div id="failMsg" class="fail-msg">
					비밀번호가 일치하지 않습니다. 다시 확인해주세요.
				</div>
			</c:if>
			
		</div>
	</div>

</body>
</html>