<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레시피 상세보기</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style type="text/css">
/* 리스트 페이지와 동일한 베이스 레이아웃 */
.admin-page {
    padding: 30px;
    background-color: #fff;
}

.admin-card {
    background: #fff;
    border-radius: 18px;
    padding: 30px;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
}

.top-bar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 30px;
    border-bottom: 2px solid #f8f9fc;
    padding-bottom: 20px;
}

.top-title {
    font-size: 28px;
    font-weight: 800;
    color: #111;
}

/* 상세 정보 그리드 레이아웃 */
.info-section {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 20px;
    margin-bottom: 30px;
}

.info-item {
    padding: 15px;
    background: #f8f9fc;
    border-radius: 12px;
}

.info-label {
    font-size: 13px;
    font-weight: 700;
    color: #6b7280;
    margin-bottom: 5px;
    display: block;
}

.info-value {
    font-size: 16px;
    font-weight: 600;
    color: #111827;
}

/* 설명 및 본문 스타일 */
.desc-box {
    padding: 20px;
    background: #fdf2f2; /* 살짝 붉은 기가 도는 포인트 컬러 */
    border-radius: 12px;
    margin-bottom: 30px;
    border-left: 5px solid #c62828;
}

.content-area {
    display: grid;
    grid-template-columns: 2fr 1fr;
    gap: 30px;
}

.recipes-content-body {
    font-size: 16px;
    line-height: 1.8;
    color: #374151;
    white-space: pre-wrap;
    min-height: 300px;
}

.img-side {
    text-align: center;
}

.recipe-img {
    width: 100%;
    border-radius: 15px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    margin-bottom: 15px;
}

/* 버튼 스타일 (리스트 페이지 스타일 이식) */
.btn-main, .btn-sub, .btn-danger-custom {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    height: 48px;
    padding: 0 24px;
    border-radius: 12px;
    border: none;
    font-size: 15px;
    font-weight: 700;
    text-decoration: none;
    cursor: pointer;
    transition: 0.2s;
}

