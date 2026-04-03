<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경</title>

<style>
/* 공통 레이아웃 스타일 */
.admin-page {
	padding: 30px;
	background-color: #fff;
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

/* 실시간 메시지 텍스트 */
.msg-text {
	font-size: 13px;
	margin-top: 6px;
	display: block;
	min-height: 18px;
}

.text-pass {
	color: #2563eb; /* 통과 시 파란색 */
}

.text-warn {
	color: #dc3545; /* 경고 시 빨간색 */
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
	    let pw = document.getElementById("pw").value;
	    let newPw = document.getElementById("newPw").value;
	    let newPw2 = document.getElementById("newPw2").value;
	    
	    let nMsg = document.getElementById("newPwMsg");
	    let nMsg2 = document.getElementById("newPw2Msg");
	    
	    let failMsg = document.getElementById("failMsg");
	    if (failMsg) { // 박스가 화면에 존재할 때만 실행
	        failMsg.style.display = "none";
	    }
	
	    // 1. 새 비밀번호 실시간 체크
	    if (newPw.length > 0) {
	        if (newPw.length < 4) {
	            nMsg.innerText = "4자 이상 입력해주세요.";
	            nMsg.className = "msg-text text-warn";
	        } else if (pw === newPw) {
	            nMsg.innerText = "현재 비밀번호와 동일합니다.";
	            nMsg.className = "msg-text text-warn";
	        } else {
	            nMsg.innerText = "사용 가능한 비밀번호입니다.";
	            nMsg.className = "msg-text text-pass";
	        }
	    } else {
	        nMsg.innerText = "";
	    }
	
	    // 2. 비밀번호 확인 실시간 체크
	    if (newPw2.length > 0) {
	        if (newPw === newPw2) {
	            nMsg2.innerText = "비밀번호가 일치합니다.";
	            nMsg2.className = "msg-text text-pass";
	        } else {
	            nMsg2.innerText = "비밀번호가 일치하지 않습니다.";
	            nMsg2.className = "msg-text text-warn";
	        }
	    } else {
	        nMsg2.innerText = "";
	    }
	}
	
	// 기존 onsubmit 에 있던 함수 (선언부가 없었으나 속성을 유지하기 위해 추가)
	function checkForm() {
		// 필요 시 제출 전 추가 검증 로직 작성
		return true;
	}
</script>
</head>
<body>

	<div class="admin-page">
		<div class="admin-card">
			
			<div class="top-bar">
				<h2 class="top-title">비밀번호 변경</h2>
			</div>
			
			<form action="changePw.do" method="post" onsubmit="return checkForm()">
				
				<div class="form-group">
					<label for="pw" class="form-label">현재 비밀번호</label>
					<input type="password" class="form-input" id="pw" name="pw" placeholder="현재 비밀번호 입력" oninput="validate()" required>
					<span class="msg-text"></span>
				</div>

				<div class="form-group">
					<label for="newPw" class="form-label">새 비밀번호</label>
					<input type="password" class="form-input" id="newPw" name="newPw" placeholder="4자 이상 입력" oninput="validate()" required>
					<span id="newPwMsg" class="msg-text"></span>
				</div>

				<div class="form-group">
					<label for="newPw2" class="form-label">새 비밀번호 확인</label>
					<input type="password" class="form-input" id="newPw2" name="newPw2" placeholder="비밀번호 다시 입력" oninput="validate()" required>
					<span id="newPw2Msg" class="msg-text"></span>
				</div>

				<div class="bottom-buttons">
					<button type="submit" class="btn-main">변경하기</button>
					<button type="button" class="btn-sub" onclick="history.back()">취소</button>
				</div>
				
			</form>

			<c:if test="${pwResult == 'fail'}">
				<div id="failMsg" class="fail-msg">
					현재 비밀번호가 일치하지 않습니다. 다시 확인해주세요.
				</div>
			</c:if>
			
		</div>
	</div>

</body>
</html>