<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>식품 상세 보기</title>
<style type="text/css">
.custom-card {
        background: white;
        border-radius: 15px;
        border: none;
        padding: 30px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        margin-top: 30px;
    }
</style>
</head>
<body>
<div class="custom-card">
<h2>식품 상세 보기</h2>
	<table class="table">
		<tbody>
			<tr>
				<th>식품</th>
				<td>${vo.name }</td>
			</tr>
			<tr>
				<th>유통기한</th>
				<td>${vo.expiryDate }</td>
			</tr>
			<tr>
				<th>수량</th>
				<td>${vo.quantity }</td>
			</tr>
			<tr>
				<th>보관방법</th>
				<td>${vo.storageType }</td>
			</tr>
			<tr>
				<th>메모</th>
				<td>${vo.memo }</td>
			</tr>
			<tr>
				<th>폴더명</th>
				<td>
					<c:if test="${empty vo.folders }">
						없음
					</c:if>
					<c:if test="${!empty vo.folders }">
						<c:forEach items="${vo.folders }" var="folder">
							${folder }<c:if test="${!status.last }">, </c:if>
						</c:forEach>
					
					</c:if>
				</td>
			</tr>
		</tbody>
	</table>
	
	<div class="d-flex flex-row-reverse gap-2">
		<a href="updateForm.do?no=${param.no }&page=${param.page }&perPageNum=${param.perPageNum }&key=${param.key }&word=${param.word }"
		 class="btn btn-primary">식품 수정</a>
		<a href="delete.do?no=${vo.no}&page=${param.page }&perPageNum=${param.perPageNum }&key=${param.key }&word=${param.word }" class="btn btn-danger" onclick="return confirm('삭제하시겠습니까?');">식품 삭제</a>
		<a href="list.do?page=${param.page }&perPageNum=${param.perPageNum }&key=${param.key }&word=${param.word }"
		 class="btn btn-warning">식품 목록 보기</a> 
	</div>
</div>
</body>
</html>