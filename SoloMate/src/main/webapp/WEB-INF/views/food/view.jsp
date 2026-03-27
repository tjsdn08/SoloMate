<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>식품 상세 보기</title>
</head>
<body>

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
				<td>${vo.folderName }</td>
			</tr>
		</tbody>
	</table>

</body>
</html>