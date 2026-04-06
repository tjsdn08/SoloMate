<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가계부 내역 상세 보기</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
    .view-table th {
        width: 150px;
        background: #f8f9fa;
        border-right: 1px solid #dee2e6;
    }
    .view-table td {
        padding: 15px;
    }
    /* 금액 스타일 */
    .income { color: #007bff; font-weight: bold; font-size: 1.2rem; }
    .expense { color: #dc3545; font-weight: bold; font-size: 1.2rem; }
    .content-box {
        min-height: 100px;
        white-space: pre-line;
        background-color: #fdfdfd;
        border: 1px inset #eee;
        padding: 10px;
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
	}
</style>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
$(function(){
    // 삭제 버튼 이벤트
    $("#deleteBtn").click(function(){
        if(confirm("이 내역을 정말 삭제하시겠습니까?")){
            $("#deleteForm").submit();
        }
    });
});
</script>

</head>
<body class="container mt-5">
<div class="custom-card">
<div class="row justify-content-center">
    <div class="col-md-8">
        <div class="top-title">💸 가계부 내역 상세 보기</div>
        

        <div class="card shadow-sm p-4">
            <div class="d-flex justify-content-between mb-3">
                <a href="list.do?${pageObject.pageQuery}" class="btn btn-outline-secondary">
                   ← 리스트로 돌아가기
                </a>
                <div>
                    <a href="updateForm.do?no=${vo.no}&${pageObject.pageQuery}" class="btn btn-dark">
                       수정하기
                    </a>
                    <button id="deleteBtn" class="btn btn-danger">
                        삭제
                    </button>
                </div>
            </div>

            <table class="table view-table table-bordered align-middle">
                <tbody>
                    <tr>
                        <th>번호</th>
                        <td>${vo.no}</td>
                    </tr>
                    <tr>
                        <th>날짜</th>
                        <td>${vo.regDate}</td>
                    </tr>
                    <tr>
                        <th>분류</th>
                        <td>
                            <span class="badge ${vo.type == 'income' ? 'bg-primary' : 'bg-danger'}">
                                ${vo.type == 'income' ? '수입' : '지출'}
                            </span>
                            <span class="ms-2 fw-bold text-secondary">[ ${vo.category} ]</span>
                        </td>
                    </tr>
                    <tr>
                        <th>금액</th>
                        <td>
                            <span class="${vo.type == 'income' ? 'income' : 'expense'}">
                                <fmt:formatNumber value="${vo.amount}" pattern="#,###" />원
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <th>내역</th>
                        <td><strong>${vo.title}</strong></td>
                    </tr>
                    <tr>
                        <th>상세 내용</th>
                        <td>
                            <div class="content-box">
                                ${empty vo.content ? '상세 내용이 없습니다.' : vo.content}
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
            
        </div>
    </div>
</div>

<form id="deleteForm" action="delete.do" method="post">
    <input type="hidden" name="no" value="${vo.no}">
    <%-- 삭제 후 리스트로 돌아갈 때 현재 페이지 정보를 유지하기 위함 --%>
    <input type="hidden" name="page" value="${pageObject.page}">
    <input type="hidden" name="perPageNum" value="${pageObject.perPageNum}">
</form>
</div>
</body>
</html>