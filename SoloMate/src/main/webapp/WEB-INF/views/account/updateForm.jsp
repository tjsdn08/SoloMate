<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가계부 내역 수정</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
    .form-label { font-weight: 600; color: #495057; }
    .card { border-radius: 15px; border: none; }
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
</style>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
$(function(){
    // 취소 버튼
    $(".cancelBtn").click(function(){
        history.back();
    });
});
</script>

</head>
<body class="bg-light">
<div class="custom-card">
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-7">
            <h2 class="mb-4 text-center">✏️ 내역 수정하기</h2>

            <div class="card shadow p-4">
                <form action="update.do" method="post">
                    <input type="hidden" name="page" value="${param.page}">
                    <input type="hidden" name="perPageNum" value="${param.perPageNum}">
                    <input type="hidden" name="category" value="${param.category}">
                    
                    <input type="hidden" name="no" value="${vo.no}">

                    <div class="mb-3">
                        <label for="regDate" class="form-label">날짜</label>
                        <input type="date" class="form-control" id="regDate" 
                               name="regDate" value="${vo.regDate}" required>
                    </div>

                    <div class="mb-4">
                        <label for="amount" class="form-label">금액 (원)</label>
                        <div class="input-group">
                            <input type="number" class="form-control amount-input" id="amount" 
                                   name="amount" value="${vo.amount}" required min="0">
                            <span class="input-group-text">₩</span>
                        </div>
                    </div>

                    <div class="mb-3">
					    <label for="cno" class="form-label">카테고리</label>
					    <select class="form-select" name="cno" id="cno" required>
					        <option value="">분류를 선택하세요</option>
					        
					        <optgroup label="💰 수입">
					            <option value="1" ${vo.cno == 1 ? "selected" : ""}>월급</option>
					            <option value="2" ${vo.cno == 2 ? "selected" : ""}>용돈</option>
					            <option value="3" ${vo.cno == 3 ? "selected" : ""}>기타(수입)</option>
					        </optgroup>
					        
					        <optgroup label="📉 지출">
					            <option value="4" ${vo.cno == 4 ? "selected" : ""}>식비</option>
					            <option value="5" ${vo.cno == 5 ? "selected" : ""}>교통비</option>
					            <option value="6" ${vo.cno == 6 ? "selected" : ""}>쇼핑</option>
					            <option value="7" ${vo.cno == 7 ? "selected" : ""}>생활비</option>
					            <option value="8" ${vo.cno == 8 ? "selected" : ""}>문화/여가</option>
					            <option value="9" ${vo.cno == 9 ? "selected" : ""}>기타(지출)</option>
					        </optgroup>
					    </select>
					</div>

                    <div class="mb-3">
                        <label for="title" class="form-label">내역</label>
                        <input type="text" class="form-control" id="title"
                               name="title" value="${vo.title}" required>
                    </div>

                    <div class="mb-3">
                        <label for="content" class="form-label">상세 메모</label>
                        <textarea class="form-control" rows="3" id="content"
                                  name="content">${vo.content}</textarea>
                    </div>

                    <div class="d-flex justify-content-between mt-5">
                        <div>
                            <button type="submit" class="btn btn-dark px-4">수정완료</button>
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