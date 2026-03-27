<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>식품 목록 보기</title>
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
				<tr class="dataRow">
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