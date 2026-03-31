<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레시피 아카이브 리스트</title>

<style type="text/css">
.dataRow:hover{
	cursor: pointer; /* 손가락 */
}
</style>

<script type="text/javascript">
 $(function(){
	 $(".dataRow").click(function(){ // jquery입니다. 클래스가 dataRow인 것을 찾아서 클릭을 하면 전달된 함수를 실행한다.
	 	let no = $(this).find(".no").text(); // js = jQuery
	 	location = "view.do?no=" + no + "&inc=1&${pageObject.pageQuery}";
	 }).mouseover(function(){
		 $(this).addClass("table-success");
	 }).mouseout(function(){
		 $(this).removeClass("table-success");
	 });
	 
 });
 
</script>

<c:if test="${!empty pageObject.key && !empty pageObject.word }">
	<script type="text/javascript">
		$(function(){
			$("#key").val("${pageObject.key}");
			$("#word").val("${pageObject.word}");
		});
	</script>
</c:if>

</head>
<body>
	<h2>레시피 아카이브 리스트</h2>
	<div>
		<form action="list.do" method="get">
			<input type="hidden" name="perPageNum" value="${pageObject.perPageNum }">
			
			<div class="d-inline-flex">
			  <!-- 넘어오는 검색 정보는 JavaScript로 처리하겠다. -> 데이터가 한개 일때만 가능하다. -->
			  <select class="form-select" name="key" id="key">
			  	<option value="t">제목</option>
			  	<option value="c">내용</option>
			  	<option value="w">재료</option>
			  	<option value="tcw">전체</option>
			  </select>
				<div class="input-group mb-3">
				  <input type="text" class="form-control" placeholder="Some text"
				   name="word" id="word">
				  <button class="btn btn-success" type="submit">검색</button>
				</div>
			</div>
		</form>
	</div>
	<!-- 검색란 처리 끝 ----------------------------------->
	
	<table class="table">
		<thead class="table-dark">
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>재료</th>
				<th>한 줄 설명</th>
				<th>조리 시간</th>
				<th>난이도</th>
				<th>북마크 수</th>
			</tr>
		</thead>
		<tbody>
		<c:if test="${empty list }">
			<tr>
				<td colspan="7">데이터가 존재하지 않습니다.</td>
			</tr>
		</c:if>
		<c:if test="${!empty list }">
			<c:forEach items="${list }" var="vo" >
				<tr class="dataRow">
					<td class="no">${vo.recipes_no }</td>
					<td>${vo.recipes_title }</td>
					<td>${vo.food }</td>
					<td>${vo.description }</td>
					<td>${vo.time }</td>
					<td>${vo.level }</td>
					<td>${vo.title }</td>
				</tr>
			</c:forEach>
		</c:if>
		</tbody>
	</table>
	<div>
		<pageNav:pageNav listURI="list.do" pageObject="${pageObject }" />
	</div>
	<a href="writeForm.do?perPageNum=${param.perPageNum }" class="btn btn-primary">글등록</a>
	<a href="list.do" class="btn btn-success">새로고침</a>
</body>
</html>
