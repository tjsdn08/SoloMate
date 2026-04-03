<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레시피 북마크 리스트</title>

<style type="text/css">
.admin-page {
	padding: 30px;
	background-color: #fff;
}

.admin-card {
	background: #fff;
	border-radius: 18px;
	padding: 24px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
}

.top-bar {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 25px;
}

.top-title {
	font-size: 28px;
	font-weight: 800;
	color: #111;
}

.btn-main, .btn-sub, .btn-danger-light {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	height: 48px;
	padding: 0 18px;
	border-radius: 12px;
	border: none;
	font-size: 15px;
	font-weight: 700;
	text-decoration: none;
	cursor: pointer;
	transition: 0.2s;
}

.btn-main { background: #111827; color: #fff; }
.btn-sub { background: #eef0f4; color: #333; }
.btn-danger-light { background: #fdecec; color: #c62828; font-size: 13px; height: 35px; }

.btn-main:hover { background: #1f2937; color: #fff; }
.btn-sub:hover { background: #e5e7eb; color: #333; }

.dataRow:hover {
	cursor: pointer;
	background: #f8f9fc;
}

.bottom-row {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-top: 20px;
}
</style>

<script type="text/javascript">
	$(function(){
		$(".dataRow").click(function(){
			let no = $(this).data("no");
			location = "${pageContext.request.contextPath}/recipes/view.do"
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

	<div class="admin-page">
		<div class="admin-card">

			<div class="top-bar">
				<div class="top-title">📖 ${login.name}님의 북마크</div>
				<a href="${pageContext.request.contextPath}/recipes/list.do?page=${param.page}&perPageNum=${param.perPageNum}&key=${param.key}&word=${param.word}"
				   class="btn-sub">전체 레시피 목록</a>
			</div>

			<table class="table table-hover align-middle">
				<thead class="table-light">
					<tr>
						<th style="width: 80px;">번호</th>
						<th>레시피 제목</th>
						<th style="width: 150px;">작성자</th>
						<th style="width: 150px;">등록일</th>
						<th style="width: 100px;" class="text-center">관리</th>
					</tr>
				</thead>

				<tbody>
					<c:if test="${empty list}">
						<tr>
							<td colspan="5" class="text-center py-5 text-muted">저장된 북마크 레시피가 없습니다.</td>
						</tr>
					</c:if>

					<c:forEach items="${list}" var="vo" varStatus="status">
						<tr class="dataRow" data-no="${vo.recipes_no}">
							<td class="text-muted">
								${pageObject.totalRow - ((pageObject.page - 1) * pageObject.perPageNum + status.index)}
							</td>
							<td class="fw-bold text-dark">${vo.recipes_title}</td>
							<td>${vo.name}</td>
							<td class="text-secondary">${vo.recipes_writeDate}</td>
							<td class="text-center">
								<a href="${pageContext.request.contextPath}/recipesbookmark/delete.do?no=${vo.recipes_no}&from=bookmark&page=${pageObject.page}&perPageNum=${pageObject.perPageNum}"
								   class="btn-danger-light"
								   onclick="event.stopPropagation(); return confirm('이 레시피를 북마크 리스트에서 삭제하시겠습니까?');">
									삭제
								</a>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>

			<div class="bottom-row">
				<div>
					<c:if test="${!empty list}">
						<pageNav:pageNav listURI="list.do" pageObject="${pageObject}"/>
					</c:if>
				</div>
				<div>
					<a href="list.do" class="btn-sub">새로고침</a>
				</div>
			</div>

		</div> </div> </body>
</html>