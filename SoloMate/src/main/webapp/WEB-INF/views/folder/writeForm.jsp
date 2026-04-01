<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>폴더 등록하기</title>
	<script type="text/javascript">
	  $(function(){
		  $(".cancelBtn").click(function(){
			 // alert("취소 버튼 클릭~~~!");
			 history.back();
		  });
	  }); 
	</script>
</head>
<body>

	<h2>폴더 등록하기</h2>

	<form action="write.do" method="post" id="writeForm">
		<input type="hidden" name="perPageNum" value="${param.perPageNum }">
		
		<div class="mb-3 mt-3">
			<label for="name" class="form-label">폴더명</label>
			<input type="text" class="form-control" id="name" placeholder="폴더명을 입력하세요" name="name"
			 title="폴더명은 필수 입력 항목 입니다." required>
		</div>
		
	
		<button type="submit" class="btn btn-primary">폴더 등록</button>
		<button type="reset" class="btn btn-warning">새로입력</button>
		<button type="button" class="cancelBtn btn btn-secondary">취소</button>	
	</form>
		<div>
			<p>폴더를 생성한 후, 식품 수정 화면에서 해당 폴더를 선택하여 식품을 분류할 수 있습니다.</p>
		</div>
</body>
</html>