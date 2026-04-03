<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<style>
    /* 기존 스타일 유지 */
    .summary-dashboard { max-width: 900px; margin: 0 auto; background-color: #ffffff; border-radius: 20px; box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08); padding: 30px; display: grid; grid-template-columns: 1fr 1fr; gap: 24px; }
    .dashboard-section { background-color: #f8f9fa; border-radius: 16px; padding: 20px; display: flex; flex-direction: column; }
    .section-header { font-size: 1.2rem; font-weight: 700; color: #2c3e50; margin-bottom: 16px; }
    a { text-decoration: none; color: inherit; }
    .bookmark-card { display: flex; align-items: center; gap: 15px; background: #ffffff; border: 1px solid #e9ecef; border-radius: 12px; padding: 12px; transition: all 0.2s ease-in-out; }
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
    .empty-state { text-align: center; color: #95a5a6; padding: 30px 0; font-size: 0.95rem; justify-content: center; }
    .quick-access-container { max-width: 900px; margin: 20px auto 0; display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; }
    .quick-btn { display: flex; flex-direction: column; align-items: center; background: #ffffff; border: 1px solid #e9ecef; border-radius: 16px; padding: 24px 16px; transition: all 0.2s; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05); }
    .quick-btn:hover { background-color: #f0f7ff; border-color: #3498db; transform: translateY(-5px); }
    .quick-btn .icon { font-size: 2rem; margin-bottom: 10px; }
    @media (max-width: 768px) { .summary-dashboard, .quick-access-container { grid-template-columns: 1fr; } }
</style>
</head>
<body>

<div class="summary-dashboard">
    <!-- 레시피 -->
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
                    <c:otherwise><div class="bookmark-card empty-state">북마크한 레시피가 없습니다.</div></c:otherwise>
                </c:choose>
            </c:when>
            <c:otherwise><div class="bookmark-card empty-state">로그인 후 이용 가능합니다.</div></c:otherwise>
        </c:choose>
    </div>

    <!-- 꿀팁 -->
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
                    <c:otherwise><div class="bookmark-card empty-state">북마크한 꿀팁이 없습니다.</div></c:otherwise>
                </c:choose>
            </c:when>
            <c:otherwise><div class="bookmark-card empty-state">로그인 후 이용 가능합니다.</div></c:otherwise>
        </c:choose>
    </div>

    <!-- 유통기한 -->
    <div class="dashboard-section">
        <div class="section-header">유통기한 임박 식품 <span class="sub-text">D-7 이하</span></div>
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
                    <c:otherwise><div class="empty-state">임박한 식품이 없습니다. 👍</div></c:otherwise>
                </c:choose>
            </c:when>
            <c:otherwise><div class="empty-state">로그인 후 이용 가능합니다.</div></c:otherwise>
        </c:choose>
    </div>

    <!-- 장보기 -->
    <div class="dashboard-section">
        <div class="section-header">장보기 예정 <span class="sub-text">최근 등록순</span></div>
        <c:choose>
            <c:when test="${not empty login}">
                <c:choose>
                    <c:when test="${not empty shoppingList}">
                        <ul class="item-list">
                            <c:forEach var="item" items="${shoppingList}">
                                <li>
                                    <div class="shopping-status">
                                        <div class="check-circle"></div>
                                        <span class="item-name">${item.name}</span>
                                    </div>
                                </li>
                            </c:forEach>
                        </ul>
                    </c:when>
                    <c:otherwise><div class="empty-state">구매 예정인 항목이 없습니다.</div></c:otherwise>
                </c:choose>
            </c:when>
            <c:otherwise><div class="empty-state">로그인 후 이용 가능합니다.</div></c:otherwise>
        </c:choose>
    </div>
</div>

<!-- 자주 사용하는 메뉴 -->
<div class="quick-access-container">
    <a href="javascript:checkLogin('/recipes/list.do')" class="quick-btn">
        <div class="icon">🍳</div><span>레시피 찾기</span>
    </a>
    <a href="javascript:checkLogin('/board/list.do')" class="quick-btn">
        <div class="icon">💡</div><span>꿀팁 게시판</span>
    </a>
    <a href="javascript:checkLogin('/shopping/list.do')" class="quick-btn">
        <div class="icon">🛒</div><span>장보기 목록</span>
    </a>
</div>

<script>
    function checkLogin(url) {
        var isLoggedIn = ${not empty login};
        if (isLoggedIn) {
            location.href = url;
        } else {
            alert("로그인 후 이용 가능한 서비스입니다.");
            location.href = "/member/loginForm.do";
        }
    }
</script>

</body>
</html>
