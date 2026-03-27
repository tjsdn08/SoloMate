<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>꿀팁 아카이브 글보기</title>

<style type="text/css">
	#deleteDiv {
		display:none;
	}
</style>

<script type="text/javascript">
	${(!empty msg)?"alert('"+=msg+="');":""}
	$(function(){
		$("#deleteBtn").click(function(){
			if(confirm("정말 삭제하시겠습니까?")){
				$("#deleteForm").submit();
			}
		});
	});
	$(function(){
		$("#bookmarkBtn").click(function(){
			$("#bookmarkForm").submit();
		});
	});
</script>

</head>
<body>

	<h2>꿀팁 아카이브 글보기</h2>
	<table>
		<tbody>
			<tr>
				<th>번호</th>
				<th class="no">${vo.no }</th>
			</tr>
			<tr>
				<th>제목</th>
				<th>${vo.title }</th>
			</tr>
			<tr>
				<th>내용</th>
				<th>${vo.content }</th>
			</tr>
			<tr>
				<th>작성자</th>
				<th>${vo.writer }</th>
			</tr>
			<tr>
				<th>작성일</th>
				<th>${vo.writeDate }</th>
			</tr>
			<tr>
				<th>조회수</th>
				<th>${vo.hit }</th>
			</tr>
			<tr>
				<th>북마크</th>
				<th>
					<c:if test="${!empty login }">
						<button type="button" id="bookmarkBtn" class="btn btn-primary">북마크</button>
					</c:if>
					${vo.bookmark }
				</th>
			</tr>
		</tbody>
	</table>
	<c:if test="${login==vo.writer }"> <!-- 로그인 처리?에 따라 변경 -->
		<a href="updateForm.do?no=${param.no }&inc=0&page=${param.page }&perPageNum=${param.perPageNum }&key=${param.key }&word=${param.word }" class="btn btn-success">수정</a>
		<a id="deleteBtn" class="btn btn-danger">삭제</a>
	</c:if>
	<a href="list.do?page=${param.page }&perPageNum=${param.perPageNum }&key=${param.key }&word=${param.word }" class="btn btn-warning">리스트</a>
	
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

<div class="mt-5">
	<%@ include file="reply.jsp" %>
</div>

</body>
</html>