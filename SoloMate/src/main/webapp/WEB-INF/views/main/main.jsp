<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<style>
    /* 기존 스타일 유지 */
    .summary-dashboard { max-width: 900px; margin: 0 auto; background-color: #ffffff; border-radius: 20px; box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08); padding: 30px; display: grid; grid-template-columns: 1fr 1fr; gap: 24px; }
    .dashboard-section { background-color: #f8f9fa; border-radius: 16px; padding: 20px; display: flex; flex-direction: column; }
    .section-header { font-size: 1.2rem; font-weight: 700; color: #2c3e50; margin-bottom: 16px; display: flex; justify-content: space-between; align-items: center;}
    .sub-text { font-size: 0.8rem; color: #7f8c8d; font-weight: normal; }
    a { text-decoration: none; color: inherit; }
    .bookmark-card { display: flex; align-items: center; gap: 15px; background: #ffffff; border: 1px solid #e9ecef; border-radius: 12px; padding: 12px; transition: all 0.2s ease-in-out; height: 100%;}
    .bookmark-card:hover { transform: translateY(-3px); box-shadow: 0 6px 16px rgba(0, 0, 0, 0.06); border-color: #3498db; }
    .recipe-img { width: 70px; height: 70px; border-radius: 8px; object-fit: cover; background-color: #eee; }
    .card-info { flex: 1; overflow: hidden; }
    .bookmark-title { font-size: 1rem; font-weight: 600; color: #333; margin: 0 0 5px 0; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
    .bookmark-desc { font-size: 0.85rem; color: #7f8c8d; margin: 0; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; }
    
    .item-list { list-style: none; padding: 0; margin: 0; }
    .item-list li { display: flex; justify-content: space-between; align-items: center; background: #ffffff; padding: 12px 16px; border-radius: 10px; margin-bottom: 8px; border: 1px solid #e9ecef; }
    .d-day-badge { padding: 4px 10px; border-radius: 20px; font-size: 0.85rem; font-weight: 700; }
    .d-day-urgent { background-color: #fdeaea; color: #c0392b; }
    .d-day-warning { background-color: #fef5e7; color: #d35400; }
    .empty-state { text-align: center; color: #95a5a6; padding: 30px 0; font-size: 0.95rem; display: flex; align-items: center; justify-content: center; height: 100%; border: 1px dashed #ced4da; border-radius: 12px; background: #fff;}
    
    /* 핫딜 & 가계부 강조 스타일 추가 */
    .expense-amount { font-size: 1.5rem; font-weight: 800; color: #e74c3c; text-align: center; padding: 15px 0; }
    .hotdeal-badge { background: #e74c3c; color: white; padding: 2px 8px; border-radius: 4px; font-size: 0.75rem; font-weight: bold; margin-bottom: 5px; display: inline-block;}

    /* 퀵 액세스 컨테이너 그리드 4열로 변경 */
    .quick-access-container { max-width: 900px; margin: 20px auto 0; display: grid; grid-template-columns: repeat(4, 1fr); gap: 15px; }
    .quick-btn { display: flex; flex-direction: column; align-items: center; background: #ffffff; border: 1px solid #e9ecef; border-radius: 16px; padding: 20px 10px; transition: all 0.2s; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05); }
    .quick-btn:hover { background-color: #f0f7ff; border-color: #3498db; transform: translateY(-5px); }
    .quick-btn .icon { font-size: 1.8rem; margin-bottom: 8px; }
    .quick-btn span { font-size: 0.9rem; font-weight: 600; color: #495057; }
    
    @media (max-width: 768px) { 
        .summary-dashboard { grid-template-columns: 1fr; } 
        .quick-access-container { grid-template-columns: repeat(2, 1fr); gap: 10px;} 
    }
    
/* 1. 슬라이더 전체를 감싸는 래퍼 */
    .hotdeal-wrapper {
        position: relative;
        width: 100%;
        flex: 1; /* 🔥 추가: 회색 박스의 남은 세로 공간을 모두 차지하도록 늘림 */
        display: flex;
        flex-direction: column;
    }
    
    /* 2. 실제 슬라이드가 움직이는 영역 */
    .hotdeal-slider-container {
        width: 100%;
        overflow: hidden; 
        position: relative;
        flex: 1; /* 🔥 추가: 래퍼의 높이에 맞춰 꽉 차게 늘림 */
    }
    .hotdeal-slider-track {
        display: flex;
        transition: transform 0.5s ease-in-out;
        height: 100%; /* 🔥 추가: 트랙의 높이도 100%로 맞춤 */
    }
    .hotdeal-slide {
        flex: 0 0 100%;
        box-sizing: border-box;
        height: 100%; /* 🔥 추가: 개별 슬라이드의 높이도 100%로 맞춤 */
        padding: 3px 0; /* 카드가 위로 움직일 때(hover) 그림자가 잘리지 않도록 미세한 여백 추가 */
    }

    /* 3. 화살표 버튼 디자인 (기존 유지) */
    .slider-btn {
        position: absolute;
        top: 50%;
        transform: translateY(-50%);
        background-color: transparent;
        color: #bdc3c7; 
        border: none;
        cursor: pointer;
        z-index: 10;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 18px; 
        width: 20px; 
        transition: color 0.2s;
        padding: 0;
    }
    .slider-btn:hover { color: #e74c3c; } 
    
    .prev-btn { left: -20px; }
    .next-btn { right: -20px; }
    
</style>
<title>메인페이지</title>
</head>
<body>

<div class="summary-dashboard">
    <div class="dashboard-section">
        <div class="section-header">최근 북마크한 레시피</div>
        <c:choose>
            <c:when test="${not empty login}">
                <c:choose>
                    <c:when test="${not empty recentRecipe}">
                        <a href="/recipes/view.do?no=${recentRecipe.recipes_no}" class="bookmark-card">
                            <img src="${recentRecipe.recipes_img}" alt="이미지" class="recipe-img">
                            <div class="card-info">
                                <h4 class="bookmark-title">${recentRecipe.recipes_title}</h4>
                                <p class="bookmark-desc">${recentRecipe.description}</p>
                            </div>
                        </a>
                    </c:when>
                    <c:otherwise><div class="empty-state">북마크한 레시피가 없습니다.</div></c:otherwise>
                </c:choose>
            </c:when>
            <c:otherwise><div class="empty-state">로그인 후 이용 가능합니다.</div></c:otherwise>
        </c:choose>
    </div>

    <div class="dashboard-section">
        <div class="section-header">최근 북마크한 꿀팁</div>
        <c:choose>
            <c:when test="${not empty login}">
                <c:choose>
                    <c:when test="${not empty recentTip}">
                        <a href="/board/view.do?no=${recentTip.boardNo}&inc=1" class="bookmark-card">
                            <div class="card-info">
                                <h4 class="bookmark-title">${recentTip.title}</h4>
                                <p class="bookmark-desc">클릭하여 꿀팁 원문을 확인해보세요!</p>
                            </div>
                        </a>
                    </c:when>
                    <c:otherwise><div class="empty-state">북마크한 꿀팁이 없습니다.</div></c:otherwise>
                </c:choose>
            </c:when>
            <c:otherwise><div class="empty-state">로그인 후 이용 가능합니다.</div></c:otherwise>
        </c:choose>
    </div>

    <div class="dashboard-section">
        <div class="section-header"><span>유통기한 임박 식품</span> <span class="sub-text">D-7 이하</span></div>
        <c:choose>
            <c:when test="${not empty login}">
                <c:choose>
                    <c:when test="${not empty expiringFoods}">
                        <ul class="item-list">
                            <c:forEach var="food" items="${expiringFoods}">
                                <li>
                                    <span class="item-name">${food.name}</span>
                                    <span class="d-day-badge ${fn:replace(food.dDay, 'D-', '') <= 3 ? 'd-day-urgent' : 'd-day-warning'}">
                                        ${food.dDay}
                                    </span>
                                </li>
                            </c:forEach>
                        </ul>
                    </c:when>
                    <c:otherwise><div class="empty-state border-0">임박한 식품이 없습니다. 👍</div></c:otherwise>
                </c:choose>
            </c:when>
            <c:otherwise><div class="empty-state">로그인 후 이용 가능합니다.</div></c:otherwise>
        </c:choose>
    </div>

    <div class="dashboard-section">
        <div class="section-header"><span>장보기 예정</span> <span class="sub-text">최근 등록순</span></div>
        <c:choose>
            <c:when test="${not empty login}">
                <c:choose>
                    <c:when test="${not empty shoppingList}">
                        <ul class="item-list">
                            <c:forEach var="item" items="${shoppingList}">
                                <li>
                                    <div class="shopping-status">
                                        <span class="item-name">◽ ${item.name}</span>
                                    </div>
                                </li>
                            </c:forEach>
                        </ul>
                    </c:when>
                    <c:otherwise><div class="empty-state border-0">구매 예정인 항목이 없습니다.</div></c:otherwise>
                </c:choose>
            </c:when>
            <c:otherwise><div class="empty-state">로그인 후 이용 가능합니다.</div></c:otherwise>
        </c:choose>
    </div>

    <div class="dashboard-section">
        <div class="section-header">이번 달 지출 현황</div>
        <c:choose>
            <c:when test="${not empty login}">
                <a href="/account/list.do" class="bookmark-card" style="flex-direction: column; justify-content: center; align-items: center;">
                    <span class="sub-text">현재까지 총 지출액</span>
					<div class="expense-amount">
					    <c:choose>
					        <c:when test="${not empty totalExpense}">
					            <fmt:formatNumber value="${totalExpense}" pattern="#,###" />원
					        </c:when>
					        <c:otherwise>0원</c:otherwise>
					    </c:choose>
					</div>
                </a>
            </c:when>
            <c:otherwise><div class="empty-state">로그인 후 이용 가능합니다.</div></c:otherwise>
        </c:choose>
    </div>

	<div class="dashboard-section">
        <div class="section-header">오늘의 추천 핫딜 🔥</div>
        <c:choose>
            <c:when test="${not empty topHotDeals}">
                <div class="hotdeal-wrapper">
                    
                    <button class="slider-btn prev-btn" id="prevBtn">&#10094;</button>
                    <button class="slider-btn next-btn" id="nextBtn">&#10095;</button>

                    <div class="hotdeal-slider-container">
                        <div class="hotdeal-slider-track" id="hotdeal-track">
                            <c:forEach var="deal" items="${topHotDeals}">
                                <div class="hotdeal-slide">
                                    <a href="/hotdeal/view.do?dealId=${deal.dealId}" class="bookmark-card">
                                        <div class="card-info">
                                            <span class="hotdeal-badge">HOT ${deal.discountRate}%</span>
                                            <h4 class="bookmark-title">${deal.title}</h4>
                                            <p class="bookmark-desc"><fmt:formatNumber value="${deal.price}" pattern="#,###" />원 / 무료배송</p>
                                        </div>
                                    </a>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                    
                </div> </c:when>
            <c:otherwise><div class="empty-state">현재 진행 중인 핫딜이 없습니다.</div></c:otherwise>
        </c:choose>
    </div>
    
    
</div>

<div class="quick-access-container">
    <a href="javascript:checkLogin('/food/writeForm.do')" class="quick-btn">
        <div class="icon">🍎</div><span>식품 등록</span>
    </a>
    <a href="javascript:checkLogin('/shopping/list.do')" class="quick-btn">
        <div class="icon">🛒</div><span>장보기 목록</span>
    </a>
    <a href="javascript:checkLogin('/account/writeForm.do')" class="quick-btn">
        <div class="icon">💸</div><span>지출 내역 추가</span>
    </a>
    <a href="javascript:checkLogin('/recipes/list.do')" class="quick-btn">
        <div class="icon">🍳</div><span>레시피 찾기</span>
    </a>
</div>

<script>
    // 기존 로그인 체크 함수
    function checkLogin(url) {
        var isLoggedIn = ${not empty login};
        if (isLoggedIn) {
            location.href = url;
        } else {
            alert("로그인 후 이용 가능한 서비스입니다.");
            location.href = "/member/loginForm.do";
        }
    }

    // 핫딜 슬라이드 (자동 10초 + 좌우 클릭)
    document.addEventListener("DOMContentLoaded", function() {
        const track = document.getElementById('hotdeal-track');
        if (!track) return; 

        const slides = track.querySelectorAll('.hotdeal-slide');
        if (slides.length <= 1) return; // 슬라이드가 1개면 버튼과 자동넘김 모두 불필요

        const prevBtn = document.getElementById('prevBtn');
        const nextBtn = document.getElementById('nextBtn');

        let currentIndex = 0;
        const totalSlides = slides.length;
        let slideTimer;

        // 특정 인덱스로 슬라이드를 이동시키는 함수
        function moveToSlide(index) {
            currentIndex = index;
            
            // 맨 끝에서 오른쪽을 누르면 처음으로, 처음에서 왼쪽을 누르면 맨 끝으로
            if (currentIndex < 0) currentIndex = totalSlides - 1;
            if (currentIndex >= totalSlides) currentIndex = 0;

            const movePercent = -(currentIndex * 100);
            track.style.transform = 'translateX(' + movePercent + '%)';
        }

        // 다음 슬라이드로 넘어가는 함수
        function nextSlide() {
            moveToSlide(currentIndex + 1);
        }

        // 10초(10000ms) 타이머 시작 함수
        function startTimer() {
            slideTimer = setInterval(nextSlide, 10000);
        }

        // 사용자가 클릭했을 때 타이머가 겹치지 않게 초기화 후 다시 시작
        function resetTimer() {
            clearInterval(slideTimer);
            startTimer();
        }

        // 왼쪽 화살표 클릭 시
        if (prevBtn) {
            prevBtn.addEventListener('click', function() {
                moveToSlide(currentIndex - 1);
                resetTimer();
            });
        }

        // 오른쪽 화살표 클릭 시
        if (nextBtn) {
            nextBtn.addEventListener('click', function() {
                nextSlide();
                resetTimer();
            });
        }

        // 페이지 로드 시 최초 10초 타이머 시작
        startTimer();
    }); // <-- 중복되어 있던 괄호를 삭제하고 하나만 남겨두었습니다.
</script>

</body>
</html>