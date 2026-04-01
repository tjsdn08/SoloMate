<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
    /* 아이디 찾기 양식과 통일감을 위한 스타일링 */
    .result-box {
        background-color: #f8f9fa;
        border-left: 4px solid #0d6efd;
    }
</style>
</head>
<body class="container mt-5">

<div class="card shadow-sm p-4 mx-auto" style="max-width: 500px;">
    <h2 class="mb-4 text-center">🔑 비밀번호 찾기</h2>
    
    <p class="text-muted text-center small mb-4">
        가입 시 입력한 정보를 입력하시면<br>
        비밀번호가 <b>등록된 연락처</b>로 재설정됩니다.
    </p>
    
    <form action="findPw.do" method="post">
        <div class="mb-3">
            <label for="name" class="form-label fw-bold">이름</label>
            <input type="text" class="form-control" name="name" id="name"
                   value="${param.name}" placeholder="이름 입력" required>
        </div>
        <div class="mb-3">
            <label for="id" class="form-label fw-bold">아이디</label>
            <input type="text" class="form-control" name="id" id="id"
                   value="${param.id}" placeholder="아이디 입력" required>
        </div>
        <div class="mb-3">
            <label for="tel" class="form-label fw-bold">연락처</label>
            <input type="tel" class="form-control" name="tel" id="tel"
                   value="${param.tel}" placeholder="010-0000-0000" required>
        </div>
        
        <div class="d-grid gap-2 mt-4">
            <button type="submit" class="btn btn-dark">비밀번호 재설정</button>
            <a href="loginForm.do" class="btn btn-outline-secondary">취소</a>
        </div>
    </form>

    <c:if test="${!empty msg}">
        <div class="mt-4 p-3 result-box rounded-3 shadow-none">
            <c:choose>
                <%-- 성공 시: 컨트롤러에서 maskedTel을 넘겨준다고 가정 --%>
                <c:when test="${not empty maskedTel}">
                    <h6 class="text-secondary fw-normal small mb-2">재설정 완료</h6>
                    <div class="mb-3">
                        <p class="mb-1 small text-muted">새 비밀번호:</p>
                        <span class="fs-5 text-primary fw-bold">${maskedTel}</span>
                        <p class="mt-2 mb-0 x-small text-muted" style="font-size: 0.8rem;">
                            * 가입하신 <b>연락처</b>가 임시 비밀번호로 설정되었습니다.
                        </p>
                    </div>
                    <a href="loginForm.do" class="btn btn-primary btn-sm w-100 rounded-2">로그인 하러가기</a>
                </c:when>
                
                <%-- 실패 시 --%>
                <c:otherwise>
                    <div class="py-1 text-center">
                        <p class="text-danger mb-0 small">❌ ${msg}</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </c:if>
</div>

</body>
</html>