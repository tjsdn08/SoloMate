<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>폴더 수정</title>
	<script type="text/javascript">
	food = {
		delete : function(folderNo, foodNo) {
			console.log("식품 삭제 처리");
			console.log(folderNo + ", " + foodNo)
			$.ajax({
			    url: "/folder/deleteFood.do",
			    type: "get",
			    data: {
			        folderNo: folderNo,
			        foodNo: foodNo
			    },
			    success: function(result) {
			        console.log("서버 응답:", result);
			        let resultValue = $(result).find(".container").text().trim();
			        console.log("추출:", resultValue);


			        if (resultValue.trim() == "1") {
			            $("#row-" + foodNo).remove();
			        } else {
			            alert("삭제 실패");
			        }
			    },
			    error: function() {
			        alert("에러 발생");
			    }
			});
		}
	}
	</script>

	<script type="text/javascript">
	  $(function(){
		  $(".cancelBtn").click(function(){
			 // alert("취소 버튼 클릭~~~!");
			  location.href = "view.do?no=${param.no}&page=${param.page}&perPageNum=${param.perPageNum}&key=${param.key}&word=${param.word}";
		  });
		<!-- foodDelete  -->
	    // 🔥 핵심 수정
	    $(document).on("click", ".foodDeleteBtn", function(){

	        let foodNo = $(this).closest(".dataRow").data("no");
	        let foodName = $(this).closest(".dataRow").find(".foodName").text();

	        if(!confirm(foodName + " 삭제 하시겠습니까?")) return;

	        food.delete(${param.no}, foodNo);
	    });
		<!-- foodDelete  -->
	  }); 
	</script>
</head>
<body>

	<h2>폴더 수정 하기</h2>

	<form action="update.do" method="post" id="updateForm">
		<input type="hidden" name="page" value="${param.page }">
		<input type="hidden" name="perPageNum" value="${param.perPageNum }">
		<input type="hidden" name="key" value="${param.key }">
		<input type="hidden" name="word" value="${param.word }">
		<input type="hidden" name="no" value="${param.no }">
		
		<div class="mb-3 mt-3">
			<label for="name" class="form-label">폴더명</label>
			<input type="text" class="form-control" id="name" name="name"
			 value="${vo.name }" required>
		</div>
		
		<div class="mb-3 mt-3">
			<label for="createdAt" class="form-label">생성일시</label>
			<input type="text" class="form-control" id="createdAt" name="createdAt"
			 value="${vo.createdAt }" readonly>
		</div>
		
			<!-- 테이블 ajax 처리 -->
		<div class="mb-3 mt-3">
			<label class="form-label">폴더 내 식품 목록</label>
				<table class="table">
					<thead class="table-dark">
						<tr>
							<th>식품</th>
							<th>D-DAY</th>
							<th>수량</th>
							<th>보관방법</th>
							<th>삭제</th>
						</tr>
					</thead>
					<tbody>
					<c:if test="${empty vo.foods }">
						<tr>
							<td colspan="4">데이터가 존재하지 않습니다.</td>
						</tr>
					</c:if>
					<c:if test="${!empty vo.foods }">
						<c:forEach items="${vo.foods }" var="foodVO" >
							<tr id="row-${foodVO.no }" class="dataRow" data-no="${foodVO.no }">
								<td class="foodName">${foodVO.name }</td>
								<td>${foodVO.dDay }</td>
								<td>${foodVO.quantity }</td>
								<td>${foodVO.storageType }</td>
								<td>
									<button class="foodDeleteBtn" type="button">
										삭제
									</button>
								</td>
							</tr>
						</c:forEach>
					</c:if>
					</tbody>
				</table>
			
		</div>
			<!-- 테이블 ajax 처리 -->
	
		<button type="submit" class="btn btn-primary">폴더 수정</button>
		<button type="reset" class="btn btn-warning">새로입력</button>
		<button type="button" class="cancelBtn btn btn-secondary">취소</button>	
	</form>
	
</body>
</html>