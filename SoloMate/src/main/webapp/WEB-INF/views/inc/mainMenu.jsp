<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
/* 1. 사이드바 전체 설정 */
.sidebar {
    width: 250px;
    height: 100vh;
    position: fixed; /* 화면 좌측 고정 */
    top: 0;
    left: 0;
    background-color: #212529; /* 다크 테마 */
    padding-top: 20px;
    z-index: 1000;
    overflow-y: auto;
    display: flex;
    flex-direction: column;
}

/* 2. 브랜드 로고 */
.sidebar .navbar-brand {
    display: block;
    text-align: center;
    font-weight: bold;
    font-size: 1.5rem;
    margin-bottom: 30px;
    padding: 10px;
    text-decoration: none;
}

/* 3. 메뉴 리스트 */
.sidebar .nav-item {
    width: 100%;
}

.sidebar .nav-link {
    color: rgba(255, 255, 255, 0.7) !important;
    padding: 12px 25px;
    transition: all 0.3s;
    font-size: 0.95rem;
}

.sidebar .nav-link:hover {
    background-color: rgba(255, 255, 255, 0.1);
    color: white !important;
    padding-left: 35px; /* 호버 시 살짝 밀리는 포인트 효과 */
}

/* 4. 하단 유저 정보 영역 */
.sidebar-footer {
    border-top: 1px solid rgba(255, 255, 255, 0.1);
    margin-top: auto; /* 하단으로 밀어냄 */
    padding: 20px 10px;
    background-color: rgba(0, 0, 0, 0.2);
}

/* 5. 본문 영역을 밀어주는 핵심 스타일 */
/* 이 스타일은 사이드바가 포함된 레이아웃에서 본문을 가리지 않게 합니다 */
body {
    margin-left: 250px; /* 사이드바 너비만큼 전체 본문을 오른쪽으로 이동 */
    background-color: #f8f9fa; /* 배경색 대비 */
}

/* 모바일 등 작은 화면에서는 상단바로 돌아가거나 숨김 처리 가능 */
@media (max-width: 992px) {
    .sidebar { display: none; }
    body { margin-left: 0; }
}
</style>

<nav class="sidebar shadow">
    <a class="navbar-brand text-white" href="/">SoloMate Co.</a>

    <ul class="nav flex-column mb-auto">
        <li class="nav-item"><a class="nav-link" href="/food/list.do">🍎 식품 관리</a></li>
        <li class="nav-item"><a class="nav-link" href="/folder/list.do">📁 식품 폴더 관리</a></li>
        <li class="nav-item"><a class="nav-link" href="/shopping/list.do">🛒 장보기 계획</a></li>
        <li class="nav-item"><a class="nav-link" href="/hotdeal/list.do">🔥 핫딜 관리</a></li>
        <li class="nav-item"><a class="nav-link" href="/account/list.do">💸 가계부</a></li>
        <li class="nav-item"><a class="nav-link" href="/recipes/list.do">📖 레시피 아카이브</a></li>
        <li class="nav-item"><a class="nav-link" href="/board/list.do">💡 꿀팁 아카이브</a></li>

        <c:if test="${!empty login && login.gradeNo == 9 }">
            <hr class="mx-3 text-secondary">
            <li class="nav-item"><a class="nav-link text-warning" href="/adminHotDeal/list.do">⚙️ 관리자 핫딜</a></li>
            <li class="nav-item"><a class="nav-link text-warning" href="/adminCategory/list.do">⚙️ 카테고리 관리</a></li>
            <li class="nav-item"><a class="nav-link text-warning" href="/member/list.do">⚙️ 회원 관리</a></li>
        </c:if>
    </ul>

    <div class="sidebar-footer">
        <ul class="nav flex-column">
            <c:if test="${empty login }">
                <li class="nav-item"><a class="nav-link btn btn-outline-light btn-sm mx-3 mb-2" href="/member/loginForm.do">로그인</a></li>
                <li class="nav-item"><a class="nav-link btn btn-outline-secondary btn-sm mx-3" href="/member/writeForm.do">회원가입</a></li>
            </c:if>
            <c:if test="${!empty login }">
                <li class="nav-item px-3 mb-3 text-white-50 small text-center">
                    <span class="text-white fw-bold">${login.name}</span>님 (${login.gradeName})
                </li>
                <li class="nav-item"><a class="nav-link py-1 small text-center" href="/member/changePw.do">비밀번호 변경</a></li>
                <li class="nav-item"><a class="nav-link py-1 small text-center" href="/member/logout.do">로그아웃</a></li>
                <li class="nav-item"><a class="nav-link py-1 small text-danger text-center" href="/member/deleteForm.do">회원 탈퇴</a></li>
            </c:if>
        </ul>

    </div>
</nav>