<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레시피 북마크 리스트</title>

<style type="text/css">
	.dataRow:hover {
		cursor:pointer;
	}
	.pagination {
	    justify-content: center;
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
</style>

<script type="text/javascript">
	$(function(){
		$(".dataRow").click(function(){
			let no = $(this).data("no");

			// 레시피 상세보기 경로로 변경
			location = "${pageContext.request.contextPath}/recipes/view.do"
				+ "?no=" + no
				+ "&inc=1"
				+ "&page=${pageObject.page}"
				+ "&perPageNum=${pageObject.perPageNum}"
				+ "&key=${empty pageObject.key ? '' : pageObject.key}"
				+ "&word=${empty pageObject.word ? '' : pageObject.word}"
				+ "&from=bookmark";
		}).mouseover(function(){
			$(this).addClass("table-success");
		}).mouseout(function(){
			$(this).removeClass("table-success");
		});
	});
</script>

</head>
<body>

<div class="container mt-5 mb-5">
    <h2>📖 ${login.name}님의 레시피 북마크 리스트</h2>

    <div class="d-flex justify-content-end gap-2 mb-3">
        <a href="${pageContext.request.contextPath}/recipes/list.do?page=${param.page}&perPageNum=${param.perPageNum}&key=${param.key}&word=${param.word}"
           class="btn btn-dark">
           레시피 목록
        </a>
    </div>

    <table class="table table-hover align-middle shadow-sm">
        <thead class="table-dark">
            <tr>
                <th style="width: 80px;">번호</th>
                <th>레시피 제목</th>
                <th style="width: 150px;">작성자</th>
                <th style="width: 150px;">등록일</th>
                <th style="width: 100px;">삭제</th>
            </tr>
        </thead>

        <tbody>
            <c:if test="${empty list}">
                <tr>
                    <td colspan="5" class="text-center p-5 text-muted">저장된 레시피 북마크가 없습니다.</td>
                </tr>
            </c:if>

            <c:forEach items="${list}" var="vo" varStatus="status">
                <tr class="dataRow" data-no="${vo.recipes_no}">
                    <td>${pageObject.totalRow - ((pageObject.page - 1) * pageObject.perPageNum + status.index)}</td>

                    <td class="fw-bold text-success">${vo.recipes_title}</td>

                    <td>${vo.name}</td>

                    <td>${vo.recipes_writeDate}</td>

                    <td class="text-center">
                        <a href="${pageContext.request.contextPath}/recipesbookmark/delete.do?no=${vo.recipes_no}&from=bookmark&page=${pageObject.page}&perPageNum=${pageObject.perPageNum}"
                           class="btn btn-outline-danger btn-sm"
                           onclick="event.stopPropagation(); return confirm('이 레시피를 북마크 리스트에서 삭제하시겠습니까?');">
                            삭제
                        </a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <div class="mt-4">
        <pageNav:pageNav listURI="list.do" pageObject="${pageObject}"/>
    </div>
</div>

</body>
</html>