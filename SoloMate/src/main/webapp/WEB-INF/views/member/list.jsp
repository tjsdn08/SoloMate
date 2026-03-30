<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 리스트</title>

<script type="text/javascript">
$(function(){
    $(".dataRow").click(function(e){
        if($(e.target).closest(".noMove").length > 0) return;
        let id = $(this).find(".id").text();
        location = "view.do?id=" + id; 
    });
    
    $(".noMove").on("click", function(event){
        event.stopPropagation(); 
    });

    $(".changeStatusBtn").on("click", function(){
        let $row = $(this).closest(".dataRow");
        let id = $row.find(".id").text();
        let status = $row.find(".status").val();
        location = "changeStatus.do?id=" + id + "&status=" + encodeURIComponent(status);
    });

    $(".changeGradeNoBtn").on("click", function(){
        let $row = $(this).closest(".dataRow");
        let id = $row.find(".id").text();
        let gradeNo = $row.find(".grade").val(); // .grade 클래스에서 값을 가져옴
        location = "changeGrade.do?id=" + id + "&gradeNo=" + gradeNo;
    });
});
</script>
</head>
<body>
	<h2>회원 리스트</h2>
	<table class="table table-hover">
		<thead class="table-success">
			<tr>
				<th>아이디</th>
				<th>이름</th>
				<th>전화번호</th>
				<th>주소</th>
				<th>상태</th>
				<th>등급명</th>
			</tr>
		</thead>
		<tbody>
		<c:if test="${empty list }">
			<tr>
				<td colspan="6">데이터가 존재하지 않습니다.</td>
			</tr>
		</c:if>
		<c:if test="${!empty list }">
			<c:forEach items="${list }" var="vo" >
				<tr class="dataRow">
					<td class="id">${vo.id }</td>
					<td>${vo.name }</td>
					<td>${vo.tel }</td>
					<td>${vo.address }</td>
					<td>
						<div class="d-inline-flex">
							<select class="form-select noMove status">
							    <option value="정상" ${(vo.status == "정상")?"selected":"" }>정상</option>
							    <option value="탈퇴" ${(vo.status == "탈퇴")?"selected":"" }>탈퇴</option>
							    <option value="강퇴" ${(vo.status == "강퇴")?"selected":"" }>강퇴</option>
							    <option value="휴면" ${(vo.status == "휴면")?"selected":"" }>휴면</option>
							</select>
							<button class="btn btn-warning noMove changeStatusBtn"
							 style="width: 100px;">수정</button>
						</div>
					</td>
					<td>
					    <div class="d-inline-flex">
					        <select class="form-select noMove grade">
					          <option value="1" ${(vo.gradeNo == 1)?"selected":"" }>일반회원</option>
					          <option value="9" ${(vo.gradeNo == 9)?"selected":"" }>관리자</option>
					        </select>
					        <button class="btn btn-warning noMove changeGradeNoBtn" style="width: 100px;">수정</button>
					    </div>
					</td>
				</tr>
			</c:forEach>
		</c:if>
		</tbody>
	</table>
	<a href="list.do" class="btn btn-success">새로고침</a>
</body>
</html>
