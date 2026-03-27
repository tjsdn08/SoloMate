<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>꿀팁 아카이브 리스트</title>

<style type="text/css">
	.dataRow:hover {
		cursor:pointer;
	}
</style>

<script type="text/javascript">
	$(function(){
		$(".dataRow").click(function(){
			let no=$(this).find(".no").text();
			location="view.do?no="+no+"&inc=1&${pageObject.pageQuery}";
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

	<h2>꿀팁 아카이브</h2>
	<div>
		<form action="list.do" method="get">
			<input type="hidden" name="perPageNum" value="${pageObject.perPageNum }">
			<div class="d-inline-flex">
				<select class="form-select" name="key" id="key">
					<option value="t">제목</option>
					<option value="c">내용</option>
					<option value="w">작성자</option>
					<option value="tc">제목/내용</option>
					<option value="tw">제목/작성자</option>
					<option value="cw">내용/작성자</option>
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

	<table class="table">
		<thead class="table-dark">
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
				<th>북마크</th>
			</tr>
		</thead>
		
		<tbody>
			<c:if test="${empty list }">
				<tr>
					<td colspan="6">데이터가 존재하지 않습니다</td>
				</tr>
			</c:if>
			<c:if test="${!empty list }">
				<c:forEach items="${list }" var="vo">
					<tr class="dataRow">
						<td class="no">${vo.no }</td>
						<td>${vo.title }</td>
						<td>${vo.writer }</td>
						<td>${vo.writeDate }</td>
						<td>${vo.hit }</td>
						<td>${vo.bookmark }</td>
					</tr>
				</c:forEach>
			</c:if>
		</tbody>
	</table>
	
	<div>
		<pageNav:pageNav listURI="list.do" pageObject="${pageObject }"/>
	</div>
	<a href="writeForm.do?perPageNum=${param.perPageNum }" class="btn btn-primary">글등록</a>
	<a href="list.do" class="btn btn-success">새로고침</a>

</body>
</html>