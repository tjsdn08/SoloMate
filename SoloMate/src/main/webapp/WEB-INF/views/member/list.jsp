<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 관리 리스트</title>

<style>
/* 핫딜 리스트와 동일한 레이아웃 설정 */
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
	margin-bottom: 20px;
}

.top-title {
	font-size: 28px;
	font-weight: 800;
	color: #111;
}

/* 회원 리스트에 맞춘 검색 그리드 */
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

/* 수정 버튼 전용 스타일 */
.btn-sm-modify {
	height: 38px;
	padding: 0 12px;
	background: #374151;
	color: #fff;
	border-radius: 8px;
	border: none;
	font-weight: 600;
	font-size: 13px;
	cursor: pointer;
}

.dataRow:hover {
	cursor: pointer;
	background: #f8f9fc;
}

/* 회원 관리 셀렉트 박스 묶음 */
.manage-box {
	display: flex;
	gap: 8px;
	align-items: center;
}

.manage-box .form-select {
	height: 38px;
	font-size: 14px;
	width: auto;
	min-width: 100px;
}

.bottom-row {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-top: 20px;
}
</style>

<script type="text/javascript">
$(function() {
	$(".dataRow").click(function(e) {
		if ($(e.target).closest(".noMove").length > 0) return;
		let id = $(this).find(".id").text();
		location = "view.do?id=" + id;
	});

	$(".noMove").on("click", function(event) {
		event.stopPropagation();
	});

	$(".changeStatusBtn").on("click", function() {
		let $row = $(this).closest(".dataRow");
		let id = $row.find(".id").text();
		let status = $row.find(".status").val();
		if(confirm(id + " 회원의 상태를 변경하시겠습니까?")) {
			location = "changeStatus.do?id=" + id + "&status=" + encodeURIComponent(status);
		}
	});

	$(".changeGradeNoBtn").on("click", function() {
		let $row = $(this).closest(".dataRow");
		let id = $row.find(".id").text();
		let gradeNo = $row.find(".grade").val();
		if(confirm(id + " 회원의 등급을 변경하시겠습니까?")) {
			location = "changeGrade.do?id=" + id + "&gradeNo=" + gradeNo;
		}
	});
});
</script>
</head>
<body>

	<div class="admin-page">
		<div class="admin-card">

			<div class="top-bar">
				<div class="top-title">회원 관리 리스트</div>
			</div>

			<form action="list.do" method="get">
				<div class="search-row">
					<input type="text" name="word" id="word" class="form-input" 
						placeholder="아이디 또는 이름 검색" value="${pageObject.word}">
					
					<select name="key" id="key" class="form-select">
						<option value="n" ${(pageObject.key == "n")?"selected":""}>이름</option>
						<option value="i" ${(pageObject.key == "i")?"selected":""}>아이디</option>
						<option value="ni" ${(pageObject.key == "ni")?"selected":""}>이름+아이디</option>
					</select>

					<select name="perPageNum" id="perPageNum" class="form-select" onchange="this.form.submit()">
						<option value="10" ${(pageObject.perPageNum == 10)?"selected":""}>10명씩</option>
						<option value="20" ${(pageObject.perPageNum == 20)?"selected":""}>20명씩</option>
						<option value="50" ${(pageObject.perPageNum == 50)?"selected":""}>50명씩</option>
					</select>

					<button type="submit" class="btn-main">검색</button>
				</div>
			</form>

			<table class="table table-hover align-middle">
				<thead class="table-light">
					<tr>
						<th>아이디</th>
						<th>이름</th>
						<th>연락처</th>
						<th>주소</th>
						<th>상태 관리</th>
						<th>등급 관리</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty list}">
						<tr>
							<td colspan="6" class="text-center py-5">데이터가 존재하지 않습니다.</td>
						</tr>
					</c:if>
					<c:if test="${!empty list}">
						<c:forEach items="${list}" var="vo">
							<tr class="dataRow">
								<td class="id fw-bold">${vo.id}</td>
								<td>${vo.name}</td>
								<td>${vo.tel}</td>
								<td class="text-muted">${vo.address}</td>
								<td>
									<div class="manage-box noMove">
										<select class="form-select status">
											<option value="정상" ${(vo.status == "정상")?"selected":""}>정상</option>
											<option value="탈퇴" ${(vo.status == "탈퇴")?"selected":""}>탈퇴</option>
											<option value="강퇴" ${(vo.status == "강퇴")?"selected":""}>강퇴</option>
											<option value="휴면" ${(vo.status == "휴면")?"selected":""}>휴면</option>
										</select>
										<button type="button" class="btn-sm-modify changeStatusBtn">수정</button>
									</div>
								</td>
								<td>
									<div class="manage-box noMove">
										<select class="form-select grade">
											<option value="1" ${(vo.gradeNo == 1)?"selected":""}>일반회원</option>
											<option value="9" ${(vo.gradeNo == 9)?"selected":""}>관리자</option>
										</select>
										<button type="button" class="btn-sm-modify changeGradeNoBtn">수정</button>
									</div>
								</td>
							</tr>
						</c:forEach>
					</c:if>
				</tbody>
			</table>

			<div class="bottom-row">
				<div>
					<c:if test="${!empty list}">
						<pageNav:pageNav listURI="list.do" pageObject="${pageObject}" />
					</c:if>
				</div>
				<div>
					<a href="list.do" class="btn-sub">새로고침</a>
				</div>
			</div>
		</div>
	</div>

</body>
</html>