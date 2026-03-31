<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>식품 수정하기</title>
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

	<h2>식품 수정하기</h2>

	<form action="update.do" method="post" id="updateForm">
		<input type="hidden" name="page" value="${param.page }">
		<input type="hidden" name="perPageNum" value="${param.perPageNum }">
		<input type="hidden" name="key" value="${param.key }">
		<input type="hidden" name="word" value="${param.word }">
		<input type="hidden" name="no" value="${param.no }">
		
		<div class="mb-3 mt-3">
			<label for="name" class="form-label">식품명</label>
			<input type="text" class="form-control" id="name" placeholder="식품명을 입력하세요" name="name"
			 value="${vo.name }" readonly>
		</div>
	
		<div class="mb-3 mt-3">
			<label for="expiryDate" class="form-label">유통기한</label>
			<input type="text" class="form-control" id="expiryDate" placeholder="yyyy-mm-dd" name="expiryDate"
			 value="${vo.expiryDate }" required>
		</div>
	
		<div class="mb-3 mt-3">
			<label for="quantity" class="form-label">수량</label>
			<input type="text" class="form-control" id="quantity" placeholder="수량을 입력하세요" name="quantity"
			 value="${vo.quantity }" required>			
		</div>
	
		<div class="mb-3 mt-3">
			<label for="storageType" class="form-label">보관방법</label>
			<select class="form-select" id="storageType" name="storageType">
				<option value="냉동" ${(vo.storageType == "냉동")? "selected" : "" }>냉동</option>
				<option value="냉장" ${(vo.storageType == "냉장")? "selected" : "" }>냉장</option>
				<option value="실온" ${(vo.storageType == "실온")? "selected" : "" }>실온</option>
			</select>
		</div>
	
		<div class="mb-3 mt-3">
			<label for="memo" class="form-label">메모</label>
		      <textarea class="form-control" rows="5" id="memo" name="memo"
		       placeholder="내용을 입력하세요.">${vo.memo }</textarea>
		</div>
		
		<div class="mb-3 mt-3">
		    <label class="form-label">소속폴더</label>
			<c:forEach items="${folderList}" var="folder">
			    <input type="checkbox" name="folderNos" value="${folder.no}"
			        <c:if test="${vo.folderNos.contains(folder.no)}">checked</c:if>
			    >
			    ${folder.name}
			</c:forEach>
		</div>
		
		<button type="submit" class="btn btn-primary">식품 수정</button>
		<button type="reset" class="btn btn-warning">새로입력</button>
		<button type="button" class="cancelBtn btn btn-secondary">취소</button>	
	</form>
</body>
</html>