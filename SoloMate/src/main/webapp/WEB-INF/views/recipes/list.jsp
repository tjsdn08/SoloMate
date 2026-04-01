<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레시피 아카이브 리스트</title>

<style type="text/css">
	.dataRow:hover {
		cursor:pointer;
	}
	.pagination {
	    justify-content: center;
	}
	
	/* 페이징 버튼 스타일 */
	.pagination .page-link {
	    color: black;
	    border: 1px solid #ddd;
	    border-radius: 8px;
	    margin: 0 3px;
	}
	
	.pagination .page-link:hover {
	    background-color: black;
	    color: white;
	}
	
	.pagination .active .page-link {
	    background-color: black;
	    border-color: black;
	    color: white;
	}
</style>

<script type="text/javascript">
	$(function(){
		// 행 클릭 시 상세보기 이동
		$(".dataRow").click(function(){
			let no = $(this).find(".no").text();
			location = "view.do?no=" + no + "&inc=1&${pageObject.pageQuery}";
		}).mouseover(function(){
			$(this).addClass("table-success");
		}).mouseout(function(){
			$(this).removeClass("table-success");
		});
		
		// 검색 조건 및 키워드 유지
		<c:if test="${!empty pageObject.key}">
			$("#key").val("${pageObject.key}");
		</c:if>
		<c:if test="${!empty pageObject.word}">
			$("#word").val("${pageObject.word}");
		</c:if>
	});
</script>

</head>
<body>

	<div class="container">
		<h2 class="mt-4 mb-4">레시피 아카이브</h2>
		
		<div class="mb-4">
		    <form action="list.do" method="get">
		        <input type="hidden" name="perPageNum" value="${pageObject.perPageNum}">
		        <div class="d-flex align-items-center gap-2">
		
		            <div class="input-group" style="max-width:500px;">
		                <span class="input-group-text bg-white border-end-0">🔍</span>
		                <input type="text" class="form-control border-start-0"
		                       name="word" id="word" placeholder="글 검색" style="height:45px;">
		            </div>
		
		            <select class="form-select" name="key" id="key" style="width:120px; height:45px;">
		                <option value="tcwf">전체</option>
		                <option value="t">제목</option>
		                <option value="f">재료</option>
		            </select>
		
		            <button class="btn btn-dark" style="width:100px; height:45px;">검색</button>
		        </div>
		    </form>
		</div>
	
		<table class="table table-hover align-middle">
			<thead class="table-dark">
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>핵심 재료</th>
					<th>한줄 설명</th>
					<th>조리시간</th>
					<th>난이도</th>
					<th>북마크</th>
				</tr>
			</thead>
			
			<tbody>
				<c:if test="${empty list}">
					<tr>
						<td colspan="7" class="text-center">데이터가 존재하지 않습니다.</td>
					</tr>
				</c:if>
				<c:if test="${!empty list}">
					<c:forEach items="${list}" var="vo">
						<tr class="dataRow">
							<td class="no">${vo.recipes_no}</td>
							<td>${vo.recipes_title}</td>
							<td>${vo.food}</td>
							<td>${vo.description}</td>
							<td>${vo.recipes_time}분</td>
							<td>${vo.recipes_level}</td>
							<td><span class="badge bg-danger">${vo.bookmark}</span></td>
						</tr>
					</c:forEach>
				</c:if>
			</tbody>
		</table>
		
		<div class="mt-4">
			<pageNav:pageNav listURI="list.do" pageObject="${pageObject}"/>
		</div>
		
		<div class="d-flex justify-content-end gap-2 mt-3 mb-5">
		    <a href="writeForm.do?perPageNum=${pageObject.perPageNum}" class="btn btn-dark">글등록</a>
		    <a href="list.do" class="btn btn-outline-dark">새로고침</a>
		    <c:if test="${not empty login}">
			    <a href="${pageContext.request.contextPath}/recipesbookmark/list.do" class="btn btn-dark">북마크 리스트</a>
			</c:if>
		</div>
	</div>

</body>
</html>