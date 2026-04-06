<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>꿀팁 아카이브 글등록</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
    .form-label {
        font-weight: 600;
    }
    .form-control, .form-select {
        height: 45px;
    }
    textarea.form-control {
        height: auto;
    }
    .custom-card {
        background: white;
        border-radius: 15px; /* 모서리 둥글게 */
        border: none;
        padding: 30px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05); /* 은은한 그림자 */
        margin-top: 30px;
        margin-bottom: 50px;
    }
</style>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
$(function(){
    $(".cancelBtn").click(function(){
        history.back();
    });
});
</script>

<c:if test="${!empty login}">
    <input type="hidden" name="writer" value="${login.id}">
</c:if>

</head>
<body class="container mt-5">
<div class="custom-card">
<h2 class="mb-4">🍯 꿀팁 아카이브 글등록</h2>

<div class="card p-4">

<form action="write.do" method="post">

    <!-- hidden -->
    <input type="hidden" name="perPageNum" value="${pageObject.perPageNum }">

    <!-- 카테고리 -->
    <div class="mb-3">
        <label for="category" class="form-label">카테고리</label>
        <select class="form-select" name="category" id="category" required>
            <option value="">선택하세요</option>
            <option value="자유게시판">자유게시판</option>
            <option value="질문답변">질문답변</option>
            <option value="정보공유">정보공유</option>
            <option value="기타">기타</option>
        </select>
    </div>

    <!-- 제목 -->
    <div class="mb-3">
        <label for="title" class="form-label">제목</label>
        <input type="text" class="form-control" id="title"
               name="title" placeholder="제목을 입력하세요." required>
    </div>

    <!-- 내용 -->
    <div class="mb-3">
        <label for="content" class="form-label">내용</label>
        <textarea class="form-control" rows="6" id="content"
                  name="content" placeholder="내용을 입력하세요." required></textarea>
    </div>

    <!-- 버튼 -->
    <div class="d-flex justify-content-between mt-4">

        <div>
            <button type="submit" class="btn btn-dark">등록</button>
            <button type="reset" class="btn btn-outline-dark">새로입력</button>
        </div>

        <button type="button" class="cancelBtn btn btn-outline-dark">취소</button>

    </div>

</form>

</div>
</div>
</body>
</html>