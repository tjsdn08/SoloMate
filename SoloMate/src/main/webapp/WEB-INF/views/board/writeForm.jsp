<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>꿀팁 아카이브 글등록</title>

<script type="text/javascript">
	$(function(){
		$(".cancelBtn").click(function(){
			history.back();
		});
	});
</script>

</head>
<body>

	<h2>일반게시판 글등록</h2>
	<form action="write.do" method="post">
		<input type="hidden" name="perPageNum" value="${pageObject.perPageNum }">
		
		<div class="mb-3 mt-3">
			<label for="category" class="form-label">카테고리</label>
			<select class="form-select" name="category" id="category" required>
				<option value="">선택하세요</option>
				<option value="자유게시판">자유게시판</option>
				<option value="질문답변">질문답변</option>
				<option value="정보공유">정보공유</option>
				<option value="기타">기타</option>
			</select>
		</div>
		
		<div class="mb-3 mt-3">
			<label for="title" class="form-label">제목</label>
	    	<input type="text" class="form-control" id="title" placeholder="제목을 입력하세요." name="title" title="제목은 필수 입력 항목입니다" required>
		</div>
		
		<div class="mb-3 mt-3">
	    	<label for="content">내용</label>
	    	<textarea class="form-control" rows="5" id="content" name="content" placeholder="내용을 입력하세요." required></textarea>
	    </div>
	    
	    <button type="submit" class="btn btn-primary">등록</button>
	  	<button type="reset" class="btn btn-warning">새로입력</button>
	  	<button type="button" class="cancelBtn btn btn-secondary">취소</button>
	</form>

</body>
</html>