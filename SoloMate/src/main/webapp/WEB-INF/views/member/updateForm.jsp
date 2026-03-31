<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
    .msg-text { font-size: 0.75rem; margin-top: 4px; display: block; min-height: 18px; }
    .text-warn { color: #dc3545; }
</style>
<script type="text/javascript">
    function validate() {
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
<body class="container mt-5">

<div class="card border-0 shadow-none p-4 mx-auto" style="max-width: 500px;">
    <h2 class="mb-4 text-start fw-bold">정보 수정</h2>
    
    <form action="update.do" method="post" class="text-start" onsubmit="return checkForm()">
        <div class="mb-3">
            <label class="form-label small text-secondary">아이디</label>
            <input type="text" class="form-control bg-light border-0" name="id" value="${vo.id}" readonly>
        </div>

        <div class="mb-3">
            <label for="pw" class="form-label small text-secondary">비밀번호 확인</label>
            <input type="password" class="form-control border-secondary-subtle" 
                   id="pw" name="pw" placeholder="현재 비밀번호 입력" oninput="validate()" required>
            <span class="msg-text text-warn small">수정하려면 비밀번호를 입력해야 합니다.</span>
        </div>

        <hr class="my-4 opacity-10">

        <div class="mb-3">
            <label for="name" class="form-label small text-secondary">이름</label>
            <input type="text" class="form-control border-secondary-subtle" 
                   id="name" name="name" value="${vo.name}" required>
        </div>

        <div class="mb-3">
            <label for="tel" class="form-label small text-secondary">전화번호</label>
            <input type="tel" class="form-control border-secondary-subtle" 
                   id="tel" name="tel" value="${vo.tel}" required>
        </div>

        <div class="mb-4">
            <label for="address" class="form-label small text-secondary">주소</label>
            <input type="text" class="form-control border-secondary-subtle" 
                   id="address" name="address" value="${vo.address}">
        </div>

        <div class="d-flex gap-2 justify-content-start">
            <button type="submit" class="btn btn-primary btn-sm px-4 rounded-2">정보 수정</button>
            <button type="button" class="btn btn-outline-secondary btn-sm px-4 rounded-2" onclick="history.back()">취소</button>
        </div>
    </form>

    <c:if test="${updateStatus == 'fail'}">
        <div id="failMsg" class="mt-4 p-3 w-100 border border-danger-subtle bg-danger-subtle bg-opacity-10 rounded-3 text-start shadow-none">
            <p class="text-danger-emphasis mb-0 small">
                비밀번호가 일치하지 않습니다. 다시 확인해주세요.
            </p>
        </div>
    </c:if>
</div>

</body>
</html>