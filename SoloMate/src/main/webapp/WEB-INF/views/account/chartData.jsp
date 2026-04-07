<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
$(function() {
    const ctx = document.getElementById('monthlyChart').getContext('2d');
    const stats = {};

    // 중요: chartData는 Controller에서 보낸 전체 통계 데이터입니다.
    <c:forEach items="${chartData}" var="vo">
        const date = "${vo.regDate}";
        if (!stats[date]) stats[date] = { income: 0, expense: 0 };
        if ("${vo.type}" === "income") stats[date].income = ${vo.amount};
        else stats[date].expense = ${vo.amount};
    </c:forEach>

    const labels = Object.keys(stats).sort();
    const incomeData = labels.map(d => stats[d].income);
    const expenseData = labels.map(d => stats[d].expense);

    new Chart(ctx, {
        type: 'line', // 달별/일별 추이는 선 그래프가 가독성이 좋습니다.
        data: {
            labels: labels,
            datasets: [
                { label: '수입', data: incomeData, borderColor: '#4bc0c0', backgroundColor: '#4bc0c0', fill: false },
                { label: '지출', data: expenseData, borderColor: '#ff6384', backgroundColor: '#ff6384', fill: false }
            ]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            interaction: { mode: 'index', intersect: false }
        }
    });
});
</script>