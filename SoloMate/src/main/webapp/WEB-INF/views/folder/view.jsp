<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>폴더 상세 보기</title>
</head>
<body>
<h2>폴더 상세 보기</h2>
<h3>${vo.name }</h3>
<h4>${vo.createdAt }</h4>
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
		<c:if test="${empty vo }">
			<tr>
				<td colspan="4">데이터가 존재하지 않습니다.</td>
			</tr>
		</c:if>
		<c:if test="${!empty vo }">
			<c:forEach items="${vo.foods }" var="vo" >
				<tr class="dataRow" data-no="${vo.no }">
					<td>${vo.name }</td>
					<td>${vo.dDay }</td>
					<td>${vo.quantity }</td>
					<td>${vo.storageType }</td>
				</tr>
			</c:forEach>
		</c:if>
		</tbody>
	</table>
	
	<a href="list.do" class="btn btn-primary">폴더 목록 보기</a>

</body>
</html>