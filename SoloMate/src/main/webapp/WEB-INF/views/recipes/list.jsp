<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레시피 아카이브</title>

<style type="text/css">
.admin-page {
	padding: 30px;
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
	margin-bottom: 20px;
}

.top-title {
	font-size: 28px;
	font-weight: 800;
	color: #111;
}

.search-row {
	display: grid;
	grid-template-columns: 1fr 140px 140px 140px;
	gap: 10px;
	align-items: center;
	margin-bottom: 20px;
}

.form-input, .form-select {
	width: 100%;
	height: 48px;
	border: 1px solid #ddd;
	border-radius: 12px;
	padding: 0 14px;
	font-size: 15px;
	outline: none;
}

.form-input:focus, .form-select:focus {
	border-color: #333;
}

.btn-main, .btn-sub {
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
}

.btn-main {
	background: #111827;
	color: #fff;
}

.btn-sub {
	background: #eef0f4;
	color: #333;
}

.dataRow:hover {
	cursor: pointer;
	background: #f8f9fc;
}

.badge-bookmark {
	padding: 5px 10px;
	border-radius: 8px;
	background-color: #fdecec;
	color: #c62828;
	font-weight: 700;
}

.bottom-row {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-top: 20px;
}

.btn-group-custom {
	display: flex;
	gap: 10px;
}

/* 기본 버튼 */
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
			let no = $(this).find(".no").text();
			location = "view.do?no=" + no + "&inc=1&${pageObject.pageQuery}";
		});
		
		$("#key").val("${(empty pageObject.key)?'tf':pageObject.key}");
		$("#word").val("${pageObject.word}");
	});
</script>

</head>
<body>

	<div class="admin-page">
		<div class="admin-card">

			<div class="top-bar">
				<div class="top-title">레시피 아카이브</div>
				<a href="writeForm.do?perPageNum=${pageObject.perPageNum}" class="btn-main">+ 레시피 등록</a>
			</div>

			<form action="list.do" method="get">
				<div class="search-row">
					<input type="text" name="word" id="word" class="form-input" 
						placeholder="레시피 제목 또는 재료 검색">
					
					<select name="key" id="key" class="form-select">
						<option value="tf">전체</option>
						<option value="t">제목</option>
						<option value="f">재료</option>
					</select>

					<select name="perPageNum" id="perPageNum" class="form-select" onchange="this.form.submit()">
						<option value="10" ${(pageObject.perPageNum == 10)?"selected":""}>10개씩</option>
						<option value="20" ${(pageObject.perPageNum == 20)?"selected":""}>20개씩</option>
					</select>

					<button type="submit" class="btn-main">검색</button>
				</div>
			</form>

			<table class="table table-hover align-middle">
				<thead class="table-light">
					<tr>
						<th style="width: 80px;">번호</th>
						<th>제목</th>
						<th>핵심 재료</th>
						<th>한줄 설명</th>
						<th style="width: 100px;">조리시간</th>
						<th style="width: 100px;">난이도</th>
						<th style="width: 80px;">북마크</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty list}">
						<tr>
							<td colspan="7" class="text-center py-5">등록된 레시피가 없습니다.</td>
						</tr>
					</c:if>
					<c:if test="${!empty list}">
						<c:forEach items="${list}" var="vo">
							<tr class="dataRow">
								<td class="no text-muted">${vo.recipes_no}</td>
								<td class="fw-bold text-dark">${vo.recipes_title}</td>
								<td>${vo.food}</td>
								<td class="text-secondary">${vo.description}</td>
								<td>${vo.recipes_time}분</td>
								<td>
									<span class="badge border text-dark font-weight-normal">${vo.recipes_level}</span>
								</td>
								<td>
									<span class="badge-bookmark">♥ ${vo.recipes_bookmark}</span>
								</td>
							</tr>
						</c:forEach>
					</c:if>
				</tbody>
			</table>

			<div class="bottom-row">
				<div>
					<c:if test="${!empty list}">
						<pageNav:pageNav listURI="list.do" pageObject="${pageObject}"/>
					</c:if>
				</div>
				<div class="btn-group-custom">
					<a href="list.do" class="btn-sub">새로고침</a>
					<c:if test="${not empty login}">
                        <a href="${pageContext.request.contextPath}/recipesbookmark/list.do" class="btn-main">내 북마크 보기</a>
					</c:if>
				</div>
			</div>

		</div> </div> </body>
</html>