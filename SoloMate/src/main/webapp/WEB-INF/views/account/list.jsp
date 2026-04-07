<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가계부 리스트</title>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style type="text/css">
    .dataRow:hover { cursor:pointer; background-color: #f2f2f2 !important; }
    .pagination { justify-content: center; }
    .income { color: #007bff; font-weight: bold; } 
    .expense { color: #dc3545; font-weight: bold; } 
    
    .search-container {
        background-color: #f1f3f5;
        padding: 15px;
        border-radius: 10px;
        margin-bottom: 20px;
    }
    
	.pagination .page-link { color: black; border: 1px solid #ddd; border-radius: 8px; margin: 0 3px; }
	.pagination .page-link:hover { background-color: black; color: white; }
	.pagination .active .page-link { background-color: black; border-color: black; color: white; }
	
	.custom-card {
        background: white; border-radius: 15px; border: none; padding: 30px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05); margin-top: 30px;
    }

    .chart-card {
        background: white; border-radius: 15px; padding: 20px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05); position: sticky; top: 100px;
    }
    .top-title { font-size: 28px; font-weight: 800; color: #111; margin-bottom: 35px; }
</style>

<script type="text/javascript">
    $(function(){
        // 1. 게시글 상세 보기 클릭
        $(".dataRow").click(function(){
            let no = $(this).find(".no").text();
            location = "view.do?no=" + no + "&inc=1&${pageObject.pageQuery}";
        });

        // 2. 카테고리/날짜 변경 시 자동 검색
        $("#category, input[name='searchMonth']").on("change", function() {
            $(this).closest("form").submit();
        });

        // 3. 차트 데이터 가공
        const labels = [];
        const data = [];
        let totalExpense = 0;
        const isMonthSelected = "${not empty param.searchMonth}" === "true";

        <c:forEach items="${chartData}" var="vo">
            if("${vo.type}" === "expense") {
                // 달이 선택되었으면 '카테고리명', 아니면 '날짜'를 라벨로 사용
                let labelName = isMonthSelected ? "${vo.category}" : "${vo.regDate}";
                labels.push(labelName);
                data.push(${vo.amount});
                totalExpense += ${vo.amount};
            }
        </c:forEach>

        // 차트 그리기
        initChart(labels, data, totalExpense);
    });

    function initChart(labels, data, totalExpense) {
        const canvas = document.getElementById('expenseChart');
        if(!canvas) return;
        const ctx = canvas.getContext('2d');
        
        if (labels.length === 0) {
            ctx.font = "16px Arial";
            ctx.textAlign = "center";
            ctx.fillText("지출 내역이 없습니다.", canvas.width/2, canvas.height/2);
            return;
        }

        new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: labels,
                datasets: [{
                    data: data,
                    backgroundColor: [
                        '#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0', '#9966FF', '#FF9F40', '#C9CBCF'
                    ],
                    hoverOffset: 15,
                    borderWidth: 2
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                cutout: '70%',
                plugins: {
                    legend: { position: 'bottom' },
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                const val = context.raw;
                                const pct = ((val / totalExpense) * 100).toFixed(1);
                                return " " + context.label + ": " + val.toLocaleString() + "원 (" + pct + "%)";
                            }
                        }
                    }
                }
            }
        });
    }
</script>
</head>
<body>

<%-- 차트용 전체 데이터(chartData)를 사용하여 수입/지출 총액을 계산 --%>
<c:set var="finalIn" value="0" />
<c:set var="finalOut" value="0" />

<c:forEach items="${chartData}" var="cvo">
    <c:choose>
        <c:when test="${cvo.type == 'income'}">
            <c:set var="finalIn" value="${finalIn + cvo.amount}" />
        </c:when>
        <c:when test="${cvo.type == 'expense'}">
            <c:set var="finalOut" value="${finalOut + cvo.amount}" />
        </c:when>
    </c:choose>
</c:forEach>

