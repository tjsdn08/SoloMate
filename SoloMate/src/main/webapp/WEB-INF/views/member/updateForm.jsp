<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>
</head>
  <script type="text/javascript">
  $(function(){
	  $(".cancelBtn").click(function(){
		 history.back();
	  });
  });
  </script>
<body>
<h2>회원 정보 수정</h2>
	<form action="update.do" method="post">
		<input type="hidden" name="page" value="${param.page }">
		<input type="hidden" name="perPageNum" value="${param.perPageNum }">
		<input type="hidden" name="key" value="${param.key }">
		<input type="hidden" name="word" value="${param.word }">
		
	  <div class="mb-3 mt-3">
	    <label for="id" class="form-label">아이디</label>
	    <input type="text" class="form-control" id="id" 
	     name="id" value="${vo.id }" readonly="readonly" >
	  </div>
	  
  	  <div class="mb-3 mt-3">
	    <label for="pw" class="form-label">본인 확인용 비밀번호</label>
	    <input type="password" class="form-control" id="pw" placeholder="본인 확인용 비밀번호를 입력하세요." name="pw">
	  </div>
	  
	
	  <div class="mb-3 mt-3">
	    <label for="name" class="form-label">이름</label>
	    <input type="text" class="form-control" id="name" placeholder="제목을 입력하세요."
	     name="name" value="${vo.name }">
	  </div>
	  
	  <div class="mb-3 mt-3">
	    <label for="tel" class="form-label">전화번호</label>
	    <input type="text" class="form-control" id="tel" placeholder="xxx-xxxx-xxxx"
	     name="tel" value="${vo.tel }">
	  </div>
	  
	  <div class="mb-3 mt-3">
	    <label for="address" class="form-label">주소</label>
	    <input type="text" class="form-control" id="tel" placeholder="주소를 입력하세요"
	     name="address" value="${vo.address }">
	  </div>
	  <button type="submit" class="btn btn-primary">수정</button>
	  <button type="reset" class="btn btn-warning">새로입력</button>
	  <button type="button" class="cancelBtn btn btn-secondary">취소</button>
	</form>
</body>
</html>