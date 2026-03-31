<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 상세 보기</title>
</head>
<body>
<h2>회원 상세 보기</h2>
	<table class="table">
		<tbody>
			<tr>
				<th>아이디</th>
				<td class="id">${vo.id }</td>
			</tr>
			<tr>
				<th>이름</th>
				<td>${vo.name }</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td>${vo.tel }</td>
			</tr>
			<tr>
				<th>주소</th>
				<td>${vo.address }</td>
			</tr>
			<tr>
				<th>상태</th>
				<td>${vo.status }</td>
			</tr>
			<tr>
				<th>등급번호</th>
				<td>${vo. gradeNo }</td>
			</tr>
			<tr>
				<th>등급명</th>
				<td>${vo.gradeName }</td>
			</tr>
			<tr>
				<th>가입일 </th>
				<td>${vo.regDate }</td>
			</tr>
			<tr>
				<th>최근 방문일 </th>
				<td>${vo.conDate }</td>
			</tr>
		</tbody>
	</table>
	
	<a href="updateForm.do?no=${param.no }&inc=0&page${param.page }&perpageNum=${param.perPageNum }&key=${param.key }&word=${param.word }"
	 class="btn btn-outline-primary">정보 수정</a>
	<a href="list.do?page=${param.page }&perPageNum=${param.perPageNum }&key=${param.key }&word=${param.word }"
	 class="btn btn-warning">리스트</a>
	 
	
</body>
</html>