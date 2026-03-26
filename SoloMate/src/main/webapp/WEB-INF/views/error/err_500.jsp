<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="error_jsp.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내부 서버 오류</title>
</head>
<body>
	<h2>내부 서버 오류</h2>
	<div class="card">
		<div class="card-header bg-dark text-white">요청 URL : ${url }</div>
		<div class="card-body">
		[${moduleName } 처리 중 오류가 발생되었습니다.] <hr>
		오류 내용 : ${e.message}<br>
		지속적인 오류가 나는 경우 사이트 관리자에게 문의해주세요.(질문답변 게시판 이용)
		</div>
		<div class="card-footer">웹짱 사이트 담당자 : 이영환</div>
	</div>
</body>
</html>