<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
    .msg-text { font-size: 0.75rem; margin-top: 4px; display: block; min-height: 18px; }
</style>
<script type="text/javascript">
    function validate() {
        let failMsg = document.getElementById("failMsg");
        if (failMsg) failMsg.style.display = "none";
    }
</script>
</head>
<body class="container mt-5">

<div class="card border-0 shadow-none p-4 mx-auto" style="max-width: 500px;">
    <h2 class="mb-3 text-start fw-bold text-danger">회원 탈퇴</h2>
    
    <div class="mb-4 p-3 border border-danger-subtle bg-danger-subtle bg-opacity-10 rounded-3 text-start shadow-none">
        <p class="text-danger-emphasis mb-1 small fw-bold">주의사항</p>
        <p class="text-muted mb-0 small">탈퇴 시 회원 정보 및 이용 기록이 모두 삭제되며, 복구가 불가능합니다.</p>
    </div>

    <form action="delete.do" method="post" class="text-start">
        <div class="mb-4">
            <label for="pw" class="form-label small text-secondary">비밀번호 확인</label>
            <input type="password" class="form-control border-secondary-subtle" 
                   id="pw" name="pw" placeholder="현재 비밀번호를 입력하세요" oninput="validate()" required>
            <span class="msg-text text-muted small">본인 확인을 위해 비밀번호가 필요합니다.</span>
        </div>

        <div class="d-flex gap-2 justify-content-start">
            <button type="submit" class="btn btn-danger btn-sm px-4 rounded-2" 
                    onclick="return confirm('정말로 탈퇴하시겠습니까?')">탈퇴하기</button>
            <button type="button" class="btn btn-outline-secondary btn-sm px-4 rounded-2" 
                    onclick="history.back()">취소</button>
        </div>
    </form>

    <c:if test="${deleteStatus == 'fail'}">
        <div id="failMsg" class="mt-4 p-3 w-100 border border-danger-subtle bg-danger-subtle bg-opacity-10 rounded-3 text-start shadow-none">
            <p class="text-danger-emphasis mb-0 small">
                비밀번호가 일치하지 않습니다. 다시 확인해주세요.
            </p>
        </div>
    </c:if>
</div>

</body>
</html>