.btn-main { background: #111827; color: #fff; }
.btn-sub { background: #eef0f4; color: #333; }
.btn-danger-custom { background: #fee2e2; color: #c62828; }

.btn-main:hover { background: #1f2937; color: #fff; }
.btn-sub:hover { background: #e5e7eb; color: #333; }

/* 북마크 버튼 특수 스타일 */
.bookmark-area {
    display: flex;
    align-items: center;
    gap: 8px;
}

.badge-bookmark {
    padding: 8px 15px;
    border-radius: 10px;
    background-color: #fdecec;
    color: #c62828;
    font-weight: 700;
    border: none;
}
</style>

<script type="text/javascript">
$(function(){
	// [기존 로직 유지] 삭제 버튼 이벤트
	$("#deleteBtn").click(function(){
		if(confirm("정말로 이 레시피를 삭제하시겠습니까?")) {
			$("#deleteForm").submit();
		}
	});

	// [기존 로직 유지] 북마크 버튼 이벤트
	$(".bookmarkBtn").click(function(){
		let loginId = "${login.id}";

		if(!loginId || loginId === "null"){
			alert("로그인이 필요한 서비스입니다.");
			location = "${pageContext.request.contextPath}/member/loginForm.do";
			return;
		}

		if($(this).hasClass("is-booked")) {
			if(confirm("북마크를 해제하시겠습니까?")) $("#bookmarkDeleteForm").submit();
		} else {
			$("#bookmarkWriteForm").submit();
		}
	});
});
</script>
</head>
<body>

<div class="admin-page">
    <div class="admin-card">
        
        <div class="top-bar">
            <div class="top-title">${vo.recipes_title}</div>
            <div class="bookmark-area">
                <c:choose>
                    <c:when test="${vo.bookmarked == 1}">
                        <button type="button" class="badge-bookmark bookmarkBtn is-booked">★ 북마크 중</button>
                    </c:when>
                    <c:otherwise>
                        <button type="button" class="btn-sub bookmarkBtn" style="padding: 8px 15px;">☆ 북마크 하기</button>
                    </c:otherwise>
                </c:choose>
                <span class="fw-bold" style="color: #c62828;">${vo.recipes_bookmark}</span>
            </div>
        </div>

        <div class="info-section">
            <div class="info-item">
                <span class="info-label">레시피 번호</span>
                <div class="info-value">${vo.recipes_no}</div>
            </div>
            <div class="info-item">
                <span class="info-label">작성자</span>
                <div class="info-value">${vo.name}</div>
            </div>
            <div class="info-item">
                <span class="info-label">작성일</span>
                <div class="info-value">${vo.recipes_writeDate}</div>
            </div>
            <div class="info-item">
                <span class="info-label">조리 시간 / 난이도</span>
                <div class="info-value">${vo.recipes_time}분 / ${vo.recipes_level}</div>
            </div>
        </div>

        <div class="info-item mb-4" style="background: #f0fdf4;">
            <span class="info-label" style="color: #166534;">필요한 재료</span>
            <div class="info-value" style="color: #166534; font-size: 18px;">${vo.food}</div>
        </div>

        <div class="desc-box">
            <span class="info-label" style="color: #c62828;">레시피 한줄 팁</span>
            <div class="fw-bold" style="font-size: 18px;">"${vo.description}"</div>
        </div>

        <div class="content-area">
            <div class="pe-4 border-end">
                <h5 class="fw-bold mb-4">👨‍🍳 조리 순서</h5>
                <div class="recipes-content-body">${vo.recipes_content}</div>
            </div>
            
            <div class="img-side">
                <h5 class="fw-bold mb-4">완성 이미지</h5>
                <c:choose>
                    <c:when test="${not empty vo.recipes_img}">
                        <img src="${vo.recipes_img}" class="recipe-img">
                    </c:when>
                    <c:otherwise>
                        <img src="https://via.placeholder.com/400x300?text=No+Image" class="recipe-img">
                    </c:otherwise>
                </c:choose>
                
                <c:if test="${login.id == vo.id}">
                    <a href="imageChangeForm.do?no=${vo.recipes_no}" class="btn-sub w-100" style="height: 40px; font-size: 13px;">이미지 변경</a>
                </c:if>
            </div>
        </div>

        <div class="d-flex justify-content-end gap-2 mt-5 pt-4 border-top">
            <c:if test="${login.id == vo.id}">
                <a href="updateForm.do?no=${vo.recipes_no}&perPageNum=${pageObject.perPageNum}" class="btn-main">수정하기</a>
                <button type="button" id="deleteBtn" class="btn-danger-custom">삭제하기</button>
            </c:if>
            <a href="list.do?${pageObject.pageQuery}" class="btn-sub">목록으로</a>
        </div>

    </div> 
</div>

<form id="deleteForm" action="delete.do" method="post">
    <input type="hidden" name="no" value="${vo.recipes_no}">
    <input type="hidden" name="perPageNum" value="${pageObject.perPageNum}">
</form>

<form id="bookmarkWriteForm" action="${pageContext.request.contextPath}/recipesbookmark/write.do" method="post">
    <input type="hidden" name="no" value="${vo.recipes_no}">
    <input type="hidden" name="page" value="${pageObject.page}">
    <input type="hidden" name="perPageNum" value="${pageObject.perPageNum}">
    <input type="hidden" name="action" value="view">
</form>

<form id="bookmarkDeleteForm" action="${pageContext.request.contextPath}/recipesbookmark/delete.do" method="post">
    <input type="hidden" name="no" value="${vo.recipes_no}">
    <input type="hidden" name="page" value="${pageObject.page}">
    <input type="hidden" name="perPageNum" value="${pageObject.perPageNum}">
    <input type="hidden" name="action" value="view">
</form>

</body>
</html>