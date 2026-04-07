<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 북마크</title>

<style type="text/css">
	.dataRow:hover {
		cursor:pointer;
		background-color: #f2f2f2 !important;
	}
	/* 기본 */
	.pagination .page-link {
	    color: black;
	    border: 1px solid #ddd;
	    border-radius: 8px;
	    margin: 0 3px;
	}
	
	/* hover */
	.pagination .page-link:hover {
	    background-color: black;
	    color: white;
	}
	
	/* 현재 페이지 */
	.pagination .active .page-link {
	    background-color: black;
	    border-color: black;
	    color: white;
	}
	.custom-card {
        background: white; border-radius: 15px; border: none; padding: 30px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05); margin-top: 30px;
    }
    .top-title { font-size: 28px; font-weight: 800; color: #111; margin-bottom: 35px; }
    
</style>

<script type="text/javascript">
	$(function(){
		$(".dataRow").click(function(){
			let no = $(this).data("no");

			location = "${pageContext.request.contextPath}/board/view.do"
				+ "?no=" + no
				+ "&inc=1"
				+ "&page=${pageObject.page}"
				+ "&perPageNum=${pageObject.perPageNum}"
				+ "&key=${empty pageObject.key ? '' : pageObject.key}"
				+ "&word=${empty pageObject.word ? '' : pageObject.word}"
				+ "&from=bookmark";
		});
	});
</script>


</head>
<body>
<div class="custom-card">
	<div class="top-title">${login.name}님의 북마크</div>
	
	<div class="d-flex justify-content-end gap-2 mb-3">
	    <a href="${pageContext.request.contextPath}/board/list.do?page=${param.page }&perPageNum=${param.perPageNum }&key=${param.key }&word=${param.word }"
	       class="btn btn-dark">
	       리스트
	    </a>
	</div>
	
	<table class="table table-hover align-middle">
		<thead class="table-light">
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>등록일</th>
				<th>삭제</th>
			</tr>
		</thead>
	
		<tbody>
			<c:if test="${empty list}">
				<tr>
					<td colspan="5">북마크가 없습니다.</td>
				</tr>
			</c:if>
	
			<c:forEach items="${list}" var="vo" varStatus="status">
				<tr class="dataRow" data-no="${vo.boardNo}">
	
					<td>${pageObject.totalRow - ((pageObject.page - 1) * pageObject.perPageNum + status.index)}</td>
	
					<td>${vo.title}</td>
	
					<td>${vo.writer}</td>
	
					<td>${vo.regDate}</td>
	
					<td>
						<a href="${pageContext.request.contextPath}/boardbookmark/delete.do?no=${vo.boardNo}&from=bookmark&page=${pageObject.page}&perPageNum=${pageObject.perPageNum}"
						   class="btn btn-outline-dark btn-sm"
						   onclick="event.stopPropagation(); return confirm('북마크 리스트에서 삭제하시겠습니까?');">
						    삭제
						</a>
					</td>
	
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<div>
		<pageNav:pageNav listURI="list.do" pageObject="${pageObject }"/>
	</div>
</div>
</body>
</html>