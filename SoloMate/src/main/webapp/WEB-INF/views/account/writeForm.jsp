<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가계부 내역 등록</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
    .form-label { font-weight: 600; color: #495057; }
    .card { border-radius: 15px; border: none; }
    /* 금액 입력칸 강조 */
    .amount-input {
        font-size: 1.5rem;
        font-weight: bold;
        text-align: right;
        color: #212529;
    }
    .custom-card {
        background: white;
        border-radius: 15px; /* 모서리 둥글게 */
        border: none;
        padding: 30px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05); /* 은은한 그림자 */
        margin-top: 30px;
        margin-bottom: 50px;
    }
    .top-title {
		font-size: 28px;
		font-weight: 800;
		color: #111;
		margin-bottom: 35px;
	}
</style>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
$(function(){
    // 취소 버튼
    $(".cancelBtn").click(function(){
        history.back();
    });

    $(function(){
        // 페이지 로드 시 오늘 날짜를 기본값으로 설정
        // ISO 형식(YYYY-MM-DD)으로 변환하여 value에 넣습니다.
        let today = new Date().toISOString().substring(0, 10);
        document.getElementById('regDate').value = today;
        
        // 취소 버튼 등 기존 스크립트...
    });
});
</script>

</head>
<body class="bg-light">
<div class="custom-card">
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-7">
            <div class="top-title">새로운 내역 등록하기</div>
            <div class="card shadow p-4">
                <form action="write.do" method="post">
                    <input type="hidden" name="perPageNum" value="${pageObject.perPageNum}">

                    <div class="mb-4">
                        <label for="amount" class="form-label">금액 (원)</label>
                        <div class="input-group">
                            <input type="number" class="form-control amount-input" id="amount" 
                                   name="amount" placeholder="0" required min="0">
                            <span class="input-group-text">₩</span>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="cno" class="form-label">카테고리</label>
                        <select class="form-select" name="cno" id="cno" required>
                            <option value="">분류를 선택하세요</option>
                            <optgroup label="💰 수입">
                                <option value="1">월급</option>
                                <option value="2">용돈</option>
                                <option value="3">기타(수입)</option>
                            </optgroup>
                            <optgroup label="📉 지출">
                                <option value="4">식비</option>
                                <option value="5">교통비</option>
                                <option value="6">쇼핑</option>
                                <option value="7">생활비</option>
                                <option value="8">문화/여가</option>
                                <option value="9">기타(지출)</option>
                            </optgroup>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label for="title" class="form-label">내역</label>
                        <input type="text" class="form-control" id="title"
                               name="title" placeholder="어디에 쓰셨나요? (예: 점심 식사, 월급 등)" required>
                    </div>

                    <div class="mb-3">
                        <label for="content" class="form-label">상세 메모</label>
                        <textarea class="form-control" rows="3" id="content"
                                  name="content" placeholder="추가로 기록할 내용을 입력하세요."></textarea>
                    </div>
                    
                    <div class="mb-3">
					    <label for="regDate" class="form-label">날짜</label>
					    <input type="date" class="form-control" id="regDate" name="regDate" required>
					</div>

                    <div class="d-flex justify-content-between mt-5">
                        <div>
                            <button type="submit" class="btn btn-dark px-4">등록하기</button>
                            <button type="reset" class="btn btn-outline-secondary">초기화</button>
                        </div>
                        <button type="button" class="cancelBtn btn btn-link text-decoration-none text-muted">취소</button>
                    </div>

                </form>
            </div>
        </div>
    </div>
</div>
</div>
</body>
</html>