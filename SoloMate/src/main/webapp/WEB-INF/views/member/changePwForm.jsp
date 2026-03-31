<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
    /* 실시간 메시지 스타일: 작고 옅게 */
    .msg-text { font-size: 0.75rem; margin-top: 4px; display: block; min-height: 18px; }
    .text-pass { color: #0d6efd; } /* 파란색: 통과 */
    .text-warn { color: #dc3545; } /* 빨간색: 경고 */
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
</script>
</head>
<body class="container mt-5">

<div class="card border-0 shadow-none p-4 mx-auto" style="max-width: 500px;">
    <h2 class="mb-4 text-start fw-bold">비밀번호 변경</h2>
    
    <form action="changePw.do" method="post" class="text-start" onsubmit="return checkForm()">
        
        <div class="mb-3">
            <label for="pw" class="form-label small text-secondary">현재 비밀번호</label>
            <input type="password" class="form-control border-secondary-subtle" 
                   id="pw" name="pw" placeholder="현재 비밀번호 입력" oninput="validate()" required>
            <span class="msg-text"></span> </div>

        <div class="mb-3">
            <label for="newPw" class="form-label small text-secondary">새 비밀번호</label>
            <input type="password" class="form-control border-secondary-subtle" 
                   id="newPw" name="newPw" placeholder="4자 이상 입력" oninput="validate()" required>
            <span id="newPwMsg" class="msg-text"></span>
        </div>

        <div class="mb-4">
            <label for="newPw2" class="form-label small text-secondary">새 비밀번호 확인</label>
            <input type="password" class="form-control border-secondary-subtle" 
                   id="newPw2" name="newPw2" placeholder="비밀번호 다시 입력" oninput="validate()" required>
            <span id="newPw2Msg" class="msg-text"></span>
        </div>

        <div class="d-flex gap-2 justify-content-start">
            <button type="submit" class="btn btn-primary btn-sm px-4 rounded-2">변경하기</button>
            <button type="button" class="btn btn-outline-secondary btn-sm px-4 rounded-2" onclick="history.back()">취소</button>
        </div>
    </form>

	<c:if test="${pwResult == 'fail'}">
	    <div id="failMsg" class="mt-4 p-3 w-100 border border-danger-subtle bg-danger-subtle bg-opacity-10 rounded-3 text-start shadow-none">
	        <p class="text-danger-emphasis mb-0 small">
	            현재 비밀번호가 일치하지 않습니다. 다시 확인해주세요.
	        </p>
	    </div>
	</c:if>
</div>

</body>
</html>