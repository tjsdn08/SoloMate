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
    .custom-card {
        background: white;
        border-radius: 15px; /* 모서리 둥글게 */
        border: none;
        padding: 30px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05); /* 은은한 그림자 */
        margin-top: 30px;
        margin-bottom: 50px;
    }
    .top-title {
		font-size: 28px;
		font-weight: 800;
		color: #111;
		margin-bottom: 35px;
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

    $(function(){
        // 북마크 버튼 클릭 이벤트
        $(".bookmarkBtn").click(function(){
            let loginId = "${login.id}";

            if(!loginId || loginId === "null"){
                alert("로그인을 해주세요.");
                location = "/member/loginForm.do";
                return;
            }

            // 현재 버튼의 상태에 따라 다른 폼을 서브밋
            if($(this).hasClass("is-booked")) {
                // 이미 북마크 된 상태면 삭제 폼 실행
                $("#bookmarkDeleteForm").submit();
            } else {
                // 북마크 안 된 상태면 등록 폼 실행
                $("#bookmarkWriteForm").submit();
            }
        });
    });
});
</script>

</head>
<body class="container mt-5">
<div class="custom-card">
<div class="top-title">꿀팁 아카이브 글보기</div>

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
				
				    <c:if test="${vo.bookmarked == 1}">
					    <button type="button" class="btn btn-dark btn-sm bookmarkBtn is-booked">★</button>
					</c:if>
					<c:if test="${vo.bookmarked == 0}">
					    <button type="button" class="btn btn-outline-dark btn-sm bookmarkBtn">☆</button>
					</c:if>
				
				    <!-- 개수 -->
				    <span>${vo.bookmark}</span>
				
				</td>
            </tr>
        </tbody>
    </table>
    <c:if test="${from == 'bookmark'}">
	    <a href="${pageContext.request.contextPath}/boardbookmark/list.do?page=${param.page}&perPageNum=${param.perPageNum}"
	       class="btn btn-outline-dark">
	       ← 북마크로 돌아가기
	    </a>
	</c:if>

</div>

<!-- 폼 -->
<form id="bookmarkForm" action="/boardbookmark/write.do" method="post">
    <input type="hidden" name="boardNo" value="${vo.no}">
</form>

<form id="deleteForm" action="delete.do" method="post">
    <input type="hidden" name="no" value="${param.no }">
    <input type="hidden" name="page" value="${param.page }">
    <input type="hidden" name="perPageNum" value="${param.perPageNum }">
    <input type="hidden" name="key" value="${param.key }">
    <input type="hidden" name="word" value="${param.word }">
</form>

<form id="bookmarkWriteForm" action="/boardbookmark/write.do" method="post">
    <input type="hidden" name="no" value="${vo.no}">
    <input type="hidden" name="from" value="${from}">
	<input type="hidden" name="action" value="view">
    
    <input type="hidden" name="page" value="${param.page}">
    <input type="hidden" name="perPageNum" value="${param.perPageNum}">
</form>

<form id="bookmarkDeleteForm" action="/boardbookmark/delete.do" method="post">
    <input type="hidden" name="no" value="${vo.no}">
    <input type="hidden" name="from" value="${from}">
	<input type="hidden" name="action" value="view">
    
    <input type="hidden" name="page" value="${param.page}">
    <input type="hidden" name="perPageNum" value="${param.perPageNum}">
</form>

<!-- 댓글 -->
<div class="mt-5">
    <%@ include file="reply.jsp" %>
</div>

</div>
</body>
</html>