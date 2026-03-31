<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">

<div class="card shadow-sm p-4 mx-auto" style="max-width: 500px;">
    <h2 class="mb-4 text-center">아이디 찾기</h2>
    
    <form action="searchId.do" method="post">
        <div class="mb-3">
            <label for="name" class="form-label">이름</label>
            <input type="text" class="form-control" name="name" 
                   value="${param.name}" placeholder="이름 입력" required>
        </div>
        <div class="mb-3">
            <label for="tel" class="form-label">연락처</label>
            <input type="tel" class="form-control" name="tel" 
                   value="${param.tel}" placeholder="연락처 입력" required>
        </div>
        <div class="d-grid gap-2">
            <button type="submit" class="btn btn-primary">아이디 찾기</button>
            <a href="loginForm.do" class="btn btn-outline-secondary">취소</a>
        </div>
    </form>

<c:if test="${!empty foundId}">
    <div class="mt-4 p-3 w-75  rounded-3 text-start shadow-none">
        
        <c:choose>
            <c:when test="${foundId != 'none'}">
                <h6 class="text-secondary fw-normal small mb-2">아이디 찾기 결과</h6>
                <div class="mb-3">
                    <span class="text-muted small">아이디: </span>
                    <span class="fs-5 text-primary-emphasis fw-bold">${foundId}</span>
                </div>
                <a href="loginForm.do" class="btn btn-primary btn-sm rounded-2 px-3">로그인 하러가기</a>
            </c:when>
            
            <c:otherwise>
                <div class="py-1">
                    <p class="text-danger-emphasis mb-0 small">일치하는 회원이 없습니다.</p>
                </div>
            </c:otherwise>
        </c:choose>
        
    </div>
</c:if>
</div>

</body>
</html>