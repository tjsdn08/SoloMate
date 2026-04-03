<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>식품 추가하기</title>
	<script type="text/javascript">
	  $(function(){
		  $(".cancelBtn").click(function(){
			 // alert("취소 버튼 클릭~~~!");
			 history.back();
		  });
		  // datepicker 적용
		  $(".datepicker").datepicker(
			{
			   changeMonth: true,
			   changeYear: true,
			   dateFormat: "yy-mm-dd",
			   dayNamesMin: [ "일", "월", "화", "수", "목", "금", "토" ],
			   monthNamesShort: [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],
		  	}
		  );

	  }); 
	</script>
</head>
<body>

	<h2>식품 추가하기</h2>

	<form action="write.do" method="post" id="writeForm">
		<input type="hidden" name="perPageNum" value="${param.perPageNum }">
		
		<div class="mb-3 mt-3">
			<label for="name" class="form-label">식품명</label>
			<input type="text" class="form-control" id="name" placeholder="식품명을 입력하세요" name="name"
			 title="식품명은 필수 입력 항목 입니다." required>
		</div>
	
		<div class="mb-3 mt-3">
			<label for="expiryDate" class="form-label">유통기한</label>
			<input type="date" class="form-control" id="expiryDate" placeholder="yyyy-mm-dd" name="expiryDate"
			   pattern="^\d{4}-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])$" min="2020-01-01" max="9999-12-31" required>
		</div>
	
		<div class="mb-3 mt-3">
			<label for="quantity" class="form-label">수량</label>
			<input type="number" class="form-control" id="quantity" placeholder="수량을 입력하세요" name="quantity"
			 title="수량은 필수 입력 항목 입니다." max="99" min="1" required>			
		</div>
	
		<div class="mb-3 mt-3">
			<label for="storageType" class="form-label">보관방법</label>
			<select class="form-select" id="storageType" name="storageType">
				<option value="냉동" selected>냉동</option>
				<option value="냉장">냉장</option>
				<option value="실온">실온</option>
			</select>
		</div>
	
		<div class="mb-3 mt-3">
			<label for="memo" class="form-label">메모</label>
		      <textarea class="form-control" rows="5" id="memo" name="memo"
		       placeholder="내용을 입력하세요." maxlength="100"></textarea>
		</div>
		
		<div class="mb-3 mt-3">
		    <label class="form-label">소속폴더</label>
		
		    <c:forEach var="folder" items="${folderList}">
		        <div class="form-check">
		            <input class="form-check-input" 
		                   type="checkbox" 
		                   name="folderNos"
		                   value="${folder.no}" 
		                   id="folder_${folder.no}">
		            
		            <label class="form-check-label" for="folder_${folder.no}">
		                ${folder.name}
		            </label>
		        </div>
		    </c:forEach>
		</div>
		<button type="submit" class="btn btn-primary">식품 추가</button>
		<button type="reset" class="btn btn-warning">새로입력</button>
		<button type="button" class="cancelBtn btn btn-secondary">취소</button>	
	</form>
</body>
</html>