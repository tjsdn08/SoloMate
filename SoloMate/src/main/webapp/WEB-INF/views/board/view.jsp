<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>꿀팁 아카이브 글보기</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
    .view-table th {
        width: 120px;
        background: #f8f9fa;
    }
    .view-table td {
        padding: 12px;
    }
    .content-box {
        min-height: 150px;
        white-space: pre-line;
    }
</style>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
	$(function(){
	    $("#deleteBtn").click(function(){
	        if(confirm("정말 삭제하시겠습니까?")){
	            $("#deleteForm").submit();
	        }
	    });
	
	    $("#bookmarkBtn").click(function(){
	        $("#bookmarkForm").submit();
	    });
	    
	    $(".bookmarkBtn").click(function(){
	        let login = "${login}";
	        // ❌ 로그인 안 한 경우
	        if(!login){
	            alert("로그인을 해주세요.");
	            // 로그인 페이지 이동
	            location = "/member/loginForm.do";
	            return;
	        }
	        // ✅ 로그인 한 경우 → 북마크 실행
	        $("#bookmarkForm").submit();
	    });
	});
</script>

</head>
<body class="container mt-5">

<h2 class="mb-4">🍯 꿀팁 아카이브 글보기</h2>

<div class="card p-4">

	    <!-- 버튼 영역 -->
    <div class="d-flex justify-content-end mt-4">

        <div>
            <c:if test="${login.id==vo.writer }">
                <a href="updateForm.do?no=${param.no }&inc=0&page=${param.page }&perPageNum=${param.perPageNum }&key=${param.key }&word=${param.word }"
                   class="btn btn-dark">
                   수정
                </a>

                <button id="deleteBtn" class="btn btn-outline-dark">
                    삭제
                </button>
            </c:if>

	        <a href="list.do?page=${param.page }&perPageNum=${param.perPageNum }&key=${param.key }&word=${param.word }"
	           class="btn btn-dark">
	           리스트
	        </a>
        </div>

    </div>

    <table class="table view-table align-middle">
        <tbody>
            <tr>
                <th>번호</th>
                <td class="no">${vo.no }</td>
            </tr>
            <tr>
                <th>제목</th>
                <td><strong>${vo.title }</strong></td>
            </tr>
            <tr>
                <th>내용</th>
                <td class="content-box">${vo.content }</td>
            </tr>
            <tr>
                <th>작성자</th>
                <td>${vo.writer }</td>
            </tr>
            <tr>
                <th>작성일</th>
                <td>${vo.writeDate }</td>
            </tr>
            <tr>
                <th>조회수</th>
                <td>${vo.hit }</td>
            </tr>
            <tr>
				<th>북마크</th>
				<td class="d-flex align-items-center gap-2">
				
				    <!-- 북마크 O -->
				    <c:if test="${vo.bookmarked == 1}">
				        <button type="button" class="btn btn-dark btn-sm bookmarkBtn">★</button>
				    </c:if>
				
				    <!-- 북마크 X -->
				    <c:if test="${vo.bookmarked == 0}">
				        <button type="button" class="btn btn-outline-dark btn-sm bookmarkBtn">☆</button>
				    </c:if>
				
				    <!-- 개수 -->
				    <span>${vo.bookmark}</span>
				
				</td>
            </tr>
        </tbody>
    </table>

</div>

<!-- 폼 -->
<form id="bookmarkForm" action="bookmark.do" method="post">
    <input type="hidden" name="boardNo" value="${vo.no}">
</form>

<form id="deleteForm" action="delete.do" method="post">
    <input type="hidden" name="no" value="${param.no }">
    <input type="hidden" name="page" value="${param.page }">
    <input type="hidden" name="perPageNum" value="${param.perPageNum }">
    <input type="hidden" name="key" value="${param.key }">
    <input type="hidden" name="word" value="${param.word }">
</form>

<!-- 댓글 -->
<div class="mt-5">
    <%@ include file="reply.jsp" %>
</div>

</body>
</html>