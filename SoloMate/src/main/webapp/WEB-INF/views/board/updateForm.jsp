<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>꿀팁 아카이브 글수정</title>

<script type="text/javascript">
	$(function(){
		$(".cancelBtn").click(function(){
			history.back();
		});
	});
</script>

</head>
<body>

	<h2>꿀팁 아카이브 글수정</h2>
	<form action="update.do" method="post">
		<input type="hidden" name="page" value="${param.page }">
		<input type="hidden" name="perPageNum" value="${param.perPageNum }">
		<input type="hidden" name="key" value="${param.key }">
		<input type="hidden" name="word" value="${param.word }">
		
		<div class="mb-3 mt-3">
			<label for="category" class="form-label">카테고리</label>
			<select class="form-select" name="category" id="category" required>
				<option value="자유게시판" ${vo.category == "자유게시판" ? "selected" : ""}>자유게시판</option>
				<option value="질문답변" ${vo.category == "질문답변" ? "selected" : ""}>질문답변</option>
				<option value="정보공유" ${vo.category == "정보공유" ? "selected" : ""}>정보공유</option>
				<option value="기타" ${vo.category == "기타" ? "selected" : ""}>기타</option>
			</select>
		</div>
		
		<div class="mb-3 mt-3">
	    	<label for="no" class="form-label">번호</label>
	    	<input type="text" class="form-control" id="no" 
	     	name="no" value="${vo.no }" readonly="readonly" >
	  	</div>
	  
	    <div class="mb-3 mt-3">
	    	<label for="title" class="form-label">제목</label>
	    	<input type="text" class="form-control" id="title" placeholder="제목을 입력하세요."
	     	name="title" value="${vo.title }" required>
	  	</div>
	  
	    <div class="mb-3 mt-3">
	      	<label for="content">내용</label>
	      	<textarea class="form-control" rows="5" id="content" name="content"
	       	placeholder="내용을 입력하세요." required>${vo.content }</textarea>
	    </div>
	    
		<button type="submit" class="btn btn-primary">수정</button>
	  	<button type="reset" class="btn btn-warning">새로입력</button>
	  	<button type="button" class="cancelBtn btn btn-secondary">취소</button>
		
	</form>

</body>
</html>