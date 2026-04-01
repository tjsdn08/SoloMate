<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레시피 상세보기</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style type="text/css">
	.data-block { border: 1px solid #ddd; margin-bottom: 20px; background-color: #fff; }
	.label-col { background-color: #f8f9fa; font-weight: bold; text-align: center; vertical-align: middle; border-right: 1px solid #ddd; }
	.value-col { padding: 10px 15px; vertical-align: middle; }
	.recipes-content { white-space: pre-wrap; padding: 20px; min-height: 300px; }
	.recipe-img-container { text-align: center; padding: 20px; }
	.recipe-img { max-width: 100%; height: auto; border-radius: 8px; }
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(function(){
	// 삭제 버튼 이벤트
	$("#deleteBtn").click(function(){
		if(confirm("정말로 이 레시피를 삭제하시겠습니까?")) {
			$("#deleteForm").submit();
		}
	});

	$(".bookmarkBtn").click(function(){
		let loginId = "${login.id}";

		if(!loginId || loginId === "null"){
			alert("로그인이 필요한 서비스입니다.");
			location = "/member/loginForm.do";
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

<div class="container mt-5 mb-5">
    <div class="card p-3 mb-4 shadow-sm">
        <h2 class="text-center m-0">레시피 상세보기</h2>
    </div>

    <div class="card shadow-sm mb-4">
        <div class="row m-0 border-bottom">
            <div class="col-md-1 label-col p-2">번호</div>
            <div class="col-md-1 value-col text-center">${vo.recipes_no}</div>
            
            <div class="col-md-2 label-col p-2">레시피 이름</div>
            <div class="col-md-2 value-col fw-bold text-success">${vo.recipes_title}</div>
            
            <div class="col-md-1 label-col p-2">작성자</div>
            <div class="col-md-1 value-col">${vo.name}</div>
            
            <div class="col-md-1 label-col p-2">날짜</div>
            <div class="col-md-1 value-col text-center text-muted">${vo.recipes_writeDate}</div>
            
            <div class="col-md-1 label-col p-2">북마크</div>
            <div class="col-md-1 value-col text-center d-flex align-items-center justify-content-center gap-2">
                <c:choose>
                    <c:when test="${vo.bookmarked == 1}">
                        <button type="button" class="btn btn-dark btn-sm bookmarkBtn is-booked">★</button>
                    </c:when>
                    <c:otherwise>
                        <button type="button" class="btn btn-outline-dark btn-sm bookmarkBtn">☆</button>
                    </c:otherwise>
                </c:choose>
                <span class="fw-bold">${vo.recipes_bookmark}</span>
            </div>
        </div>
        <div class="row m-0">
            <div class="col-md-2 label-col p-2">재료</div>
            <div class="col-md-5 value-col text-muted">${vo.food}</div>
            <div class="col-md-1 label-col p-2">시간</div>
            <div class="col-md-1 value-col text-center">${vo.recipes_time}분</div>
            <div class="col-md-1 label-col p-2">난이도</div>
            <div class="col-md-2 value-col text-center">${vo.recipes_level}</div>
        </div>
    </div>

    <div class="card p-3 mb-4 shadow-sm bg-light">
        <div class="d-flex align-items-center">
            <span class="fw-bold me-3">레시피 한줄 설명</span>
            <span class="fs-5 text-secondary">${vo.description}</span>
        </div>
    </div>

	<div class="card p-4 mb-4 shadow-sm bg-light">
	        <div class="row m-0">
	            <div class="col-md-8 border-end pe-4">
	                <div class="d-flex align-items-center mb-4">
	                    <span class="fw-bold me-3" style="font-size: 1.2rem;">👨‍🍳 레시피 상세 내용</span>
	                </div>
	                
	                <div class="recipes-content-body fs-5 text-secondary" style="white-space: pre-wrap; line-height: 1.8;">
	                    ${vo.recipes_content}
	                </div>
	            </div>
	            
	            <div class="col-md-4 d-flex align-items-center justify-content-center ps-4">
	                <div class="recipe-img-container text-center w-100">
	                    <span class="fw-bold d-block mb-3" style="font-size: 1rem;">대표 이미지</span>
	                    <c:choose>
	                        <c:when test="${not empty vo.recipes_img}">
	                            <img src="${vo.recipes_img}" class="recipe-img img-thumbnail shadow-sm w-100">
	                        </c:when>
	                        <c:otherwise>
	                            <img src="https://via.placeholder.com/300x200?text=No+Image" class="recipe-img img-thumbnail w-100">
	                        </c:otherwise>
	                    </c:choose>
	                    
	                    <c:if test="${login.id == vo.id}">
	                        <div class="mt-3">
	                            <a href="imageChange.do?no=${vo.recipes_no}" class="btn btn-sm btn-outline-secondary">이미지 변경</a>
	                        </div>
	                    </c:if>
	                </div>
	            </div>
	        </div>
	    </div>

    <div class="d-flex justify-content-end gap-2 mt-4">
        <c:if test="${login.id == vo.id}">
            <a href="recipeUpdate.do?no=${vo.recipes_no}" class="btn btn-dark">수정</a>
            <button type="button" id="deleteBtn" class="btn btn-danger">삭제</button>
        </c:if>
        <a href="list.do?${pageObject.pageQuery}" class="btn btn-outline-dark">리스트</a>
    </div>
</div>

<form id="deleteForm" action="delete.do" method="post">
    <input type="hidden" name="no" value="${vo.recipes_no}">
    <input type="hidden" name="perPageNum" value="${pageObject.perPageNum}">
</form>

<form id="bookmarkWriteForm" action="/recipesbookmark/write.do" method="post">
    <input type="hidden" name="no" value="${vo.recipes_no}">
</form>

<form id="bookmarkDeleteForm" action="/recipesbookmark/delete.do" method="post">
    <input type="hidden" name="no" value="${vo.recipes_no}">
</form>

</body>
</html>