<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>폴더 상세 보기</title>
<style type="text/css">
	.custom-card {
	        background: white;
	        border-radius: 15px;
	        border: none;
	        padding: 30px;
	        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
	        margin-top: 30px;
    }
	.dataRow:hover{
		/* background: #888; /* 배경색 변경 - BootStrap 5에서 적용이 안됨 -> table class=table-hover 추가 회색*/ 
		cursor: pointer; /* 손가락 */
	}
</style>

<script type="text/javascript">
 // jQuery :: 아래 HTML이 로딩이 끝나면 실행 줘 - $() 사이에 실행할 function을 넘긴다. body가 다 로딩이 되면 function이 실행됨.
 $(function(){
	 // alert("jQuery 영역이 실행됐다.~~~"); // 자바 스크립트의 팝업 열기
	 $(".dataRow").click(function(){ // jquery입니다. 클래스가 dataRow인 것을 찾아서 클릭을 하면 전달된 함수를 실행한다.
	 	
		 let no = $(this).data("no"); // js = jQuery

		 location = "/food/view.do?no=" + no;
	 });
	 
	 
 });
 
</script>

</head>
<body>
	<div class="custom-card">
	<h2>폴더 상세 보기</h2>
	<hr>
	<div class="d-flex justify-content-between mb-3">
		<h3>${vo.name }</h3>
		<h4>${vo.createdAt }</h4>
	</div>
		<table class="table table-hover align-middle text-center table-bordered">
			<thead class="table-light">
				<tr>
					<th>식품</th>
					<th>D-DAY</th>
					<th>수량</th>
					<th>보관방법</th>
				</tr>
			</thead>
			<tbody>
			<c:if test="${empty vo.foods }">
				<tr>
					<td colspan="4">데이터가 존재하지 않습니다.</td>
				</tr>
			</c:if>
			<c:if test="${!empty vo.foods }">
				<c:forEach items="${vo.foods }" var="vo" >
					<tr class="dataRow" data-no="${vo.no }">
						<td>${vo.name }</td>
						<td>${vo.dDay }</td>
						<td>${vo.quantity }</td>
						<td>${vo.storageType }</td>
					</tr>
				</c:forEach>
			</c:if>
			</tbody>
		</table>
		
		<div class="d-flex flex-row-reverse gap-2">
			<a href="updateForm.do?no=${param.no }&page=${param.page }&perPageNum=${param.perPageNum }&key=${param.key }&word=${param.word }" class="btn btn-success">
			폴더 수정 하기</a>
			<a href="delete.do?no=${param.no }&page=${param.page }&perPageNum=${param.perPageNum }&key=${param.key }&word=${param.word }" class="btn btn-warning">폴더 삭제 하기</a>
			<a href="list.do" class="btn btn-primary">폴더 목록 보기</a>
		</div>
	</div>
</body>
</html>