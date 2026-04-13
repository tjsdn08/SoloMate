<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 상세 보기</title>

<style>
.admin-page {
	padding: 30px;
}

.admin-card {
	background: #fff;
	border-radius: 18px;
	padding: 30px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
	max-width: 800px;
	margin: 0 auto;
}

.top-bar {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 24px;
	padding-bottom: 16px;
	border-bottom: 2px solid #f8f9fc;
}

.top-title {
	font-size: 28px;
	font-weight: 800;
	color: #111;
}

/* 상세 정보 테이블 전용 스타일 */
.detail-table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 30px;
}

.detail-table th, .detail-table td {
	padding: 16px 20px;
	border-bottom: 1px solid #f1f3f5;
	font-size: 15px;
	text-align: left;
}

.detail-table th {
	width: 160px;
	background-color: #f8f9fc;
	color: #333;
	font-weight: 700;
}

.detail-table td {
	color: #444;
}

/* 하단 버튼 영역 */
.btn-main, .btn-sub {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	height: 48px;
	padding: 0 24px;
	border-radius: 12px;
	border: none;
	font-size: 15px;
	font-weight: 700;
	text-decoration: none;
	cursor: pointer;
	transition: background 0.2s ease;
}

.btn-main {
	background: #111827;
	color: #fff;
}

.btn-main:hover {
	background: #374151;
	color: #fff;
}

.btn-sub {
	background: #eef0f4;
	color: #333;
}

.btn-sub:hover {
	background: #e5e7eb;
}

.bottom-buttons {
	display: flex;
	justify-content: flex-end;
	gap: 12px;
}
</style>
</head>
<body>

	<div class="admin-page">
		<div class="admin-card">
		
			<div class="top-bar">
				<div class="top-title">회원 상세 보기</div>
			</div>

			<table class="detail-table">
				<tbody>
					<tr>
						<th>아이디</th>
						<td class="id fw-bold text-dark">${vo.id }</td>
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
						<td>${vo.gradeNo }</td>
					</tr>
					<tr>
						<th>등급명</th>
						<td>${vo.gradeName }</td>
					</tr>
					<tr>
						<th>가입일</th>
						<td>${vo.regDate }</td>
					</tr>
					<tr>
						<th>최근 방문일</th>
						<td>${vo.conDate }</td>
					</tr>
				</tbody>
			</table>
			
			<div class="bottom-buttons">
				<a href="updateForm.do?id=${vo.id}&page=${param.page}&perPageNum=${param.perPageNum}&key=${param.key}&word=${param.word}" class="btn-main">정보 수정</a>
				<a href="list.do?page=${param.page }&perPageNum=${param.perPageNum }&key=${param.key }&word=${param.word }"
				 class="btn-sub">리스트</a>
			</div>
			
		</div>
	</div>
	
</body>
</html>