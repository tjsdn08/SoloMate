<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가계부 리스트</title>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style type="text/css">
    .dataRow:hover { cursor:pointer; background-color: #f8f9fa !important; }
    .pagination { justify-content: center; }
    .income { color: #007bff; font-weight: bold; } 
    .expense { color: #dc3545; font-weight: bold; } 
    
    .search-container {
        background-color: #f1f3f5;
        padding: 15px;
        border-radius: 10px;
        margin-bottom: 20px;
    }
    
    /* 페이징 스타일 */
	.pagination .page-link { color: black; border: 1px solid #ddd; border-radius: 8px; margin: 0 3px; }
	.pagination .page-link:hover { background-color: black; color: white; }
	.pagination .active .page-link { background-color: black; border-color: black; color: white; }
	
	.custom-card {
        background: white;
        border-radius: 15px;
        border: none;
        padding: 30px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        margin-top: 30px;
    }

    /* 차트 카드 스타일 */
    .chart-card {
        background: white;
        border-radius: 15px;
        padding: 20px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        position: sticky;
        top: 100px; /* 스크롤 시 따라오도록 설정 */
    }
    .top-title {
		font-size: 28px;
		font-weight: 800;
		color: #111;
	}
</style>

<script type="text/javascript">
    $(function(){
        $(".dataRow").click(function(){
            let no = $(this).find(".no").text();
            location = "view.do?no=" + no + "&inc=1&${pageObject.pageQuery}";
        });

        $("#category").on("change", function() {
            $(this).closest("form").submit();
        });

        // 차트 데이터 준비 (서버 데이터를 JS 배열로 변환)
        let chartLabels = [];
        let chartData = [];
        let totalExp = 0;

        <c:forEach items="${list}" var="vo">
            if("${vo.type}" === "expense") {
                chartLabels.push("${vo.category}");
                chartData.push(${vo.amount});
                totalExp += ${vo.amount};
            }
        </c:forEach>

        // 차트 초기화 함수 호출
        initChart(chartLabels, chartData, totalExp);
    });

    function initChart(labels, data, total) {
        // 카테고리별 합산 로직 (중복 제거)
        const summary = {};
        labels.forEach((label, i) => {
            summary[label] = (summary[label] || 0) + data[i];
        });

        const ctx = document.getElementById('expenseChart').getContext('2d');
        new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: Object.keys(summary),
                datasets: [{
                    data: Object.values(summary),
                    backgroundColor: ['#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0', '#9966FF', '#C9CBCF'],
                    hoverOffset: 10
                }]
            },
            options: {
                cutout: '70%',
                plugins: {
                    legend: { position: 'bottom' }
                }
            }
        });
    }
</script>
</head>
<body>

<div class="container-fluid mt-4">
    <div class="row">
        <div class="col-lg-8">
            <div class="custom-card">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div class="top-title">💸 ${login.name}님의 가계부</div>
                </div>

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
                                    <option value="">카테고리 전체</option>
                                    <optgroup label="지출">
                                        <option value="식비" ${pageObject.category == '식비' ? 'selected' : ''}>식비</option>
                                        <option value="교통비" ${pageObject.category == '교통비' ? 'selected' : ''}>교통비</option>
                                        <option value="쇼핑" ${pageObject.category == '쇼핑' ? 'selected' : ''}>쇼핑</option>
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
                        <c:set var="totalIn" value="0" />
                        <c:set var="totalOut" value="0" />
                        <c:forEach items="${list}" var="vo">
                            <c:if test="${vo.type == 'income'}"><c:set var="totalIn" value="${totalIn + vo.amount}" /></c:if>
                            <c:if test="${vo.type == 'expense'}"><c:set var="totalOut" value="${totalOut + vo.amount}" /></c:if>
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
                <h5 class="fw-bold mb-4">📊 지출 카테고리 비율</h5>
                <div style="position: relative; height: 300px;">
                    <canvas id="expenseChart"></canvas>
                </div>
                <hr>
                <div class="p-2">
                    <div class="d-flex justify-content-between mb-2">
                        <span class="text-muted small">총 수입</span>
                        <span class="income">+<fmt:formatNumber value="${totalIn}" pattern="#,###" />원</span>
                    </div>
                    <div class="d-flex justify-content-between mb-2">
                        <span class="text-muted small">총 지출</span>
                        <span class="expense">-<fmt:formatNumber value="${totalOut}" pattern="#,###" />원</span>
                    </div>
                    <div class="d-flex justify-content-between border-top pt-2">
                        <span class="fw-bold">최종 잔액</span>
                        <span class="fw-bold fs-5 ${totalIn - totalOut >= 0 ? 'income' : 'expense'}">
                            <fmt:formatNumber value="${totalIn - totalOut}" pattern="#,###" />원
                        </span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>