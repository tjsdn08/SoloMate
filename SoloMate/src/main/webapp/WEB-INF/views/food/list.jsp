<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>식품 목록 보기</title>
<style type="text/css">
/* :hover - 마우스가 오라 갔을 때 CSS. 공백없이 :hover 작성  */
.dataRow:hover{
	/* background: #888; /* 배경색 변경 - BootStrap 5에서 적용이 안됨 */
	cursor: pointer; /* 손가락 */
}
</style>

<script type="text/javascript">
 // jQuery :: 아래 HTML이 로딩이 끝나면 실행 줘 - $() 사이에 실행할 function을 넘긴다. body가 다 로딩이 되면 function이 실행됨.
 $(function(){
	 // alert("jQuery 영역이 실행됐다.~~~"); // 자바 스크립트의 팝업 열기
	 $(".dataRow").click(function(){ // jquery입니다. 클래스가 dataRow인 것을 찾아서 클릭을 하면 전달된 함수를 실행한다.
	 	
		 let no = $(this).data("no"); // js = jQuery

		 location = "view.do?no=" + no + "&${pageObject.pageQuery}";
	 }).mouseover(function(){
		 $(this).addClass("table-success");
	 }).mouseout(function(){
		 $(this).removeClass("table-success");
	 });
	 
	 
 });
 
</script>

</head>
<body>

<h2>식품 목록 보기</h2>

	<table class="table">
		<thead class="table-dark">
			<tr>
				<th>식품</th>
				<th>D-DAY</th>
				<th>수량</th>
				<th>보관방법</th>
			</tr>
		</thead>
		<tbody>
		<c:if test="${empty list }">
			<tr>
				<td colspan="4">데이터가 존재하지 않습니다.</td>
			</tr>
		</c:if>
		<c:if test="${!empty list }">
			<c:forEach items="${list }" var="vo" >
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
	<div>
		<pageNav:pageNav listURI="list.do" pageObject="${pageObject }"></pageNav:pageNav>
	</div>

</body>
</html>