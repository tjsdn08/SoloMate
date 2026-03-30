<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>꿀팁 아카이브 글수정</title>

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
</style>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
$(function(){
    $(".cancelBtn").click(function(){
        history.back();
    });
});
</script>

</head>
<body class="container mt-5">

<h2 class="mb-4">🍯 꿀팁 아카이브 글수정</h2>

<div class="card p-4">

<form action="update.do" method="post">

    <!-- hidden -->
    <input type="hidden" name="page" value="${param.page }">
    <input type="hidden" name="perPageNum" value="${param.perPageNum }">
    <input type="hidden" name="key" value="${param.key }">
    <input type="hidden" name="word" value="${param.word }">

    <!-- 카테고리 -->
    <div class="mb-3">
        <label for="category" class="form-label">카테고리</label>
        <select class="form-select" name="category" id="category" required>
            <option value="자유게시판" ${vo.category == "자유게시판" ? "selected" : ""}>자유게시판</option>
            <option value="질문답변" ${vo.category == "질문답변" ? "selected" : ""}>질문답변</option>
            <option value="정보공유" ${vo.category == "정보공유" ? "selected" : ""}>정보공유</option>
            <option value="기타" ${vo.category == "기타" ? "selected" : ""}>기타</option>
        </select>
    </div>

    <!-- 번호 -->
    <div class="mb-3">
        <label for="no" class="form-label">번호</label>
        <input type="text" class="form-control" id="no"
               name="no" value="${vo.no }" readonly>
    </div>

    <!-- 제목 -->
    <div class="mb-3">
        <label for="title" class="form-label">제목</label>
        <input type="text" class="form-control" id="title"
               name="title" value="${vo.title }" required>
    </div>

    <!-- 내용 -->
    <div class="mb-3">
        <label for="content" class="form-label">내용</label>
        <textarea class="form-control" rows="6" id="content"
                  name="content" required>${vo.content }</textarea>
    </div>

    <!-- 버튼 -->
    <div class="d-flex justify-content-between mt-4">

        <div>
            <button type="submit" class="btn btn-dark">수정</button>
            <button type="reset" class="btn btn-outline-dark">새로입력</button>
        </div>

        <button type="button" class="cancelBtn btn btn-outline-dark">취소</button>

    </div>

</form>

</div>

</body>
</html>