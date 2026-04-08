<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>
    /* [레이아웃] 메인 컨테이너 */
    .main-page-container {
        display: grid;
        grid-template-columns: 1.8fr 1fr;
        gap: 25px;
        max-width: 1300px;
        margin: 20px auto;
        padding: 0 20px;
        align-items: stretch; /* 좌우 높이를 동일하게 맞춤 */
    }

    /* [왼쪽] 대시보드 메인 판넬 */
    .summary-dashboard { 
        width: 100%;
        background-color: #ffffff; 
        border-radius: 20px; 
        box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08); 
        padding: 30px; 
        display: grid; 
        grid-template-columns: 1fr 1fr; 
        gap: 24px; /* 섹션 간 간격 */
    }
    
    /* [오른쪽] 리포트 사이드바 (전체 클릭 가능 영역) */
    .report-sidebar {
        background: white; 
        border-radius: 20px; 
        padding: 20px; /* 대시보드 섹션 패딩과 통일 */
        box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08); 
        height: 100%;
        transition: all 0.3s ease;
        border: 2px solid transparent;
        display: flex;
        flex-direction: column;
        box-sizing: border-box;
    }
    .report-sidebar:hover {
        transform: translateY(-5px);
        border-color: #3498db;
        box-shadow: 0 12px 30px rgba(52, 152, 219, 0.15);
    }

    /* 리포트 내부 요소 간격 통일 (24px) */
    .report-title { font-size: 1.25rem; font-weight: 800; color: #111; margin-bottom: 20px; }
    
    .report-chart-box {
        position: relative; 
        height: 250px; 
        margin-bottom: 24px; /* 대시보드 gap과 통일 */
    }

    .report-summary-block {
        display: flex;
        flex-direction: column;
        gap: 10px; /* 수입/지출/잔액 간 촘촘한 간격 */
        padding-top: 20px;
    }

    .category-rank-list { 
        list-style: none; 
        padding: 0; 
        margin: 24px 0 0 0; /* 상단 마진을 대시보드 gap과 통일 */
        border-top: 1px dashed #eee; 
        padding-top: 20px; 
    }

	.budget-progress-container { 
	    margin-top: 24px; 
	    /* 왼쪽 .dashboard-section과 동일하게 패딩 20px, 곡률 16px로 통일 */
	    padding: 20px; 
	    background: #f8f9fa; 
	    border-radius: 16px; 
	    box-sizing: border-box;
	}

    .income { color: #007bff; font-weight: bold; } 
    .expense { color: #dc3545; font-weight: bold; }

    /* [공통] 대시보드 개별 섹션 스타일 */
    .dashboard-section { 
        background-color: #f8f9fa; 
        border-radius: 16px; 
        padding: 20px; 
        display: flex; 
        flex-direction: column; 
    }
    .section-header { 
        font-size: 1.2rem; 
        font-weight: 700; 
        color: #2c3e50; 
        margin-bottom: 16px; 
        display: flex; 
        justify-content: space-between; 
        align-items: center;
    }
    .sub-text { font-size: 0.8rem; color: #7f8c8d; font-weight: normal; }
    
    /* [공통] 카드 및 링크 스타일 */
    a { text-decoration: none; color: inherit; }
    .bookmark-card { 
        display: flex; 
        align-items: center; 
        gap: 15px; 
        background: #ffffff; 
        border: 1px solid #e9ecef; 
        border-radius: 12px; 
        padding: 12px; 
        transition: all 0.2s ease-in-out; 
        height: 100%;
    }
    .bookmark-card:hover { 
        transform: translateY(-3px); 
        box-shadow: 0 6px 16px rgba(0, 0, 0, 0.06); 
        border-color: #3498db; 
    }
    .recipe-img { width: 70px; height: 70px; border-radius: 8px; object-fit: cover; background-color: #eee; }
    .card-info { flex: 1; overflow: hidden; }
    .bookmark-title { 
        font-size: 1rem; 
        font-weight: 600; 
        color: #333; 
        margin: 0 0 5px 0; 
        white-space: nowrap; 
        overflow: hidden; 
        text-overflow: ellipsis; 
    }
    .bookmark-desc { 
        font-size: 0.85rem; 
        color: #7f8c8d; 
        margin: 0; 
        display: -webkit-box; 
        -webkit-line-clamp: 2; 
        -webkit-box-orient: vertical; 
        overflow: hidden; 
    }
    
    /* [식품] 유통기한 리스트 스타일 */
    .item-list { list-style: none; padding: 0; margin: 0; }
    .item-list li { 
        padding: 0; 
        margin-bottom: 8px;
        border: 1px solid #e9ecef;
        border-radius: 10px;
        overflow: hidden;
        transition: all 0.2s ease;
        background: #ffffff;
    }
    .item-list li a {
        display: flex; 
        justify-content: space-between; 
        align-items: center;
        padding: 12px 16px;
        width: 100%;
        box-sizing: border-box;
    }
    .item-list li:hover {
        transform: translateX(5px);
        border-color: #3498db;
        background-color: #f0f7ff;
    }
    .d-day-badge { padding: 4px 10px; border-radius: 20px; font-size: 0.85rem; font-weight: 700; }
    .d-day-urgent { background-color: #fdeaea; color: #c0392b; }
    .d-day-warning { background-color: #fef5e7; color: #d35400; }
    
    /* [공통] 데이터 없음 상태 */
    .empty-state { 
        text-align: center; 
        color: #95a5a6; 
        padding: 30px 0; 
        font-size: 0.95rem; 
        display: flex; 
        align-items: center; 
        justify-content: center; 
        height: 100%; 
        border: 1px dashed #ced4da; 
        border-radius: 12px; 
        background: #fff;
    }
    
    /* [핫딜] 리스트 형식 스타일 */
    .hotdeal-list { display: flex; flex-direction: column; gap: 10px; }
    .hotdeal-card { 
        height: 75px !important; 
        padding: 8px 15px !important; 
        border-left: 4px solid #e74c3c !important; 
    }
    .hotdeal-badge { 
        background: #e74c3c; 
        color: white; 
        padding: 2px 8px; 
        border-radius: 4px; 
        font-size: 0.75rem; 
        font-weight: bold; 
        margin-bottom: 3px; 
        display: inline-block;
    }

    /* [하단] 퀵 버튼 영역 */
    .quick-access-container { 
        max-width: 1300px; 
        margin: 20px auto; 
        display: grid; 
        grid-template-columns: repeat(4, 1fr); 
        gap: 15px; 
        padding: 0 20px; 
    }
    .quick-btn { 
        display: flex; 
        flex-direction: column; 
        align-items: center; 
        background: #ffffff; 
        border: 1px solid #e9ecef; 
        border-radius: 16px; 
        padding: 20px 10px; 
        transition: all 0.2s; 
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05); 
    }
    .quick-btn:hover { background-color: #f0f7ff; border-color: #3498db; transform: translateY(-5px); }
    .quick-btn .icon { font-size: 1.8rem; margin-bottom: 8px; }
    .quick-btn span { font-size: 0.9rem; font-weight: 600; color: #495057; }
    
    /* 냉장고 파먹기 추천 그리드 */
    .fridge-recipe-grid { display: flex; gap: 15px; width: 100%; align-items: stretch; }
    .fridge-recipe-grid .bookmark-card { flex: 1; min-width: 0; }

    /* 리포트 하단 랭킹 요소 */
    .rank-item { display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px; }
    .rank-label { display: flex; align-items: center; gap: 8px; font-size: 0.9rem; color: #444; }
    .rank-dot { width: 8px; height: 8px; border-radius: 50%; }
    .rank-price { font-weight: 700; font-size: 0.9rem; color: #2c3e50; }
    
    /* 예산 프로그래스 바 */
    .budget-info { display: flex; justify-content: space-between; font-size: 0.85rem; margin-bottom: 8px; }
	.progress-track { 
	    background: #e9ecef; 
	    border-radius: 10px; 
	    height: 12px; /* 8px에서 12px로 두껍게 변경 */
	    overflow: hidden; 
	}
	.progress-fill { 
	    background: linear-gradient(90deg, #3498db, #2ecc71); 
	    height: 100%; 
	    transition: width 0.5s ease; 
	}

	.budget-progress-container .sub-text {
    margin-top: 12px;
    font-size: 0.8rem;
    color: #7f8c8d;
    text-align: center;
	}


	/* 예산 대비 지출 헤더 스타일 추가 */
	.budget-header {
	    font-size: 1.1rem;      /* 다른 섹션 제목(1.2rem)과 비슷하게 */
	    font-weight: 700;       /* 굵게 */
	    color: #2c3e50;         /* 제목 전용 진한 색상 */
	    margin-bottom: 12px;    /* 바(bar)와의 간격 */
	    display: block;         /* 한 줄을 다 차지하도록 */
	}
	
	/* 예산 정보 레이아웃 수정 */
	.budget-info { 
	    display: flex; 
	    justify-content: space-between; 
	    align-items: flex-end;  /* 글자 하단 정렬 */
	    margin-bottom: 12px; 
	}
	
	/* 퍼센트 숫자 강조 */
	.budget-percent {
	    font-size: 1.1rem;
	    font-weight: 800;
	    color: #3498db; /* 진행률 강조 색상 */
	}

    /* [반응형] 미디어 쿼리 */
    @media (max-width: 1100px) {
        .main-page-container { grid-template-columns: 1fr; }
        .report-sidebar { height: auto; }
    }
    @media (max-width: 768px) { 
        .summary-dashboard { grid-template-columns: 1fr; } 
        .quick-access-container { grid-template-columns: repeat(2, 1fr); gap: 10px;} 
    }
</style>
<title>메인페이지</title>
</head>
<body>

<%-- 데이터 합산 로직 --%>
<c:set var="finalIn" value="0" />
<c:set var="finalOut" value="0" />
<c:forEach items="${chartData}" var="cvo">
    <c:choose>
        <c:when test="${cvo.type == 'income'}"><c:set var="finalIn" value="${finalIn + cvo.amount}" /></c:when>
        <c:when test="${cvo.type == 'expense'}"><c:set var="finalOut" value="${finalOut + cvo.amount}" /></c:when>
    </c:choose>
</c:forEach>

<div class="main-page-container">
    
    <div class="summary-dashboard">
		<div class="dashboard-section" style="grid-column: 1 / span 2;">
		    <div class="section-header">
		        <span>냉장고 파먹기 추천 👨‍🍳</span>
		        <c:if test="${not empty ingredientNames}">
		            <span class="sub-text">임박한 <b>${ingredientNames}</b> 활용하기</span>
		        </c:if>
		    </div>
		    <c:choose>
		        <c:when test="${not empty login}">
		            <c:choose>
		                <c:when test="${not empty fridgeRecipes}">
		                    <div class="fridge-recipe-grid">
		                        <c:forEach var="fRec" items="${fridgeRecipes}">
		                            <a href="/recipes/view.do?no=${fRec.recipes_no}" class="bookmark-card">
		                                <img src="${fRec.recipes_img}" alt="레시피" class="recipe-img">
		                                <div class="card-info">
		                                    <h4 class="bookmark-title">${fRec.recipes_title}</h4>
		                                    <p class="bookmark-desc">${fRec.description}</p>
		                                </div>
		                            </a>
		                        </c:forEach>
		                    </div>
		                </c:when>
		                <c:otherwise><div class="empty-state">맞춤 레시피를 찾고 있어요! 🔍</div></c:otherwise>
		            </c:choose>
		        </c:when>
		        <c:otherwise><div class="empty-state">로그인 후 이용 가능합니다.</div></c:otherwise>
		    </c:choose>
		</div>

        <div class="dashboard-section">
            <div class="section-header">최근 북마크한 레시피</div>
            <c:choose>
                <c:when test="${not empty login && not empty recentRecipe}">
                    <a href="/recipes/view.do?no=${recentRecipe.recipes_no}" class="bookmark-card">
                        <img src="${recentRecipe.recipes_img}" alt="이미지" class="recipe-img">
                        <div class="card-info">
                            <h4 class="bookmark-title">${recentRecipe.recipes_title}</h4>
                            <p class="bookmark-desc">${recentRecipe.description}</p>
                        </div>
                    </a>
                </c:when>
                <c:otherwise><div class="empty-state">데이터가 없습니다.</div></c:otherwise>
            </c:choose>
        </div>

        <div class="dashboard-section">
            <div class="section-header">최근 북마크한 꿀팁</div>
            <c:choose>
                <c:when test="${not empty login && not empty recentTip}">
                    <a href="/board/view.do?no=${recentTip.boardNo}&inc=1" class="bookmark-card">
                        <div class="card-info">
                            <h4 class="bookmark-title">${recentTip.title}</h4>
                            <p class="bookmark-desc">클릭하여 원문을 확인해보세요!</p>
                        </div>
                    </a>
                </c:when>
                <c:otherwise><div class="empty-state">데이터가 없습니다.</div></c:otherwise>
            </c:choose>
        </div>

		<div class="dashboard-section">
		    <div class="section-header"><span>유통기한 임박 식품</span></div>
		    <c:choose>
		        <c:when test="${not empty login && not empty expiringFoods}">
		            <ul class="item-list">
		                <c:forEach var="food" items="${expiringFoods}">
		                    <li>
		                        <a href="/food/view.do?no=${food.no}" style="display: flex; justify-content: space-between; width: 100%; align-items: center;">
		                            <span class="item-name">${food.name}</span>
		                            <span class="d-day-badge ${fn:replace(food.dDay, 'D-', '') <= 3 ? 'd-day-urgent' : 'd-day-warning'}">
		                                ${food.dDay}
		                            </span>
		                        </a>
		                    </li>
		                </c:forEach>
		            </ul>
		        </c:when>
		        <c:otherwise>
		            <div class="empty-state">임박한 식품이 없습니다.</div>
		        </c:otherwise>
		    </c:choose>
		</div>

        <div class="dashboard-section">
            <div class="section-header">오늘의 추천 핫딜 🔥</div>
            <c:choose>
                <c:when test="${not empty topHotDeals}">
                    <div class="hotdeal-list">
                        <c:forEach var="deal" items="${topHotDeals}" varStatus="status">
                            <c:if test="${status.index < 3}"> <%-- 최대 3개 --%>
                                <a href="/hotdeal/view.do?dealId=${deal.dealId}" class="bookmark-card hotdeal-card">
                                    <div class="card-info">
                                        <span class="hotdeal-badge">HOT ${deal.discountRate}%</span>
                                        <h4 class="bookmark-title">${deal.title}</h4>
                                        <p class="bookmark-desc"><fmt:formatNumber value="${deal.price}" pattern="#,###" />원</p>
                                    </div>
                                </a>
                            </c:if>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise><div class="empty-state">핫딜 정보가 없습니다.</div></c:otherwise>
            </c:choose>
        </div>
    </div>

    <aside class="report-sidebar" onclick="location.href='/account/list.do'" style="cursor: pointer;">
        <div class="report-title">📊 이번 달 소비 리포트</div>
        
        <c:choose>
            <c:when test="${not empty login}">
                <div style="position: relative; height: 250px; margin-bottom: 20px;">
                    <canvas id="mainExpenseChart"></canvas>
                </div>
                
                <hr>
                
                <div class="p-2">
                    <div style="display: flex; justify-content: space-between; margin-bottom: 10px;">
                        <span class="text-muted small">총 수입</span>
                        <span class="income">+<fmt:formatNumber value="${finalIn}" pattern="#,###" />원</span>
                    </div>
                    <div style="display: flex; justify-content: space-between; margin-bottom: 10px;">
                        <span class="text-muted small">총 지출</span>
                        <span class="expense">-<fmt:formatNumber value="${finalOut}" pattern="#,###" />원</span>
                    </div>
                    <div style="display: flex; justify-content: space-between; border-top: 1px solid #eee; pt-2; margin-top: 10px; margin-bottom: 15px;">
                        <span style="font-weight: 700;">최종 잔액</span>
                        <span style="font-weight: 700; font-size: 1.1rem;" class="${finalIn - finalOut >= 0 ? 'income' : 'expense'}">
                            <fmt:formatNumber value="${finalIn - finalOut}" pattern="#,###" />원
                        </span>
                    </div>

                    <ul class="category-rank-list">
    				    <c:set var="rankCount" value="0" />
    				    <c:forEach items="${chartData}" var="vo">
    				        <c:if test="${vo.type == 'expense' && rankCount < 4}">
    				            <li class="rank-item">
    				                <div class="rank-label">
    				                    <span class="rank-dot" style="background-color: 
    				                        <c:choose>
    				                            <c:when test="${rankCount == 0}">#FF6384</c:when>
    				                            <c:when test="${rankCount == 1}">#36A2EB</c:when>
    				                            <c:when test="${rankCount == 2}">#FFCE56</c:when>
    				                            <c:otherwise>#4BC0C0</c:otherwise>
    				                        </c:choose>"></span>
    				                    ${vo.category}
    				                </div>
    				                <span class="rank-price"><fmt:formatNumber value="${vo.amount}" pattern="#,###" />원</span>
    				            </li>
    				            <c:set var="rankCount" value="${rankCount + 1}" />
    				        </c:if>
    				    </c:forEach>
    				</ul>
				
					<div class="budget-progress-container">
					    <c:set var="budgetGoal" value="1000000" />
					    <c:set var="usagePercent" value="${(finalOut / budgetGoal) * 100}" />
					    
					    <div class="budget-info">
					        <span class="budget-header">예산 대비 지출</span>
					        <span class="budget-percent"><fmt:formatNumber value="${usagePercent}" maxFractionDigits="1"/>%</span>
					    </div>
					
					    <div class="progress-track">
					        <div class="progress-fill" style="width: ${usagePercent > 100 ? 100 : usagePercent}%"></div>
					    </div>
					</div>
            </c:when>
            <c:otherwise><div class="empty-state">로그인 후 확인 가능합니다.</div></c:otherwise>
        </c:choose>
    </aside>
</div>

<div class="quick-access-container">
    <a href="javascript:checkLogin('/food/writeForm.do')" class="quick-btn"><div class="icon">🍎</div><span>식품 등록</span></a>
    <a href="javascript:checkLogin('/shopping/list.do')" class="quick-btn"><div class="icon">🛒</div><span>장보기 목록</span></a>
    <a href="javascript:checkLogin('/account/writeForm.do')" class="quick-btn"><div class="icon">💸</div><span>수입/지출 등록</span></a>
    <a href="javascript:checkLogin('/recipes/list.do')" class="quick-btn"><div class="icon">🍳</div><span>레시피 찾기</span></a>
</div>

<script>
    function checkLogin(url) {
        if (${not empty login}) { location.href = url; } 
        else { alert("로그인 후 이용 가능합니다."); location.href = "/member/loginForm.do"; }
    }

    $(function() {
        const labels = [];
        const data = [];
        let totalExpense = 0;

        <c:forEach items="${chartData}" var="vo">
            if("${vo.type}" === "expense") {
                labels.push("${vo.category}");
                data.push(${vo.amount});
                totalExpense += ${vo.amount};
            }
        </c:forEach>

        const ctx = document.getElementById('mainExpenseChart');
        if(ctx) {
            if (labels.length === 0) {
                const context = ctx.getContext('2d');
                context.font = "14px Arial"; context.textAlign = "center";
                context.fillText("지출 내역이 없습니다.", ctx.width/2, ctx.height/2);
            } else {
                new Chart(ctx, {
                    type: 'doughnut',
                    data: {
                        labels: labels,
                        datasets: [{
                            data: data,
                            backgroundColor: ['#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0', '#9966FF', '#FF9F40', '#C9CBCF'],
                            hoverOffset: 15, borderWidth: 2
                        }]
                    },
                    options: {
                        responsive: true, maintainAspectRatio: false, cutout: '75%',
                        plugins: {
                            legend: { display: false }, // 리포트에서는 깔끔하게 범례 숨김
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
        }
        // 핫딜 슬라이더 JS 로직 삭제됨
    });
</script>
</body>
</html>