<div class="container-fluid mt-4">
    <div class="row">
        <div class="col-lg-8">
            <div class="custom-card">
                <div class="top-title">💸 ${login.name}님의 가계부</div>

                <div class="search-container">
                    <form action="list.do" method="get">
                        <input type="hidden" name="perPageNum" value="${pageObject.perPageNum}">
                        <div class="row g-2 align-items-center">
                            <div class="col-md-5">
                                <div class="input-group">
                                    <span class="input-group-text bg-white">🔍</span>
                                    <input type="text" class="form-control" name="word" value="${pageObject.word}" placeholder="글 검색">
                                </div>
                            </div>
                            <div class="col-md-2">
                                <select class="form-select" name="key">
                                    <option value="tcw" ${pageObject.key == 'tcw' ? 'selected' : ''}>전체</option>
                                    <option value="t" ${pageObject.key == 't' ? 'selected' : ''}>제목</option>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <select class="form-select" name="category" id="category">
                                    <option value="">전체 카테고리</option>
                                    <optgroup label="💰 수입">
                                        <option value="income" ${param.category == 'income' ? 'selected' : ''}>전체 수입</option>
                                        <option value="월급" ${param.category == '월급' ? 'selected' : ''}>월급</option>
                                        <option value="용돈" ${param.category == '용돈' ? 'selected' : ''}>용돈</option>
                                    </optgroup>
                                    <optgroup label="📉 지출">
                                        <option value="expense" ${param.category == 'expense' ? 'selected' : ''}>전체 지출</option>
                                        <option value="식비" ${param.category == '식비' ? 'selected' : ''}>식비</option>
                                        <option value="교통비" ${param.category == '교통비' ? 'selected' : ''}>교통비</option>
                                        <option value="쇼핑" ${param.category == '쇼핑' ? 'selected' : ''}>쇼핑</option>
                                    </optgroup>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <button class="btn btn-dark w-100">검색</button>
                            </div>
                        </div>
                    </form>
                </div>

                <table class="table table-hover text-center">
                    <thead class="table-light">
                        <tr>
                            <th>날짜</th>
                            <th>카테고리</th>
                            <th>내역</th>
                            <th>금액</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${list}" var="vo">
                            <tr class="dataRow">
                                <td class="no d-none">${vo.no}</td>
                                <td>${vo.regDate}</td>
                                <td><span class="badge bg-secondary">${vo.category}</span></td>
                                <td class="text-start"><strong>${vo.title}</strong></td>
                                <td class="text-end border-start">
                                    <span class="${vo.type == 'income' ? 'income' : 'expense'}">
                                        <fmt:formatNumber value="${vo.amount}" pattern="#,###" />원
                                    </span>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                
                <div class="mt-4"><pageNav:pageNav listURI="list.do" pageObject="${pageObject}" /></div>
                
                <div class="d-flex justify-content-end mt-3 gap-2">
                    <a href="writeForm.do" class="btn btn-dark text-white">내역 등록</a>
                    <a href="list.do" class="btn btn-outline-secondary">새로고침</a>
                </div>
            </div>
        </div>

        <div class="col-lg-4">
		    <div class="chart-card mt-5">
		        <div class="d-flex justify-content-between align-items-center mb-4">
		            <h5 class="fw-bold m-0">
		                <c:choose>
		                    <c:when test="${not empty param.searchMonth}">
		                        📊 ${param.searchMonth} 리포트
		                    </c:when>
		                    <c:otherwise>
		                        📊 전체 소비 추이
		                    </c:otherwise>
		                </c:choose>
		            </h5>
		            
		            <form action="list.do" method="get" id="monthForm">
		                <input type="month" name="searchMonth" 
		                       class="form-control form-control-sm" 
		                       value="${param.searchMonth}" 
		                       onchange="this.form.submit()">
		            </form>
		        </div>
		
		        <div style="position: relative; height: 300px;">
		            <canvas id="expenseChart"></canvas>
		        </div>
		        
		        <hr>
		
		        <div class="p-2">
		            <div class="d-flex justify-content-between mb-2">
		                <span class="text-muted small">총 수입</span>
		                <span class="text-primary fw-bold">
		                    +<fmt:formatNumber value="${finalIn}" pattern="#,###" />원
		                </span>
		            </div>
		        
		            <div class="d-flex justify-content-between mb-2">
		                <span class="text-muted small">총 지출</span>
		                <span class="text-danger fw-bold">
		                    -<fmt:formatNumber value="${finalOut}" pattern="#,###" />원
		                </span>
		            </div>
		        
		            <div class="d-flex justify-content-between border-top pt-2">
		                <span class="fw-bold">최종 잔액</span>
		                <span class="fw-bold fs-5 ${finalIn - finalOut >= 0 ? 'text-primary' : 'text-danger'}">
		                    <fmt:formatNumber value="${finalIn - finalOut}" pattern="#,###" />원
		                </span>
		            </div>
		        </div>
		
		        <c:if test="${not empty param.searchMonth}">
		            <div class="text-center mt-3">
		                <a href="list.do" class="btn btn-sm btn-outline-secondary w-100" style="border-radius: 10px;">
		                    전체 기간 데이터 보기
		                </a>
		            </div>
		        </c:if>
		    </div>
		</div>
    </div>
</div>

</body>
</html>